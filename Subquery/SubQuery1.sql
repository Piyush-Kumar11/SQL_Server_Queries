-- Retrieve all data from Employees and Departments
SELECT * FROM Employees;
SELECT * FROM Departments;

-- Non-Correlated Subquery:
---------------------------
-- Find the employee with the maximum salary
SELECT *
FROM Employees
WHERE salary = (SELECT MAX(salary) FROM Employees);

-- Retrieve employees working in the 'HR' department
SELECT *
FROM Employees
WHERE department_id IN (
    SELECT department_id
    FROM Departments
    WHERE department_name = 'HR'
);

-- Employees in departments with more than one employee
SELECT *
FROM Employees
WHERE department_id IN (
    SELECT department_id
    FROM Employees
    GROUP BY department_id
    HAVING COUNT(*) > 1
);

-- Employees not in the 'IT' department
SELECT *
FROM Employees
WHERE department_id NOT IN (
    SELECT department_id
    FROM Departments
    WHERE department_name = 'IT'
);

-- Employees with salaries below the company average
SELECT *
FROM Employees
WHERE salary < (
    SELECT AVG(salary)
    FROM Employees
);

-- Department with the highest number of employees
SELECT department_name
FROM Departments
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM Employees
    GROUP BY department_id
    ORDER BY COUNT(*) DESC
);

-- Employees earning less than the lowest salary in the 'Marketing' department
SELECT *
FROM Employees
WHERE salary < (
    SELECT MIN(salary)
    FROM Employees
    WHERE department_id = (
        SELECT department_id
        FROM Departments
        WHERE department_name = 'Marketing'
    )
);

-- Departments without any employees
SELECT *
FROM Departments
WHERE department_id NOT IN (
    SELECT DISTINCT department_id
    FROM Employees
);

-- Employees earning the second-highest salary
SELECT *
FROM Employees
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
    WHERE salary < (SELECT MAX(salary) FROM Employees)
);

-- Retrieve the department name with the lowest salary paid to an employee
SELECT department_name
FROM Departments
WHERE department_id = (
    SELECT department_id
    FROM Employees
    WHERE salary = (SELECT MIN(salary) FROM Employees)
);

-- Correlated Subquery:
-----------------------
-- Find employees earning above the average salary in their department
SELECT e1.name, e1.salary
FROM Employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM Employees e2
    WHERE e2.department_id = e1.department_id
);

-- Employees in the same department as 'Alice'
SELECT *
FROM Employees
WHERE department_id = (
    SELECT department_id
    FROM Employees
    WHERE name = 'Alice'
);

-- Employees who earn more than the average salary across all departments combined
SELECT *
FROM Employees e1
WHERE e1.salary > (
    SELECT AVG(salary)
    FROM Employees e2
);

-- Employees with salaries greater than the salary of their department manager
-- Assuming a manager's salary is the maximum in the department
SELECT *
FROM Employees e1
WHERE e1.salary > (
    SELECT MAX(e2.salary)
    FROM Employees e2
    WHERE e2.department_id = e1.department_id
);

-- EXISTS Subquery:
--------------------
-- List departments with at least one employee
SELECT department_name
FROM Departments d
WHERE EXISTS (
    SELECT *
    FROM Employees e
    WHERE e.department_id = d.department_id
);

-- Check if any department has no employees
SELECT department_name
FROM Departments d
WHERE NOT EXISTS (
    SELECT *
    FROM Employees e
    WHERE e.department_id = d.department_id
);

-- ANY Subquery:
-----------------
-- Retrieve employees earning more than any employee in the 'Marketing' department
SELECT *
FROM Employees
WHERE salary > ANY (
    SELECT salary
    FROM Employees
    WHERE department_id = (
        SELECT department_id
        FROM Departments
        WHERE department_name = 'Marketing'
    )
);

-- Retrieve employees earning a salary higher than at least one employee in the company
SELECT *
FROM Employees
WHERE salary > ANY (
    SELECT salary
    FROM Employees
);

-- ALL Subquery:
-----------------
-- Retrieve employees earning more than all employees in the 'Finance' department
SELECT name, salary
FROM Employees
WHERE salary > ALL (
    SELECT salary
    FROM Employees
    WHERE department_id = (
        SELECT department_id
        FROM Departments
        WHERE department_name = 'Finance'
    )
);

-- Retrieve employees earning less than all employees in the 'IT' department
SELECT name, salary
FROM Employees
WHERE salary < ALL (
    SELECT salary
    FROM Employees
    WHERE department_id = (
        SELECT department_id
        FROM Departments
        WHERE department_name = 'IT'
    )
);

-- Retrieve the department(s) where all employees earn above the company average salary
SELECT department_name
FROM Departments d
WHERE NOT EXISTS (
    SELECT *
    FROM Employees e
    WHERE e.department_id = d.department_id
    AND e.salary <= (SELECT AVG(salary) FROM Employees)
);
