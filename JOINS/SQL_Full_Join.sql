-- Select all columns from the employees table
SELECT * FROM employees;

-- Select all columns from the departments table
SELECT * FROM departments;

-- Basic FULL JOIN: Get all employees and all departments, even if they don't have matching records
-- If an employee doesn't belong to a department, department_name will be NULL
-- If a department doesn't have any employees, employee_name will be NULL
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- FULL JOIN with WHERE clause: Filter results to show only employees named 'David' 
-- and their corresponding departments (if any)
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
WHERE 
    employees.employee_name = 'David';

-- FULL JOIN with sorting: Get all employees and departments, ordered by employee name
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
ORDER BY 
    employees.employee_name;

-- FULL JOIN with aggregation: Count the number of employees in each department, including departments with no employees
SELECT 
    departments.department_name, 
    COUNT(employees.employee_id) AS TotalEmployees
FROM 
    departments
FULL JOIN 
    employees 
ON 
    departments.department_id = employees.department_id
GROUP BY 
    departments.department_name
ORDER BY 
    TotalEmployees DESC;

-- FULL JOIN with DISTINCT: Ensure only unique department-employee combinations are returned
SELECT DISTINCT
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- FULL JOIN with NULL filter: Get employees with no departments or departments with no employees
-- If the employee_name is NULL, the employee doesn't belong to any department
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
FULL JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
WHERE 
    employees.employee_name IS NULL 
    OR departments.department_name IS NULL;