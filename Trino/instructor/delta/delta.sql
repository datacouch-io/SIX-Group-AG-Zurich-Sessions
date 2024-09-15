-- create a schema for delta catalog
CREATE SCHEMA delta.delta_schema
WITH (
    location = 's3a://lakehouse/delta'
);


--drop table if already exist
DROP TABLE delta.delta_schema.my_delta_tbl;


--Let's create a delta table
CREATE TABLE delta.delta_schema.my_delta_tbl (
id integer,
name varchar(55),
description varchar(255)
);


--Let's check table schema & check delta_log in S3
SHOW CREATE TABLE delta.delta_schema.my_delta_tbl;

--Let’s check MinIO for meta file
{"commitInfo":{"version":0,"timestamp":1726049216313,"userId":"admin","userName":"admin","operation":"CREATE TABLE","operationParameters":{"queryId":"20240911_100656_00086_2dq6g"},"clusterId":"trino-455-datapains-trino-cluster-trino-coordinator-6d5864c74f-kdsrf","readVersion":0,"isolationLevel":"WriteSerializable","isBlindAppend":true}}
{"protocol":{"minReaderVersion":1,"minWriterVersion":2}}
{"metaData":{"id":"d4d2dafa-57b7-4407-ba7c-2eb5375390dc","format":{"provider":"parquet","options":{}},"schemaString":"{\"type\":\"struct\",\"fields\":[{\"name\":\"id\",\"type\":\"integer\",\"nullable\":true,\"metadata\":{}},{\"name\":\"name\",\"type\":\"string\",\"nullable\":true,\"metadata\":{}},{\"name\":\"description\",\"type\":\"string\",\"nullable\":true,\"metadata\":{}}]}","partitionColumns":[],"configuration":{},"createdTime":1726049216313}}



--Let's insert some data into above table
INSERT INTO
delta.delta_schema.my_delta_tbl (id, name, description)
VALUES
(1, 'one', 'added via 1st INSERT statement'),
(2, 'two', 'added via 1st INSERT statement'),
(3, 'three', 'added via 1st INSERT statement');


--Let's check delta_log in MinIO again
{"commitInfo":{"version":1,"timestamp":1726049350561,"userId":"admin","userName":"admin","operation":"WRITE","operationParameters":{"queryId":"20240911_100906_00088_2dq6g"},"clusterId":"trino-455-datapains-trino-cluster-trino-coordinator-6d5864c74f-kdsrf","readVersion":0,"isolationLevel":"WriteSerializable","isBlindAppend":true}}
{"add":{"path":"20240911_100906_00088_2dq6g_44c5f99b-d5dd-4de8-b7aa-0726c54d9652","partitionValues":{},"size":613,"modificationTime":1726049350031,"dataChange":true,"stats":"{\"numRecords\":3,\"minValues\":{\"id\":1,\"name\":\"one\",\"description\":\"added via 1st INSERT statement\"},\"maxValues\":{\"id\":3,\"name\":\"two\",\"description\":\"added via 1st INSERT statement\"},\"nullCount\":{\"id\":0,\"name\":0,\"description\":0}}","tags":{}}}


--Let's add three additional rows
INSERT INTO
delta.delta_schema.my_delta_tbl (id, name, description)
VALUES
(4, 'four', 'added via 2nd INSERT statement'),
(5, 'five', 'added via 2nd INSERT statement'),
(6, 'six', 'added via 2nd INSERT statement');


--check MinIO for delta and data file


-- check table and verify whether all 6 records are present
SELECT * FROM delta.delta_schema.my_delta_tbl ORDER BY id;


--Let's try update operation
UPDATE
delta.delta_schema.my_delta_tbl
SET
description = 'UPPER-CASED name col via 1st UPDATE statement',
name = UPPER(name)
WHERE
(id % 2) = 0;


--Let's verify the update
SELECT * FROM delta.delta_schema.my_delta_tbl ORDER BY id;


