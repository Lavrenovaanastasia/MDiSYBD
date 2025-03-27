SELECT *
  FROM [MDiSUBD].[dbo].[Questions]

SELECT *
  FROM [MDiSUBD].[dbo].[Vacancy]

SELECT *
  FROM [MDiSUBD].[dbo].[Suppiier]

SELECT *
  FROM [MDiSUBD].[dbo].[DepartmentCar]

SELECT *
  FROM [MDiSUBD].[dbo].[Cars]

SELECT *
  FROM [MDiSUBD].[dbo].[Categories] 

SELECT *
  FROM [MDiSUBD].[dbo].[Department]

SELECT *
  FROM [MDiSUBD].[dbo].[Contact]

SELECT *
  FROM [MDiSUBD].[dbo].[Review]

SELECT *
  FROM [MDiSUBD].[dbo].[UserDiscaunts]

SELECT *
  FROM [MDiSUBD].[dbo].[User]

SELECT *
  FROM [MDiSUBD].[dbo].[PromoCode]

SELECT *
  FROM [MDiSUBD].[dbo].[Supply]

SELECT *
  FROM [MDiSUBD].[dbo].[Suppiier]


--                                                          Задание1
-- 1 запрос: Получение информации о поставщиках, запчастях и автомобилях, где код детали содержит '1'.
SELECT [Name], Adress, Phone, Category_Name, Cars_name, Code, Instraction, [Description], Photo
  
-- Из таблицы Suppiier (поставщики)
FROM [MDiSUBD].[dbo].[Suppiier] 

-- Внутреннее соединение с таблицей Supply (поставки) по полю Suppiier_ID
INNER JOIN [MDiSUBD].[dbo].[Supply] ON ([Suppiier].Suppiier_ID = [Supply].Suppiier_ID)

-- Правое соединение с таблицей Cars (автомобили) по полю Car_ID
                                  RIGHT JOIN [MDiSUBD].[dbo].[Cars] ON ([Cars].Car_ID = [Supply].Car_ID)

-- Правое соединение с таблицей Categories (категории) по полю Category_ID
                  RIGHT JOIN [MDiSUBD].[dbo].[Categories] ON ([Categories].Category_ID = [Cars].Category_ID) 

-- Фильтруем результаты, где поле Code содержит '1' 
WHERE Code LIKE '%1%' 

-- Сортируем результаты по полю Adress в убывающем порядке
ORDER BY Adress DESC;



-- 2 запрос: Получение информации об отзывах и пользователях.
SELECT Title, Rating, Need, Reviews_Data, [User_Name], (FirstName + ' ' + LastName) AS [Name]
  
-- Из таблицы Review (отзывы)
FROM [MDiSUBD].[dbo].[Review] 

-- Левое соединение с таблицей User (пользователи) по полю User_ID
Left JOIN [MDiSUBD].[dbo].[User] ON ([Review].[User_ID] = [User].[User_ID]);



-- 3 запрос:  Получение количества отзывов для каждого пользователя, где количество отзывов больше 1.
-- Вложенный запрос:  Считаем количество отзывов для каждого пользователя
--  Выбираем User_ID и считаем количество записей (COUNT(FirstName)) как Rew_Count, группируя по User_ID

SELECT [User_ID], [Rew_Count]
  FROM
	(SELECT [Review].[User_ID], COUNT(FirstName) AS [Rew_Count]
		 FROM [MDiSUBD].[dbo].[Review] Left JOIN [MDiSUBD].[dbo].[User] ON ([Review].[User_ID] = [User].[User_ID]) 
		 GROUP BY [Review].[User_ID])
				AS [File] WHERE [Rew_Count] > 1;

-- Внешний запрос: Фильтруем результаты вложенного запроса, оставляя только пользователей с количеством отзывов > 1.
--  Результат вложенного запроса  алиасится как [File]


--                                                                         Задание2 
--Запросы с JOIN различного типа
-- Запрос 1: INNER JOIN -  получение информации о пользователях и их отзывах
-- Используется INNER JOIN для получения только тех пользователей, которые оставили отзывы.
SELECT u.User_ID, u.User_Name, r.Title AS ReviewTitle, r.Rating
FROM [User] AS u
INNER JOIN Review AS r ON u.User_ID = r.User_ID;

-- Запрос 2: FULL OUTER JOIN - получение информации о всех пользователях и всех отзывах с объединением данных
-- Используется FULL OUTER JOIN для получения всех пользователей и всех отзывов, независимо от того, есть ли связь между ними.
--  В SQL Server FULL OUTER JOIN  эмулируется с помощью UNION ALL из LEFT и RIGHT JOIN.
SELECT u.User_ID, u.User_Name, r.Title AS ReviewTitle, r.Rating
FROM[User] AS u
LEFT OUTER JOIN Review AS r ON u.User_ID = r.User_ID
UNION ALL
SELECT u.User_ID, u.User_Name, r.Title AS ReviewTitle, r.Rating
FROM [User] AS u
RIGHT OUTER JOIN Review AS r ON u.User_ID = r.User_ID
WHERE u.User_ID IS NULL; --убираем дубликаты


