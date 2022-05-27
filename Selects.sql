use shop;

-- Вывести полный список продуктов (с помощью вложенных запросов)
SELECT 
id,
`name`,
(SELECT `name` FROM brand WHERE id = brand_id) as brand,
(SELECT `name` FROM category WHERE id = category_id) as category,
(SELECT `name` FROM type WHERE id = type_id) as `type`,
price
FROM products;

-- Вывести полный список продуктов (с помощью джоинов)

SELECT 
	p.id,
	p.name name, 
	b.name brand, 
    c.name category, 
    t.name type,
    p.price
FROM 
	products p JOIN brand b JOIN category c JOIN type t 
ON c.id = p.category_id AND b.id = brand_id AND t.id = type_id;

-- Повысить цены на видеокарты в связи с дефицитом

UPDATE category c JOIN products p ON c.id = p.category_id SET price = price * 1.2 WHERE c.name = "Видеокарты";

-- Вывести полную информацию только о тех продуктах, которые есть на складе

SELECT
	id,
    name,
    (SELECT name FROM brand WHERE id = brand_id) brand,
    (SELECT name FROM category WHERE id = category_id) category,
    (SELECT name FROM type WHERE id = type_id) type,
    price
FROM products WHERE id NOT IN (SELECT product_id FROM storehouses_products WHERE count = 0);

-- Вывести полную информацию только о тех продуктах, которые есть на складе (с помощью джоинов)

SELECT 
	p.id,
    p.name,
    b.name brand,
    c.name category,
    t.name type,
    price
FROM products p JOIN brand b JOIN category c JOIN type t
ON b.id = p.brand_id AND c.id = p.category_id AND t.id = p.type_id
WHERE p.id NOT IN (SELECT product_id FROM storehouses_products WHERE count = 0);