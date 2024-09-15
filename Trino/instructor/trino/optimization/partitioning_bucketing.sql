-- Use schema
Use hive.hive_Schema


--Create a hive table with no Partitioning
CREATE TABLE orders_no_pttn
AS
SELECT *
FROM tpch.sf1.orders;

-- Check the path in MinIO


-- let's try creating a hive table with partitionin on orderpriority column
CREATE TABLE orders_pttn_priority
WITH (
partitioned_by = ARRAY['orderpriority']
)
AS
SELECT *
FROM tpch.sf1.orders;

-- let's reorders the columns so that orderpriority is last.
CREATE TABLE orders_pttn_priority
WITH (
partitioned_by = ARRAY['orderpriority'],
)
AS
SELECT orderkey, custkey, orderstatus, totalprice,
orderdate, clerk, shippriority, comment,
orderpriority
FROM tpch.sf1.orders;

-- Check the for partitions in MinIO

-- Partitioning Pruning at scan time
EXPLAIN 
SELECT * from orders_pttn_priority
WHERE totalprice >= 430000.00;

EXPLAIN 
SELECT * from orders_pttn_priority
WHERE totalprice >= 430000.00
AND orderpriority = '4-NOT SPECIFIED';


-- Create an order table bucketed on custkey
CREATE TABLE orders_bckt_custkey
WITH (
bucketed_by = ARRAY['custkey'],
bucket_count = 4
)
AS
SELECT *
FROM tpch.sf1.orders;


-- check MinIO 


-- Scan fewer data with bucketing
Explain 
SELECT *
FROM orders_bckt_custkey;



Explain 
SELECT *
FROM orders_bckt_custkey
WHERE custkey = 130000;