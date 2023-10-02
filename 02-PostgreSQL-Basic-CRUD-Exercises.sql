/*Exercises: PostgreSQL Basic CRUD 
This document defines the exercise assignments for the PostgreSQL course @ Software University.
Submit your solutions in the SoftUni Judge Contest.
Important: Throughout the course, you will receive different databases that may have similar names and structures 
but contain different data specific to each exercise. To ensure proper execution and avoid conflicts, it is crucial 
to create a new database for each exercise and import the provided file with the corresponding records. By following this approach, you can 
accurately work on each exercise and avoid any interference or data overlap between different exercises.

To begin, the initial step is to generate a database known as softuni_management_db and subsequently launch its query tool. Then, you need to 
download the file 02-Exercise-Basic-CRUD-softuni_management_db.sql from the course instance and import it into the query section of your database. 
Following the import process, you should run the queries included in the file. Once the queries have been executed, it is recommended that you become 
familiar with the database schemas and tables in the softuni_management_db before proceeding with the following tasks.
    1. Select Cities
Write a SQL query to retrieve all available information about the "cities", sorted by "id". 
Submit your query for this task in the Judge system.*/

SELECT * FROM cities
ORDER BY id;

    /*2. Concatenate
From the selected already data combine the "name" and "state", fields into a single field called "Cities Information". Rename the "area" column as "Area (km2)".
Submit your query for this task in the Judge system. */

SELECT
name ||' '||state AS "Cities Information",
area AS "Area (km2)"
FROM cities
ORDER BY id;


    /*3. Remove Duplicate Rows
As you can see, the "cities" table contains duplicate entries. Write an SQL query to retrieve DISTINCT city "name", sorting them in descending alphabetical order 
and eliminating duplicates. Do not forget to select the "area" column and keep the name of the column the same as in the previous task.
Submit your query for this task in the Judge system.*/

SELECT DISTINCT ON (name)
name,
area AS "Area (km2)"
FROM cities
ORDER BY name DESC;

    /*4. Limit Records
Develop a SQL query that selects from the "employees" table "id", "first_name", "last_name", and 
"job_title". Combine the "first_name" and "last_name" fields into a single field called "Full Name". Rename the "id" column as "ID" and the "job_title" 
column as "Job Title". Sort them by the "first_name" field in ascending alphabetical order. Finally, LIMIT the results to 50.
Submit your query for this task in the Judge system.*/

SELECT 
id AS "ID", 
first_name||' '|| last_name AS "Full Name",  
job_title AS "Job Title"
FROM employees
ORDER BY first_name
LIMIT 50;

    /*5. Skip Rows
Create a SQL query that selects the "employees" records including their "id", "first_name", "middle_name", "last_name", 
and "hire_date". Combine the "first_name", "middle_name" and "last_name", fields into a single field called "Full Name". Rename the "hire_date" column 
as "Hire Date". Sort the results by the "Hire Date" field in ascending order. Lastly, OFFSET the results by 10 rows.
*** Note that the OFFSET clause is zero-based, which means it skips the specified number of rows starting from 0.
Submit your query for this task in the Judge system.*/

SELECT 
id, 
first_name||' '|| middle_name||' '|| last_name AS "Full Name",  
hire_date AS "Hire Date"
FROM employees
ORDER BY hire_date
OFFSET 9;

    /*6. Find the Addresses
Select "id", "number", "street" and "city_id" from the "addresses" table WHERE "id" is greater than or equal to 20. Concatenate the "number" and 
"street" fields into a single field called "Address".
Submit your query for this task in the Judge system.*/

SELECT
id, 
number||' '|| street AS "Address",
city_id
FROM addresses
WHERE id >= 20;

   /* 7. Positive Even Number
Select "number" and "street" into one column called "Address" as well as "city_id", from the "addresses" table where "city_id" is a 
positive even number. Order them by the "city_id" field in ascending order.
Submit your query for this task in the Judge system.*/

SELECT
number||' '|| street AS "Address",
city_id
FROM addresses
WHERE city_id > 0 AND city_id % 2 = 0
ORDER BY city_id;

    /*8. Projects within a Date Range
Select the projects` "name" from the "projects" table where the "start_date" is greater than or equal to '2016-06-01 07:00:00' and the 
"end_date" is less than '2023-06-04 00:00:00'. Then, order the resulting rows in ascending order based on the "start_date" column.
Submit your query for this task in the Judge system.*/

SELECT
name,
start_date,
end_date
FROM projects
WHERE start_date >='2016-06-01 07:00:00' AND end_date < '2023-06-04 00:00:00'
ORDER BY start_date;

    /*9. Multiple Conditions
Write an SQL query to select "number" and "street" from the "addresses" table where "id" is BETWEEN 50 and 100 OR "number" is less than 1000.
Submit your query for this task in the Judge system.*/


SELECT
number,
street
FROM addresses
WHERE id BETWEEN 50 AND 100 OR number < 1000;


    /*10. Set of Values
From the "employees_projects" table, select "employee_id" and "project_id" where "employee_id" is IN the set of values (200, 250) and 
"project_id" is NOT IN the set of values (50, 100).
Submit your query for this task in the Judge system.*/

