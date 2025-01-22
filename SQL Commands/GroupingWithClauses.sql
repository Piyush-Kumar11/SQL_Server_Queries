--Grouping Data
-- 1. Simple GROUP-BY with COUNT
-- Total number of people in each state
SELECT State, COUNT(*) AS Total_People
FROM Person
GROUP BY State;

-- 2. GROUP BY with HAVING
-- Total number of people in each state, filtering those with more than 2 people
SELECT State, COUNT(*) AS Total_People
FROM Person
GROUP BY State
HAVING COUNT(*) > 2;

-- 3. GROUP BY with ROLLUP
-- Total people by state and grand total (Including subtotals)
SELECT State, COUNT(*) AS Total_People
FROM Person
GROUP BY ROLLUP(State);

-- 4. GROUP BY with CUBE
-- Total people by state and age, showing all combinations including subtotals
SELECT State, Age, COUNT(*) AS Total_People
FROM Person
GROUP BY CUBE(State, Age);

-- 5. GROUP BY with GROUPING SETS
-- Total number of people by state, age, and combinations of both
SELECT State, Age, COUNT(*) AS Total_People
FROM Person
GROUP BY GROUPING SETS ((State), (Age), (State, Age), ());

-- 6. Aggregate Functions in GROUP BY
-- Average age of people in each state
SELECT State, AVG(Age) AS Average_Age
FROM Person
GROUP BY State;

-- 7. GROUP BY with Multiple Columns
-- Total people in each state and age group
SELECT State, Age, COUNT(*) AS Total_People
FROM Person
GROUP BY State, Age;

-- 8. GROUP BY with ORDER BY
-- Total people in each state, ordered by total people descending
SELECT State, COUNT(*) AS Total_People
FROM Person
GROUP BY State
ORDER BY COUNT(*) DESC;

-- 9. GROUP BY with SUM and HAVING
-- Total sum of pin codes in each state, only showing states with a total sum greater than 500000
SELECT State, SUM(Pincode) AS Total_Pincode
FROM Person
GROUP BY State
HAVING SUM(Pincode) > 500000;

-- 10. GROUP BY with WHERE Clause
-- People from each state where the age is greater than 20
SELECT State, COUNT(*) AS Total_People
FROM Person
WHERE Age > 20
GROUP BY State;

-- 11. GROUP BY with ALIASES
-- Total people by state, with alias for state and population
SELECT State AS Region, COUNT(*) AS Population
FROM Person
GROUP BY State;

-- 12. GROUP BY with LIKE Operator
-- People whose first name starts with 'P', grouped by state
SELECT State, COUNT(*) AS Total_People
FROM Person
WHERE First_Name LIKE 'P%'
GROUP BY State;

-- 14. GROUP BY with COUNT DISTINCT
-- Counting distinct first names in each state
SELECT State, COUNT(DISTINCT First_Name) AS Unique_Names
FROM Person
GROUP BY State;

-- 15. GROUP BY with Multiple Aggregate Functions
-- Average age and total number of people in each state
SELECT State, AVG(Age) AS Average_Age, COUNT(*) AS Total_People
FROM Person
GROUP BY State;

-- 16. GROUP BY with ORDER BY and DESC
-- Total number of people in each state, ordered by population descending
SELECT State, COUNT(*) AS Total_People
FROM Person
GROUP BY State
ORDER BY Total_People DESC;

-- 18. GROUP BY with MIN/MAX
-- Finding the youngest and oldest person in each state
SELECT State, MIN(Age) AS Youngest_Age, MAX(Age) AS Oldest_Age
FROM Person
GROUP BY State;

-- 19. GROUP BY with CONCAT
-- Concatenating first and last names and counting occurrences
SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name, COUNT(*) AS Total_People
FROM Person
GROUP BY CONCAT(First_Name, ' ', Last_Name);

-- 20. GROUP BY with subquery
-- People with average age greater than 25, grouped by state
SELECT State, AVG(Age) AS Average_Age
FROM Person
WHERE Age > (SELECT AVG(Age) FROM Person)
GROUP BY State;