---USE CASE Statement

SELECT 
    custkey,
    acctbal,
    CASE
        WHEN acctbal <= 0 THEN 'negative_balance'
        WHEN acctbal > 0 AND acctbal < 4483 THEN 'below_50'
        WHEN acctbal >= 4483 THEN 'above_50'
        ELSE 'Unknown'
    END AS percentile
FROM tpch.sf1.customer;


-- Use COALESCE
SELECT 
    custkey,
    acctbal,
    COALESCE(
        IF( acctbal <= 0 , 'negative_balance'),
        IF( acctbal > 0 AND acctbal < 4483, 'below_50'),
        IF( acctbal >= 4483 , 'above_50'),
         'Unknown')
     AS percentile
FROM tpch.sf1.customer;

--USING IF STATEMENT
SELECT custkey, mktsegment,
    IF 
        (mktsegment IN 
        ('BUILDING','AUTOMOBILE','MACHINERY'),
        'heavy','light') 
    AS seg_type
FROM tpch.sf1.customer;
LIMIT 10;


