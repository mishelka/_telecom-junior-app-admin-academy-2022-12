-- DROP TABLE person;

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

-- CREATE TABLE person(
--   id INT PRIMARY KEY NOT NULL,
--   name VARCHAR(20) NOT NULL,
--   surname VARCHAR(30) NOT NULL,
--   age INT NOT NULL,
--   birth_date DATE,
--   address VARCHAR(50),
--   salary REAL
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

drop table if exists color_serial, color;