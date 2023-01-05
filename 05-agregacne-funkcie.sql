select COUNT(DISTINCT f.language_id)
from film f;

select AVG(f.rental_rate)
from film f;

select SUM(f.length) * 60 as time_in_seconds
from film f;

--max cena filmov z kategorie Animation
SELECT MIN(f.rental_rate) FROM film f
join film_category fc using(film_id)
join category c using(category_id)
WHERE c.name LIKE 'Animation';

--priemer vsetkych cien filmov pre kazdu kategoriu
select c.name,
       ROUND(AVG(f.rental_rate), 2) || ' EUR' as average_price,
       MIN(f.rental_rate) as min,
       MAX(f.rental_rate) as max,
       count(f.film_id)
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by average_price desc;

-- 1. Vypiste sumarne, kolko filmov sa nachadza v jednotlivych kategoriach.
--     Pre overenie vedzte, ze v kategorii Sports sa nachadza 74 filmov a v kategorii Music 51.
select c.name, count(fc.film_id)
from category c
inner join film_category fc on c.category_id = fc.category_id
inner join film f on fc.film_id = f.film_id
group by c.category_id, c.name
order by count(fc.film_id) desc;

--2. Zistite čas v minutach najdlhsieho filmu, najkratsieho filmu a priemerný čas filmov v kategorii Sci-Fi.
-- Priemerny cas zaokruhlite na 2 desatinne miesta.
-- Pre kontrolu vedzte, ze max je 51, min 185 a priemerny cas v Sci-Fi je 108,2.
select c.name, MAX(f.length),
       MIN(f.length),
       ROUND(AVG(f.length), 2)
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
--where c.name LIKE 'Sci-Fi'
group by c.name
having AVG(f.length) > 110;


select min(length) as min_min,
      max(length) as max_min,
      round(avg(length), 2) as avg_min_sec
from film f
inner join film_category fc on f.film_id = fc.film_id
inner join category c on fc.category_id = c.category_id
where c.name LIKE 'Sci-Fi';

-- 3. Vypiste sumarne zisky pozicovne filmov po jednotlivych dnoch v mesiaci februar. Platby mame iba za tento mesiac.


--4 Vypíšte zisky z vypoziciek podľa krajiny,
-- z ktorych pochazdaju zakaznici.
-- Zoznam zoraďte podľa zisku od najvyšších po najnižšie.
select fa.country, SUM(amount) as zisk
from payment p
    inner join rental r on r.rental_id = p.rental_id
    join customer c on c.customer_id = r.customer_id
    inner join full_address fa on c.address_id = fa.address_id
where DATE(p.payment_date) = '2007-02-16'
group by fa.country;

select cr.country, SUM(p.amount) as sum
from rental r
  inner join payment p using(rental_id)
  inner join customer c on p.customer_id = r.customer_id
  inner join address a using(address_id)
  inner join city ct using (city_id)
  inner join country cr using (country_id)
group by cr.country
order by sum desc;

-- Kolko za poziciavanie filmov uz minul Karl Seal?
-- Pre overenie správnosti vedzte, že Karl Seal minul poziciavanim filmov $208.58.
select SUM(amount)
from payment p
join customer c using(customer_id)
where c.first_name LIKE 'Karl'
  AND c.last_name LIKE 'Seal';

select c.first_name, c.last_name, SUM(amount) as vydaje
from payment p
join customer c using(customer_id)
where c.first_name LIKE 'D%'
group by c.customer_id
having SUM(amount) > 100;

select customer.first_name, customer.last_name,
       sum(amount) as vydaje
from payment
natural join customer
group by customer_id
order by vydaje desc;

--Aký herec je najobľúbenejší film u zákazníka Karla Seala?
-- (najobľúbenejší - poziciaval ho najčastejšie).
-- Pre overenie vedzte, že jeho najoblubenejsou hereckou je Uma Wood a filmy s touto hereckou si pozical 6x.
select a.first_name, a.last_name, count(a.actor_id)
from rental r
join customer c on r.customer_id = c.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on f.film_id = i.film_id
join film_actor fa on f.film_id = fa.film_id
join actor a on fa.actor_id = a.actor_id
where c.first_name = 'Karl'
and c.last_name = 'Seal'
group by a.actor_id
order by count(a.actor_id) desc;