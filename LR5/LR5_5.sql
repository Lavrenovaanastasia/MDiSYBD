CREATE TRIGGER trg_AutoUpdateServiceQuantity
ON [MDiSUBD].[dbo].[Supply]
AFTER INSERT
AS
BEGIN
    -- Обновляем количество деталей в таблице DepartmentCar
    UPDATE [MDiSUBD].[dbo].[DepartmentCar]
    SET Quantity = ISNULL(Quantity, 0) + 1
    FROM [MDiSUBD].[dbo].[DepartmentCar] AS DC
    INNER JOIN Inserted AS I
        ON DC.Car_ID = I.Car_ID;

    -- Логируем событие
    INSERT INTO [MDiSUBD].[dbo].[LogTable] ([Action], [Details], [Timestamp])
    SELECT 
        'Service Quantity Updated',
        CONCAT('Car_ID: ', Car_ID, ', Suppiier_ID: ', Suppiier_ID, ' - Quantity incremented'),
        GETDATE()
    FROM Inserted;
END;
SELECT * FROM [MDiSUBD].[dbo].[DepartmentCar];
SELECT * FROM [MDiSUBD].[dbo].[LogTable];