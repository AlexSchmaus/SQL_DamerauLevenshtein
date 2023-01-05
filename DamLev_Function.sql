--
-- Alex Schmaus 1/5/2023
-- An implementation of Damerau–Levenshtein distance in Transact SQL
--

-- The two strings to compare
DECLARE @A varchar(256) = 'Alex Shmus'
DECLARE @B varchar(256) = 'Alex Schmaus'

-- The output - how "different" are the strings?
DECLARE @Distance int

DECLARE @ALen int = len(@A)
DECLARE @BLen int = len(@B)

-- There needs to be something to work with!
IF @A IS NULL OR @B IS NULL OR @ALen = 0 OR @BLen = 0
	RETURN
	   
-- Create a numbers table 
-- 6 passes get us to 65,536 - if we need more then this, there's gonna be a bigger issue
DECLARE @Num table (N int)
;WITH 
	C1 AS (SELECT 1 AS N),
	C2 AS (SELECT 1 AS N FROM C1 UNION ALL SELECT N FROM C1),
	C3 AS (SELECT 1 AS N FROM C2 A CROSS APPLY C2 B),
	C4 AS (SELECT 1 AS N FROM C3 A CROSS APPLY C3 B),
	C5 AS (SELECT 1 AS N FROM C4 A CROSS APPLY C4 B),
	C6 AS (SELECT 1 AS N FROM C5 A CROSS APPLY C5 B)
INSERT INTO @Num
SELECT
	ROW_NUMBER() OVER (ORDER BY N)
FROM C6

-- Create two tables, where each letter of the two strings has a row, a
DECLARE @ATbl table (Letter varchar, Distance int)
DECLARE @BTbl table (Letter varchar, Distance int)
DECLARE @i int = 1

WHILE @i <= @ALen BEGIN
	INSERT INTO @Atbl
	SELECT SUBSTRING(@A, @i, 1), NULL

	SET @i += 1
	END

SET @i = 1
WHILE @i <= @BLen BEGIN
	INSERT INTO @BTbl
	SELECT SUBSTRING(@B, @i, 1), NULL
	
	SET @i += 1
	END


SELECT * FROM @ATbl
SELECT * FROM @BTbl

DECLARE @MaxLen int
SELECT @MaxLen = MAX(L) FROM (VALUES (@ALen),(@BLen)) AS src (L)



-- Check every row from 1 to @MaxLen, and try matching
-- the idea here is to build a "matrix", like this, If @A = CTAB and @B = CAT
--   C T A B
-- C 0 1 1 2
-- A 1 1 0 1
-- T 0 0 1 2
--   1 1 1 1
--
-- Each table will hold the max for its letter
-- the D-L distance will then be the max distance, across the two tables
-- Or..... that's the idea at any rate

SET @i = 1
WHILE @i <= @MaxLen BEGIN
	
	-- Going to stop for the day here
	SELECT @i
	-- Going to stop for the day here
	
	SET @i += 1
	END
