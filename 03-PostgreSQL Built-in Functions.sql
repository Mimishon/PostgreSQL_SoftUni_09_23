/*                                                      Exercises: PostgreSQL Built-in Functions
This document defines the exercise assignments for the PostgreSQL course @ Software University.
Submit your solutions in the SoftUni Judge Contest.
Important: Throughout the course, you will receive different databases that may have similar names and structures but contain different data specific to each exercise. 
To ensure proper execution and avoid conflicts, it is crucial to create a new database for each exercise and import the provided file with the corresponding records. 
By following this approach, you can accurately work on each exercise and avoid any interference or data overlap between different exercises.	
Begin by creating a database called geography_db and then launch its query tool. After that, download the 03-Exercises-Built-in-Functions-geography_db.sql file from 
the course instance, import it into the query tab of your database, and execute the queries provided in the file. Once you've executed the queries, take some time 
to familiarize yourself with the geography_db database and get to know its schema and tables.
    1. River Info
Create a view named "view_river_info" that concatenates the "river_name", "outflow" and "length" columns from the "rivers" table in the following format:
'The river', ' ', river_name, ' ', 'flows into the', ' ', outflow, ' ', 'and is', ' ', "length", ' ', 'kilometers long.'
The resulting column should be named "River Information", and the rows should be ordered by the "river_name" field in ascending alphabetical order. */

CREATE VIEW view_river_info
AS SELECT
CONCAT('The river', ' ', river_name, ' ', 'flows into the', ' ', outflow, ' ', 'and is', ' ', "length", ' ', 'kilometers long.') AS "River Information"
FROM rivers
ORDER BY river_name;

/* 2. Concatenate Geography Data
Create a view named "view_continents_countries_currencies_details". To do so, follow these steps:
    • from the "continents" table, combine the "continent_name" and "continent_code" with a colon (: ) separator, and name the resulting column "Continent Details"
    • from the "countries" table, select the "country_name", "capital", and "area_in_sq_km" fields. You can add a hyphen ( - ) between the fields and append 'km2' 
    to the end of "area_in_sq_km" to avoid confusion with other data. Name the resulting columns "Country Information"
    • in the last column, combine the "description" and "currency_code" fields of the "currencies" table, using the following format: description (currency_code). 
    Name the resulting column "Currencies"
    • sort the result by the "Country Information" and "Currencies" fields in ascending alphabetical order */

CREATE VIEW view_continents_countries_currencies_details
AS SELECT
CONCAT(TRIM(c.continent_name, ' '), ': ', c.continent_code) AS "Continent Details",
CONCAT(ctr.country_name, ' - ', ctr.capital, ' - ', ctr.area_in_sq_km, ' - ',  'km2') AS "Country Information",
CONCAT(crc.description, ' ', '(', crc.currency_code, ')') AS "Currencies"
FROM continents as c, countries AS ctr, currencies AS crc
WHERE ctr.continent_code = c.continent_code AND ctr.currency_code = crc.currency_code
ORDER BY "Country Information", "Currencies";


/* 3. Capital Code
Add a new column to the "countries" table named "capital_code", by generating the code by using the SUBSTRING() function to extract the first 2 letters from the "capital" field.
Choose whichever SQL syntax you prefer to use for the query. */

ALTER TABLE countries
ADD COLUMN capital_code VARCHAR(5);

UPDATE countries
SET capital_code = SUBSTRING(capital, 1, 2)
RETURNING*;

/* 4. (Descr)iption
Develop an SQL query that removes a portion of the "description" column from the "currencies" table. The query should extract the string starting from the 5th 
character and return the rest of the string. */

SELECT 
RIGHT(description, -4) AS substring
FROM currencies;

/* 5. Substring River Length
Compose an SQL query to fetch the "river_length" from the "River Information" column within the "view_river_info" view. Ensure that only the numerical value is
 selected from the string, with a maximum of four digits, ranging from 0 to 9.
*** Note that you can use the following regex expression '([0-9]{1,4})' to find the number in the sentence. */

