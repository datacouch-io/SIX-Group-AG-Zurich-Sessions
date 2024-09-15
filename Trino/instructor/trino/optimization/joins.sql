--sort-merge join
EXPLAIN
SELECT c.name, c.acctbal, o.orderkey, o.totalprice
  FROM tpch.sf100.orders   AS o 
  LEFT JOIN tpch.sf100.customer AS c 
    ON c.custkey = o.custkey

--broadcast join
EXPLAIN
SELECT c.name, c.acctbal, o.orderkey, o.totalprice
  FROM tpch.sf1.orders   AS o 
  LEFT JOIN tpch.sf1.customer AS c 
    ON c.custkey = o.custkey