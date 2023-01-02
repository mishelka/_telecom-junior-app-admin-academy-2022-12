-- INSERT INTO category (last_update, name)
-- VALUES ('2006-02-15 09:46:27', 'Sci-Fi'),
--        ('2006-02-15 09:46:27', 'Dalsia kategoria')
-- RETURNING category_id;
--
-- INSERT INTO category
-- VALUES ('Sci-Fi', '2006-02-15 09:46:27');

UPDATE category
SET name = 'Nova'
--     , last_update = '...'
WHERE category_id = 18;

UPDATE category
SET name = 'Nova Kategoria'
WHERE name LIKE 'Sci-Fi' AND category_id > 14;

DELETE FROM category
WHERE category_id = 19 OR category_id = 20;

SELECT * FROM category;
