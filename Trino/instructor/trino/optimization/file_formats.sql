CREATE TABLE hive.hive_schema.customer_csv (
    custkey VARCHAR,
    name VARCHAR,
    address VARCHAR,
    nationkey VARCHAR,
    phone VARCHAR,
    acctbal VARCHAR,
    mktsegment VARCHAR,
    comment VARCHAR
)
WITH (
    format = 'CSV'
);

INSERT INTO hive.hive_schema.customer_csv
SELECT
    CAST(custkey AS VARCHAR) AS custkey,
    CAST(name AS VARCHAR) AS name,
    CAST(address AS VARCHAR) AS address,
    CAST(nationkey AS VARCHAR) AS nationkey,
    CAST(phone AS VARCHAR) AS phone,
    CAST(acctbal AS VARCHAR) AS acctbal,
    CAST(mktsegment AS VARCHAR) AS mktsegment,
    CAST(comment AS VARCHAR) AS comment
FROM tpch.sf1.customer;

CREATE TABLE hive.hive_schema.customer_parquet (
    custkey VARCHAR,
    name VARCHAR,
    address VARCHAR,
    nationkey VARCHAR,
    phone VARCHAR,
    acctbal VARCHAR,
    mktsegment VARCHAR,
    comment VARCHAR
)
WITH (
    format = 'PARQUET'
);

INSERT INTO hive.hive_schema.customer_parquet
SELECT
    CAST(custkey AS VARCHAR) AS custkey,
    CAST(name AS VARCHAR) AS name,
    CAST(address AS VARCHAR) AS address,
    CAST(nationkey AS VARCHAR) AS nationkey,
    CAST(phone AS VARCHAR) AS phone,
    CAST(acctbal AS VARCHAR) AS acctbal,
    CAST(mktsegment AS VARCHAR) AS mktsegment,
    CAST(comment AS VARCHAR) AS comment
FROM tpch.sf1.customer;

--Check files in S3 and compare file size difference between csv and parquet
SELECT DISTINCT("$path")
FROM hive.hive_schema.customer_parquet;

SELECT DISTINCT("$path")
FROM hive.hive_schema.customer_csv;


--How much CPU time is consumed for reading the CSV table and only getting a few columns?
--Also notice how much data is actually read by trino engine
Explain Analyze
select custkey,name from hive.hive_schema.customer_parquet;

Explain Analyze
select custkey,name from hive.hive_schema.customer_csv;

