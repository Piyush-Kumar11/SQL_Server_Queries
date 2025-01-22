-- 1. UNION - Combine results from two queries with distinct values
-- First names of people from Bihar & Karnataka (no duplicates)
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
UNION
SELECT First_Name
FROM Person
WHERE State = 'Karnataka';

-- 2. UNION ALL - Combine results from two queries including duplicates
-- First names of people from Bihar and Karnataka (including duplicates)
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
UNION ALL
SELECT First_Name
FROM Person
WHERE State = 'Karnataka';

-- 3. INTERSECT - Find common first names of people in both Bihar and Karnataka
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
INTERSECT
SELECT First_Name
FROM Person
WHERE State = 'Karnataka';

-- 4. EXCEPT - Find people who live in Bihar but not in Karnataka
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
EXCEPT
SELECT First_Name
FROM Person
WHERE State = 'Karnataka';

-- 5. UNION Example with more than two queries
-- First names of people from Bihar, Karnataka, and Maharashtra (no duplicates)
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
UNION
SELECT First_Name
FROM Person
WHERE State = 'Karnataka'
UNION
SELECT First_Name
FROM Person
WHERE State = 'Maharashtra';

-- 6. UNION ALL Example with more than two queries
-- First names of people from Bihar, Karnataka, and Maharashtra (including duplicates)
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
UNION ALL
SELECT First_Name
FROM Person
WHERE State = 'Karnataka'
UNION ALL
SELECT First_Name
FROM Person
WHERE State = 'Maharashtra';

-- 7. INTERSECT Example with more than two queries
-- Common first names between Bihar, Karnataka, and Maharashtra
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
INTERSECT
SELECT First_Name
FROM Person
WHERE State = 'Karnataka'
INTERSECT
SELECT First_Name
FROM Person
WHERE State = 'Maharashtra';

-- 8. EXCEPT Example with more than two queries
-- Find people who live in Bihar but not in Karnataka or Maharashtra
SELECT First_Name
FROM Person
WHERE State = 'Bihar'
EXCEPT
SELECT First_Name
FROM Person
WHERE State = 'Karnataka'
EXCEPT
SELECT First_Name
FROM Person
WHERE State = 'Maharashtra';
