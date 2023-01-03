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

--domaca uloha

DROP TABLE IF EXISTS links, urls;

CREATE TABLE links(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20),
    url VARCHAR(50)
);

INSERT INTO links (name, url)
    VALUES
        ('Facebook', 'www.facebook.com'),
        ('LinkedIn', 'www.linkedin.com'),
        ('CDE', 'www.cde.sk');

ALTER TABLE links RENAME TO urls;

UPDATE urls
SET name = 'Microsoft'
WHERE id = 2;

--pozor, vymaze vsetko!
--DELETE FROM urls;
--TRUNCATE urls;

DELETE FROM urls WHERE id = 1;

-- SELECT * FROM urls;
SELECT COUNT(*) FROM urls;

