DROP TABLE IF EXISTS person;

CREATE TABLE person(
  id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(20) NOT NULL,
  surname VARCHAR(30) NOT NULL,
  age INT NOT NULL CHECK(age > 0),
  birth_date DATE,
  address VARCHAR(50),
  identification_number UUID NOT NULL UNIQUE,
  salary DECIMAL(18,2) DEFAULT 5000.00 CHECK(salary > 0)
);

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