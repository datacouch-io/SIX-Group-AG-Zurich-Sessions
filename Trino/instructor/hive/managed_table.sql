
--create managed table

CREATE TABLE hive.hive_Schema.my_managed_table
(
 custId varchar(55),
 custName varchar(60)
);

--check in MinIO at locationn s3a://lakehouse/hive

--Show table definitation
SHOW CREATE TABLE "hive"."hive_schema"."my_managed_table";


--See underlying files
SELECT DISTINCT("$path")
FROM "hive"."hive_schema"."my_managed_table";


-- Insert some data into above table
INSERT INTO "hive"."hive_schema"."my_managed_table"
VALUES ('100','John');


--Check the path again and S3 as well
SELECT DISTINCT("$path")
FROM "hive"."hive_schema"."my_managed_table";

--Insert some more data
INSERT  INTO "hive"."hive_schema"."my_managed_table"
values ('200','Jim'),
('300','Kim');


--Check files again
SELECT DISTINCT("$path")
FROM "hive"."hive_schema"."my_managed_table";

--update the table
Update 
UPDATE hive.hive_schema.my_managed_table SET custid_new = '101' WHERE custname = 'John';

--Drop the table and check S3
drop table  hive.hive_schema.my_managed_table;

--check in MinIO