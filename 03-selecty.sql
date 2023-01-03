-- SELECT * FROM urls;
-- SELECT COUNT(*) FROM urls;
SELECT name, url FROM urls WHERE id = 2;
SELECT name, url FROM urls WHERE name LIKE '%E%';

SELECT country FROM country
	WHERE country LIKE 'S%a';
SELECT country FROM country
	WHERE country LIKE 'S%'
	AND country LIKE '%a'
	AND LENGTH(country) > 10
	ORDER BY country DESC;

SELECT
	first_name || ' ' || last_name as fullname,
	email
FROM customer
WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

SELECT DISTINCT last_name, first_name
FROM customer
ORDER BY
	last_name ASC NULLS FIRST,
	first_name ASC
LIMIT 10 OFFSET 3;

