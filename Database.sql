DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
use shop;

/* Создание таблиц */

-- пользователи

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password_hash VARCHAR(100) NOT NULL, -- пароль
	phone BIGINT NOT NULL,
    is_deleted bit default 0, -- удален ли пользователь

    INDEX users_firstname_lastname_idx(firstname, lastname)
);

-- профили пользователей

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles` (
	user_id SERIAL PRIMARY KEY,
    gender VARCHAR(1),
    birthday DATETIME,
    photo_id VARCHAR(150),
    created_at DATETIME,
    hometown VARCHAR(50),

    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- категория товара

DROP TABLE IF EXISTS category;
CREATE TABLE category (
	id SERIAL PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL,
    discount int default 0
);

-- бренд товара

DROP TABLE IF EXISTS brand;
CREATE TABLE brand (
	id SERIAL PRIMARY KEY,
    `name` VARCHAR(150) NOT NULL
);

-- тип товара

DROP TABLE IF EXISTS `type`;
CREATE TABLE `type`(
	id SERIAL PRIMARY KEY,
    `name` VARCHAR(100)
);

-- товары

DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL,
    `name` VARCHAR(150) NOT NULL, -- название товара
    brand_id BIGINT UNSIGNED, -- производитель
    category_id BIGINT UNSIGNED, -- категория товара
    type_id BIGINT UNSIGNED,
    price int NOT NULL, -- цена

    FOREIGN KEY (brand_id) REFERENCES brand(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(type_id) REFERENCES type(id) ON UPDATE CASCADE ON DELETE CASCADE,
    INDEX products_name_brand_id_idx(`name`, brand_id)
);

-- заказы пользователей

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
	id SERIAL PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    `date` DATETIME default NOW(),
    is_paid bit default 0,
    is_deleted bit default 0,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
 );
 
 -- заказы

DROP TABLE IF EXISTS order_products;
CREATE TABLE order_products(
	order_id BIGINT UNSIGNED NOT NULL,
    product_id BIGINT UNSIGNED NOT NULL,
    count int NOT NULL,

    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- склады

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  `name` VARCHAR(255),
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW()
);

-- продукты на складе

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id BIGINT UNSIGNED,
  product_id BIGINT UNSIGNED,
  `count` INT UNSIGNED,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW(),

  FOREIGN KEY (storehouse_id) REFERENCES storehouses(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

/* Заполнение таблиц */

-- users

INSERT INTO users(firstname, lastname, email, password_hash, phone)
VALUES
('Reuben', 'Nienow', 'arlo50@example.org', "sajdfgjfdsvi3245idifs", '9374071116'),
('Frederik', 'Upton', 'terrence.cartwright@example.org', "sdfng439gifkmview",'9127498182'),
('Unique', 'Windler', 'rupert55@example.org', "asdmv493jfidsamvg43qf",'9921090703'),
('Norene', 'West', 'rebekah29@example.net', "igad932gdfsgii43wg",'9592139196'),
('Frederick', 'Effertz', 'von.bridget@example.net', "reisgmvdif390gwidfsb",'9909791725'),
('Victoria', 'Medhurst', 'sstehr@example.net', "dsa0etyajxcvi5wdfsb",'9456642385'),
('Austyn', 'Braun', 'itzel.beahan@example.com', "493gkz6vxzimv239fisdjvzx",'9448906606'),
('Jaida', 'Kilback', 'johnathan.wisozk@example.com', "gkdmfsivoq4jgvsdmcxv",'9290679311'),
('Mireya', 'Orn', 'missouri87@example.org', "fmv439w9vosdkmcvsirs",'9228624339'),
( 'Jordyn', 'Jerde', 'edach@example.com', "go43womzcviaweginbvcx",'9443126821'),
('Thad', 'McDermott', 'shaun.ferry@example.org', "mrg394mvsdimcvbniweisnd",'9840726982'),
('Aiden', 'Runolfsdottir', 'doug57@example.net', "sdaov403smikciovseof",'9260442904'),
('Bernadette', 'Haag', 'lhoeger@example.net', "rmegwozsdlmvjnbrtds",'9984574866'),
('Dedric', 'Stanton', 'tconsidine@example.org', "2o3qkfoksdivjxicvaopew",'9499932439'),
('Clare', 'Wolff', 'effertz.laverna@example.org', "sdfvm4i3r02ofka",'9251665331');

-- profiles

INSERT INTO `profiles` VALUES 
('1','f','1976-11-08','1','1970-01-18 03:54:01','Adriannaport'),
('2','f','2011-12-20','2','1994-11-06 23:56:10','North Nettieton'),
('3','m','1994-06-15','3','1975-11-27 02:27:11','Padbergtown'),
('4','f','1979-11-07','4','1994-04-12 04:31:49','Port Rupertville'),
('5','f','1976-04-19','5','1976-07-05 02:25:30','Spencerfort'),
('6','f','1983-09-07','6','1981-06-20 15:54:43','South Woodrowmouth'),
('7','m','2014-07-31','7','1997-06-21 07:52:05','South Jeffereyshire'),
('8','f','1975-03-26','8','2008-08-18 18:23:25','Howeside'),
('9','f','1982-11-01','9','2014-09-29 01:22:26','Loweborough'),
('10','m','1977-05-14','10','1980-03-17 18:17:45','New Nellaside'),
('11','m','1988-10-28','11','2011-08-22 08:31:06','New Skylar'),
('12','f','1994-02-07','12','2015-08-04 16:34:50','South Dameontown'),
('13','f','1998-08-08','13','1978-02-12 03:14:55','North Terencemouth'),
('14','f','1973-11-16','14','2015-03-13 03:01:16','West Wilfordshire'),
('15','m','1979-08-20','15','1983-08-13 03:48:56','North Xavier');

-- brand

INSERT INTO brand(name)
VALUES
("Intel"),
("AMD"),
("NVIDIA"),
("Gigabyte"),
("AsRock"),
("MSI"),
("ZULMAN"),
("Kingston"),
("Patriot"),
("ASUS"),
("Corsair"),
("Western Digital");

-- category

INSERT INTO category(`name`, discount) 
VALUES
("Процессоры", 5),
("Видеокарты", default),
("Материнские платы", 10),
("Оперативная память", 5),
("Жесткие диски", default),
("SSD", default),
("Блоки питания", default),
("Куллеры", 15),
("Жесткие диски", default),
("Корпусы", 5),
("Водяные системы охлаждения", default),
("Компьютерные мыши", default),
("Флешки", default);

-- type

INSERT INTO `type`(`name`)
VALUES
("Комплектующие ПК"),
("Девайсы для ПК"),
("Дополнительные носители памяти");

-- products

INSERT INTO products(`name`, brand_id, category_id, type_id, price)
VALUES
("Core i5 5040", 1, 1, 1, 12500),
("FX 6500 X", 2, 1, 1, 8900),
("GTX 1050Ti", 3, 2, 1, 23500),
("RX 570 Super", 2, 2, 1, 25000),
("MX 6493 Gaming", 4, 3, 1, 7999),
("GF 3200 Pro", 5, 3, 1, 5600),
("OME 8GB", 8, 4, 1, 2800),
("Gaming OPMEM 16GB", 8, 4, 1, 5699),
("PB 550W", 7, 7, 1, 5000),
("PBX 1200W", 7, 7, 1, 14500),
("Blue Disk 1TB", 12, 5, 1, 4500),
("CPU Cul", 11, 8, 1, 2399),
("Black Block", 7, 10, 1, 12000),
("Water Cold", 9, 11, 1, 7600),
("Computer Mouse", 10, 12, 2, 2300),
("Flesh 32GB", 8, 13, 3, 350);

-- orders

INSERT INTO orders(user_id, is_paid) 
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 0),
(6, 0),
(7, 0),
(8, 1),
(9, 1),
(10, 0),
(11, 0),
(12, 1),
(13, 1),
(14, 1),
(15, 0);

-- order_products

INSERT INTO order_products(order_id, product_id, count)
VALUES
(1, 1, 1),
(2, 3, 1),
(3, 2, 1),
(4, 1, 2),
(5, 10, 1),
(6, 7, 2),
(7, 4, 1),
(8, 12, 1),
(9, 13, 3),
(10, 2, 2),
(11, 13, 2),
(12, 5, 1),
(13, 8, 1),
(14, 9, 1),
(15, 2, 1);

-- storehouses

INSERT INTO storehouses(`name`)
VALUES
("Moscow Central Storehouse"),
("Saint-Peterburg Storehouse"),
("Minsk Urucha Storehouse");

-- storehouses_products

INSERT INTO storehouses_products(storehouse_id, product_id, count)
VALUES
(1, 1, 22),
(1, 2, 15),
(1, 3, 34),
(1, 4, 25),
(3, 5, 12),
(3, 6, 0),
(2, 7, 67),
(1, 8, 21),
(2, 9, 5),
(2, 10, 79),
(1, 11, 35),
(1, 12, 48),
(3, 13, 220),
(2, 14, 57),
(2, 15, 18);