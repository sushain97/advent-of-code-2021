CREATE TABLE input (txt TEXT);

INSERT INTO
  input
VALUES
  (readfile('input'));

CREATE TABLE movements (dir TEXT, units INT);

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
    CAST(
      SUBSTR(
        SUBSTR(rest, 0, INSTR(rest, char(10))),
        0,
        INSTR(rest, ' ')
      ) AS TEXT
    ),
    CAST(
      SUBSTR(
        SUBSTR(rest, 0, INSTR(rest, char(10))),
        INSTR(rest, ' ') + 1
      ) AS INT
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

CREATE TABLE position (horiz INT, depth INT);

WITH RECURSIVE walker (horiz, depth, n) AS (
  SELECT
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
      WHEN dir = 'down' THEN depth + units
      WHEN dir = 'up' THEN depth - units
      ELSE depth
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