SELECT 
SUBSTRING("River Information", '([0-9]{1,4})') AS river_length
FROM view_river_info;

/* 6. Replace A
To write a SQL query that replaces letters in the "mountain_range" column of the "mountains" table, please follow these steps:
    • replace all occurrences of "a" with "@". Name the resulting column "replace_a"
    • replace all occurrences of "A" with "$". Name the resulting column "replace_A"
*** Note, the PostgreSQL REPLACE() function is case-sensitive. This means that if you use the function to replace a specific string or character, it will only 
replace those occurrences that match the case of the original string. */

SELECT 
	REPLACE(mountain_range, 'a', '@') AS replace_a,
	REPLACE(mountain_range, 'A', '$') AS replace_A
FROM mountains;

/* 7. Translate
You may notice that the "capital" names in the "countries" table include letters that are not found in the English alphabet. To address this, you can employ the TRANSLATE() 
function to convert the non-English characters 'áãåçéíñóú' to their corresponding English letters. Name the resulting column "translated_name". */

SELECT 
capital,
TRANSLATE(capital, 'áãåçéíñóú', 'aaaceinou')
FROM countries;

/* 8. LEADING
If you open the records in the "continents" table, you will find that there are additional spaces added to the front of some of the "continent_name" values. Use the TRIM() 
function with the appropriate flag to remove them.
*** Please be aware that the accurate method to confirm the correctness of your query is by double-clicking on the field to select the value. The additional blue
 background color before or after the continent's name will signify any empty spaces, as illustrated in the screenshots below. */

SELECT
continent_name,
TRIM(LEADING FROM continent_name) AS trim
FROM continents;

/* 9. TRAILING
The TRIM() function also has another flag, which can help you remove trailing spaces from the "continent_name" values. */

SELECT
continent_name,
TRIM(TRAILING FROM continent_name) AS trim
FROM continents;

/* 10. LTRIM & RTRIM
The TRIM() function has a shortened version that can remove both spaces and characters. Write an SQL query to remove the "m" character as follows:
    • remove the 'M' character from the left side of the "peak_name" column within the "peaks" table, and assign the name "Left Trim" to the resulting new column
    • remove the 'm' character from the right side of the "peak_name" column within the "peaks" table, and assign the name "Right Trim" to the resulting new column
*** Note that the PostgreSQL TRIM() function and its equivalent functions are case-sensitive. */

SELECT
LTRIM(peak_name, 'M') AS "Left Trim",
RTRIM(peak_name, 'm') AS "Right Trim"
FROM peaks;

/* 11. Character Length and Bits
Combine the "mountain_range" column from the "mountains" table and the "peak_name" column from the "peaks" table into a single field called "Mountain Information".
 Find the number of characters in the newly created text field and name the new column "Characters Length". Additionally, express the length in bits and name the column "Bits of a String". */

SELECT
CONCAT(m.mountain_range, ' ', p.peak_name) AS "Mountain Information",
LENGTH(CONCAT(m.mountain_range, ' ', p.peak_name)) AS "Characters Length",
BIT_LENGTH(CONCAT(m.mountain_range, ' ', p.peak_name)) AS "Bits of a String"
FROM mountains as m, peaks AS p
WHERE m.id = p.mountain_id;

/* 12. Length of a Number
Measure the length of the "population" numbers in the "countries" table. In this case, use the CAST() function to convert the number into a string and then use the LENGTH() function. */


SELECT 
	c.population,
LENGTH(
CAST(c.population AS VARCHAR(25))
		) AS length
FROM countries AS c;

/* 13. Positive and Negative LEFT
Write a SQL query to select the FIRST 4 characters from the "peak_name" column and name the new column "Positive Left". Also, select all characters except the
 LAST 4 from the "peak_name" column and name the new column "Negative Left".  */

SELECT
peak_name,
SUBSTRING(peak_name, 1, 4) AS "Positive Left",
LEFT(peak_name, -4) AS "Negative Left"
FROM peaks;

