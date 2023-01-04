-- ALTER TABLE staff ADD COLUMN IF NOT EXISTS title VARCHAR(20);
-- ALTER TABLE staff ADD COLUMN IF NOT EXISTS reports_to INT;
-- ALTER TABLE staff ADD CONSTRAINT fk_customer_boss FOREIGN KEY (reports_to) REFERENCES staff (staff_id);
-- ALTER TABLE staff ADD COLUMN IF NOT EXISTS birthdate DATE;
-- ALTER TABLE staff ADD COLUMN IF NOT EXISTS hiredate DATE;
-- ALTER TABLE staff DROP COLUMN IF EXISTS username;
-- ALTER TABLE staff DROP COLUMN IF EXISTS password;
-- ALTER TABLE staff ALTER COLUMN address_id DROP NOT NULL;
--
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Adams', 'Andrew', 'General Manager', NULL, '1962-02-18', '2002-08-14', 'andrew@chinookcorp.com', 1, 1, true);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Edwards', 'Nancy', 'Rent Manager', 1, '1958-12-08', '2002-05-01', 'nancy@chinookcorp.com', 2, 1, true);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Peacock', 'Jane', 'Rent Support Agent', 2, '1973-08-29', '2002-04-01', 'jane@chinookcorp.com', 3, 1, false);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Park', 'Margaret', 'Rent Support Agent', 2, '1947-09-19', '2003-05-03', 'margaret@chinookcorp.com', 4, 1, true);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Johnson', 'Steve', 'Rent Support Agent', 2, '1965-03-03', '2003-10-17', 'steve@chinookcorp.com', NULL, 2, false);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Mitchell', 'Michael', 'IT Manager', 1, '1973-07-01', '2003-10-17', 'michael@chinookcorp.com', 6, 1, true);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('King', 'Robert', 'IT Staff', 6, '1970-05-29', '2004-01-02', 'robert@chinookcorp.com', NULL, 1, true);
-- INSERT INTO staff (last_name, first_name, title, reports_to, birthdate, hiredate, email, address_id, store_id, active)
--     VALUES ('Callahan', 'Laura', 'IT Staff', 6, '1968-01-09', '2004-03-04', 'laura@chinookcorp.com', 8, 2, true);
--
-- UPDATE staff SET reports_to = 4 WHERE reports_to IS NULL;
-- UPDATE staff SET birthdate = '1984-12-10' WHERE birthdate IS NULL;
-- UPDATE staff SET hiredate = NOW() WHERE hiredate IS NULL;
-- UPDATE staff SET title = 'Shop Worker' WHERE staff_id = 1 OR staff_id = 2;

-- CREATE TABLE film_review(
--    review_id SERIAL PRIMARY KEY,
--    film_id INT,
--    review VARCHAR(255) NOT NULL
-- );
--
-- INSERT INTO film_review(film_id, review)
-- VALUES(1, 'Excellent'),
--       (1, 'Awesome'),
--       (2, 'Cool'),
--       (NULL, 'Beautiful');

--full outer join (can contain nulls on both sides)
--all addresses and all staff, whether they have reference between them or not
select
    address.address_id,
    staff.staff_id,
    staff.first_name, staff.last_name
from address --left table
full outer join staff --right table
    on address.address_id = staff.address_id
order by address_id nulls first;

--left join
--all adresses with or without a reference in staff
select
    address.address_id,
    staff.staff_id,
    staff.first_name, staff.last_name
from address --left table
left join staff --right table
    on address.address_id = staff.address_id
order by staff_id nulls last;

--right join
--all staff, whether they have an address or not
select
    address.address_id,
    staff.staff_id,
    staff.first_name, staff.last_name
from address --left table
right join staff --right table
    on address.address_id = staff.address_id
order by address_id nulls first;

--full outer join
--all films and inventory, whether they have reference between them or not
select f.film_id, title, inventory_id
    from film f
    full outer join inventory i
    on i.film_id = f.film_id
    order by inventory_id nulls first;

--left join
--films that are not in any inventory
SELECT
    inventory_id,
	f.film_id,
	title
FROM
	film f --left table - can contain null values
LEFT JOIN inventory i --right table
   ON i.film_id = f.film_id
WHERE i.film_id IS NULL
ORDER BY title;

--right join
--all reviews and titles, but list also reviews that do not reference any movie
SELECT review, title
FROM film --left table
RIGHT JOIN film_review --right table - will contain null values
   ON film_review.film_id = film.film_id;

--right join
--find a review that does not have any movie assigned
SELECT review, title
FROM film
RIGHT JOIN film_review using (film_id)
WHERE title IS NULL;

--ktori zamestnanci nepozicali ani jeden film? (8)
SELECT rental.rental_id, staff.staff_id, staff.first_name, staff.last_name
FROM rental
right join staff ON rental.staff_id = staff.staff_id
where rental_id is null;

--ktore pozicky este nemali ziadnu platbu? (1452)
--kolko ich bolo zaplatenych celkovo? (14596)
select payment.payment_id, rental.rental_id from payment
full outer join rental
on payment.rental_id = rental.rental_id
where payment.payment_id is /*not*/ null;
