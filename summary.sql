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

