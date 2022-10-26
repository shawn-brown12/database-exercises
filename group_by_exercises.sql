USE employees;

#Q2 In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

SELECT DISTINCT title
FROM titles;

#There are 7 unique titles 

#Q3 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE 'e%e';

#Q4 Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT first_name, last_name
FROM employees
GROUP BY first_name, last_name
HAVING last_name LIKE 'e%e'; 

#Q5 Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%'; 

#Results - Chleq Lindqvist Qiwen

#Q6 Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

#Q7 Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(*) AS total
FROM employees
GROUP BY first_name, gender
HAVING first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name;

#Q8 Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), "_", SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2))) AS employee_username, COUNT(*) AS count_user
FROM employees
GROUP BY employee_username
HAVING count_user > 1;

#13251 Records returned as duplicated

#Bonus Questions:
#Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

SELECT AVG(salary)
FROM salaries;

#Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

SELECT dept_no, COUNT(emp_no) AS num_in_dept
FROM dept_emp
GROUP BY dept_no;

#Determine how many different salaries each employee has had. This includes both historic and current.

SELECT emp_no, COUNT(salary) AS salary_changes
FROM salaries
GROUP BY emp_no;

#Find the maximum salary for each employee.

SELECT emp_no, MAX(salary) AS highest_pay
FROM salaries
GROUP BY emp_no;

#Find the minimum salary for each employee.

SELECT emp_no, MIN(salary) AS lowest_pay
FROM salaries
GROUP BY emp_no;

#Find the standard deviation of salaries for each employee.

SELECT emp_no, STDDEV(salary) AS standard_deviation
FROM salaries
GROUP BY emp_no;

#Now find the max salary for each employee where that max salary is greater than $150,000.

SELECT emp_no, MAX(salary) AS highest_paid
FROM salaries
GROUP BY emp_no
HAVING highest_paid > 150000;

#Find the average salary for each employee where that average salary is between $80k and $90k.

SELECT emp_no, AVG(salary) AS pay
FROM salaries
GROUP BY emp_no
HAVING pay BETWEEN 80000 AND 90000;