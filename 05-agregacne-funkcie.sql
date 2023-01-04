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


