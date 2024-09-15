USE iceberg.navdeep;

------------------ NORMAL VIEWS ------------------------------------

--Let's create supplier,nation and region table from tpch catalog
CREATE TABLE supplier10 AS
SELECT * FROM tpch.sf10.supplier;

CREATE TABLE nation10 AS
SELECT * FROM tpch.sf10.nation;

CREATE TABLE region10 AS
SELECT * FROM tpch.sf10.region;


--Let's check output of below SQL statement
SELECT r.name AS "The Region", count() AS "# of Suppliers"
FROM supplier10 AS s
JOIN nation10 AS n ON (s.nationkey = n.nationkey)
JOIN region10 AS r ON (n.regionkey = r.regionkey)
GROUP BY r.name;


--Let's create a view on previous SQL
CREATE VIEW normal_view AS
SELECT r.name AS "The Region", count() AS "# of Suppliers"
FROM supplier10 AS s
JOIN nation10 AS n ON (s.nationkey = n.nationkey)
JOIN region10 AS r ON (n.regionkey = r.regionkey)
GROUP BY r.name;

--Let's read from view
Select * FROM normal_view;

--Check Query details -> Advanced section --> tables referenced


------------------- MATERIALIZED VIEWS --------------------------------

CREATE MATERIALIZED VIEW my_mv AS
SELECT r.name AS "The Region", count() AS "# of Suppliers"
FROM supplier10 AS s
JOIN nation10 AS n ON (s.nationkey = n.nationkey)
JOIN region10 AS r ON (n.regionkey = r.regionkey)
GROUP BY r.name;

--Let's read data and check query details for accessed tables
SELECT * FROM my_mv;

-- populate materialized views
REFRESH MATERIALIZED VIEW my_mv;



--Let's try again and check query details
SELECT * FROM my_mv;


DROP MATERIALIZED VIEW my_mv;
DROP VIEW normal_view; 
DROP TABLE supplier10;
DROP TABLE nation10;
DROP TABLE region10;