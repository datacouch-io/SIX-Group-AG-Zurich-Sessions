### Lab 3: Partitioning and Partition Evolution

#### Lab Summary:

In this lab, you'll delve into partitioning and partition evolution within Apache Iceberg, utilizing the orders table from the TPCH dataset. You will create a partitioned Iceberg table, populate it with data, and observe the impact of partitioning on query performance and data organization. Additionally, you'll perform partition evolution, demonstrating how Iceberg facilitates changes in partitioning without the need to rewrite existing data.

#### Estimated Completion Time:

25 minutes

#### Learning Objectives:

-   Create a partitioned Iceberg table using the orders table from TPCH.
-   Insert data into the partitioned Iceberg table.
-   Understand how data is organized using partitioning.
-   Execute partition evolution to modify the partitioning scheme of the Iceberg table.
-   Learn how Iceberg manages partition evolution seamlessly, preserving existing data.

#### Steps:

##### Step 1: Create a Partitioned Iceberg Table (Partition by orderdate)

Create a partitioned Iceberg table based on the orderdate column from the TPCH orders table. Date-based partitioning enhances query performance for date range filters.

```
CREATE TABLE iceberg.iceberg_schema.orders_partitioned (
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
   partitioning = ARRAY['year(orderdate)']
);
```

##### Step 2: Insert Data into the Partitioned Iceberg Table

Insert data from the TPCH orders table into the newly created partitioned Iceberg table.

```
INSERT INTO iceberg.iceberg_schema.orders_partitioned
SELECT * FROM tpch.sf1.orders;
```

##### Step 3: Explore the Partitioned Data

Explore how Iceberg organizes the data into partitions by querying the partition metadata.

```
SELECT * FROM "iceberg"."iceberg_schema"."orders_partitioned$partitions";
```

##### Step 4: Query Data Using Partition Pruning

Execute a query that benefits from partition pruning, targeting only relevant partitions to enhance query efficiency.

```
EXPLAIN
SELECT orderkey, custkey, orderdate
FROM iceberg.iceberg_schema.orders_partitioned
WHERE orderdate = DATE '1996-01-01';
```

##### Step 5: Perform Partition Evolution

Change the partitioning scheme of the Iceberg table from date-based to status-based partitioning.

```
ALTER TABLE iceberg.iceberg_schema.orders_partitioned
SET PROPERTIES PARTITIONING = ARRAY['orderstatus'];
```

##### Step 6: Insert New Data After Partition Evolution

Insert additional data post-partition evolution and observe how Iceberg handles the new partitioning scheme.

```
INSERT INTO iceberg.iceberg_schema.orders_partitioned
SELECT * FROM tpch.sf1.orders WHERE orderstatus = 'O';
```

##### Step 7: Check the Partition Table Again

After inserting new data, explore how Iceberg organizes the data into the new partitions.

```
SELECT * FROM "iceberg"."iceberg_schema"."orders_partitioned$partitions";
```

##### Step 8: Query Data with the New Partitioning Scheme

Query the table using the new partitioning scheme and observe how partition pruning functions with the new partition attribute.

```
SELECT orderkey, custkey, orderstatus
FROM iceberg.iceberg_schema.orders_partitioned
WHERE orderstatus = 'O';
```

#### Conclusion:

Throughout this lab, you have:

-   Created a partitioned Iceberg table using the orders table from TPCH.
-   Inserted data and explored how partitioning organizes data for more efficient querying.
-   Performed partition evolution to switch the partitioning scheme from orderdate to orderstatus.
-   Inserted new data using the updated partitioning scheme and queried the table based on both old and new partitions.
