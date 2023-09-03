-- Создание таблицы Staff
CREATE TABLE Staff (
staff_id INTEGER NOT NULL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
salary DECIMAL(10, 2) NOT NULL,
email VARCHAR(255),
birthday DATE,
jobtitle_id INT
);

-- Заполнение таблицы данными
INSERT INTO Staff (staff_id, name, salary, email, birthday, jobtitle_id) VALUES
(1, 'Иванов Сергей', 100000, 'test@test.ru', '03.03.1990', 1),
(2, 'Петров Пётр', 60000, 'petr@test.ru', '01.12.2000', 7),
(3, 'Сидоров Василий', 80000, 'test@test.ru', '04.02.1999', 6),
(4, 'Максимов Иван', 70000, 'ivan.m@test.ru', '02.10.1997', 4),
(5, 'Попов Иван', 120000, 'popov@test.ru', '25.04.2001', 5);

-- Создание таблицы Jobtitles
CREATE TABLE Jobtitles (
jobtitle_id NUMBER(10,0) NOT NULL PRIMARY KEY,
name VARCHAR(255) NOT NULL
);

-- Заполнение таблицы данными
INSERT INTO Jobtitles (jobtitle_id, name) VALUES
(1, 'Разработчик'),
(2, 'Системный аналитик'),
(3, 'Менеджер проектов'),
(4, 'Системный администратор'),
(5, 'Руководитель группы'),
(6, 'Инженер тестирования'),
(7, 'Сотрудник группы поддержки');

-- Напишите запрос, с помощью которого можно найти дубли в поле email из таблицы Sfaff.
--1
SELECT * FROM (SELECT s.email, COUNT(s.email) AS count_ FROM Staff s GROUP BY s.email) WHERE count_ > 1
  
--2
SELECT s.email, COUNT(s.email) AS count_
FROM Staff s
GROUP BY s.email
HAVING COUNT(s.email) > 1;

-- Напишите запрос, с помощью которого можно определить возраст каждого сотрудника из таблицы Staff на момент запроса.
-- Функции Oracle DB. MONTHS_BETWEEN возвращает количество месяцев между датами не целым числом, TRUNC в данном случае уберёт значения после запятой, без округления.
SELECT name, TRUNC(MONTHS_BETWEEN(SYSDATE, TO_DATE(birthday)) / 12)
FROM STAFF; 

--Напишите запрос, с помощью которого можно определить должность (Jobtitles.name) со вторым по величине уровнем зарплаты
--1
SELECT j.name, s.salary FROM Staff s join Jobtitles j on s.jobtitle_id = j.jobtitle_id
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

--2
SELECT name FROM Jobtitles j WHERE j.jobtitle_id IN (SELECT s.jobtitle_id FROM Staff s ORDER BY salary DESC LIMIT 1 OFFSET 1);