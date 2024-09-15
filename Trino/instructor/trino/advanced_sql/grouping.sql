SELECT nationkey, mktsegment, COUNT(*)
FROM tpch.sf1.customer
WHERE nationkey = 1
GROUP BY  nationkey, mktsegment
UNION ALL
SELECT nationkey, NULL, COUNT(*)
FROM students.instructor.customer
WHERE nationkey = 1
GROUP BY  nationkey
UNION ALL
SELECT 
  NULL, 
  NULL, 
  COUNT(*) AS ordercount
FROM tpch.sf1.customer
WHERE nationkey = 1;




--Using Rollup
SELECT nationkey, mktsegment, COUNT(*)
FROM tpch.sf1.customer
WHERE nationkey = 1
GROUP BY ROLLUP (nationkey, mktsegment)
ORDER BY 1,2;

--Using Cube
SELECT nationkey, mktsegment, COUNT(*)
FROM tpch.sf1.customer
WHERE nationkey = 1
GROUP BY CUBE (nationkey, mktsegment)
ORDER BY 1,2;


--Using GroupingSets
SELECT nationkey, mktsegment, COUNT(*)
FROM tpch.sf1.customer
WHERE nationkey = 1
GROUP BY GROUPING SETS (
  (mktsegment),
  (nationkey),
  (nationkey, mktsegment),
  ()
)
ORDER BY 1,2;

--Using GroupingSets

SELECT nationkey, mktsegment, COUNT(*)
FROM tpch.sf1.customer
WHERE nationkey = 1
GROUP BY GROUPING SETS (
  (nationkey),
  (nationkey, mktsegment),
  ()
)
ORDER BY 1,2;




