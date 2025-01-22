-- Selecting all data from the employees table
SELECT * 
FROM employees;

-- Selecting all data from the departments table
SELECT * 
FROM departments;

-- Performing CROSS JOIN to generate all possible combinations of employees and departments
SELECT employees.employee_name, departments.department_name
FROM employees
CROSS JOIN departments;

-- Filtering the result using WHERE clause to show only employees in the 'HR' department
SELECT employees.employee_name, departments.department_name
FROM employees
CROSS JOIN departments
WHERE departments.department_name = 'HR';  -- Only HR department employees are selected

-- Sorting the result alphabetically by employee name using ORDER BY
SELECT employees.employee_name, departments.department_name
FROM employees
CROSS JOIN departments
ORDER BY employees.employee_name;  -- The result will be sorted by employee names in ascending order

-- Using GROUP BY to group results by employee and department, and HAVING to ensure non-zero department counts
SELECT employees.employee_name, departments.department_name
FROM employees
CROSS JOIN departments
GROUP BY employees.employee_name, departments.department_name  -- Grouping by employee and department
HAVING COUNT(departments.department_name) > 0;  -- Ensures that the result only includes valid department combinations

-- Using CONCAT to generate a sentence showing which employee works in which department
SELECT employees.employee_name, departments.department_name,
       CONCAT(employees.employee_name, ' works in ', departments.department_name) AS report
FROM employees
CROSS JOIN departments;  -- Creates a descriptive report combining employee and department names

-- Limiting the results to the top 10 employee-department combinations (useful for large datasets)
SELECT TOP 10 employees.employee_name, departments.department_name
FROM employees
CROSS JOIN departments;  -- Shows only the first 10 combinations

-- Using a nested query to display the total number of employees in the result set
SELECT employees.employee_name, departments.department_name,
       (SELECT COUNT(*) FROM employees) AS total_employees  -- Nested query to count all employees
FROM employees
CROSS JOIN departments;  -- Shows the total number of employees for each employee-department pair
