USE employees;

#Q1 Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT CONCAT(first_name, ' ', last_name) AS full_name, hire_date
FROM employees
WHERE hire_date = (SELECT hire_date FROM employees WHERE emp_no = 101010);

#Subquery here is to grab all employee hire dates with matching employee number to compare to hire dates in main query

#Q2 Find all the titles ever held by all current employees with the first name Aamod.

SELECT CONCAT(first_name, ' ', last_name) AS full_name, title, emp_no
FROM employees
JOIN dept_emp USING(emp_no)
JOIN titles USING(emp_no)
WHERE dept_emp.to_date > CURDATE() AND first_name = 'Aamod';

/*SELECT *
FROM titles
WHERE emp_no = (SELECT emp_no, first_name
			     	 FROM employees
					 	 WHERE first_name = 'Aamod'
					 );	 */

#Q3 How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT DISTINCT emp_no
FROM employees
JOIN dept_emp USING(emp_no) 
JOIN salaries USING(emp_no)
JOIN titles USING(emp_no)
WHERE titles.to_date < CURDATE() AND salaries.to_date < CURDATE() AND dept_emp.to_date < CURDATE()
;
#Q4 Find all the current department managers that are female. List their names in a comment in your code.

SELECT CONCAT(first_name, ' ', last_name), dept_name
FROM employees
JOIN dept_manager USING(emp_no)
JOIN departments USING(dept_no)
WHERE to_date > NOW() AND gender = 'F';
#ISamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

#Q5 Find all the employees who currently have a higher salary than the companies overall, historical average salary.

SELECT emp_no, CONCAT(first_name, ' ', last_name) AS full_name, MAX(salary) as highest
FROM employees
JOIN salaries USING(emp_no)
WHERE salary > (SELECT AVG(salary)
				FROM salaries
					WHERE to_date > NOW()
					)
GROUP BY emp_no, full_name;
				
SELECT AVG(salary)
FROM salaries
WHERE to_date < NOW();

#Q6 How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

#Hint You will likely use multiple subqueries in a variety of ways
#Hint It's a good practice to write out all of the small queries that you can. Add a comment above the query showing the number of rows returned. You will use this number (or the query that produced it) in other, larger queries.

#Bonus Questions

#Find all the department names that currently have female managers.

#Find the first and last name of the employee with the highest salary.

#Find the department name that the employee with the highest salary works in.