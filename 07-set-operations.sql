--1a
select count(*) from (
    select first_name, last_name
       from customer
    union
       select first_name, last_name
       from staff
    union
       select first_name, last_name
       from actor
) as u;

--1b cez nejaky jedinecny identifikator - no nie je isty vysledok
--moze sa stat, ze tam budu nejake entity v oboch tabulkach s rovnakym menom, priezviskom a id, vtedy nam ten jeden udaj bude chybat
select count(*) from (
    select customer_id as id, first_name, last_name
       from customer
    union
       select staff_id as id, first_name, last_name
       from staff
    union
       select actor_id as id, first_name, last_name
       from actor
) as u;
--istiejsie cez union all:
select count(*) from (
    select first_name, last_name
       from customer
    union all
       select first_name, last_name
       from staff
    union all
       select first_name, last_name
       from actor
) as u;
--2 vsetci zamestnanci a zakaznici z Kanady
select last_name, first_name, address, city, country, 'employee' as TYPE
    from staff
    inner join full_address fa on staff.address_id = fa.address_id
    where country = 'Canada'
union
select last_name, first_name, address, city, country, 'customer' as TYPE
    from customer
    inner join full_address f on customer.address_id = f.address_id
    where country = 'Canada'
order by type, last_name, first_name;

--BONUS: Vypíšte zoznam všetkých filmov (ich názvy),
-- ktoré nepatria do kategorie 'Action'. (936)
--hint: pouzite except alebo intersect
select f.title from film f
where f.film_id not in (
    select f1.film_id from film f1
    intersect
    select fc.film_id from film_category fc
       join category p on fc.category_id = p.category_id
       and p.name = 'Action'
);
--cez except
SELECT title, film_id
FROM film
EXCEPT
SELECT f.title, f.film_id
FROM film f
JOIN film_category fc
   ON f.film_id=fc.film_id
JOIN category c
   ON fc.category_id=c.category_id
WHERE c.name LIKE 'Action';
