-- Find employees with salaries above the average salary in their department
WITH DeptAvgSalaryCTE AS (
    SELECT department_id, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY department_id
)
SELECT E.employee_id, E.name, E.salary, E.department_id
FROM Employees E
JOIN DeptAvgSalaryCTE CTE
    ON E.department_id = CTE.department_id
WHERE E.salary > CTE.AvgSalary;

-- Update employee salary for those in the HR department
WITH HR_DepartmentsCTE AS (
    SELECT department_id
    FROM Departments
    WHERE department_name = 'HR'
)
UPDATE Employees
SET salary = salary + 5000
WHERE department_id IN (SELECT department_id FROM HR_DepartmentsCTE);

-- Find departments where the total salary expense exceeds $1,00,000
WITH DepartmentSalaryExpenseCTE AS (
    SELECT department_id, SUM(Salary) AS TotalSalaryExpense
    FROM Employees
    GROUP BY department_id
)
SELECT D.department_id, D.department_name
FROM Departments D
JOIN DepartmentSalaryExpenseCTE CTE
    ON D.department_id = CTE.department_id
WHERE CTE.TotalSalaryExpense > 100000;

-- Find employees who have a higher salary than their department's average salary
WITH DeptAvgSalaryCTE AS (
    SELECT department_id, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY department_id
)
SELECT E.employee_id, E.name, E.salary, E.department_id
FROM Employees E
JOIN DeptAvgSalaryCTE CTE
    ON E.department_id = CTE.department_id
WHERE E.salary > CTE.AvgSalary;

-- Find employees who worked in more than one department
WITH EmployeeDepartmentsCTE AS (
    SELECT employee_id, COUNT(DISTINCT department_id) AS department_count
    FROM Employees
    GROUP BY employee_id
)
SELECT E.employee_id, E.name
FROM Employees E
JOIN EmployeeDepartmentsCTE CTE
    ON E.employee_id = CTE.employee_id
WHERE CTE.department_count > 1;

-- Find the highest-paid employee in each department
WITH MaxSalaryCTE AS (
    SELECT department_id, MAX(Salary) AS MaxSalary
    FROM Employees
    GROUP BY department_id
)
SELECT E.employee_id, E.name, E.salary, E.department_id
FROM Employees E
JOIN MaxSalaryCTE CTE
    ON E.department_id = CTE.department_id
WHERE E.salary = CTE.MaxSalary;

-- Find employees with salaries higher than the average salary of all employees
WITH AvgSalaryCTE AS (
    SELECT AVG(Salary) AS AvgSalary
    FROM Employees
)
SELECT E.employee_id, E.name, E.salary
FROM Employees E
JOIN AvgSalaryCTE CTE
    ON E.salary > CTE.AvgSalary;

-- Find the number of employees in each department
WITH EmployeeCountCTE AS (
    SELECT department_id, COUNT(employee_id) AS EmployeeCount
    FROM Employees
    GROUP BY department_id
)
SELECT D.department_name, E.EmployeeCount
FROM Departments D
JOIN EmployeeCountCTE E
    ON D.department_id = E.department_id;

--Find employees whose salary is below the average salary in their department and update them
WITH DeptAvgSalaryCTE AS (
    SELECT department_id, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY department_id
)
UPDATE Employees
SET salary = salary + 2000
WHERE department_id IN (SELECT department_id FROM DeptAvgSalaryCTE WHERE Salary < AvgSalary);