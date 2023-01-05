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
--1 Vyberte zakaznikov,
-- ktori si pozicali viac ako 40x
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

--2 Zoznam filmov,
-- ktore neboli pozicane ani raz
select count(title) from film
where film_id not in (
    select film_id from rental r
    join inventory i on r.inventory_id = i.inventory_id
);

--to iste cez right join
select /*distinct i.film_id, title*/
    count(distinct title) from rental r
    inner join inventory i on r.inventory_id = i.inventory_id
    right join film f on i.film_id = f.film_id
where i.film_id is null;
--order by i.film_id nulls first;

--3 vyberte vsetkych zamestnancov,
-- ktorych vek je mensi ako priemerny
--vek vsetkych zamestnancov (5)
--a cez extract - ale ak je tam nejaky prechodny datum, nemusi sediet
select staff_id from staff
    group by birthdate, staff_id
    having extract(year from current_date)
               - extract(year from birthdate) < (
        select avg(extract(year from current_date)
                       - extract(year from birthdate))
        from staff
);

select last_name,
      first_name,
      extract(year from current_date) - extract(year from birthdate) as age
from staff
where staff_id in (
    select staff_id from staff
    group by birthdate, staff_id
    having extract(year from current_date) - extract(year from birthdate) < (
        select avg(extract(year from current_date) - extract(year from birthdate))
        from staff
    )
);

--b cez date_part
select last_name,
      first_name,
      DATE_PART('year', AGE(now(), birthdate))
from staff
where staff_id in (
    select staff_id from staff
    group by birthdate, staff_id
    having DATE_PART('year', AGE(now(), birthdate)) < (
        select avg(DATE_PART('year', AGE(now(), birthdate)))
        from staff
    )
);

select title, c.name,
      f.length as duration
from category c
    inner join film_category fc
        on c.category_id = fc.category_id
               and c.name = 'Action'
    inner join film f on f.film_id = fc.film_id
order by duration desc;

--4 najdlhsi a najkratsi film v kategorii Children.
select title,
      f.length as duration
from category c
    inner join film_category fc
        on c.category_id = fc.category_id
               and c.name = 'Action'
    inner join film f on f.film_id = fc.film_id
where f.length = (
    select max(length) from film f
        inner join film_category fc on f.film_id = fc.film_id
        inner join category c on fc.category_id = c.category_id
            and c.name = 'Action'
)
or f.length = (
    select min(length) from film f
        inner join film_category ct on f.film_id = ct.film_id
        inner join category c on ct.category_id = c.category_id
            and c.name = 'Action'
);
