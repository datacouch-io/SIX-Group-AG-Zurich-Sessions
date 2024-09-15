--Create Iceberg table with Partitioning on nationkey
CREATE TABLE iceberg.navdeep.demo_cust_iceberg_part (
custkey bigint,
nationkey bigint,
mktsegment varchar(10),
acctbal double
)
WITH (
format = 'orc',
partitioning=ARRAY['nationkey']
);

-- Check the path in MinIO

--Select some data from tpch.tiny.customer table
SELECT custkey, nationkey, mktsegment, acctbal FROM tpch.tiny.customer
WHERE nationkey < 5
AND acctbal > 9000;



--let's insert above data into our iceberg table
INSERT INTO iceberg.navdeep.demo_cust_iceberg_part (
SELECT custkey, nationkey, mktsegment, acctbal FROM tpch.tiny.customer
WHERE nationkey < 5
AND acctbal > 9000
);

--let's check partitions created in MinIO

--Let's check total count and count in each partition
SELECT * FROM "iceberg"."navdeep"."demo_cust_iceberg_part$partitions";


--Let's select data for nationkey=6
SELECT custkey, nationkey, mktsegment, acctbal
FROM tpch.tiny.customer
WHERE nationkey = 6;



--Let's insert this data into an iceberg table and check whether a new partition is added?
INSERT INTO iceberg.navdeep.demo_cust_iceberg_part (
SELECT custkey, nationkey, mktsegment, acctbal
FROM tpch.tiny.customer
WHERE nationkey = 6
);


--Let's check partition table again
SELECT * FROM "iceberg"."navdeep"."demo_cust_iceberg_part$partitions";


--ALter table to add new Partitioning column
ALTER TABLE iceberg.navdeep.demo_cust_iceberg_part
SET PROPERTIES partitioning = ARRAY['mktsegment'];


--Lets check table schema
SHOW CREATE TABLE  iceberg.navdeep.demo_cust_iceberg_part;

--Let's check partition table again
SELECT * FROM "iceberg"."navdeep"."demo_cust_iceberg_part$partitions";


--Let's check on MinIO. The content on S3 still looks the same. THE EXISTING DATA DID NOT GET REPARTITIONED; it is still partitioned the same way


--we are going to insert some new data in table
SELECT mktsegment, count() AS nbr_custs
FROM tpch.tiny.customer
WHERE nationkey < 5
AND acctbal > 8500 AND acctbal < 9000
GROUP BY mktsegment;


--Let's insert above data into our partitioned table
INSERT INTO iceberg.navdeep.demo_cust_iceberg_part (
SELECT custkey, nationkey, mktsegment, acctbal FROM tpch.tiny.customer
WHERE nationkey < 5
AND acctbal > 8500 AND acctbal < 9000
);


--Let's check MinIO again

--Let's check metadata table for partition as well
SELECT * FROM "iceberg"."navdeep"."demo_cust_iceberg_part$partitions";


--Let's check the snapshot table as well
SELECT * FROM "iceberg"."navdeep"."demo_cust_iceberg_part$snapshots";









