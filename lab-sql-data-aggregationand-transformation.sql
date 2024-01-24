-- Challenge 1
-- You need to use SQL built-in functions to gain insights relating to the duration of movies:

-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
USE sakila;
SELECT title, MAX(length(length)) AS max_duration, MIN(length(length)) AS min_duration
FROM sakila.film
GROUP BY title;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.
-- You need to gain insights related to rental dates:
SELECT 
  ROUND(AVG(length), 0) AS avg_length,
  CONCAT(
    LEFT((AVG(length) / 60), 1),
    ' hour/s ',
    ROUND(AVG(length) % 60, 0),
    ' minute/s'
  ) AS length_hours_minutes
FROM film;


-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.
SELECT rental_date
FROM rental;

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days_operating
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT *, MONTH(rental_date), WEEKDAY(rental_date)
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values 'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *,
CASE 
	WHEN WEEKDAY(rental_date) IN (6,0) THEN 'weekend'
ELSE 'work day'
END AS 'DAY_TYPE'
FROM rental;

-- 3. You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
-- Please note that even if there are currently no null values in the rental duration column, the query should still be written to handle such cases in the future.
-- Hint: Look for the IFNULL() function.
SELECT title, IFNULL(rental_duration, 'Not Available') AS rental_duration
FROM film
ORDER BY title ASC;

-- 4 Bonus: The marketing team for the movie rental company now needs to create a personalized email campaign for customers. To achieve this, you need to retrieve the concatenated first and last names of customers, along with the first 3 characters of their email address, so that you can address them by their first name and use their email address to send personalized recommendations. The results should be ordered by last name in ascending order to make it easier to use the data.
SELECT CONCAT(first_name, " ", last_name,": ", LEFT(email,3)) AS campaing_email_customers
FROM customer
ORDER BY last_name ASC;

## FINISH OF THE FIRST CHALLENGE


## START OF CHALLENGE 2

-- Challenge 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(film_id) AS films_released_count
FROM film;

-- 1.2 The number of films for each rating.
SELECT COUNT(film_id) AS films_released_count, rating
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.
SELECT COUNT(film_id) AS films_released_count, rating
FROM film
GROUP BY rating
ORDER BY films_released_count DESC;

-- Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT round(AVG(length),2) AS avg_duration, rating
FROM film
GROUP BY rating
ORDER BY avg_duration DESC;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT round(AVG(length),2) AS avg_duration, rating
FROM film
GROUP BY rating
HAVING avg_duration > 120
ORDER BY avg_duration DESC;

-- 3. Bonus: determine which last names are not repeated in the table actor.
SELECT last_name
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) = 1;

# I want to make sure that the code worked, so I just check all the column last_name and see which last names are not repeated.
SELECT last_name
FROM actor;