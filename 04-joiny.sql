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