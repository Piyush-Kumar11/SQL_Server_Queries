-- View all records from employees table
SELECT * FROM employees;

-- View all records from departments table
SELECT * FROM departments;

-- Perform Inner Join to find matching department_id in both tables
SELECT 
    e.employee_name AS EmployeeName, 
    d.department_name AS DepartmentName
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.department_id = d.department_id;


	-----------------------------------------
SELECT 
    e.employee_id AS Emp_Id, 
    e.employee_name AS Emp_Name, 
    d.department_name AS Dept_Name
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.department_id = d.department_id;

	-------------------WHERE----------------------
SELECT 
    e.employee_name AS Emp_Name, 
    d.department_name AS Dept_Name
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.department_id = d.department_id
WHERE 
    d.department_name = 'HR';

	------------------Order By-----------------------
SELECT 
    e.employee_name, 
    d.department_name 
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.department_id = d.department_id
ORDER BY 
    d.department_name, e.employee_name;

	------------------Order By-----------------------
SELECT 
    d.department_name, 
    COUNT(e.employee_id) AS TotalEmployees 
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.department_id = d.department_id
GROUP BY 
    d.department_name
ORDER BY 
    TotalEmployees DESC;

	------------------Distinct-----------------------
SELECT DISTINCT
    e.employee_name, 
    d.department_name 
FROM 
    employees e
INNER JOIN 
    departments d
ON 
    e.department_id = d.department_id;
