-- Подсчет количества товаров после каждого добавления
DROP TRIGGER IF EXISTS prod_cnt;
delimiter //
	CREATE TRIGGER prod_cnt AFTER INSERT ON products FOR EACH ROW
    BEGIN
		SELECT COUNT(*) INTO @prod_cnt FROM products;
    END //
delimiter ;

INSERT INTO products (name, brand_id, category_id, type_id, price)
VALUES 
("H14S59 Pro", 8, 6, 1, 5990);

SELECT @prod_cnt;

-- Если при редактировании информации старое значение полей было NULL и новое NULL, вставляется стандартное значение

DROP TRIGGER IF EXISTS products_update;
delimiter //
	CREATE TRIGGER products_update BEFORE UPDATE ON products FOR EACH ROW
    BEGIN
		DECLARE cop_id INT;
		SELECT id INTO cop_id FROM products ORDER BY id LIMIT 1;
        SET NEW.brand_id = COALESCE(NEW.brand_id, OLD.brand_id, cop_id);
        SET NEW.category_id = COALESCE(NEW.category_id, OLD.category_id, cop_id);
        SET NEW.type_id = COALESCE(NEW.type_id, OLD.type_id, cop_id);
    END //
delimiter ;

INSERT INTO products (name, brand_id, category_id, type_id, price)
VALUES 
("Test", NULL, NULL, NULL, 5990);

UPDATE products 
SET brand_id = NULL, category_id = NULL, type_id = NULL
WHERE name = "Test";

SELECT name, brand_id, category_id, type_id FROM products WHERE name = "Test";