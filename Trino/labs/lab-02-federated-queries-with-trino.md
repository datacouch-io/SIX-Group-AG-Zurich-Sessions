## Lab 2: Federated Queries with Trino

#### Estimated Completion Time:

20 minutes

#### Lab Summary:

In this lab, you will learn how to create and manage tables in the Hive catalog using Trino, insert data from the TPCH catalog into a Hive table, and perform federated queries by joining data from the Hive and TPCH catalogs. This exercise will help you understand the power of Trino in querying across different data sources seamlessly.

#### Prerequisites:

-   Ensure your cluster is running as configured in Lab 1.

#### Learning Objectives:

-   Create and manage tables in the Hive catalog using Trino.
-   Insert data from the TPCH catalog into a Hive table.
-   Perform federated queries across Hive and TPCH catalogs.
-   Explore the benefits of using Trino for querying across multiple data sources seamlessly.

#### Steps:

##### Step 1: Create a Parquet Table in Hive (Customer Table)

Create a customer table in the Hive catalog using the Parquet file format optimized for analytics.

```
CREATE TABLE hive.hive_schema.customer_parquet (
   custkey bigint,
   name varchar(25),
   address varchar(50),
   nationkey bigint,
   phone varchar(15),
   acctbal double,
   mktsegment varchar(10),
   comment varchar(117)
)
WITH (
   format = 'PARQUET'
);
```

##### Step 2: Insert Data into the Customer Parquet Table

Insert data from the tpch.sf1.customer table into the newly created Parquet table in Hive.

```
INSERT INTO hive.hive_schema.customer_parquet
SELECT * FROM tpch.sf1.customer LIMIT 100;
```
##### Step 3: Create a JSON Table in Hive (Orders Table)

Create an orders table in the Hive catalog using the JSON file format, suitable for storing unstructured or semi-structured data.

```
CREATE TABLE hive.hive_schema.orders_json (
   orderkey bigint,
   custkey bigint,
   orderstatus varchar(1),
   totalprice double,
   orderdate date,
   orderpriority varchar(15),
   clerk varchar(15),
   shippriority integer,
   comment varchar(79)
)
WITH (
   format = 'JSON'
);
```

##### Step 4: Insert Data into the Orders JSON Table

Populate the orders_json table with data from the tpch.sf1.orders table.

```
INSERT INTO hive.hive_schema.orders_json
SELECT * FROM tpch.sf1.orders;
```
##### Step 5: Perform Federated Query Joining Parquet, JSON, and TPCH Tables

Execute a federated query that joins tables from the Hive and TPCH catalogs, combining customer data from the Parquet table, orders data from the JSON table, and data from the nation table in TPCH.

```
SELECT
   c.custkey,
   c.name AS customer_name,
   o.orderkey,
   o.totalprice,
   n.name AS nation_name
FROM
   hive.hive_schema.customer_parquet c
JOIN hive.hive_schema.orders_json o ON c.custkey = o.custkey
JOIN tpch.sf1.nation n ON c.nationkey = n.nationkey
ORDER BY
   c.custkey, o.orderkey;
   ```

##### Step 6: Federated Query with Aggregation

Calculate the total order value for each customer by aggregating data across the tables.

```
SELECT
   c.custkey,
   c.name AS customer_name,
   SUM(o.totalprice) AS total_order_value,
   n.name AS nation_name
FROM
   hive.hive_schema.customer_parquet c
JOIN hive.hive_schema.orders_json o ON c.custkey = o.custkey
JOIN tpch.sf1.nation n ON c.nationkey = n.nationkey
GROUP BY
   c.custkey, c.name, n.name
ORDER BY
   total_order_value DESC;
   ```

#### Conclusion:

This lab demonstrated the creation of tables in the Hive catalog, the insertion of data from the TPCH catalog, and the execution of federated queries. Through these exercises, you have experienced the versatility of Trino in seamlessly querying across multiple data sources.