SELECT
employee_id, project_id
FROM employees_projects
WHERE employee_id IN (200, 250) AND project_id NOT IN (50, 100);

    /*11. Compare Character Values
Retrieve the first 20 records of the "name" and "start_date" columns from the "projects" table where the "name" is 'Mountain', 'Road', 
or 'Touring' using the IN operator.
*** Note that using the PostgreSQL IN condition can improve the statement's readability and efficiency.
Submit your query for this task in the Judge system.*/

SELECT
name,
start_date
FROM projects
WHERE name IN ('Mountain', 'Road', 'Touring')
LIMIT 20;

    /*12. Salary
Write a SQL query to find the "Full Name", "job_title" and "salary" of all employees whose salary is 12500, 14000, 23600, or 25000.
 "Full Name" is a combination of "first_name" and "last_name" (separated with a single space). Order by highest salary.
Submit your query for this task in the Judge system.*/

SELECT 
first_name||' '|| last_name AS "Full Name",  
job_title,
salary
FROM employees
WHERE salary IN (12500, 14000, 23600, 25000)
ORDER BY salary DESC;

    /*13. Missing Value
Develop a SQL query to find the first 3 employees with their "id", "first_name" and "last_name" where the "middle_name" is NULL.
Submit your query for this task in the Judge system.*/

SELECT
id,
first_name, 
last_name
FROM employees
WHERE middle_name IS NULL
LIMIT 3;

    /*14. INSERT Departments
Write a SQL query to create a few new records in the "departments" table. You can find the values below:
	('Finance', 3),
	('Information Services', 42),
	('Document Control', 90),
	('Quality Assurance', 274),
	('Facilities and Maintenance', 218),
	('Shipping and Receiving', 85),
	('Executive', 109);
Submit your query for this task in the Judge system.*/

INSERT INTO departments (department, manager_id)
VALUES 	('Finance', 3),
	('Information Services', 42),
	('Document Control', 90),
	('Quality Assurance', 274),
	('Facilities and Maintenance', 218),
	('Shipping and Receiving', 85),
	('Executive', 109);


    /*15. New Table 
Write a SQL query to generate a new table named "company_chart" by inserting data from the existing records. 
Retrieve the "Full Name" column which is a combination of the "first_name" and "last_name" columns from the "employees" table, 
and also select the "job_title" column, which should be renamed as "Job Title". Select the "department_id" column and rename it 
as "Department ID", and select the "manager_id" column, which should be renamed as "Manager ID".
Submit your query for this task in the Judge system.*/

CREATE TABLE company_chart
AS SELECT
first_name||' '|| last_name AS "Full Name",  
job_title AS "Job Title",
department_id AS "Department ID",
manager_id AS "Manager ID"
FROM employees;

    /*16. Update the Project End Date
Retrieve all projects without an "end_date", and add 5 months to their "start_date".
*** Note, you have the option to utilize the commutative pairs "+ INTERVAL" to increase the "start_date" by 5 months and determine the date after this duration.
Submit your query for this task in the Judge system.*/

UPDATE projects
SET end_date = start_date + interval '5 months'
WHERE end_date IS NULL;

    /*17. Award Employees with Experience
Get all employees who were hired between January 1, 1998, and January 5, 2000. Increase their "salary" by 1500. Add the prefix "Senior" to their "job_title". 
Submit your query for this task in the Judge system.*/



    /*18. Delete Addresses 
Delete records from the "addresses" table where the "city_id" is (5, 17, 20, 30).
Submit your query for this task in the Judge system.*/

DELETE FROM addresses
WHERE city_id IN (5, 17, 20, 30);

    /*19. Create a View
Create a view named "view_company_chart" that selects "Full Name" and "Job Title" of employees whose "Manager ID" is 184.
Submit your query for this task in the Judge system.*/



    /*20. Create a View with Multiple Tables
Create a view called "view_addresses" that selects the "first_name" and "last_name" as "Full Name" and "department_id" from the 
"employees" table and the "number" and "street" as "Address" from the "addresses" table where the "address_id" matches the "id" 
in the "addresses" table. Order the results by the "Address" column.
Submit your query for this task in the Judge system.*/


CREATE VIEW view_addresses
	AS SELECT
		e.first_name||' '|| e.last_name AS "Full Name",
		e.department_id,
		a.number||' '|| a.street AS "Address"
	FROM employees AS e, addresses AS a
	WHERE e.address_id = a.id
	ORDER BY "Address";

    /*21. ALTER VIEW
Rename the "view_addresses" to a more relevant name, "view_employee_addresses_info".
Submit your query for this task in the Judge system.*/



    /*22. DROP VIEW
You can delete the "view_company_chart" since it is no longer necessary.
Submit your query for this task in the Judge system.*/



    /*23. * UPPER
Modify the "projects" table by changing the "name" column to its uppercase equivalent.
Submit your query for this task in the Judge system.*/



    /*24. * SUBSTRING
Create a view called "view_initials" that includes the "first_name" and "last_name" columns from the "employees" table. 
In addition, modify the "first_name" column by extracting the first two characters and renaming the new column as "initial". Order the results by "last_name".
Submit your query for this task in the Judge system.*/



    /*25. * LIKE
Write a SQL query that selects the "name" and "start_date" columns from the "projects" table where the "name" 
column starts with the characters 'MOUNT%'. The results should be sorted by project "id".
Submit your query for this task in the Judge system.*/