select * from film f
where f.rental_rate > 2;

select * from film f
where f.rental_rate BETWEEN (
    SELECT AVG(rental_rate)
    FROM film
) AND 4;

--filmy v kategorii Action a Drama
select f.title, fc.category_id from film f, film_category fc
where fc.film_id = f.film_id
and fc.category_id IN (
   SELECT category_id
   FROM category
   WHERE name = 'Action'
   OR name = 'Drama'
);

--to iste cez any
select f.title, fc.category_id from film f, film_category fc
where fc.film_id = f.film_id
and fc.category_id = ANY (
   SELECT category_id
   FROM category
   WHERE name = 'Action'
   OR name = 'Drama'
);
--to iste cez join
select f.title, fc.category_id
from film f
join film_category fc
    on fc.film_id = f.film_id
join category c
    on fc.category_id = c.category_id
where c.name IN ('Action', 'Drama');

--exists
SELECT first_name, last_name
FROM customer c
WHERE EXISTS (
    SELECT 1 FROM payment p
    WHERE p.customer_id = c.customer_id
    AND amount > 11
)
ORDER BY first_name , last_name;

-- Vypíšte zamestnancov,
-- ktorých vek je menší ako
-- priemerný vek vsetkych zamestnancov.

select * from film f
where f.rental_rate < (
    SELECT AVG(rental_rate)
    FROM film
);

--1 vyberte filmy, ktore boli pozicane viac ako 5x
select title from film f
where (
    select count(i.film_id) from inventory i
    left join rental r on i.inventory_id = r.inventory_id
    where f.film_id = i.film_id
    group by i.film_id
) > 30;

select r.customer_id, count(r.customer_id)
from rental r
group by r.customer_id
order by count(r.customer_id) desc;

select first_name, last_name
from customer c
where (
    select count(r.customer_id)
    from rental r
    where r.customer_id = c.customer_id
) > 40;