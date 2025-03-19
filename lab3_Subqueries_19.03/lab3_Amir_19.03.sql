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
	b.title,
	b.author,
	s.quantity
FROM
	books AS b INNER JOIN sales as s
	ON b.book_id = s.book_id
WHERE
	s.quantity > 2;

/*
3. NOT IN Subquery:
Find titles of books that have never been sold.
*/


/*
4. Subquery with Aggregation:
List authors whose books have an average rating above the average rating of
all books.
*/


/*
5. Subquery with Comparison Operator:
Retrieve the details of books priced higher than the average price of all books.
*/


/*
6. Nested Subquery:
List the books with a price greater than the average price of books published
by authors who have published exactly 1 book.
*/


/*
7. Subquery with Date Condition:
Find titles of books that have been sold after the date when the most
expensive book was first sold.
*/


/*
8. Correlated Subquery:
Find each book's title along with the quantity sold in the most recent sale of
that book.
*/


/*
9. EXISTS Subquery:
Find authors who have at least one book sold.
*/


/*
10. NOT EXISTS Subquery:
Find authors who have no books sold.
*/