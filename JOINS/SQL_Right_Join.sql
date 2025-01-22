-- Select all columns from the employees table
SELECT * FROM employees;

-- Select all columns from the departments table
SELECT * FROM departments;

-- Basic RIGHT JOIN: Get all departments and their corresponding employee names
-- If a department has no employees, the employee_name will be NULL
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- RIGHT JOIN with WHERE clause to filter by department
-- This will include all departments, even those with NULL employee names, but filter out only those in 'Sales' department
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
WHERE 
    departments.department_name = 'Sales';

-- RIGHT JOIN with sorting: Get departments and employees, ordered by employee name
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
ORDER BY 
    employees.employee_name;

-- RIGHT JOIN with aggregation: Count the number of employees in each department, including departments with no employees
SELECT 
    departments.department_name, 
    COUNT(employees.employee_id) AS TotalEmployees
FROM 
    departments
RIGHT JOIN 
    employees
ON 
    departments.department_id = employees.department_id
GROUP BY 
    departments.department_name
ORDER BY 
    TotalEmployees DESC;

-- RIGHT JOIN with DISTINCT: Ensure that only unique department-employee combinations are returned
SELECT DISTINCT
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- RIGHT JOIN with NULL filter: Get departments that have no employees (NULL employee_name)
SELECT 
    employees.employee_name AS E_Name, 
    departments.department_name
FROM 
    employees
RIGHT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
WHERE 
    employees.employee_name IS NULL;