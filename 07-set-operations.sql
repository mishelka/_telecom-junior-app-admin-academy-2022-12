--1a
select count(*) from (
    select first_name, last_name, email
       from customer
    union all
       select first_name, last_name, email
       from staff
    union all
       select first_name, last_name, null as email
       from actor
) as u;

--intersect
select first_name, last_name
       from actor
    intersect
       select first_name, last_name
       from customer;

select first_name, last_name
       from customer --599
    except -- -1
       select first_name, last_name
       from actor;

select first_name, last_name
       from actor --200
    except -- -1
       select first_name, last_name
       from customer;

--1b cez nejaky jedinecny identifikator - no nie je isty vysledok
--moze sa stat, ze tam budu nejake entity v oboch tabulkach s rovnakym menom, priezviskom a id, vtedy nam ten jeden udaj bude chybat
--NESPRAVNE
-- select count(*) from (
--     select customer_id as id, first_name, last_name
--        from customer
--     union
--        select staff_id as id, first_name, last_name
--        from staff
--     union
--        select actor_id as id, first_name, last_name
--        from actor
-- ) as u;

--istejsie cez union all:
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
