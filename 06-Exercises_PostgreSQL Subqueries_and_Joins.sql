                            /*   Exercises: PostgreSQL Subqueries and Joins
This document defines the exercise assignments for the PostgreSQL course @ Software University.
Submit your solutions in the SoftUni Judge Contest.
In preparation for the upcoming assignments, you will engage with a database you are already familiar with, albeit with some modifications adjusted for these specific tasks. 
Begin by establishing a new database called subqueries_joins_booking_db and accessing its designated query tool. Retrieve the 06-Exercises-Subqueries-Joins-booking_db.sql
 file from the course instance and input it into the query section of your database tool. Following the import, run the queries outlined in the file. The schema and tables
  present in the subqueries_joins_booking_db database will be leveraged for the ensuing tasks.
    1. Booked for Nights
Perform a JOIN operation between the "apartments" table and the "bookings" table to retrieve only matching rows. The resulting columns should be renamed as
 "apartment_address" for the concatenated "address" and "address_2" columns and "nights" for the "booked_for" column. Conclude by arranging the outcome 
 in ascending order based on the "apartment_id" column. */

SELECT
CONCAT(a.address, ' ', a.address_2) AS apartment_address,
b.booked_for AS nights
FROM apartments AS a
JOIN bookings AS b 
	ON b.booking_id = a.booking_id
ORDER BY a.apartment_id;

     /*  2. First 10 Apartments Booked At
Create an SQL query that selects the first 10 apartments in the "apartments" table, along with their corresponding booking date from the 
"bookings" table (if available). If a column in the LEFT table has no booking date, it should still be included in the result set.
    • select the "name" column from the "apartments" table 
    • select the "country" column from the "apartments" table 
    • select the "booked_at" column from the "bookings" table, convert it to a date format
*** Note, that the LEFT JOIN is the same as the LEFT OUTER JOIN so you can use them interchangeably. */

SELECT
a.name,
a.country,
b.booked_at::DATE
FROM apartments AS a
LEFT JOIN bookings AS b 
	ON b.booking_id = a.booking_id
LIMIT 10;

     /*  3. First 10 Customers with Bookings
Write a SQL query that selects the first 10 bookings in the "bookings" table, along with their corresponding customer's full name from the

 "customers" table. If any column in the RIGHT table does not have booking information available, it should still be included in the result set.
    • select the " booking_id" column from the "bookings" table
    • select the "starts_at" column from the "bookings" table, convert it to a date format
    • select the "apartment_id" column from the "bookings" table
    • select the concatenated "first_name" and "last_name" columns from the "customers" table, renaming the resulting column as "customer_name"
    • order the outcome in ascending order based on the "Customer Name" column
*** Note, that the RIGHT JOIN and RIGHT OUTER JOIN are the same therefore you can use them interchangeably. */

SELECT
b.booking_id,
b.starts_at::DATE,
b.apartment_id,
CONCAT(c.first_name, ' ', c.last_name) AS "Customer Name"
FROM bookings AS b 
RIGHT JOIN customers AS c 
	ON c.customer_id = b.customer_id
ORDER BY "Customer Name"
LIMIT 10;

     /*  4. Booking Information 
Retrieve booking information from the three tables, where all records should be returned, regardless of matches.
    • select the "booking_id" column from the "bookings" table
    • select the "name" column from the "apartments" table and rename it as "apartment_owner"
    • select the "apartment_id" column from the "apartments" table
    • select the concatenated "first_name" and "last_name" columns from the "customers" table, renaming the resulting column as "customer_name"
    • order the results in ascending order based on the "booking_id", "apartment_owner" and "customer_name" columns
*** Note, that the FULL JOIN and FULL OUTER JOIN are the same therefore you can use them interchangeably. */

SELECT
b.booking_id,
a.name AS apartment_owner,
a.apartment_id,
CONCAT(c.first_name, ' ', c.last_name) AS "Customer Name"
FROM bookings AS b 
FULL JOIN customers AS c 
	ON c.customer_id = b.customer_id
FULL JOIN apartments AS a 
	ON a.booking_id = b.booking_id
ORDER BY "booking_id", "apartment_owner", "Customer Name";

 /*  5. Multiplication of Information****
Write a SQL query to fetch the booking "booking_id" and customer "first_name" from the "bookings" and "customers" tables, respectively. 
Use a CROSS JOIN to generate a Cartesian product of the two tables. Finally, sort the result set in ascending order based on the "customer_name".
The CROSS JOIN operation combines all rows from two or more tables, resulting in a new dataset where each row from the first table is paired with every
 row from the second table (and so on, for any additional tables). Due to the potentially substantial output in our specific task, there is no 
 necessity to submit this particular operation to the Judge system */

