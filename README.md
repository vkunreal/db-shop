# Database for a shop

There are 10 tables in the database: users, profiles, products, brand, category, type, orders, order_products, storehouses, storehouses_products.

1. The users table contains users of the online store. Has columns: ID, first name, last name, email. email, password hash, phone number, and whether the user has been deleted.

2. The profiles table contains user profiles. Has columns: user id, gender, birthday, photo, creation date and city.

3. The products table contains products. It has columns: id, name, product brand id, product category id, product type id and price.

4. The brand table contains product brands. Has columns: index and name.

5. The category table contains product categories. Has columns: id, name, and product discount.

6. The type table contains the product type. Has columns: index and name.

7. The orders table contains user orders. It has columns: ID, user ID, order date and information about order cancellation and payment.

8. The order_products table contains order information. Has columns: Order ID, Product ID, and Product Quantity. (primary keys - order id and product id).

9. The storehouses table contains information about the warehouses of the online store. It has columns: index, name, date of creation and date of replenishment.

10. The storehouses_products table contains information about products in warehouses. It has columns: identifier, warehouse ID, product ID, quantity in stock, date of delivery and date of transportation.

Database tasks:

1. Storage of information about users, profiles, products, orders, warehouses

2. Update this information

3. Maintain integrity
