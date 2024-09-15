--Use Schema
USE  iceberg.navdeep;

--create an iceberg table partitioned on day
CREATE TABLE phone_provisioning (
phone_nbr bigint,
event_time timestamp(6),
action varchar(15),
notes varchar(150)
);


--let's verify the snapshot
SELECT * FROM "phone_provisioning$snapshots";

--let's add some historical activation records (7 days old) for two new phone number
INSERT INTO
phone_provisioning (phone_nbr, event_time, action, notes)
VALUES
(
1111111, current_timestamp(6) - interval '7' day, 'ordered', null
),
(
2222222, current_timestamp(6) - interval '7' day, 'ordered', null
);


--let's verify the added records
SELECT * FROM phone_provisioning ORDER BY event_time DESC;


--let's add 6 days old data for the same two phone numbr=er
INSERT INTO
phone_provisioning (phone_nbr, event_time, action, notes)
VALUES
(
1111111, current_timestamp(6) - interval '6' day, 'activated',
null
),
(
2222222, current_timestamp(6) - interval '6' day, 'activated',
null
);


--let's verify the records again
SELECT * FROM phone_provisioning ORDER BY event_time DESC;


--let's verify the snapshot again
SELECT * FROM "phone_provisioning$snapshots";


--let add Add historical activation records from five days ago to capture an error that was reported on phone number 2222222.
INSERT INTO
phone_provisioning (phone_nbr, event_time, action, notes)
VALUES
(2222222, current_timestamp(6) - interval '5' day, 'errorReported',
'customer reports unable to initiate call');

--let's verify the records again
SELECT * FROM phone_provisioning ORDER BY event_time DESC;


--Four days ago, a system error prevented the notes column from being populated correctly
--Upon review of the problem, it was determined that the following two commands are needed to modify the affected records.
UPDATE phone_provisioning
SET notes = 'customer requested new number'
WHERE action = 'ordered'
AND notes is null;
UPDATE phone_provisioning
SET notes = 'number successfully activated'
WHERE action = 'activated'
AND notes is null;

--let's review all row again
SELECT * FROM phone_provisioning ORDER BY event_time DESC;


--let's check the snapshots & review summary for last two snapshot added because of update operatin
SELECT * FROM "phone_provisioning$snapshots";

--TIME TRAVEL WITH SNAPSHOT ID
--let's check what our table looked like with snapshot id
SELECT * FROM phone_provisioning
FOR VERSION AS OF 7206506543728423875
ORDER BY event_time DESC;


--TIME TRAVEL AGAINST A POINT IN TIME
--$snapshots metadata table have a committed_at timestamp which is leveraged when FOR TIMESTAMP AS OF is utilized.
SELECT * FROM "phone_provisioning$snapshots";

SELECT * FROM phone_provisioning
FOR TIMESTAMP AS OF current_timestamp(6) - interval '35' minute
ORDER BY event_time DESC;



-- Rolling back to a previous state using snapshot files
-- check for latest snapshot id in history table
SELECT snapshot_id FROM "phone_provisioning$history"
ORDER BY made_current_at DESC LIMIT 1;


SELECT * FROM phone_provisioning
EXCEPT
SELECT * FROM phone_provisioning
FOR VERSION AS OF 8840843722832294024;


--let's run some deletes
DELETE FROM phone_provisioning
WHERE phone_nbr = 2222222;

--verfiy three records are deleted
SELECT * FROM phone_provisioning ORDER BY event_time DESC;


--oops, delete was a mistake, we need to roolback
--let's rollback to previous snapshot
CALL iceberg.system.rollback_to_snapshot(
'navdeep', 'phone_provisioning',
8840843722832294024);


--let's verify data
SELECT * FROM phone_provisioning ORDER BY event_time DESC;





















