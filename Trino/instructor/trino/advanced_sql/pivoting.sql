Select * FROM students.instructor.customer LIMIT 10; 


--Without Pivoting
SELECT 
  nationKey, 
  mktsegment, 
  COUNT(*)
FROM tpch.sf1.customer
GROUP BY nationkey, mktsegment
ORDER BY 1, 2;

--Pivoting Using COUNT_IF
SELECT 
  nationKey, 
  COUNT_IF(mktsegment='AUTOMOBILE') as auto,
  COUNT_IF(mktsegment='BUILDING') as building,
  COUNT_IF(mktsegment='FURNITURE') as furniture,
  COUNT_IF(mktsegment='MACHINERY') as machinery,
  COUNT_IF(mktsegment='HOUSEHOLD') as household
FROM tpch.sf1.customer
GROUP BY nationkey
ORDER BY 1;

--Pivoting for other Aggregations
SELECT 
  nationKey, 
  SUM(acctbal) FILTER(WHERE mktsegment='AUTOMOBILE') as auto_sum,
  avg(acctbal) FILTER(WHERE mktsegment='BUILDING') as building_avg,
  COUNT_IF(mktsegment='FURNITURE') as furniture_count
FROM tpch.sf1.customer
GROUP BY nationkey
ORDER BY 1;
