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
