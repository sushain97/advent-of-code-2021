CREATE TABLE input (txt TEXT) STRICT;

INSERT INTO
  input
VALUES
  (CAST(readfile('input') AS TEXT));

CREATE TABLE movements (dir TEXT, units INT) STRICT;

WITH RECURSIVE data_builder (dir, units, rest) AS (
  SELECT
    '',
    0,
    txt
  FROM
    input
  UNION
  ALL
  SELECT
    SUBSTR(
      SUBSTR(rest, 0, INSTR(rest, char(10))),
      0,
      INSTR(rest, ' ')
    ),
    SUBSTR(
      SUBSTR(rest, 0, INSTR(rest, char(10))),
      INSTR(rest, ' ') + 1
    ),
    SUBSTR(rest, INSTR(rest, char(10)) + 1)
  FROM
    data_builder
  WHERE
    rest != ''
)
INSERT INTO
  movements
SELECT
  dir,
  units
FROM
  data_builder
WHERE
  dir != '';

CREATE TABLE position (horiz INT, depth INT) STRICT;

WITH RECURSIVE walker (horiz, depth, aim, n) AS (
  SELECT
    0,
    0,
    0,
    0
  UNION
  ALL
  SELECT
    CASE
      WHEN dir = 'forward' THEN horiz + units
      ELSE horiz
    END,
    CASE
      WHEN dir = 'forward' THEN depth + aim * units
      ELSE depth
    END,
    CASE
      WHEN dir = 'down' THEN aim + units
      WHEN dir = 'up' THEN aim - units
      ELSE aim
    END,
    n + 1
  FROM
    walker,
    movements
  WHERE
    (walker.n + 1) = movements.rowid
    AND n < (
      SELECT
        MAX(rowid)
      FROM
        movements
    )
)
INSERT INTO
  position
SELECT
  horiz,
  depth
FROM
  walker
ORDER BY
  n DESC
LIMIT
  1;

SELECT
  horiz * depth
FROM
  position;