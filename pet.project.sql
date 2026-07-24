-- ============================================
--ШАГ 1: РАЗВЕДКА ДАННЫХ
-- ============================================

--1.1. Просмотр базовых товаров --
SELECT product_id, product_name, unit_price
FROM products
LIMIT 10;

--1.2 смотрим детали заказов --
SELECT order_id,product_id, unit_price, quantity,discount
FROM order_details
LIMIT 10;

-- ============================================
--ШАГ 2: АНАЛИЗ КОММЕРЧЕСКОЙ ЭФФЕКТИВНОСТИ
-- ============================================
SELECT 
p.product_name AS "Название товара",
SUM(od.unit_price*od.quantity) AS "Общая выручка"
FROM order_details od
INNER JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name 
ORDER BY "Общая выручка" DESC
LIMIT 10;

-- ============================================
--ШАГ 3: АНАЛИЗ СКИДОК
-- ============================================

--3.1 Определяем статус скидки -- 
SELECT
	od.order_id,
	od.discount,
	CASE 
		WHEN od.discount = 0 THEN 'Без скидки'
		ELSE 'Есть скидка'
	END AS "Статус"
FROM order_details od;

--3.2 Бизнес отчет -- 
SELECT
	CASE
		WHEN od.discount = 0 THEN 'Без скидки'
		WHEN od.discount <=0.10 THEN 'Небольшая скидка(до 10%)'
		ELSE 'Крупная скидка(более 10%)'
	END AS "Категория скидки",
	COUNT(*) AS "Количество позиций",
	SUM(od.unit_price*quantity) AS "Общая выручка"
FROM order_details od
GROUP BY
	CASE
		WHEN od.discount = 0 THEN 'Без скидки'
		WHEN od.discount <=0.10 THEN 'Небольшая скидка(до 10%)'
		ELSE 'Крупная скидка(более 10%)'
	END
ORDER BY "Общая выручка" DESC;

-- ============================================
--ШАГ 4: СЕГМЕНТАЦИЯ КЛИЕНТОВ (кто приносит больше всего денег?)
-- ============================================

-- 4.1 -- 

SELECT
	c.company_name AS "Компания",
	SUM(od.unit_price*od.quantity) AS "Всего покупок"
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id
INNER JOIN order_details od ON o.order_id = od. order_id
GROUP BY c.company_name
ORDER BY "Всего покупок" DESC
LIMIT 5;

