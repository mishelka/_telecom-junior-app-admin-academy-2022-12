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