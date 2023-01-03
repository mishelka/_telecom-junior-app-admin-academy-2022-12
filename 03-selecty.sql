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

-- vyberte mena a priezviska a platby zakaznikov, ktorych platby boli vyssie ako 10 dolarov
-- kolko ich je?
-- SELECT * from payment;
SELECT COUNT(*) FROM customer c, payment p
WHERE c.customer_id = p.customer_id
  AND amount > 10;

SELECT first_name, last_name, amount FROM customer, payment
 WHERE customer.customer_id = payment.customer_id
     AND amount > 10;

SELECT UPPER(c.first_name || ' ' || c.last_name) as customer,
       amount,
       s.first_name || ' ' || s.last_name as staff
FROM customer c, payment p, staff s
 WHERE c.customer_id = p.customer_id
     AND s.staff_id = p.staff_id
     AND amount > 10;

--2 vypiste nazvy vsetkych kategorii podla abecedy
--3a zmente jazyk viacerych filmov na rozne ine jazyky cez UPDATE, aby ste dostali iny vysledok.
--3 vyberte vsetky filmy v anglickom jazyku (1000). Kolko je takych, ktore nie su v anglictine? (0)
--4 vypiste adresy zoradene podla okresu (district) abecedne (vzostupne), pričom prázdne okresy (null) budú zobrazené ako prvé
--5 kolko akcnych filmov sa nachadza v nasej databaze? (64)
--6 vypiste pocet vsetkych filmov v obchode s id 1 (2270)
--7 vypiste adresy a telefonne cisla vsetkych obchodov
--  pridajte aj mena a emaily ich manazerov
--  k adrese pridajte aj mesto a krajinu
--8 ktore filmy zatial neboli vratene? Nazvy tychto filmov vypiste velkymi pismenami. (183)
--9 Vypiste zoznam filmov, v ktorych hral James Pitt (31).
--10 vypiste nazvy pozicanych (rentals) filmov, ktore sa uskutocnili v roku 2006 (treba pouzit funkciu EXTRACT na vybratie roku) (182)
--   BONUS: pridajte aj adresu obchodu, z ktoreho boli pozicane a priezvisko zamestnanca, ktory filmy pozical