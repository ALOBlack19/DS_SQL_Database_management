-- 		MINI PROJECT - Mini-Project 1: Analyzing Baby Name Trends

-- TASK 1: Find names that have been given to babies every year between 1920 and 2020.
SELECT
	bn.first_name,
	bn.num
FROM	
	baby_names AS bn
WHERE
	bn.year BETWEEN 1920 AND 2020
ORDER BY
	bn.num DESC;

--TASK 2: Classify each name's popularity according to the number of years that the name appears in the dataset.

SELECT
	bn.first_name,
	COUNT(bn.first_name),
	CASE 
		WHEN COUNT(bn.first_name) > 80 THEN 'Classic'
		WHEN COUNT(bn.first_name) > 50 THEN 'Semi-classic'
		WHEN COUNT(bn.first_name) > 20 THEN 'Semi-trend'
		ELSE 'Trendy' 
		END AS popularity_type
FROM
	baby_names AS bn
WHERE
	bn.first_name = bn.first_name -- Possibility of replacing (bn.first_name) per 'desired baby name'.
GROUP BY
	bn.first_name
ORDER BY
	first_name;

-- TASK 3: Take a look at the ten highest-ranked American female names

SELECT
	bn.first_name,
	SUM(num) AS total_babies,
	RANK() OVER(ORDER BY SUM(num) DESC) AS name_rank
FROM	
	baby_names AS bn
WHERE
	bn.sex = 'F'
GROUP BY
	bn.first_name
ORDER BY
	name_rank DESC
LIMIT
	10;

-- TASK 4: Return a list of female names that end in the letter 'a' since 2015.

SELECT
	bn.first_name,
	SUM(bn.num) AS name_rank
FROM	
	baby_names AS bn
WHERE
	bn.sex = 'F' AND bn.year >= 2015 AND bn.first_name LIKE '%a'
GROUP BY
	bn.first_name
ORDER BY
	name_rank DESC;

-- TASK 5: Find the cumulative number of babies named Olivia over the years since the name first appeared.

SELECT
	bn.year,
	bn.first_name,
	bn.num,
	RANK() OVER(ORDER BY SUM(num) DESC) AS cumulative_olivias
FROM
	baby_names AS bn
WHERE
	bn.first_name = 'Olivia'
GROUP BY
	bn.year,
	bn.num,
	bn.first_name
ORDER BY
	bn.year;

-- TASK 6: Write a query that selects the year and the maximum num of babies given any male name in that year.

SELECT
	bn.year,
	MAX(bn.num) AS max_num
FROM
	baby_names AS bn
WHERE
	bn.sex = 'M'
GROUP BY
	bn.year
ORDER BY
	max_num DESC;

-- TASK 7: Look up the first_name that was given to 65,339 babies in 1989, as well as the top male first name for all other years.
WITH male_pop AS (
SELECT
	bn.first_name,
	bn.year,
	bn.num AS total_babies
FROM
	baby_names AS bn
	INNER JOIN
		(SELECT
			bn.year,
			MAX(bn.num) AS max_num
		FROM
			baby_names AS bn
		WHERE
			bn.sex = 'M'
		GROUP BY
			bn.year) AS s1
			ON bn.year = s1.year AND bn.num = s1.max_num
) 
SELECT
	*
FROM
	male_pop
ORDER BY
	male_pop.year DESC;


-- TASK 8: Return a list of first names that have been the top male first name in any year along with a count of the number of years that name has been the top name.

WITH male_pop AS (
    SELECT
        bn.first_name,
        bn.year,
        bn.num AS total_babies
    FROM
        baby_names AS bn
    INNER JOIN (
        SELECT
            bn.year,
            MAX(bn.num) AS max_num
        FROM
            baby_names AS bn
        WHERE
            bn.sex = 'M'
        GROUP BY
            bn.year
    ) AS s1
    ON bn.year = s1.year AND bn.num = s1.max_num)	
SELECT
    first_name,
    COUNT(first_name) AS count_top_name
FROM
    male_pop
GROUP BY
    first_name
ORDER BY
    count_top_name DESC;

