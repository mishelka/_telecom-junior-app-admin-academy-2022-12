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

CREATE TABLE IF NOT EXISTS film_review(
   review_id SERIAL PRIMARY KEY,
   film_id INT,
   review VARCHAR(255) NOT NULL
);

INSERT INTO film_review(film_id, review)
VALUES(1, 'Excellent'),
      (1, 'Awesome'),
      (2, 'Cool'),
      (NULL, 'Beautiful');

--inner join - iba tie, ktore maju na seba recenzie (3ks)
-- PRIENIK mnozin
select f.title
    as film, r.review, f.film_id, r.review_id
from film_review r
inner join film f on r.film_id = f.film_id;

--full outer join - vsetko - recenzie ktore nemaju film (4+1000-2 = 1002)
-- aj filmy, ktore nemaju recenzie
-- ZJEDNOTENIE mnozin
select f.title
    as film, r.review, f.film_id, r.review_id
from film_review r
full outer join film f on r.film_id = f.film_id;