--Для подсёта среднего рейтинга по отзывам
-- (1, 'Great service', 5, 'Oil Change', '2024-12-18'),
USE MDiSUBD;
GO

CREATE TRIGGER UpdateServiceRating
ON [MDiSUBD].[dbo].[Review]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    -- Подсчитать общее количество отзывов
    UPDATE [MDiSUBD].[dbo].[ServiceRating]
    SET TotalReviews = (
        SELECT COUNT(*)
        FROM [MDiSUBD].[dbo].[Review]
    );

    -- Рассчитать средний рейтинг
    UPDATE [MDiSUBD].[dbo].[ServiceRating]
    SET AverageRating = (
        SELECT AVG(Rating)
        FROM [MDiSUBD].[dbo].[Review]
    );
END


SELECT * FROM [MDiSUBD].[dbo].[ServiceRating] ;
SELECT * FROM [MDiSUBD].[dbo].[Review] ;



