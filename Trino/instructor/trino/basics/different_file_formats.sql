
-- use hive schema
Use hive.hive_schema;

-- create a table with parquet file format and add data from tpch orders table
CREATE TABLE
t_orders_parquet
WITH
(format = 'Parquet') AS
SELECT
*
FROM
tpch.sf1.orders;



-- Let's see table summary for above table
SELECT format_number(AVG("$file_size")) AS avg_file_size,
COUNT() AS tot_nbr_files,
format_number(SUM("$file_size")) AS tot_file_size
FROM
(SELECT DISTINCT "$path", "$file_size"
FROM t_orders_parquet);

-- create a table with orc  file format and add data from tpch limits table
CREATE TABLE
t_lineitem_orc
WITH
(format = 'ORC') AS
SELECT
*
FROM
Tpch.sf1.lineitem limit 1000;

-- Let's see table summary for above table
SELECT format_number(AVG("$file_size")) AS avg_file_size,
COUNT() AS tot_nbr_files,
format_number(SUM("$file_size")) AS tot_file_size
FROM
(SELECT DISTINCT "$path", "$file_size"
FROM t_lineitem_orc);


-- Let's join above table
SELECT
o.orderkey,
l.linenumber
FROM
t_lineitem_orc AS l
JOIN t_orders_parquet AS o ON l.orderkey = o.orderkey;

-- create a table with avro  file format and add data from tpch customers table
CREATE TABLE
t_customer_avro
WITH
(format = 'Avro') AS
SELECT
*
FROM
tpch.sf1.customer;

-- lets join all three tables
SELECT
o.orderkey,
l.linenumber,
c.name AS customer_name
FROM
t_lineitem_orc AS l
JOIN t_orders_parquet AS o ON l.orderkey = o.orderkey
JOIN t_customer_avro AS c ON o.custkey = c.custkey;

-- create more table with more formats
CREATE TABLE t_region_rctext
WITH (format = 'RCText') AS
SELECT * FROM tpch.sf1.region;

CREATE TABLE t_part_sf
WITH (format = 'SequenceFile') AS
SELECT * FROM tpch.sf1.part;

CREATE TABLE t_supplier_json
WITH (format = 'JSON') AS
SELECT * FROM tpch.sf1.supplier;

-- let’s join all formats together

SELECT
O.orderkey, l.linenumber,
c.name AS customer_name,
n.name AS nation_name,
r.name AS region_name,
p.name AS part_name,
s.name AS supplier_name
FROM
t_lineitem_orc AS l
JOIN t_orders_parquet AS o ON l.orderkey = o.orderkey
JOIN t_customer_avro AS c ON o.custkey = c.custkey
JOIN nation AS n ON c.nationkey = n.nationkey
JOIN t_region_rctext AS r ON n.regionkey = r.regionkey
JOIN t_part_sf AS p ON l.partkey = p.partkey
JOIN t_supplier_json AS s ON l.suppkey = s.suppkey
