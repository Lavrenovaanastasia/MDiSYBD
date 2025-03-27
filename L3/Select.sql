SELECT *
  FROM [MDiSUBD].[dbo].[Questions]

SELECT *
  FROM [MDiSUBD].[dbo].[Vacancy]

SELECT *
  FROM [MDiSUBD].[dbo].[Suppiier]

SELECT *
  FROM [MDiSUBD].[dbo].[Sales]

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

-- Запрос 1: Выборка всех столбцов из таблицы Sales, где Car_ID равен 1.
-- Выбираются все данные о продажах, связанных с автомобилем с ID 1.
-- * означает, что выбираются все столбцы.
SELECT *
  FROM [MDiSUBD].[dbo].[Sales] 
  WHERE Car_ID = 1;


-- Запрос 2: Выборка столбца Cars_name из таблицы Cars.
-- Выводятся только названия автомобилей из таблицы Cars.
SELECT Cars_name
  FROM [MDiSUBD].[dbo].[Cars];


-- Запрос 3: Удаление строк из таблицы Sales, где Car_ID равен 1.
-- Удаляются все записи о продажах, связанные с автомобилем с ID 1.
-- Будьте осторожны с этим запросом, так как он необратимо удаляет данные.  
-- Рекомендуется использовать резервное копирование перед выполнением таких запросов.
DELETE FROM [MDiSUBD].[dbo].[Sales] 
  WHERE (Car_ID = 1);


-- Запрос 4: Обновление столбца Car_ID в таблице Sales.
-- Все записи, где Car_ID равен 2, будут изменены на Car_ID = 1.
UPDATE [MDiSUBD].[dbo].[Sales] 
  SET Car_ID = 1 
  WHERE (Car_ID = 2);


-- Запрос 5: Выборка всех столбцов из таблицы Review, отсортированных по столбцу Title в убывающем порядке.
-- Выводятся все отзывы, отсортированные по названию от Z до A.
SELECT *
  FROM [MDiSUBD].[dbo].[Review] 
  ORDER BY [Title] DESC;

-- Строка в обратном порядке
SELECT *,
REVERSE(Questions) as Questions_name
FROM [MDiSUBD].[dbo].[Questions]

-- Определённый элемент
SELECT User_ID, User_Name, [Status]
FROM [MDiSUBD].[dbo].[User]
WHERE [Status] = 'active'

-- DESC Вывести таблицу в обратном порядке
SELECT *
FROM [MDiSUBD].[dbo].[Questions]
ORDER BY [Questions_ID] DESC
-- LIKE поиск в строках общего
SELECT * 
FROM [MDiSUBD].[dbo].[Questions]
WHERE Questions LIKE '%услуг%';

-- BETWEEN диапазон (вместе с AND)
SELECT * 
FROM [MDiSUBD].[dbo].[Questions] 
WHERE Questions_Data BETWEEN '2024-12-01' AND '2024-12-31';

-- DISTINCT-удаляет повторы
SELECT DISTINCT Questions 
FROM [MDiSUBD].[dbo].[Questions] ;

-- CONCAT - объединение
SELECT CONCAT(FirstName, ' ', LastName) AS [Name] FROM [MDiSUBD].[dbo].[User];

-- AS -переименование
SELECT Questions AS QuestionText 
FROM [MDiSUBD].[dbo].[Questions] ;

-- CASE- условное выражение и возвращать разное значение в зависимости от результата
SELECT CASE
  WHEN Answer = 'Yes' THEN 'Да'
  WHEN Answer = 'No' THEN 'Нет'
  ELSE 'Неизвестно'
END AS AnswerText
FROM [MDiSUBD].[dbo].[Questions];

-- ASC - сортирует результаты в порядке возрастания указанного столбца
SELECT * 
FROM [MDiSUBD].[dbo].[Questions] 
ORDER BY Questions_Data ASC;

-- IN - принадлежит ли значение указанного столбца списку значений
SELECT * 
FROM [MDiSUBD].[dbo].[Questions] 
WHERE Questions IN ('Everything okay?', 'How fast can I get the service?');

-- TOP - количество строк
SELECT TOP 3 * FROM [MDiSUBD].[dbo].[Questions];


-- OFFSET- пропустить строки
SELECT * FROM [MDiSUBD].[dbo].[Questions] 
ORDER BY Questions_Id 
    OFFSET 2 ROWS
    FETCH NEXT 3 ROWS ONLY;



