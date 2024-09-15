--create schema in iceberg catalog
CREATE SCHEMA iceberg.navdeep
WITH (
    location = 's3a://lakehouse/db'
);


-- create an iceberg table
CREATE TABLE iceberg.navdeep.person_risk (
anon_id int,
us_state varchar(2),
credit_score int,
notes varchar(50)
);

--let's check the snapshot table
SELECT * FROM "iceberg"."navdeep"."person_risk$snapshots";

--Let’s explores meta file in MinIO

--let's insert some data in above table
INSERT INTO iceberg.navdeep.person_risk (
anon_id, us_state, credit_score, notes
)
VALUES
(1, 'GA', 850, 'initial insert'),
(2, 'TX', 750, 'initial insert'),
(3, 'LA', 800, 'initial insert');

--let's check the snapshot again
SELECT * FROM "iceberg"."navdeep"."person_risk$snapshots";

-- Explore data, metadata and snapshot files in MinIO

--let's insert some more records
INSERT INTO iceberg.navdeep.person_risk (
anon_id, us_state, credit_score, notes
)
VALUES
(4, 'GA', 825, 'initial insert');

INSERT INTO iceberg.navdeep.person_risk (
anon_id, us_state, credit_score, notes
)
VALUES
(5, 'LA', 725, 'initial insert'),
(6, 'TX', 700, 'initial insert');

--let's check snapshot table again
SELECT * FROM "iceberg"."navdeep"."person_risk$snapshots";

--let's delete some records
DELETE FROM iceberg.navdeep.person_risk
WHERE anon_id = 1;

--let's check snapshot table again
SELECT * FROM "iceberg"."navdeep"."person_risk$snapshots";

--let's verify records are deleted
SELECT * FROM iceberg.navdeep.person_risk
ORDER BY anon_id;

--let's try updates also
UPDATE iceberg.navdeep.person_risk
SET credit_score = 6500,
notes = 'accidentally uses 6500 instead of 650'
WHERE us_state = 'TX';

--Let's check whether update has happened
SELECT * FROM iceberg.navdeep.person_risk
ORDER BY anon_id;