SELECT
b.booking_id,
c.first_name AS customer_name
FROM bookings AS b 
CROSS JOIN customers AS c 
ORDER BY customer_name;

 /*  6. Unassigned Apartments
Create a SQL query to retrieve the "booking_id" of bookings and the corresponding "companion_full_name" from the "customers" table, where the "apartment_id" has not been assigned yet.
*** Note that in a SQL JOIN operation, if the columns being joined have the same name in both tables, you can use the USING syntax in the JOIN predicate instead of the ON clause. */

SELECT
b.booking_id,
a.apartment_id,
companion_full_name
FROM bookings AS b 
LEFT JOIN customers AS c 
	ON c.customer_id = b.customer_id
LEFT JOIN apartments AS a 
	ON a.apartment_id = b.apartment_id
WHERE a.apartment_id IS NULL;

 /*  7. Bookings Made by Lead
Write a SQL query that selects the "apartment_id", "booked_for" nights, customer's "first_name", and "country" from the "bookings" and "customers" tables, 
respectively, by performing an INNER JOIN. Filter the results only to include bookings made by customers with a "job_type" of "Lead". */

SELECT
b.apartment_id,
b.booked_for,
c.first_name,
c.country
FROM bookings AS b 
INNER JOIN customers AS c 
	ON c.customer_id = b.customer_id
WHERE c.job_type LIKE '%Lead%';

 /*  8. Hahn's Bookings
Create a SQL query that COUNT the number of bookings made by customers whose "last_name" is 'Hahn'. The output should show only the count of bookings and no other columns. */

SELECT
COUNT(b.booking_id)
FROM bookings AS b 
INNER JOIN customers AS c 
	ON c.customer_id = b.customer_id
WHERE c.last_name LIKE 'Hahn';

 /*  9. Total Sum of Nights
Write a SQL query that retrieves the "name" of each apartment in the "apartments" table along with the total sum of nights "booked_for" for each apartment. 
Group the result by the apartment "name" and sort the result in ascending order based on the "name". */

SELECT
a.name,
SUM(b.booked_for)
FROM apartments AS a 
JOIN bookings AS b 
	ON b.apartment_id = a.apartment_id
GROUP BY a."name"
ORDER BY a."name";

 /*  10. Popular Vacation Destination
Create a SQL query to determine which "country" is a popular vacation destination during the summer season by:
    • counting the number of bookings "booking_id" made for each "country" between '2021-05-18 07:52:09.904+03' and '2021-09-17 19:48:02.147+03' (exclusive)
    • grouping the results by the "country"
    • ordering the results in descending order based on the "booking_count". */

SELECT
a.country,
COUNT(b.booking_id) AS booking_count
FROM apartments AS a 
JOIN bookings AS b 
	ON b.apartment_id = a.apartment_id
WHERE b.booked_at > '2021-05-18 07:52:09.904+03' AND b.booked_at < '2021-09-17 19:48:02.147+03'
GROUP BY a.country
ORDER BY booking_count DESC;

 /*  To accomplish the upcoming exercises, you will be dealing with a database that you are already familiar with, but it has undergone some
 modifications specific to the upcoming tasks. Your first step is to create a fresh database named subqueries_joins_geography_db and access its query tool. 
 Retrieve the 06-Exercises-Subqueries-Joins-geography_db.sql file from the course instance and import it into the query tab of your newly created database. 
 Once imported, proceed to execute the queries provided within the file. The schema and tables from the subqueries_joins_geography_db database will serve as 
 the foundation for the subsequent tasks.

  11. Bulgaria's Peaks Higher than 2835 Meters
Retrieve the "country_code", "mountain_range", "peak_name" and "elevation" from the "mountains", "peaks", and "mountains_countries" tables using a SQL query.
 The query should only include rows where the peak "elevation" is greater than 2835 meters and the "country_code" is 'BG'. The results should be sorted in descending order based on peak "elevation". */

SELECT
mc.country_code, 
m.mountain_range,
p.peak_name, 
p.elevation
FROM mountains AS m 
JOIN peaks AS p 
	ON p.mountain_id = m.id
JOIN mountains_countries AS mc 
	ON mc.mountain_id = m.id
WHERE p.elevation > 2835 AND mc.country_code = 'BG'
ORDER BY p.elevation DESC;

 /*  12. Count Mountain Ranges
Create a SQL query that returns the number of unique mountain ranges for the countries with the country codes 'US', 'RU', and 'BG'. 
The results should be grouped by "country_code" and ordered in descending order based on the "mountain_range_count". */
 
SELECT
mc.country_code, 
COUNT(DISTINCT(m.mountain_range)) AS mountain_range_count
FROM mountains AS m 
JOIN mountains_countries AS mc 
	ON mc.mountain_id = m.id
WHERE mc.country_code IN('BG','RU','US')
GROUP BY mc.country_code
ORDER BY mountain_range_count DESC;

 /*  13. Rivers in Africa
Write a SQL query that selects the "country_name" and "river_name" (if any) from the "countries", "countries_rivers" and "rivers" tables,
 respectively, for the first five countries in Africa. If a country has no river, the "river_name" should be NULL. The result should be ordered in ascending order based on the "country_name". */

