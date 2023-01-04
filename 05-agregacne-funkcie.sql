select COUNT(DISTINCT f.language_id)
from film f;

select AVG(f.rental_rate)
from film f;

select SUM(f.length) * 60 as time_in_minutes
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
