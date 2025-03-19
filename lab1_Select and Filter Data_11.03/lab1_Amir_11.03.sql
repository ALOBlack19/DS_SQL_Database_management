-- 									LAB 01: SQL Lab Select and Filter Data Exercises

-- Question 1
SELECT *
FROM 
	movies;

-- Question 2
SELECT 
	title, release_year
FROM 
	movies;
	
-- Question 3

SELECT
	title, release_year
FROM
	movies
WHERE
	release_year > 2000;

-- Question 4

SELECT 
	title, genre
FROM
	movies
WHERE
	genre = 'Action';

-- Question 5

SELECT
	COUNT (title) AS total_movies
FROM
	movies;
	
-- Question 6

SELECT
	COUNT (DISTINCT genre) AS distinct_genre
FROM
	movies;
	
-- Question 7

SELECT
	title, release_year
FROM
	movies
WHERE
	release_year BETWEEN 1990 AND 2000;
	
-- Question 8

SELECT
	title, genre, release_year
FROM
	movies
WHERE
	genre = 'Drama'
	OR release_year < 1990;
-- Question 9

SELECT
	title
FROM
	movies
WHERE
	title LIKE 'The%';

-- Question 10

SELECT
	title
FROM
	movies
WHERE
	title NOT ILIKE '%love%';
	--ILIKE is LIKE but case sensitive, so it will find all kinds od different "love" typing.

-- Question 11

SELECT
	title, genre
FROM
	movies
WHERE
	genre  IN ('Drama', 'Fantasy', 'Action');
	
-- Question 12

SELECT
	title, genre, release_year
FROM
	movies
WHERE
	genre = 'Fantasy'
	AND release_year BETWEEN 2005 AND 2015;

-- Question 13

SELECT
	genre,
	COUNT (DISTINCT title) AS movies_per_genre	
FROM
	movies
GROUP BY
	genre;
	
-- Question 14

SELECT
	title, release_year
FROM
	movies
WHERE
	release_year > 2000
ORDER BY
	release_year
LIMIT 10;

-- Question 15

SELECT
	title
FROM
	movies
WHERE
	title LIKE '%Star%';

-- Question 16

SELECT
	release_year,
	COUNT (DISTINCT title) AS distinct_release_years	
FROM
	movies
GROUP BY
	release_year;
	
-- Question 17

SELECT
	genre,
	COUNT (DISTINCT title) AS genre_counting
FROM
	movies
GROUP BY
	genre
HAVING     -- HAVING to perform an operation in a operation
	COUNT (DISTINCT title) > 50;

-- Question 18

SELECT
	title,
	genre
FROM
	movies
WHERE
	genre NOT IN ('Fantasy');

-- Question 19

SELECT
	title, release_year
FROM
	movies
WHERE
	release_year IS NULL;

-- Question 20

SELECT
	title,
	release_year
FROM
	movies
WHERE
	release_year BETWEEN 1990 AND 1999
ORDER BY
	release_year ASC

-- Question 21

SELECT
	* 
FROM
	movies




	


