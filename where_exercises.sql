USE employees;

#Q2 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya');

#709 records returned

#Q3 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

SELECT *
FROM employees
WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

#709 records returned, same number as answer for Q2

#Q4 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE (first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya')
	AND gender = 'M';
	
#441 Records returned

#Q5 Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.

SELECT *
FROM employees
WHERE last_name LIKE 'e%';

#7330 Records returned

#Q6 Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?

SELECT *
FROM employees
WHERE last_name LIKE 'e%' OR last_name LIKE '%e';

SELECT *
FROM employees
WHERE last_name LIKE '%e' AND last_name NOT LIKE 'e%';

#This query is just me double checking the opposite to make sure the numbers add up
SELECT * 
FROM employees
WHERE last_name LIKE 'e%' AND last_name NOT LIKE '%e';


#30723 Records returned for employees whose last names either start OR end with e; 23393 Records returned for employees whose last names ended with e, but didnt start with e

#Q7 Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees last names end with E, regardless of whether they start with E?

SELECT *
FROM employees
WHERE last_name LIKE 'e%e';

SELECT *
FROM employees
WHERE last_name LIKE '%e';

#899 Records found for employees whose last names start and end with e; 24292 Records found for employees whose last names end with e, reguardless of what they start with.

#Q8 Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE hire_date LIKE '199%';

#The next two queries are me double checking the numbers
SELECT *
FROM employees;

SELECT *
FROM employees
WHERE hire_date NOT LIKE '199%';

#135214 Records returned for employees hired in the 90s

#Q9 Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25';

#842 Records returned for employees born on Christmas

#Q10 Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.

SELECT *
FROM employees
WHERE birth_date LIKE '%-12-25' AND hire_date LIKE '199%';

#362 Records returned for employees born on Christmas and hired in the 90s

#Q11 Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

SELECT *
FROM employees
WHERE last_name LIKE '%q%';

#1873 Records returned for employees with q in their last name

#Q12 Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

SELECT *
FROM employees
WHERE last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

#547 Record returned with employees whose last names have q but not qu
