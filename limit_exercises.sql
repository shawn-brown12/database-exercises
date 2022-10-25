USE employees;

SELECT DISTINCT title 
FROM titles;

#Q2 List the first 10 distinct last name sorted in descending order.

SELECT DISTINCT *
FROM employees
ORDER BY last_name DESC 
LIMIT 10;

# The last name for the last ten employess sorted alphabetically in descending order is Zykh for all of them

#Q3 Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

SELECT *
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5;

#The names of the five employees returned are : Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, and Petter Stroustrup

#Q4 Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results.

#LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

SELECT *
FROM employees
WHERE hire_date LIKE '199%' AND birth_date LIKE '%-12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45;

#LIMIT and OFFSET here are related in that OFFSET is skipping the first 45 records in the data, and from there is outputting what is left, with the LIMIT limiting the amount of results given. The page number here is 10, because with a limit of 5 per page, to get to 10 we need to get the first 9 pages out of the way, which is 45

