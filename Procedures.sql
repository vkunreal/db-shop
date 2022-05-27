/* Процедуры */

-- среднее значение цены

DROP PROCEDURE IF EXISTS average_price;
delimiter //
	CREATE PROCEDURE average_price()
    BEGIN
		SELECT ROUND(AVG(price)) as "average price" FROM products;
    END //
delimiter ;

CALL average_price();

-- данные о таблице заказов

DROP PROCEDURE IF EXISTS data_orders;
delimiter //
	CREATE PROCEDURE data_orders()
    BEGIN
		SELECT 
			(SELECT COUNT(COLUMN_NAME) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders') 'количество столбцов',
		
			COUNT(*) 'количество полей',
            
            (SELECT C.COLUMN_NAME FROM information_schema.TABLE_CONSTRAINTS AS pk
            INNER JOIN information_schema.KEY_COLUMN_USAGE AS C ON
            C.TABLE_NAME = pk.TABLE_NAME AND
			C.CONSTRAINT_NAME = pk.CONSTRAINT_NAME AND
			C.TABLE_SCHEMA = pk.TABLE_SCHEMA
            WHERE pk.TABLE_NAME = 'orders' AND pk.TABLE_SCHEMA = 'shop' limit 1) 'первичный ключ',
            
            (SELECT C.COLUMN_NAME FROM information_schema.TABLE_CONSTRAINTS AS pk
            INNER JOIN information_schema.KEY_COLUMN_USAGE AS C ON
            C.TABLE_NAME = pk.TABLE_NAME AND
			C.CONSTRAINT_NAME = pk.CONSTRAINT_NAME AND
			C.TABLE_SCHEMA = pk.TABLE_SCHEMA
            WHERE pk.TABLE_NAME = 'orders' AND pk.TABLE_SCHEMA = 'shop' ORDER BY COLUMN_NAME DESC limit 1) 'внешние ключи'
		FROM `orders`;
    END //
delimiter ;

CALL data_orders();