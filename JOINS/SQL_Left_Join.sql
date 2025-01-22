-- Select all columns from the employees table
SELECT * FROM employees;

-- Select all columns from the departments table
SELECT * FROM departments;

-- Basic LEFT JOIN: Get all employees and their corresponding department names
-- If an employee doesn't belong to any department, the department_name will be NULL
SELECT 
    employees.employee_name, 
    departments.department_name
FROM 
    employees
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- LEFT JOIN with WHERE clause to filter by department
-- This will include all employees, even those with NULL department names, but filter out only those in 'HR' department
SELECT 
    employees.employee_name, 
    departments.department_name
FROM 
    employees
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
WHERE 
    departments.department_name = 'HR';

-- LEFT JOIN with sorting: Get employees and departments, ordered by department_name
SELECT 
    employees.employee_name, 
    departments.department_name
FROM 
    employees
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
ORDER BY 
    departments.department_name;

-- LEFT JOIN with aggregation: Count the number of employees in each department, including departments with no employees
SELECT 
    departments.department_name, 
    COUNT(employees.employee_id) AS TotalEmployees
FROM 
    departments
LEFT JOIN 
    employees
ON 
    departments.department_id = employees.department_id
GROUP BY 
    departments.department_name
ORDER BY 
    TotalEmployees DESC;

-- LEFT JOIN with DISTINCT: Ensure that only unique department-employee combinations are returned
SELECT DISTINCT
    employees.employee_name, 
    departments.department_name
FROM 
    employees
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id;

-- LEFT JOIN with NULL filter: Get employees who do not belong to any department (NULL department_name)
SELECT 
    employees.employee_name, 
    departments.department_name
FROM 
    employees
LEFT JOIN 
    departments 
ON 
    employees.department_id = departments.department_id
WHERE 
    departments.department_name IS NULL;