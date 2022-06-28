-- 1.	Показать всю информацию об авторах.
SELECT * FROM `authors`;

-- 2.	Показать всю информацию о жанрах.
SELECT * FROM `genres`;

-- 9.	Показать список авторов в обратном алфавитном порядке (т.е. «Я -> А»).
SELECT `a_name` 
FROM `authors` 
ORDER BY `a_name` DESC;

-- 14.	Показать идентификатор «читателя-рекордсмена», взявшего в библиотеке больше книг, чем любой другой читатель.
SELECT `sb_subscriber`
FROM `subscriptions`
GROUP BY `sb_subscriber` 
HAVING COUNT(`sb_book`) = (SELECT MAX(`books`) FROM (SELECT COUNT(`sb_book`) AS `books`, `sb_subscriber` FROM `subscriptions` GROUP BY `sb_subscriber`) AS `max`);

-- 15.	Показать, сколько в среднем экземпляров книг есть в библиотеке.
SELECT AVG(`b_quantity`) AS `avg_quantity` 
FROM `books`;