--уменьшает количество доступных услуг в таблице DepartmentCar при добавлении записи в таблицу Sales
USE MDiSUBD;
GO
CREATE TRIGGER ReduceServiceQuantity
ON [MDiSUBD].[dbo].[Sales]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Уменьшаем количество услуг в DepartmentCar на основе вставленных данных в Sales
    UPDATE [MDiSUBD].[dbo].[DepartmentCar]
    SET Quantity = [MDiSUBD].[dbo].[DepartmentCar].Quantity - inserted.Quantity
    FROM [MDiSUBD].[dbo].[DepartmentCar]
    INNER JOIN inserted
        ON [MDiSUBD].[dbo].[DepartmentCar].Dep_ID = inserted.Dep_ID
        AND [MDiSUBD].[dbo].[DepartmentCar].Car_ID = inserted.Car_ID
    WHERE [MDiSUBD].[dbo].[DepartmentCar].Quantity >= inserted.Quantity;

    -- Проверяем на недопустимые отрицательные значения и сбрасываем на 0
    UPDATE [MDiSUBD].[dbo].[DepartmentCar]
    SET Quantity = 0
    WHERE Quantity < 0;
END;

SELECT * FROM [MDiSUBD].[dbo].[Sales];


SELECT * FROM [MDiSUBD].[dbo].[DepartmentCar];