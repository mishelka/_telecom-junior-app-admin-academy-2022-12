--INNER JOIN
select f.film_id, l.language_id
from film f
inner join language l on f.language_id = l.language_id;

select f.film_id, l.language_id
from film f
left join language l on f.language_id = l.language_id
order by l.language_id nulls first;

select f.film_id, l.language_id, l.name
from film f
right join language l on f.language_id = l.language_id
order by f.film_id nulls first;

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
SELECT staff.first_name, staff.last_name,
       staff.email, address.address_id
FROM rental
right join staff ON rental.staff_id = staff.staff_id
    --right join = aj taka PRAVA STRANA, ktora NEMA REFERENCIU na lavu/v lavej
    --aj staff nema referenciu v rental
    -- = staff, ktory nikdy neurobil ziadny rental
left join address on staff.address_id = address.address_id
    --left join = aj taka LAVA STRANA, ktora NEMA REFERENCIU na pravu/v pravej
    --aj rental+staff nema referenciu na address
    -- = cize rental+staff bez adresy
where rental_id is null;
--opacne, zacneme od zamestnanca
SELECT distinct staff.first_name, staff.last_name,
                staff.email, address.address
FROM staff
left join address on staff.address_id = address.address_id
left join rental ON rental.staff_id = staff.staff_id;

--4 Ktore vypozicky (rentals) este nemali ziadnu platbu? (1452)
select r.rental_id, p.payment_id
from rental r
--tu mozeme pouzit aj full outer join,lebo kazdy payment ma referenciu na rental
left join payment p on r.rental_id = p.rental_id
where p.payment_id IS NULL
order by p.payment_id nulls first;

select p.payment_id, r.rental_id from rental r
left join payment p on p.rental_id = r.rental_id
where p.payment_id IS NULL;
--4a Ku kazdej pozicke vypiste meno a priezvisko zakaznika a nazov pozicaneho filmu
select c.first_name, c.last_name, f.title
from rental r
left join payment p on r.rental_id = p.rental_id
inner join customer c on r.customer_id = c.customer_id
inner join inventory i on r.inventory_id = i.inventory_id
inner join film f on i.film_id = f.film_id
where p.payment_id IS NULL
order by p.payment_id nulls first;
-- join payment p using(rental_id);

--4b Kolko ich bolo zaplatenych celkovo? (14596)
select c.first_name, c.last_name, f.title, p.payment_id, r.rental_id from rental r
    inner join customer c on r.customer_id = c.customer_id
    inner join inventory i on r.inventory_id = i.inventory_id
    inner join film f on i.film_id = f.film_id
    left join payment p on p.rental_id = r.rental_id
where p.payment_id IS NOT NULL;
