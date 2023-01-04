--INNER JOIN
select f.title
from film f, language l
where f.language_id = l.language_id;

select f.title from film f
INNER JOIN language l
ON f.language_id = l.language_id;

select title from film
JOIN language
ON language_id;

--LEFT JOIN
select f.title from film f
LEFT JOIN language l
ON f.language_id = l.language_id;

--RIGHT JOIN
select f.title from film f
RIGHT JOIN language l
ON f.language_id = l.language_id;

--ULOHA na prepisanie:
--bez inner joinu (sql ho ale automaticky robi):
SELECT COUNT(*) FROM customer c, payment p
WHERE c.customer_id = p.customer_id
AND amount > 10;
--s inner joinom:
SELECT COUNT(*) FROM customer c
    INNER JOIN payment p
        ON c.customer_id = p.customer_id
WHERE amount > 10;
--skratenie vdaka tomu, ze customer_id je v oboch tabulkach rovnako nazvane
SELECT COUNT(*) FROM customer
    INNER JOIN payment
        ON customer_id
WHERE amount > 10;

--1 vyber recenziu, ktora nema film (1)
-- ROZDIEL mnozin
select f.title as film_title,
       r.review, f.film_id, r.review_id
from film f
right join film_review r on r.film_id = f.film_id
where r.film_id IS NULL;

--2 vyber filmy, ktore nemaju recenziu (1000-2 = 998)
select f.title as film_title,
       r.review, f.film_id, r.review_id
from film f
LEFT JOIN film_review r on r.film_id = f.film_id
where r.review_id IS NULL;

--3 ktori zamestnanci nikomu nepozicali ani jeden film? (8)
SELECT rental.rental_id, staff.staff_id
FROM rental
right join staff ON rental.staff_id = staff.staff_id
where rental_id is null;
--3a vypiste ich mena, priezviska a emaily
SELECT staff.first_name, staff.last_name, staff.email
FROM rental
right join staff ON rental.staff_id = staff.staff_id
where rental_id is null;
--3b vypiste aj ich adresy
SELECT staff.first_name, staff.last_name, staff.email, address.address_id
FROM rental
right join staff ON rental.staff_id = staff.staff_id
left join address on staff.address_id = address.address_id
where rental_id is null;
