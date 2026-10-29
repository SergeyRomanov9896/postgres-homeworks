-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT c.company_name, concat_ws(' ', e.first_name, e.last_name) AS employee_name
FROM customers AS c
INNER JOIN orders AS o ON c.customer_id = o.customer_id
INNER JOIN employees AS e ON e.employee_id = o.employee_id
INNER JOIN shippers AS s ON s.shipper_id = o.ship_via
WHERE c.city = 'London' AND e.city = 'London' AND s.company_name = 'United Package';

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone 
FROM products AS p
INNER JOIN suppliers AS s USING(supplier_id)
INNER JOIN categories AS c USING(category_id)
WHERE p.discontinued = 0 
	AND p.units_in_stock < 25
	AND c.category_name IN ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name
FROM customers AS c
WHERE NOT EXISTS (
	SELECT 1
	FROM orders AS o
	WHERE c.customer_id = o.customer_id
	);

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT(p.product_name)
FROM products AS p
WHERE p.product_id IN (
	SELECT o.product_id
	FROM order_details AS o
	WHERE o.quantity = 10
);
