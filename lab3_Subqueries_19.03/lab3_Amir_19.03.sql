--  						Lab 3: SQL Subqueries 1
-- Visualizing the data for better understanding

SELECT
	*
FROM
	books

SELECT
	*
FROM
	sales

/*
1. Simple Subquery
Find all books priced above the average price.
*/

SELECT
	b.title,
	b.price
FROM
	books AS b
WHERE
	b.price > (SELECT AVG(b.price) 
				FROM books AS b)
ORDER BY
	b.price DESC
	
-- PRACTICING BEST VISION QUERY

SELECT
	b.title,
	b.price,
	CASE 
		WHEN b.price > (SELECT AVG(b.price) FROM books AS b)
		THEN 'Above average'
		ELSE 'Below average'
	END AS above_average
FROM
	books AS b
GROUP BY
	b.price,
	b.title
ORDER BY
	b.price DESC;
	
/*
2. IN Subquery:
Find titles of books authored by authors who have published more than 2
books.
*/

SELECT
    b.title
FROM
    books AS b
WHERE
    b.author IN
        (SELECT
            b.author			
        FROM
            books as b
        GROUP BY
            b.author
        HAVING
            COUNT(DISTINCT b.book_id) > 2);		

/*
3. NOT IN Subquery:
Find titles of books that have never been sold.
*/

SELECT
	title
FROM	
	books
WHERE
	book_id NOT IN -- Because the question asks NOT IN
	(SELECT
		s.book_id
	FROM
		books AS b LEFT JOIN sales AS s
		ON b.book_id = s.book_id
	WHERE
		s.book_id IS NOT NULL); -- I needed to use NOT NULL
	

/*
4. Subquery with Aggregation:
List authors whose books have an average rating above the average rating of
all books.
*/

SELECT
	author,
	title,
	rating
FROM
	books
WHERE
	rating >
	(SELECT
		ROUND (AVG(rating),2) AS average_rate
	FROM
		books)

/*
5. Subquery with Comparison Operator:
Retrieve the details of books priced higher than the average price of all books.
*/

SELECT
	author,
	title,
	price
FROM
	books
WHERE
	price >
	(SELECT
		ROUND (AVG(price),2) AS average_price
	FROM
		books)

/*
6. Nested Subquery:
List the books with a price greater than the average price of books published
by authors who have published exactly 1 book.
*/

SELECT
	title,
	price
FROM
	books
WHERE
	price > 
	(SELECT
		AVG(price) AS avg_price
	FROM
		books)
	AND author IN-- USING "AND" TO COMBINE 2 CONDITIONS (PRICE GREATER THAN AVG & AUTHORS WITH 1 BOOK)	
	(SELECT
		author
	FROM
		books
	GROUP BY
		author
	HAVING
		COUNT(author) = 1);

/*
7. Subquery with Date Condition:
Find titles of books that have been sold after the date when the most
expensive book was first sold.
*/


SELECT
	b.title,
	s.sale_date
FROM
	sales AS s LEFT JOIN books AS b 
	ON s.book_id = b.book_id
WHERE
	s.sale_date >
	(SELECT
		MIN(s.sale_date) AS first_sell_exp
	FROM
		sales AS s LEFT JOIN books AS b 
		ON s.book_id = b.book_id
	WHERE
		b.price IN
		(SELECT
			MAX(price)
		FROM
			books))
ORDER BY
	s.sale_date DESC;

	

/*
8. Correlated Subquery:
Find each book's title along with the quantity sold in the most recent sale of
that book.
*/

SELECT
	title, s.quantity, s.sale_date
FROM
	books AS b INNER JOIN sales AS s
	ON s.book_id = b.book_id
WHERE
	s.sale_date IN
		(SELECT
			MAX(s2.sale_date)
		FROM
			sales AS s2
		WHERE
			s2.book_id = s.book_id)

/*
9. EXISTS Subquery:
Find authors who have at least one book sold.
*/

-- This code can show every author's book selling.
SELECT
    b.author,
	b.title,
    (SELECT SUM(s2.quantity) FROM sales AS s2 WHERE s2.book_id = b.book_id) AS quantity_per_book -- Subquerie to calculate the total quantity
FROM
    books AS b
WHERE 
    EXISTS 
    (SELECT  -- Subquerie to identify every book sold, comparing the book_id of books and sales table.
		s.book_id
     FROM 
	 	sales AS s
     WHERE 
	 	b.book_id = s.book_id)
ORDER BY
	b.author;
	

/*
10. NOT EXISTS Subquery:
Find authors who have no books sold.
*/

SELECT
    b.author
FROM
    books AS b
WHERE
    NOT EXISTS ( -- NOT EXISTS will works in the opposite way and find the authors who haven't sold books.
        SELECT -- Subquerie to identify every book sold, comparing the book_id of books and sales table.
           	s.book_id
        FROM
            sales AS s
        WHERE
            s.book_id = b.book_id
    );