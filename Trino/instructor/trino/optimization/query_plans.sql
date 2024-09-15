-- PLAN 1

-- one stage full scan with all columns
--  ran as [SINGLE] since engine knew it would limit
--  the number of rows (i.e. did NOT need parallel read)
EXPLAIN  
SELECT *
  FROM tpch.sf1.customer;



-- PLAN 2

-- PROJECTION PRUNING
-- shows the shorter list of columns being retrieved
EXPLAIN  
SELECT custkey,name
  FROM tpch.sf1.customer;


-- PLAN 3

-- PREDICATE PUSHDOWN
-- further helps as TableScan becomes a ScanFilter operation
EXPLAIN  
SELECT *
  FROM tpch.sf1.customer
  where nationkey=15;


-- PLAN 4

-- add a sort which adds 2 more stages for sorting
--  (a distributed partial sort and a single merge 
--   of sorted lists)
EXPLAIN 
SELECT *
  FROM tpch.sf1.customer
  where nationkey in (1,15)
 ORDER BY custkey,nationKey;


-- PLAN 5

-- Let's add a group by 
EXPLAIN 
SELECT nationKey,count(*)
  FROM tpch.sf1.customer
 GROUP BY nationKey;



-- PLAN 6

--PARTITION JOIN
EXPLAIN
CREATE TABLE BOGUS_STUFF AS 
SELECT c.name, c.acctbal, o.orderkey, o.totalprice
  FROM tpch.sf100.orders   AS o 
  LEFT JOIN tpch.sf100.customer AS c 
    ON c.custkey = o.custkey;


-- PLAN 7

--BROADCAST JOIN
EXPLAIN (TYPE DISTRIBUTED)
SELECT c.name, c.acctbal, o.orderkey, o.totalprice
  FROM tpch.sf1.orders   AS o 
  LEFT JOIN tpch.sf1.customer AS c 
    ON c.custkey = o.custkey


-- PLAN 8

-- PARTITION PRUNING
CREATE TABLE hive.hive_Schema.orders_pttn_priority
WITH (
partitioned_by = ARRAY['orderpriority']
)
AS
SELECT *
FROM tpch.sf1.orders;

EXPLAIN 
SELECT * from hive.hive_Schema.orders_pttn_priority
WHERE orderpriority = '4-NOT SPECIFIED';
