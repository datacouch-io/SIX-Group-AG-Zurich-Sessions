SELECT
    custkey,
    name,
    nationkey,
    acctbal,
    
    -- ROW_NUMBER assigns a unique row number to each row within a partition
    ROW_NUMBER() OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS row_num,

    -- RANK assigns a rank with gaps in case of ties
    RANK() OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS rank_num,

    -- DENSE_RANK assigns a rank without gaps for ties
    DENSE_RANK() OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS dense_rank_num,

    -- NTILE splits rows into n number of buckets
    NTILE(4) OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS bucket,

    -- LAG returns the previous account balance in the result set
    LAG(acctbal, 1) OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS prev_acctbal,

    -- LEAD returns the next account balance in the result set
    LEAD(acctbal, 1) OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS next_acctbal,

    -- SUM computes the running total of account balances
    SUM(acctbal) OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS running_total_acctbal,

    -- AVG computes the average account balance over the partition
    AVG(acctbal) OVER (PARTITION BY nationkey ORDER BY acctbal DESC) AS running_avg_acctbal

FROM tpch.sf1.customer
ORDER BY nationkey, acctbal DESC;


SELECT
    custkey,
    name,
    nationkey,
    acctbal,

    -- RANGE: Calculates the difference between current and previous row's balance
    SUM(acctbal) OVER (PARTITION BY nationkey 
                       ORDER BY acctbal 
                       RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_acctbal,

    -- RANGE: Get the current row's balance + previous 2 rows' balance
    SUM(acctbal) OVER (PARTITION BY nationkey 
                       ORDER BY acctbal 
                       RANGE BETWEEN 2 PRECEDING AND CURRENT ROW) AS range_sum_acctbal

FROM tpch.sf1.customer
ORDER BY nationkey, acctbal;
