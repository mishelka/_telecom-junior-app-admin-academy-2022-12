-- SELECT * FROM urls;
-- SELECT COUNT(*) FROM urls;
-- SELECT name, url FROM urls WHERE id = 2;
-- SELECT name, url FROM urls WHERE name LIKE '%E%';

--vyber názvy všetkých filmov, ktoré majú vo svojom názve písmeno 'b'.
SELECT country FROM country WHERE country LIKE '%b%';

--vyber názvy všetkých krajín, ktoré začínajú na 'S' a končia na 'a'.
SELECT country FROM country	WHERE country LIKE 'S%a';
--... a ich názov má dĺžku väčšiu ako 10
SELECT country FROM country
	WHERE country LIKE 'S%'
	AND country LIKE '%a'
	AND LENGTH(country) > 10
	ORDER BY country DESC; --zoradíme zostupne podľa abecedy

-- vyberieme meno a priezvisko zákazníka v jednom stĺpci a email v druhom
SELECT
	first_name || ' ' || last_name as fullname,
	email
FROM customer
WHERE first_name LIKE 'C%' OR last_name LIKE 'C%';

-- vyberme len tých, ktorí majú jedinečné meno a priezvisko
SELECT DISTINCT last_name, first_name
FROM customer
ORDER BY
	last_name ASC NULLS FIRST,
	first_name ASC
LIMIT 10 OFFSET 3; --len prvých 10

-- vyberme vsetky rozne hodnoty stlpca active v zakaznikovi
SELECT DISTINCT active FROM customer; --pomocny select

-- vyberte všetkých neaktívnych zákazníkov
SELECT first_name, last_name, active
FROM customer
WHERE active = 0;

-- vyberte sumy a dátumy platieb, ktorých suma bola medzi 3 a 5 dolárov
SELECT amount, payment_date FROM payment
WHERE amount BETWEEN 3.0 AND 5.0;

-- pocet takych platieb
SELECT COUNT(amount) FROM payment WHERE amount BETWEEN 3.0 AND 5.0;

