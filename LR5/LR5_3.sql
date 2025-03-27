CREATE TRIGGER trg_AddPromoToUser
ON [MDiSUBD].[dbo].[PromoCode]
AFTER INSERT
AS
BEGIN
    -- ��������� ���������� ��� �����������
    DECLARE @PromoID INT, @UserID INT, @Timestamp DATETIME;

    -- �������� ������ �� ����������� �����
    SELECT @PromoID = Promo_ID FROM Inserted;

    -- ������������� ������� ���� � ����� ��� �����������
    SET @Timestamp = GETDATE();

    -- ������� ��������� ������������
    SELECT TOP 1 @UserID = User_ID
    FROM [MDiSUBD].[dbo].[User]
    WHERE [Status] = 'active';

    -- ���� ������������ ������, ��������� ������ � UserDiscaunts
    IF @UserID IS NOT NULL
    BEGIN
        INSERT INTO [MDiSUBD].[dbo].[UserDiscaunts] ([User_ID], Promo_ID)
        VALUES (@UserID, @PromoID);
    END;

    -- ���������� ���������� � ���������� �������� � ������� �����������
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