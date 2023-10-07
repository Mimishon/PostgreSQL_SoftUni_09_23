/* Exercises: PostgreSQL Data Aggregation
This document defines the exercise assignments for the PostgreSQL course @ Software University.
Submit your solutions in the SoftUni Judge Contest.
Mr. Bodrog is a small and greedy goblin who serves as the supervisor of Gringotts, the biggest bank in the wizarding community. 
His most prized possession is a database that contains information about deposits made in the wizarding world, and his pastime is to extort money from others. 
Despite his eagerness to obtain your money, you do not possess any magical abilities. Instead, you have expertise in database management, 
which allows you to access this valuable data Mr. Bodrog insists that you provide him with daily reports, threatening to send a pack of 
starving werewolves after you if you fail to comply. To avoid these dangerous creatures, it is recommended to create a database named 
gringotts_db and open its query tool. Download the 04-Exercises-Data-Aggregation-gringotts_db.sql file from the course instance, import it into the query tab
 of your database, and execute the queries provided in the file. Take some time to familiarize yourself with the tables in the gringotts_db database, 
 as they will be used in the exercises that follow.

1. COUNT of Records 
After gaining access to this extremely valuable database, determine the exact number of records contained within it.*/

SELECT
COUNT(*)
FROM wizard_deposits;

/* 2. Total Deposit Amount
Compose a SQL query that calculates the total sum of the deposit amount held at Gringotts Bank. */

SELECT
SUM(deposit_amount)
FROM wizard_deposits;

/* 3. AVG Magic Wand Size
In your role as the database manager, compute the average size of "magic_wand_size" that belongs to wizards and round the result to the third decimal place. */

SELECT
ROUND(AVG(magic_wand_size), 3)
FROM wizard_deposits;

/* 4. MIN Deposit Charge
To become acquainted with the database, determine the smallest amount of "deposit_charge".*/

SELECT
MIN(deposit_charge)
FROM wizard_deposits;

/* 5. MAX Age
Determine the maximum "age" among the wizards in the database.*/

SELECT
MAX(age) AS maximum_age
FROM wizard_deposits;

/* 6. GROUP BY Deposit Interest
Write a SQL query to order the "deposit_group" based on the total amount of "deposit_interest" in each group, and then sort the results in 
descending order by the total interest in each group.*/

SELECT
deposit_group,
SUM(deposit_interest) AS deposit_interest
FROM wizard_deposits
GROUP BY deposit_group
ORDER BY deposit_interest DESC;

/* 7. LIMIT the Magic Wand Creator
Retrieve the "magic_wand_creator" with the smallest "magic_wand_size" from the "wizard_deposits" table. The query should group the results by
 "magic_wand_creator" and display the "minimum_wand_size" for each creator. The results should be sorted in ascending order by the minimum 
 wand size and limited to the top five smallest wand sizes. */

SELECT
magic_wand_creator,
MIN(magic_wand_size) AS minimum_wand_size
FROM wizard_deposits
GROUP BY magic_wand_creator
ORDER BY minimum_wand_size
LIMIT 5;

/* 8. Bank Profitability
Mr. Bodrog is interested in the profitability of the bank and wants to know the average interest rates of all "deposit_groups" rounded down 
to the nearest integer. The query should categorize the deposits based on whether they have expired or not and retrieve data only for deposits 
that have a "deposit_start_date" after '1985-01-01'. The results should be sorted in descending order by "deposit_group" and ascending order by the "is_deposit_expired" flag.*/

SELECT
deposit_group,
is_deposit_expired,
FLOOR(AVG(deposit_interest)) AS deposit_interest
FROM wizard_deposits
WHERE deposit_start_date > '1985-01-01'
GROUP BY deposit_group, is_deposit_expired
ORDER BY deposit_group DESC, is_deposit_expired;

/* 9. Notes with Dumbledore
Generate a SQL query to retrieve the "last_name" of each wizard and the number of "notes" they wrote that contains the word "Dumbledore" in the "wizard_deposits" table.*/



/* 10. Wizard View
Create a view in SQL named "view_wizard_deposits_with_expiration_date_before_1983_08_17" that fetches data from the "wizard_deposits" table.
 The view should display the full name of the wizard, concatenated from their "first_name" and "last_name", along with the "deposit_start_date", 
 "deposit_expiration_date", and "deposit_amount". The view's results should be grouped by the "wizard_name", "start_date", "expiration_date", 
 and "amount". Additionally, the view should only include deposits that have an expiration date before or on '1983-08-17', and should be 
 ordered by the "expiration_date" in ascending order.*/



