CREATE OR REPLACE STREAM "DESTINATION_SQL_STREAM" (
  "Name"                VARCHAR(16),
  "StatusTime"          TIMESTAMP,
  "Distance"            SMALLINT,
  "MinMagicPoints"      SMALLINT,
  "MaxMagicPoints"      SMALLINT,
  "MinHealthPoints"     SMALLINT,
  "MaxHealthPoints"     SMALLINT
);

CREATE OR REPLACE PUMP "STREAM_PUMP" AS
  INSERT INTO "DESTINATION_SQL_STREAM"
    SELECT STREAM "Name", "ROWTIME", SUM("Distance"), MIN("MagicPoints"),
                  MAX("MagicPoints"), MIN("HealthPoints"), MAX("HealthPoints")
    FROM "SOURCE_SQL_STREAM_001"
    GROUP BY FLOOR("SOURCE_SQL_STREAM_001"."ROWTIME" TO MINUTE), "Name";