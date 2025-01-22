-- Filtering using Clauses

-- 1. DISTINCT Clause: Removes duplicate rows

-- Fetch all unique rows from the Person table
SELECT DISTINCT * 
FROM Person;

-- Fetch unique First_Name values where Age is greater than 28
SELECT DISTINCT First_Name 
FROM Person 
WHERE Age > 28;

-- Example: Fetch unique combinations of State and Pincode
SELECT DISTINCT State, Pincode 
FROM Person;

-- Example: Fetch unique Last_Name and Age where State is Karnataka
SELECT DISTINCT Last_Name, Age 
FROM Person 
WHERE State = 'Karnataka';

-- Example: Fetch unique ages of people who have a Pincode starting with '8'
SELECT DISTINCT Age 
FROM Person 
WHERE Pincode LIKE '8%';

-- 2. AND Operator: Combines multiple conditions; all must be true

-- Fetch names of people older than 20 and residing in Karnataka
SELECT First_Name 
FROM Person 
WHERE Age > 20 AND State = 'Karnataka';

-- Fetch all details of people named 'Piyush' residing in Bihar
SELECT * 
FROM Person 
WHERE First_Name = 'Piyush' AND State = 'Bihar';

-- Example: Fetch all details of people aged between 25 and 30 and living in Gujarat
SELECT * 
FROM Person 
WHERE Age BETWEEN 25 AND 30 AND State = 'Gujarat';

-- Example: Fetch names of people whose First_Name starts with 'A' and whose Age is greater than 22
SELECT First_Name 
FROM Person 
WHERE First_Name LIKE 'A%' AND Age > 22;

-- 3. OR Operator: Combines multiple conditions; at least one must be true

-- Fetch all details of people named 'Piyush' or residing in Gujarat
SELECT * 
FROM Person 
WHERE First_Name = 'Piyush' OR State = 'Gujarat';

-- Fetch names of people older than 20 or having Pincode 824217
SELECT First_Name 
FROM Person 
WHERE Age > 20 OR Pincode = 824217;

-- Example: Fetch details of people aged less than 18 or greater than 60
SELECT * 
FROM Person 
WHERE Age < 18 OR Age > 60;

-- Example: Fetch names of people with Last_Name ending in 'an' or living in Karnataka
SELECT First_Name 
FROM Person 
WHERE Last_Name LIKE '%an' OR State = 'Karnataka';

-- 4. IN Operator: Checks if a value matches any in the given list

-- Fetch all details of people aged 22, 24, or 25
SELECT * 
FROM Person 
WHERE Age IN (22, 24, 25);

-- Fetch First_Name and State for selected names
SELECT First_Name, State 
FROM Person 
WHERE First_Name IN ('Piyush', 'Rahul', 'Sneha');

-- Example: Fetch all details of people residing in specific states
SELECT * 
FROM Person 
WHERE State IN ('Bihar', 'Karnataka', 'Gujarat');

-- Example: Fetch details of people with Pincode from a given list
SELECT * 
FROM Person 
WHERE Pincode IN (824217, 560001, 110011);

-- 5. BETWEEN Clause: Filters data within a specified range (inclusive)

-- Fetch all details of people aged between 22 and 26
SELECT * 
FROM Person 
WHERE Age BETWEEN 22 AND 26;

-- Fetch all details of people with Id between 5 and 6 (inclusive)
SELECT * 
FROM Person 
WHERE Id BETWEEN 5 AND 6;

-- Example: Fetch names and ages of people between 30 and 40 years old
SELECT First_Name, Age 
FROM Person 
WHERE Age BETWEEN 30 AND 40;

-- Example: Fetch details of people whose Pincode falls in a specific range
SELECT * 
FROM Person 
WHERE Pincode BETWEEN 800000 AND 900000;

-- 6. LIKE Operator: Pattern matching using wildcards

-- Fetch names starting with 'P'
SELECT First_Name 
FROM Person 
WHERE First_Name LIKE 'P%';

-- Fetch all details of people whose Last_Name ends with 'ar' (e.g., Kumar)
SELECT * 
FROM Person 
WHERE Last_Name LIKE '%ar';

-- Fetch names containing the substring 'am'
SELECT First_Name 
FROM Person 
WHERE First_Name LIKE '%am%';

-- Example: Fetch details of people whose State name starts with 'K'
SELECT * 
FROM Person 
WHERE State LIKE 'K%';

-- Example: Fetch names of people whose First_Name has exactly 5 characters
SELECT First_Name 
FROM Person 
WHERE First_Name LIKE '_____';

-- 7. Aliases: Assign temporary names to columns or tables

-- Rename the First_Name column in the result set to 'n'
SELECT First_Name AS n 
FROM Person;

-- Rename columns First_Name to Name and Age to Years
SELECT First_Name AS Name, Age AS Years 
FROM Person;

-- Use an alias for the Person table (shortens references)
SELECT P.First_Name, P.Age 
FROM Person AS P;

-- Use table alias to filter data
SELECT p.First_Name, p.Age 
FROM Person AS p 
WHERE p.State = 'Bihar';

-- Example: Combine aliases with calculations
SELECT P.First_Name AS Name, P.Age + 5 AS Age_In_5_Years 
FROM Person AS P;

-- Example: Use aliases in a JOIN (if applicable)
-- Assuming another table called Orders with a column Person_Id
SELECT p.First_Name, o.Order_Id 
FROM Person AS p 
JOIN Orders AS o ON p.Id = o.Person_Id;
