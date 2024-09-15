--Drop table if already exists
DROP TABLE iceberg.navdeep.bogus_info ;
DROP TABLE iceberg.navdeep.deltas_recd;


--Create an Icerberg table
CREATE TABLE iceberg.navdeep.bogus_info (
bogus_id int, date_created varchar,
field1 varchar, field2 varchar, field3 varchar
);


--Let's insert some data in above table
INSERT INTO iceberg.navdeep.bogus_info
(bogus_id, date_created, field1, field2, field3)
values
(11,'2022-09-17','base','base','base'),
(12,'2022-09-17','base','base','base'),
(13,'2022-09-17','base','base','base'),
(14,'2022-09-18','base','base','base'),
(15,'2022-09-18','base','base','base'),
(16,'2022-09-18','base','base','base'),
(17,'2022-09-19','base','base','base'),
(18,'2022-09-19','base','base','base'),
(19,'2022-09-19','base','base','base');




--Let's create some delta table
CREATE TABLE iceberg.navdeep.deltas_recd (
bogus_id int, date_created varchar,
field1 varchar, field2 varchar, field3 varchar
);


--Let's insert some data in this delta table
insert into iceberg.navdeep.deltas_recd
(bogus_id, date_created, field1, field2, field3)
values
(20,'2022-09-20','NEW','base','base'),
(21,'2022-09-20','NEW','base','base'),
(22,'2022-09-20','NEW','base','base'),
(12,'2022-09-17','EXISTS','CHANGED','base'),
(14,'2022-09-18','EXISTS','CHANGED','base'),
(16,'2022-09-18','EXISTS','CHANGED','base');


--Let's check data in both table
Select * from iceberg.navdeep.bogus_info;
Select * from iceberg.navdeep.deltas_recd;


--Let's merge data of these two tables
MERGE INTO iceberg.navdeep.bogus_info AS B
USING iceberg.navdeep.deltas_recd AS D
ON B.bogus_id = D.bogus_id
AND B.date_created = D.date_created
WHEN MATCHED THEN
UPDATE SET field1 = D.field1,
field2 = D.field2,
field3 = D.field3
WHEN NOT MATCHED THEN
INSERT VALUES (D.bogus_id, D.date_created,
D.field1, D.field2, D.field3);


--Let's check the table again after merge
SELECT * FROM "iceberg"."navdeep"."bogus_info" order by bogus_id;