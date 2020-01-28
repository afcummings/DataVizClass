--THE PROBLEMS

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.gender, Salaries.salary
FROM Employees
JOIN Salaries
ON Employees.emp_no = Salaries.emp_no;

SELECT first_name, last_name, hire_date 
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01';

SELECT Departments.dept_no, Departments.dept_name, Dept_manager.emp_no, Employees.last_name, Employees.first_name, Dept_manager.from_date, Dept_manager.to_date
FROM Departments
JOIN Dept_manager
ON Departments.dept_no = Dept_manager.dept_no
JOIN Employees
ON Dept_manager.emp_no = Employees.emp_no;

SELECT Dept_emp.emp_no, Employees.last_name, Departments.dept_name, Employees.first_name
FROM Dept_emp
JOIN Employees
ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments
ON Dept_emp.dept_no = Departments.dept_no;

SELECT first_name, last_name
FROM Employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

SELECT Employees.last_name, Employees.first_name, Dept_emp.emp_no, Departments.dept_name
FROM Dept_emp
JOIN Employees
ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments
ON Dept_emp.dept_no = Departments.dept_no
WHERE Departments.dept_name = 'Sales';

SELECT Employees.first_name, Dept_emp.emp_no, Employees.last_name, Departments.dept_name
FROM Dept_emp
JOIN Employees
ON Dept_emp.emp_no = Employees.emp_no
JOIN Departments
ON Dept_emp.dept_no = Departments.dept_no
WHERE Departments.dept_name = 'Sales' 
OR Departments.dept_name = 'Development';

SELECT last_name,
COUNT(last_name) AS "frequency"
FROM Employees
GROUP BY last_name
ORDER BY
COUNT(last_name) DESC;