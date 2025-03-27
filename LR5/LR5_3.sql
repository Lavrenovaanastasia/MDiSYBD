CREATE TRIGGER trg_AddPromoToUser
ON [MDiSUBD].[dbo].[PromoCode]
AFTER INSERT
AS
BEGIN
    -- Объявляем переменные для логирования
    DECLARE @PromoID INT, @UserID INT, @Timestamp DATETIME;

    -- Получаем данные из вставленных строк
    SELECT @PromoID = Promo_ID FROM Inserted;

    -- Устанавливаем текущую дату и время для логирования
    SET @Timestamp = GETDATE();

    -- Находим активного пользователя
    SELECT TOP 1 @UserID = User_ID
    FROM [MDiSUBD].[dbo].[User]
    WHERE [Status] = 'active';

    -- Если пользователь найден, добавляем запись в UserDiscaunts
    IF @UserID IS NOT NULL
    BEGIN
        INSERT INTO [MDiSUBD].[dbo].[UserDiscaunts] ([User_ID], Promo_ID)
        VALUES (@UserID, @PromoID);
    END;

    -- Записываем информацию о выполнении триггера в таблицу логирования
    INSERT INTO [MDiSUBD].[dbo].[LogTable] ([Action], [Details], [Timestamp])
    VALUES 
    (
        'PromoCode Assigned',
        CONCAT('Promo_ID: ', @PromoID, ', User_ID: ', ISNULL(CAST(@UserID AS NVARCHAR), 'NULL')),
        @Timestamp
    );
END;

SELECT * FROM [MDiSUBD].[dbo].[UserDiscaunts];
SELECT * FROM [MDiSUBD].[dbo].[LogTable];