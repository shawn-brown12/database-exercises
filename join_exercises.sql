USE employees;

#Q2 Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

#Common link between the dept_manager and departments table is the dept_no key, which is the primary in departments table, then link the dept_manager table to the emnployees via emp_no and pull first and last names
#Have to filter out past managers for each department via the to_date column

SELECT departments.dept_name, dept_manager.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM dept_manager
	JOIN departments USING(dept_no)
	JOIN employees ON dept_manager.emp_no = employees.emp_no
	WHERE dept_manager.to_date = '9999-01-01';


#Q3 Find the name of all departments currently managed by women.

SELECT departments.dept_name, dept_manager.emp_no, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name
FROM dept_manager
	JOIN departments USING(dept_no)
	JOIN employees ON dept_manager.emp_no = employees.emp_no
	WHERE employees.gender = 'F' AND dept_manager.to_date = '9999-01-01';

#Q4 Find the current titles of employees currently working in the Customer Service department.

# Workflow > start in titles for title > join to employees to concat first/last names via emp_no > join employees to dept_emp for dept_no via emp_no > join to department via dept_no > filter out old employees with where
 
SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, titles.title, dept_name
FROM titles
	JOIN employees USING(emp_no)
	JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
	JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date = '9999-01-01' AND titles.to_date = '9999-01-01';

#Q5 Find the current salary of all current managers.

SELECT CONCAT(employees.first_name, ' ', employees.last_name), salaries.salary
FROM dept_manager
	JOIN employees USING(emp_no)
	JOIN salaries USING(emp_no)
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';

#Q6 Find the number of current employees in each department.

SELECT dept_name, COUNT(emp_no)
FROM departments
	JOIN dept_emp USING(dept_no)
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY dept_name;

#Q7 Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salary) AS avg_salary
FROM departments
	JOIN dept_emp USING(dept_no)
	JOIN salaries USING(emp_no)
WHERE salaries.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY  avg_salary DESC;

#Q8 Who is the highest paid employee in the Marketing department?

SELECT dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, MAX(salary) AS max_salary
FROM dept_emp
	JOIN departments USING(dept_no)
	JOIN employees USING(emp_no)
	JOIN salaries USING(emp_no)
WHERE departments.dept_name = 'Marketing' AND dept_emp.to_date = '9999-01-01'
GROUP BY full_name
ORDER BY max_salary DESC
LIMIT 1;

#Q9 Which current department manager has the highest salary?

SELECT dept_name, CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, salary
FROM dept_manager
	JOIN departments USING(dept_no)
	JOIN employees USING(emp_no)
	JOIN salaries USING(emp_no)
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
ORDER BY salary DESC
LIMIT 1;

#Q10 Determine the average salary for each department. Use all salary information and round your results.

SELECT dept_name, ROUND(AVG(salary) ,2) AS 'avg'
FROM departments
	JOIN dept_emp USING(dept_no)
	JOIN salaries USING(emp_no)
GROUP BY dept_name;

#Q11 Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(employees.first_name, ' ', employees.last_name) AS full_name, dept_name, 
		CONCAT(e.first_name, ' ', e.last_name) AS manager_name
FROM employees
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
	JOIN dept_manager USING(dept_no)
	JOIN employees AS e ON dept_manager.emp_no = e.emp_no
	WHERE dept_emp.to_date = '9999-01-01' AND dept_manager.to_date = '9999-01-01';
	
#Q12 Bonus Who is the highest paid employee within each department?


	 
