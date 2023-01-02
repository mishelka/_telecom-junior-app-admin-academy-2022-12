DROP TABLE IF EXISTS person, contact;

CREATE TABLE person(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20) NOT NULL,
  surname VARCHAR(30) NOT NULL,
  age INT NOT NULL CHECK(age >= 0),
  birth_date DATE,
  address VARCHAR(50),
  identification_number UUID NOT NULL UNIQUE,
  salary DECIMAL(18,2) DEFAULT 5000.00 CHECK(salary > 0)
);

CREATE TABLE contact(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    person_id INT,
    email VARCHAR(20),
    CONSTRAINT fk_person
        FOREIGN KEY(person_id)
        REFERENCES person(id)
);

ALTER TABLE person ADD COLUMN sex VARCHAR(10);
ALTER TABLE person DROP COLUMN address;
ALTER TABLE person RENAME sex TO gender;
ALTER TABLE person RENAME identification_number to id_number;
ALTER TABLE person ALTER COLUMN name DROP NOT NULL;
ALTER TABLE contact ALTER COLUMN email SET NOT NULL;
/*
jfkldsa
jkfldsa
jflds
*/

-- CREATE TABLE person(
-- 	id INT NOT NULL,
-- 	name VARCHAR(20) NOT NULL,
-- 	surname VARCHAR(30) NOT NULL,
-- 	age INT NOT NULL,
-- 	birth_date DATE,
-- 	address VARCHAR(50),
-- 	salary REAL,
-- 	PRIMARY KEY(name, surname)
-- );


-- CREATE TABLE color(
--     id INT GENERATED ALWAYS AS IDENTITY,
--     name VARCHAR NOT NULL,
--     primary key(id)
-- );
--
-- CREATE TABLE color_serial(
--     id SERIAL,
--     name VARCHAR NOT NULL,
--     primary key(id)
-- );

-- drop table if exists color_serial, color;