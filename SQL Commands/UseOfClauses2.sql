-- Using the SELECT TOP clause
--Examples

-- 1. Fetch the youngest person (based on Age)
SELECT TOP 1 First_Name
FROM Person
ORDER BY Age;
-- Explanation: Retrieves the first row with the smallest Age after sorting in ascending order.

-- 2. Fetch all persons who share the youngest age
SELECT TOP 1 WITH TIES *
FROM Person
ORDER BY Age;
-- Explanation: `WITH TIES` includes additional rows with the same Age as the youngest. 
-- Useful when multiple people have the same lowest Age.

-- 3. Fetch the first 25% of data from the Person table, sorted by Id
SELECT TOP 25 PERCENT First_Name, Last_Name
FROM Person
ORDER BY Id;
-- Explanation: Retrieves the top 25% of rows based on the total row count, ordered by Id.

-- 4. Fetch the oldest person (highest Age)
SELECT TOP 1 First_Name, Last_Name
FROM Person
ORDER BY Age DESC;
-- Explanation: Retrieves the first row with the largest Age by sorting in descending order.

-- 5. Fetch the top 3 oldest people
SELECT TOP 3 First_Name, Last_Name, Age
FROM Person
ORDER BY Age DESC;
-- Explanation: Retrieves the top 3 rows with the largest Age values in descending order.

-- 6. Fetch the first 50% of data from the table, sorted by Age
SELECT TOP 50 PERCENT *
FROM Person
ORDER BY Age;
-- Explanation: Retrieves the first 50% of rows, ordered by Age, to analyze a subset of the data.

-- 7. Fetch the top 5 people from Bihar, sorted by Age
SELECT TOP 5 *
FROM Person
WHERE State = 'Bihar'
ORDER BY Age;
-- Explanation: Retrieves the first 5 rows from Bihar based on ascending Age.

-- 8. Fetch all rows where the Age is in the top 10%
SELECT TOP 10 PERCENT *
FROM Person
ORDER BY Age DESC;
-- Explanation: Retrieves the top 10% of rows with the largest Age values.

-- 9. Fetch the top person with the highest Pincode
SELECT TOP 1 First_Name, Pincode
FROM Person
ORDER BY Pincode DESC;
-- Explanation: Retrieves the person with the highest Pincode, sorting in descending order.

-- 10. Fetch 2 people from each state (if tied, include all rows with the same sorting value)
SELECT TOP 2 WITH TIES *
FROM Person
ORDER BY State, Age;
-- Explanation: For each state, retrieves 2 rows ordered by Age. 
-- `WITH TIES` ensures inclusion of additional rows with identical Age values.

-- Notes:
-- `TOP` is commonly used in SQL Server for row limiting.
-- Always pair it with `ORDER BY` to ensure predictable results.
-- For large datasets or performance-sensitive queries, consider indexing on the `ORDER BY` column(s).