/* 11. Filter Max Deposit
Create a SQL query that retrieves the name of the "magic_wand_creator" and their maximum "deposit_amount" from the "wizard_deposits" table. 
The results should be grouped by the "magic_wand_creator" and filtered to only include those with a maximum "deposit_amount" that falls outside 
the range of 20000 to 40000. Order the results by "max_deposit_amount" in descending order, and limit the results to 3 records.*/



/* 12. Age Group
Create a SQL query that groups the wizards from the "wizard_deposits" table into age groups of '[0-10]', '[11-20]', '[21-30]', '[31-40]', '[41-50]', 
'[51-60]', and '[61+]'. The query should count the number of wizards in each "age_group" and display the results in ascending order based on the "age_group".*/



/* Congratulations on your effective management of the Gringotts database! Your expertise has earned you an invitation to become an analyst at SoftUni. 
To prepare for this role, you'll be working with a familiar database, which has been modified for these tasks. 
Start by creating a fresh database named data_aggregation_softuni_management_db. Once done, retrieve the
 04-Exercises-Data-Aggregation-softuni_management_db.sql file from the course instance, import it into your database's query tab, and execute the queries in the file. 
 Take your time to familiarize yourself with the tables in the data_aggregation_softuni_management_db as they will be utilized in the upcoming exercises. 
 This way, you'll be ready to tackle the tasks effectively and showcase your analytical skills.

13. SUM the Employees
Your first task as an analyst at SoftUni is to write an SQL query that calculates the total number of employees in each department. 
The "department_id" is stored in the "employees" table, and the following IDs are used to identify each department:
1 - Engineering
2 - Tool Design
3 - Sales
4 - Marketing
5 - Purchasing
6 - Research and Development
7 - Production */



/* 14. Update Employees' Data
You have been tasked with updating the salaries and job titles of employees based on their hire dates. Write a SQL query that updates the "salary" and "job_title" 
columns of the "employees" table according to the following rules:
    • if the employee's "hire_date" is before '2015-01-16', their salary should be increased by 2500 and their job title should be prefixed with "Senior"
    • if the employee's "hire_date" is before '2020-03-04, their salary should be increased by 1500 and their job title should be prefixed with "Mid-"
    • otherwise, the employee's salary and job title should remain unchanged.*/



/* 15. Categorizes Salary
Write a SQL query that groups employees by their job titles and calculates the average salary for each group. The query should also add a 
column called "category" that categorizes each "job_title" based on the following rules:
    • if the average "salary" is greater than 45,800, the category should be "Good"
    • if the average "salary" is between 27,500 and 45,800 (inclusive), the category should be "Medium"
    • if the average salary for the job title is less than 27,500, the scale should be "Need Improvement"
Arrange the outcomes based on the "category" column in ascending sequence. If there are several employees within the group, arrange them by their 
"job_title" in alphabetical order. */



/* 16. WHERE Project Status
Create a SQL query that selects the "project_name" with the word '%Mountain%' in their name from the "projects" table. The project status should
 be determined based on the following criteria:
    • if a project has NO "start_date" and "end_date", its status is "Ready for development"
    • if a project has a "start_date" but NO "end_date", its status is "In Progress".
    • otherwise, its status is "Done".*/



/* 17. HAVING Salary Level
Write a SQL query to retrieve the number of employees and salary level of each department from the "employees" table. The "salary_level" column 
should be determined based on the following rules:
    • if the average "salary" of a department is above 50,000, the salary level is "Above average"
    • if the average "salary" of a department is below or equal to 50,000, the salary level is "Below average"
    • only departments with an average "salary" above 30,000 should be included in the result.
The resulting dataset should encompass the subsequent columns: "department_id", "num_employees" and "salary_level". Arrange the output based on the "department_id".*/
 


/* 18. * Nested CASE Conditions
To create a view ("view_performance_rating"), select the "first_name", "last_name", "job_title", "salary", and "department_id" from the "employees" table. 
Then, use the following conditions to generate the "performance_rating" column:
    • if an employee's "salary" is greater than or equal to 25,000 and their " job_title" starts with 'Senior%', their "performance_rating" should be "High-performing Senior"
    • if an employee's "salary" is greater than or equal to 25,000 and their "job_title" does not start with "Senior", their "performance_rating" should be "High-performing Employee"
    • if neither of the above criteria is met, the employee's "performance_rating" should be "Average-performing".*/



 /* 19. * Foreign Key
Create a table named "employees_projects" with columns for "id", "employee_id", and "project_id". The "employee_id" column should have a foreign key 
constraint that references the "id" column in the "employees" table, and the "project_id" column should have a foreign key constraint that references 
the "id" column in the "projects" table.*/



/* 20. * JOIN Tables
Write a SQL query to join all columns from the "departments" table and the "employees" table where the "id" column in the "departments" table matches 
the "department_id" column in the "employees" table. The result set should include all columns from both tables.
*/