-- Запрос 3: CROSS JOIN - получение всех возможных комбинаций пользователей и промокодов
-- Используется CROSS JOIN для получения всех возможных комбинаций пользователей и промокодов.  
SELECT u.User_ID, u.User_Name, p.Code AS PromoCode
FROM [User] AS u
CROSS JOIN PromoCode AS p;


--                                                                                Задание3
-- Запросы с GROUP BY 
--Сгруппировать отзывы по рейтингу и посчитать количество отзывов для каждого рейтинга.
SELECT Rating, COUNT(Review_ID) AS Review_Count
FROM [MDiSUBD].[dbo].[Review]
GROUP BY Rating;

-- Запрос 2: HAVING, GROUP BY + агрегатные функции -  средний рейтинг отзывов и количество отзывов для каждого пользователя
SELECT u.[User_ID], u.[User_Name], AVG(r.Rating) AS AverageRating, COUNT(*) AS ReviewCount
FROM [User] AS u
LEFT JOIN Review AS r ON u.[User_ID] = r.[User_ID]
GROUP BY u.[User_ID], u.[User_Name]
HAVING COUNT(*) > 1; -- Фильтруем результаты, оставляя только пользователей с более чем одним отзывом

-- Запрос 3: UNION - объединение результатов запросов  (пример: объединение пользователей с разными статусами)
SELECT User_ID, User_Name, [Status]
FROM [User]
WHERE [Status] = 'active'
UNION
SELECT User_ID, User_Name, [Status]
FROM [User]
WHERE [Status] = 'inactive';

--                                                                                 Задание4
-- Запрос 1: EXISTS -  проверка наличия отзывов у пользователя
SELECT u.User_Name
FROM [User] AS u
WHERE EXISTS ( SELECT 1
        FROM Review AS r
        WHERE r.[User_ID] = u.[User_ID]
    );

-- Запрос 2: CASE -  добавление новой колонки с категоризацией возраста пользователей
SELECT
    *,
    CASE
        WHEN Age < 25 THEN 'Молодой'
        WHEN Age BETWEEN 25 AND 50 THEN 'Средний возраст'
        ELSE 'Пожилой'
    END AS AgeCategory
FROM
    [User];


--Запрос 3:  Пример использования EXISTS для проверки наличия  соответствия  в связанных таблицах
-- Проверим, есть ли заказы у пользователей, которые не имеют  промокодов
SELECT * FROM [User] u
WHERE NOT EXISTS (SELECT 1 FROM UserDiscaunts ud WHERE u.User_ID = ud.User_ID) ;


SELECT User_ID
FROM [User] AS u
WHERE EXISTS ( SELECT 1
        FROM Review AS r
        WHERE r.[User_ID] = u.[User_ID]
    );


	SELECT u.User_Name, c.Category_name, COUNT(s.Car_ID) AS Cars_Bought
  FROM [MDiSUBD].[dbo].[User] u INNER JOIN [MDiSUBD].[dbo].[Review] r ON u.User_ID = r.User_ID
                              INNER JOIN [MDiSUBD].[dbo].[Sales] s ON u.User_ID = s.User_ID
                              INNER JOIN [MDiSUBD].[dbo].[Cars] car ON s.Car_ID = car.Car_ID
                              INNER JOIN [MDiSUBD].[dbo].[Categories] c ON car.Category_ID = c.Category_ID
  WHERE (SELECT COUNT(*) FROM [MDiSUBD].[dbo].[Review] WHERE User_ID = u.User_ID) = 1
  GROUP BY u.User_Name, c.Category_name;


  SELECT *
  FROM [MDiSUBD].[dbo].[Review]

SELECT *
  FROM [MDiSUBD].[dbo].[User]

  SELECT *
  FROM [MDiSUBD].[dbo].[Sales]

SELECT u.[User_Name], c.Category_name, 
COUNT(s.Car_ID) AS Cars_Bought
  FROM [MDiSUBD].[dbo].[User] u INNER JOIN [MDiSUBD].[dbo].[Review] r ON u.[User_ID] = r.[User_ID]
                              INNER JOIN [MDiSUBD].[dbo].[Sales] s ON u.[User_ID] = s.[User_ID]
                              INNER JOIN [MDiSUBD].[dbo].[Cars] car ON s.Car_ID = car.Car_ID
                              INNER JOIN [MDiSUBD].[dbo].[Categories] c ON car.Category_ID = c.Category_ID
  WHERE (SELECT COUNT(*) 
  FROM [MDiSUBD].[dbo].[Review] 
  WHERE [User_ID] = u.[User_ID]) = 1
  GROUP BY u.[User_Name], 
  c.Category_name;