
--let's create a table in our hive catalog
CREATE TABLE hive.hive_schema.nation (
   nationkey bigint,
   name varchar(25),
   regionkey bigint,
   comment varchar(152)
);


-- let's insert some data into above table
insert into hive.hive_schema.nation 
select * from tpch.sf1.nation limit 100;


-- let's join postgres table dierctly with data on MinIO
SELECT
c.custkey,
c.nationkey,
n.name
FROM
tpch.sf1.customer c
JOIN hive.hive_schema.nation n ON c.nationkey = n.nationkey
ORDER BY
c.custkey;