SELECT
c.country_name,
r.river_name
FROM countries AS c 
LEFT JOIN countries_rivers AS cr
	ON cr.country_code = c.country_code 
LEFT JOIN rivers AS r 
	ON r.id = cr.river_id
WHERE c.continent_code = 'AF'
ORDER BY c.country_name
LIMIT 5;

 /*  14. Minimum Average Area Across Continents
Compute the minimum average area among all the continents, where the average area is calculated as the average area of all the countries within each continent. */

SELECT 
MIN(average_area)
FROM(SELECT AVG(area_in_sq_km) AS average_area
		FROM countries 
	 	GROUP BY continent_code) AS min_average_area;

 /*  15. Countries Without Any Mountains
Create an SQL query to retrieve the number of countries that do not have any mountains.  */

SELECT
COUNT(*) AS countries_without_mountains
FROM countries AS c
LEFT JOIN mountains_countries AS mc
ON c.country_code = mc.country_code
WHERE mc.mountain_id IS NULL;

 /*  16. Monasteries by Country ****
To begin, create a table called "monasteries" with three columns: 
    • "id" - column should be a PRIMARY KEY and automatically incremented
    •  "monastery_name" - column should have a maximum length of 255 characters 
    • "country_code" - column should be exactly two characters long. 
Then, insert the provided data into this table:
('Rila Monastery 'St. Ivan of Rila', 'BG'),
('Bachkovo Monastery 'Virgin Mary', 'BG'),
('Troyan Monastery 'Holy Mother''s Assumption', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR');
Next, modify the "countries" table by adding a BOOLEAN column called "three_rivers". This column should have a default value of false, 
indicating that the country does not have three rivers. To update the "three_rivers" column for countries that have more than three rivers 
running through them, use a subquery to count the number of rivers in each country and compare the result to the value of 3.
Finally, write a SQL query that selects the "monastery_name" and their respective "country_name" from the "monasteries" table, 
ordered alphabetically by "monastery_name". The query should exclusively retrieve records for countries that have more than three rivers flowing within their borders. */



 /*  17. Monasteries by Continents and Countries****
Create a SQL query that updates the "countries" table by replacing 'Myanmar' with 'Burma'. Additionally, add a new row 
to the "monasteries" table with 'Hanga Abbey' as the name and 'Tanzania' as the country code. Another row should also be inserted into 
the "monasteries" table with 'Myin-Tin-Daik' as the name and 'Myanmar' as the country code.
To retrieve the number of monasteries in each country along with their corresponding "continent_name", construct a query that joins 
the "continents", "countries", and "monasteries" tables. Choose exclusively those countries without the "three_rivers" column.  Group the results
 by "country_name" and "continent_name", and sort them by the number of monasteries in descending order. In the case of a tie, sort the results by country name in ascending order. */



 /*  18. Retrieving Information about Indexes
Write a SQL query that selects the fields "tablename", "indexname", and "indexdef" from the "pg_indexes" table, with the condition that only 
indexes from the "public" schema are retrieved. Sort the results in ascending order based on the "tablename" field. If any of the values are equal, 
then sort the results by "indexname" in ascending order.  */



 /*  19. * Continents and Currencies
Write a SQL query to create a view called "continent_currency_usage" that shows the "continent_code", "currency_code", and a number of countries 
using the currency where more than one country on a continent uses the same currency. The column displaying the number of countries using 
the currency should be renamed as "currency_usage". The data should be ordered by the "currency_usage" column in descending order. 
*** Hint, to solve this problem, you should use a subquery with a SELECT statement that includes the DENSE RANK() function to assign a rank
 to each row within a partition of the result set. You will need to use the GROUP BY clause to group the results by continent and currency, 
 and the HAVING clause to filter the results to only include those where multiple countries are using the same currency. */



 /*  20. * The Highest Peak in Each Country
Create a SQL query to retrieve the "peak_name" and "elevation" of the highest peak for each country, along with the "mountain_range" it belongs to. 
In cases where there are no peaks available in some countries, display "0" as the "elevation", "(no highest peak)" as the "peak_name", 
and "(no mountain)" as the "mountain_range". If there are multiple peaks in some countries with the same elevation, include all of them in the result. 
Sort the "country_name" in alphabetical order, and if there are countries with the same name, sort them by highest peak "elevation" in descending order.
*** Hint, one approach to tackle this problem is by utilizing a Common Table Expression (CTE) to create a temporary result set that can be 
referenced within another SQL statement, including SELECT. Name the CTE as "row_number". The ROW_NUMBER() function will assign a ranking to 
the peaks in each country based on their elevation, with the highest peak receiving a rank of 1. Use the COALESCE() function to replace 
any null values in the "peak_name" and "elevation" columns, for countries where no peaks are available. You can use a CASE statement 
to display the "mountain_range" when the "peak_name" is not null, and "(no mountain)" when no peaks are available. Finally, 
filter the result set by the "row_number" column to only show the highest peak for each country. */
