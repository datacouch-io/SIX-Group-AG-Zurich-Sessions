-- create a schema with hive catalog
CREATE SCHEMA hive.hive_Schema
WITH (
    location = 's3a://lakehouse/hive'
);

-- Create table with external location on MinIO
CREATE TABLE hive.hive_Schema.ratings_csv (
    userId varchar(55),
    movieId varchar(55),
    rating double,
    timestamp varchar(55)
) 
WITH (
    external_location = 's3a://my-bucket-2/',
    format = 'TEXTFILE',
    textfile_field_separator = ',',
    skip_header_line_count = 1
);


-- select from above table
Select * from hive.hive_Schema.ratings_csv;

-- let's check table description
SHOW CREATE TABLE  hive.hive_Schema.ratings_csv;

-- drop the table
drop table  hive.hive_Schema.ratings_csv;

-- check in MinIO at s3a://my-bucket-2/
