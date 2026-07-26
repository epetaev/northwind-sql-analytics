-- ============================================
--Округление ROUND
-- ===========================================
SELECT
    title,
    author,
    amount,
    ROUND(price *(1- 0.3),2) AS "new_price"
FROM book;

-- ============================================
--Оператор CASE WHEN и округление ROUND
-- ============================================
SELECT
    author,
    title,
    CASE
        WHEN author ='Булгаков М.А.' THEN ROUND((price*1.1),2)
        WHEN author = 'Есенин С.А.' THEN ROUND ((price*1.05),2)
        ELSE ROUND(price,2)
    END AS new_price
FROM book;

-- ============================================
--Оператор WHERE
-- ============================================
SELECT
    author,
    title,
    price,
FROM book
WHERE amount<10;

-- ============================================
--Операторы WHERE, OR, AND
-- ============================================
SELECT
    title,
    author,
    price,
    amount
FROM book
WHERE (price<500 OR price>600) AND price*amount>=5000; -- AND имеет большмий приоритет по сравнению с OR, поэтому при необходимости заключаем в-е в скобки


-- ============================================
--Операторы BETWEEN, IN
-- ============================================
SELECT
    title,
    author
FROM book
WHERE price BETWEEN 540.50 AND 800 AND amount = 2 OR amount = 3 OR amount = 5 OR amount = 7;

-- ============================================
--Оператор ORDER BY
-- ============================================
SELECT
    author,
    title
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC,title;

-- ============================================
--Оператор WHERE (подзапрос используется два SELECT)
-- ============================================
SELECT author,title,price
FROM book
WHERE price <=(
    SELECT AVG (price)
    FROM book)
    ORDER BY price DESC;

-- ============================================
--Оператор WHERE и HAVING разница на примере 
-- ============================================
-- Создаём тестовую таблицу
CREATE TABLE orders (
    order_id INT,
    seller_id INT,
    status TEXT,
    gmv NUMERIC
);

-- Наполняем данными
INSERT INTO orders VALUES
(1, 100, 'Completed', 500),
(2, 100, 'Completed', 300),
(3, 100, 'Cancelled', 200),
(4, 200, 'Completed', 100),
(5, 200, 'Completed', 150),
(6, 300, 'Completed', 1000),
(7, 300, 'Completed', 1000),
(8, 300, 'Completed', 1000);
-- Приимер с WHERE
SELECT seller_id, COUNT(*) AS orders_count, SUM(gmv) AS total_gmv
FROM orders
WHERE status = 'Completed'
GROUP BY seller_id;
--Результат: продавец 100 попадёт в выборку с 2 заказами (отменённый заказ #3 просто не учитывается).

--Пример с HAVING — сначала группируем ВСЕ строки, а потом фильтруем уже готовые группы:
SELECT seller_id, COUNT(*) AS orders_count, SUM(gmv) AS total_gmv
FROM orders
GROUP BY seller_id
HAVING COUNT(*) >= 3;
--Результат: останется только продавец 300 (у него 3 заказа), продавцы 100 и 200 отсеются — потому что HAVING проверяет количество заказов уже после группировки.

-- UNION & UNION ALL - same number of columns in both queries
SELECT country
FROM customers
UNION
SELECT country
FROM employees