/* 14. Positive and Negative RIGHT
Write a SQL query to select the LAST 4 characters from the "peak_name" column and name the new column "Positive Right". Also, select all characters except 
the FIRST 4 from the "peak_name" column and name the new column "Negative Right". */

SELECT
peak_name,
RIGHT(peak_name, 4) AS "Positive Right",
RIGHT(peak_name, -4) AS "Negative Right"
FROM peaks;


/* 15. Update iso_code
As some of the values in the "iso_code" column of the "countries" table are null, update them by taking the first three characters from the "country_name" 
column and converting them to uppercase. */

UPDATE countries
SET iso_code = UPPER(SUBSTRING(country_name, 1, 3))
WHERE iso_code IS NULL
RETURNING *;

/* 16. REVERSE country_code
Create a SQL query to update the values in the "country_code" column of the "countries" table. The update should convert the values to lowercase and reverse the string. */

UPDATE countries
SET country_code = LOWER(REVERSE(country_code))
RETURNING *;

/* 17. Elevation --->> Peak Name
Write an SQL query to select the "elevation" and "peak_name" columns from the "peaks" table where the "elevation" is greater than or equal to 4884. 
Concatenate them with a single space, use the REPEAT() function to create an arrow between them "--->>", and name the new column "Elevation --->> Peak Name".
To complete the upcoming exercises, it is necessary to create a new database named booking_db and open its query tool. Download 
the 03-Exercises-Built-in-Functions-booking_db.sql file from the course instance and import it into the query tab of your database. After importing, 
execute the queries in the file. Use the schema and tables available in the booking_db database for the tasks that follow */

SELECT
CONCAT(elevation,' --->> ', peak_name) AS "Elevation --->> Peak Name"
FROM peaks
WHERE elevation >= 4884;

/* 18. Arithmetical Operators
Let's apply our understanding of mathematical operators in SQL. To begin, create a fresh table named "bookings_calculation". 
You can achieve this by selecting the "booked_for" values from the "bookings" table where the "apartment_id" equals 93. The "booked_for" column 
signifies the number of nights the apartment is booked.
Next, alter the table by adding two new columns:
    • "multiplication" column with a NUMERIC data type
    • "modulo" column, also of NUMERIC data type
For the final step, proceed to calculate the earnings earned by the owner for each night, following these instructions:
    • populate the "multiplication" column by multiplying the "booked_for" values by 50
    • fill the "modulo" column with values representing the remainder when "booked_for" is divided by 50 */

CREATE TABLE bookings_calculation
AS SELECT booked_for
FROM bookings
WHERE bookings.apartment_id = 93;

ALTER TABLE bookings_calculation
ADD COLUMN multiplication NUMERIC,
ADD COLUMN modulo NUMERIC;

UPDATE bookings_calculation
SET multiplication = booked_for * 50,
modulo = booked_for % 50;

/* 19. ROUND vs TRUNC
Create a SQL query that retrieves the "latitude" column from the "apartments" table. Apply the ROUND() function to it with a precision 
of 2 decimal places, and then apply the TRUNC() function with the same precision. Finally, compare and measure the differences in the output produced by the two functions. */


SELECT
latitude,
ROUND(latitude, 2) AS round,
TRUNC(latitude, 2) AS TRUNC
FROM apartments;

/* 20. Absolute Value
Write an SQL query to select the "longitude" column from the "apartments" table and apply the ABS() function to it to find its absolute value.*/

SELECT
longitude,
ABS(longitude)
FROM apartments;

/* 21. Billing Day****
To generate payment documents for reservations made for apartments, follow these steps: 
    • firstly, add a new column to the "bookings" table called "billing_day" with the data type of "TIMESTAMPTZ" and set its default value to 
    "CURRENT_TIMESTAMP"
    • after that, create a SQL query that retrieves the "billing_day" column from the "bookings" table and formats it as "DD 'Day' MM 'Month' YYYY 'Year' HH24:MI:SS", 
    naming the resulting column "Billing Day".
The example result shown below is generated using the CURRENT_TIMESTAMP and it is purely for illustrative purposes.*/
 
