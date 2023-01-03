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

/*****
       RIESENIA ULOH
                      ******/
--2 vypiste nazvy vsetkych kategorii podla abecedy
select name
from category
order by name asc;
--3 vyberte vsetky filmy v anglickom jazyku (1000).
-- Kolko je takych, ktore nie su v anglictine? (0)
select f.title
from film f, language l
where f.language_id = l.language_id
and l.name = 'English';
select f.title
from film f, language l
where f.language_id = l.language_id
and l.name != 'English';
--3a zmente jazyk viacerych filmov na rozne ine jazyky cez UPDATE, aby ste dostali iny vysledok.

--4 vypiste adresy zoradene podla okresu (district) abecedne (vzostupne), pričom prázdne okresy (null) budú zobrazené ako prvé
select a.address, a.district
from address a
order by district nulls first;

--5 kolko akcnych filmov sa nachadza v nasej databaze? (64)
select count(*)
from film f, category c, film_category fc
where f.film_id = fc.film_id
and fc.category_id = c.category_id
and c.name = 'Action';

--6 vypiste pocet vsetkych filmov v obchode s id 1 (2270)
select COUNT(*)
from store s, inventory i, film f
where f.film_id = i.film_id
and i.store_id = s.store_id
and s.store_id = 1;

--7 vypiste adresy a telefonne cisla vsetkych obchodov
--  pridajte aj mena a emaily ich manazerov
--  k adrese pridajte aj mesto a krajinu
--r.return_date IS NULL
select a.address, a.phone,
       sf.first_name, sf.last_name, sf.email,
       c.city, ct.country
from store sr, address a, staff sf, city c, country ct
where sr.address_id = a.address_id
and sf.staff_id = sr.manager_staff_id
and a.city_id = c.city_id
and c.country_id = ct.country_id;

--8 ktore filmy zatial neboli vratene? Nazvy tychto filmov vypiste velkymi pismenami. (183)
select UPPER(f.title)
from film f, rental r, inventory i
where r.inventory_id = i.inventory_id
and i.film_id = f.film_id
and r.return_date IS NULL;

--9 Vypiste zoznam filmov, v ktobrych hral James Pitt (31).
select f.title
from film f, actor a, film_actor fa
where f.film_id = fa.film_id
and a.actor_id = fa.actor_id
and a.first_name = 'James'
and a.last_name = 'Pitt';

--10 vypiste nazvy pozicanych (rentals) filmov, ktore sa uskutocnili v roku 2006 (treba pouzit funkciu EXTRACT na vybratie roku) (182)
select f.title
from film f, rental r, inventory i
where r.inventory_id = i.inventory_id
and i.film_id = f.film_id
and EXTRACT(YEAR FROM r.rental_date) = 2006;

--   BONUS: pridajte aj adresu obchodu, z ktoreho boli pozicane a priezvisko zamestnanca, ktory filmy pozical
select f.title as movie,
       st.first_name as staff_name,
       st.last_name as staff_surname,
       a.address as store_address
from film f, rental r, inventory i, store s, staff st, address a
where r.inventory_id = i.inventory_id
and i.film_id = f.film_id
and i.store_id = s.store_id
and r.staff_id = st.staff_id
and st.address_id = a.address_id
and EXTRACT(YEAR FROM r.rental_date) = 2006;

--11 ktorych zakaznikov mame zo strednej Europy? ('Austria', 'Czech Republic', 'Hungary', 'Poland', 'Slovakia')
select c.first_name, c.last_name, co.country
from customer c, address a, city ci, country co
where c.address_id = a.address_id
and a.city_id = ci.city_id
and ci.country_id = co.country_id
and co.country IN ('Austria', 'Czech Republic', 'Hungary', 'Poland', 'Slovakia');

select count(*) from customer where first_name like 'T%';