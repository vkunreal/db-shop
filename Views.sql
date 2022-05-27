-- Видеокарты от самых дорогих к самым дешёвым

CREATE OR REPLACE VIEW sort_prod AS
SELECT
	id,
	name,
    (SELECT name FROM brand WHERE brand.id = brand_id) brand,
    (SELECT name FROM category WHERE category.id = category_id) category,
    (SELECT name FROM type WHERE type.id = type_id) type,
    price
FROM products WHERE category_id = 1 ORDER BY price DESC;

SELECT * FROM sort_prod;

-- Категории продуктов со скидкой, от большей к меньшей 

CREATE OR REPLACE VIEW discount_categories AS
SELECT
	GROUP_CONCAT(name) name,
	discount
FROM category WHERE discount != 0 GROUP BY discount ORDER BY discount DESC;

SELECT * FROM discount_categories;