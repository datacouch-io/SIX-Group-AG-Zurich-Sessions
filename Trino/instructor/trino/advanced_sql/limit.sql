SELECT 
    custkey,
    acctbal 
FROM tpch.sf1.customer
LIMIT 5;


-- Get me top 5 customers with the largest account balance
SELECT 
    custkey,
    acctbal 
FROM tpch.sf1.customer
ORDER BY acctbal DESC
LIMIT 5;

--USING FETCH 
SELECT 
    custkey,
    acctbal 
FROM tpch.sf1.customer
FETCH FIRST 5 ROWS ONLY;

--USING FETCH to get first 9 account balances
SELECT 
    custkey,
    acctbal 
FROM tpch.sf1.customer
ORDER BY acctbal DESC
FETCH FIRST 9 ROWS ONLY;


--USING FETCH to get first 9 account balances and include ties
SELECT 
    custkey,
    acctbal 
FROM tpch.sf1.customer
ORDER BY acctbal DESC
FETCH FIRST 9 ROWS WITH TIES;

--- USING OFFSETS
SELECT 
    custkey,
    acctbal 
FROM tpch.sf1.customer
ORDER BY acctbal DESC
OFFSET 5
FETCH FIRST 9 ROWS WITH TIES;