--let's check MinIO for delta and data files
{"commitInfo":{"version":3,"timestamp":1726049497495,"userId":"admin","userName":"admin","operation":"MERGE","operationParameters":{"queryId":"20240911_101132_00090_2dq6g"},"clusterId":"trino-455-datapains-trino-cluster-trino-coordinator-6d5864c74f-kdsrf","readVersion":2,"isolationLevel":"WriteSerializable","isBlindAppend":false}}
{"remove":{"path":"20240911_100906_00088_2dq6g_44c5f99b-d5dd-4de8-b7aa-0726c54d9652","partitionValues":{},"deletionTimestamp":1726049497535,"dataChange":true}}
{"remove":{"path":"20240911_101019_00089_2dq6g_614e6b94-dbec-4247-be8d-90f5da42f434","partitionValues":{},"deletionTimestamp":1726049497535,"dataChange":true}}
{"add":{"path":"20240911_101132_00090_2dq6g_976c5398-3b03-4809-991e-5b3c7b4d49d2","partitionValues":{},"size":678,"modificationTime":1726049495029,"dataChange":true,"stats":"{\"numRecords\":2,\"minValues\":{\"id\":2,\"name\":\"FOUR\",\"description\":\"UPPER-CASED name col via 1st UPDATE statement\"},\"maxValues\":{\"id\":4,\"name\":\"TWO\",\"description\":\"UPPER-CASED name col via 1st UPDATE statement\"},\"nullCount\":{\"id\":0,\"name\":0,\"description\":0}}","tags":{}}}
{"add":{"path":"20240911_101132_00090_2dq6g_86b91cf6-b294-4337-8478-1788f68a306a","partitionValues":{},"size":605,"modificationTime":1726049497116,"dataChange":true,"stats":"{\"numRecords\":2,\"minValues\":{\"id\":1,\"name\":\"one\",\"description\":\"added via 1st INSERT statement\"},\"maxValues\":{\"id\":3,\"name\":\"three\",\"description\":\"added via 1st INSERT statement\"},\"nullCount\":{\"id\":0,\"name\":0,\"description\":0}}","tags":{}}}
{"add":{"path":"20240911_101132_00090_2dq6g_e2f6ee9e-90a7-4449-82ac-0dbb1293c05a","partitionValues":{},"size":576,"modificationTime":1726049497235,"dataChange":true,"stats":"{\"numRecords\":1,\"minValues\":{\"id\":5,\"name\":\"five\",\"description\":\"added via 2nd INSERT statement\"},\"maxValues\":{\"id\":5,\"name\":\"five\",\"description\":\"added via 2nd INSERT statement\"},\"nullCount\":{\"id\":0,\"name\":0,\"description\":0}}","tags":{}}}
{"add":{"path":"20240911_101132_00090_2dq6g_3e07c5b1-4630-4611-8272-cae7aa4d3033","partitionValues":{},"size":648,"modificationTime":1726049497213,"dataChange":true,"stats":"{\"numRecords\":1,\"minValues\":{\"id\":6,\"name\":\"SIX\",\"description\":\"UPPER-CASED name col via 1st UPDATE statement\"},\"maxValues\":{\"id\":6,\"name\":\"SIX\",\"description\":\"UPPER-CASED name col via 1st UPDATE statement\"},\"nullCount\":{\"id\":0,\"name\":0,\"description\":0}}","tags":{}}}


--Let's check whether delete works in delta table?
--delete rows where id is odd
DELETE FROM
delta.delta_schema.my_delta_tbl
WHERE
(id % 2) = 1;


--Run select query
SELECT * FROM delta.delta_schema.my_delta_tbl ORDER BY id;



-- check MinIO for meta data
{"commitInfo":{"version":4,"timestamp":1726049580226,"userId":"admin","userName":"admin","operation":"MERGE","operationParameters":{"queryId":"20240911_101259_00091_2dq6g"},"clusterId":"trino-455-datapains-trino-cluster-trino-coordinator-6d5864c74f-kdsrf","readVersion":3,"isolationLevel":"WriteSerializable","isBlindAppend":false}}
{"remove":{"path":"20240911_101132_00090_2dq6g_86b91cf6-b294-4337-8478-1788f68a306a","partitionValues":{},"deletionTimestamp":1726049580252,"dataChange":true}}
{"remove":{"path":"20240911_101132_00090_2dq6g_e2f6ee9e-90a7-4449-82ac-0dbb1293c05a","partitionValues":{},"deletionTimestamp":1726049580252,"dataChange":true}}