ALTER TABLE bookings
ADD COLUMN billing_day TIMESTAMPTZ DEFAULT(CURRENT_TIMESTAMP);

SELECT
TO_CHAR(billing_day, 'DD "Day" MM "Month" YYYY "Year" HH24:MI:SS' ) AS "Billing Day"
FROM bookings;

/* 22. EXTRACT Booked At
Create a SQL query to retrieve the YEAR, MONTH, DAY, HOUR, MINUTE, and SECOND values from the "booked_at" column. Use the CEILING() function to round up 
the SECOND value to the nearest whole number.
*** Note that the "booked_at" column is stored as "TIMESTAMPTZ" (timestamp with time zone) data type. When extracting hours from this column, 
please be aware that the extraction considers your account's time zone information, which may result in different hour values based on the time zone. 
To ensure consistent results for this task, utilize the "AT TIME ZONE" function to convert the timestamp to the UTC time zone before extracting the hour.
 This approach will help ensure uniformity in the results.*/

SELECT
EXTRACT(YEAR FROM booked_at) AS "YEAR",
EXTRACT(MONTH FROM booked_at) AS "MONTH",
EXTRACT(DAY FROM booked_at) AS "DAY",
EXTRACT(HOUR FROM booked_at) AS "HOUR",
EXTRACT(MINUTE FROM booked_at) AS "MINUTE",
CEILING(EXTRACT(SECOND FROM booked_at)) AS "SECOND"
FROM bookings;

/* 23. Early Birds****
Compose a SQL query to determine the "user_id" of customers who prefer booking 10 months in advance. Achieve this by computing the time 
difference between the "starts_at" and "booked_at" columns in the "bookings" table, and storing the resultant values in a new column named 
"Early Birds". Afterward, apply a filter to select only the rows where the "Early Birds" value is greater than or equal to 10 months, 
and retrieve the corresponding "user_id".
*** As a suggestion, it is worth noting that the WHERE clause allows you to use the INTERVAL '10 months' to indicate a time period of 
10 months when used in conjunction with the AGE() function for computing the time difference between two dates.*/

SELECT
user_id, 
AGE(starts_at, booked_at) AS "Early Birds"
FROM bookings
WHERE AGE(starts_at, booked_at)>= INTERVAL '10 months';

/* 24. Match or Not
Retrieve the "companion_full_name" and "email" columns from the "users" table where the following conditions are met:
    • the "companion_full_name" column should contain the substring '%aNd%' in a case-insensitive manner
    • the "email" column should NOT contain the substring '%@gmail' in a case-sensitive manner*/

SELECT
companion_full_name,
email
FROM users
WHERE companion_full_name ILIKE '%aNd%' AND email NOT LIKE '%@gmail';

/* 25. * COUNT by Initial
To generate a report displaying the user count grouped by their initials, you can utilize an SQL query. This query involves selecting 
the initial two characters from the "first_name" column of the "users" table and storing them in a newly created column named "initials". 
Afterward, you can use the GROUP BY clause to group the users based on their initials. Then, employ the COUNT() function to retrieve 
the number of users in each group, and name the resulting column "user_count". Finally, you can arrange the resulting data in descending order 
according to the "user_count" column. In cases where multiple groups have the same count, you can further sort them alphabetically based on their "initials".*/

SELECT
SUBSTRING(first_name, 1, 2) AS initials,
COUNT(*) AS user_count
FROM users
GROUP BY initials
ORDER BY user_count DESC, initials ASC;

/* 26. * SUM
To calculate the total value of bookings for the apartment, you can use an SQL query that retrieves the "booked_for" column from the 
"bookings" table and applies the SUM() function to it. Then, you can add a filter to select only the rows where the "apartment_id" is equal to 90.*/

SELECT
SUM(booked_for) AS total_value
FROM bookings
WHERE apartment_id = 90;

/* 27. * Average Value
Create an SQL query that utilizes the AVG() function to calculate the average value of the "multiplication" column in the "bookings_calculation" table. */

SELECT
AVG(multiplication) AS average_value
FROM bookings_calculation;