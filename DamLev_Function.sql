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
-- 5 passes get us to 256, which is the lentgh of our input variables
DECLARE @Num table (N int)
;WITH 
	C1 AS (SELECT 1 AS N),
	C2 AS (SELECT 1 AS N FROM C1 UNION ALL SELECT N FROM C1),
	C3 AS (SELECT 1 AS N FROM C2 A CROSS APPLY C2 B),
	C4 AS (SELECT 1 AS N FROM C3 A CROSS APPLY C3 B),
	C5 AS (SELECT 1 AS N FROM C4 A CROSS APPLY C4 B)
INSERT INTO @Num
SELECT
	ROW_NUMBER() OVER (ORDER BY N)
FROM C5


DECLARE @Max int = @ALen + @BLen

DECLARE @ATbl table (Letter varchar, Distance int)
DECLARE @BTbl table (Letter varchar, Distance int)


