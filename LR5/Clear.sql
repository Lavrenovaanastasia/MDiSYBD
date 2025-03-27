-- Очистка данных
DELETE FROM [MDiSUBD].[dbo].[Review];

SELECT * FROM [MDiSUBD].[dbo].[Review];


DELETE FROM [MDiSUBD].[dbo].[Review]
WHERE Review_ID = 2;

DELETE FROM [MDiSUBD].[dbo].[Sales];
SELECT * FROM [MDiSUBD].[dbo].[Sales];


-- Обновление для закрытия вакансии
UPDATE [MDiSUBD].[dbo].[Vacancy]
SET Need = NULL
WHERE Vacancy_ID = 1;


INSERT INTO [MDiSUBD].[dbo].[Supply]
VALUES (1, 1), (2, 2), (1, 2);

