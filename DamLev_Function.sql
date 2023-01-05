--
-- Alex Schmaus 1/5/2023
-- An implementation of Damerau–Levenshtein distance in Transact SQL
--

-- The two strings to compare
DECLARE @A varchar(256) = 'Alex Shmus'
DECLARE @B varchar(256) = 'Alex Schmaus'

-- The size of the alphabet
DECLARE @Alpha int = 26
-- The output - how "different" are the strings?
DECLARE @Distance int



DECLARE @da table (i int, val int)

;WITH cteNums AS (
	SELECT 
		ROW_NUMBER() OVER (ORDER BY name) AS RwNm
	FROM sys.objects
)
INSERT INTO @da
SELECT 
	RwNm, 0
FROM cteNums
WHERE RwNm <= @Alpha

SELECT * FROM @da
