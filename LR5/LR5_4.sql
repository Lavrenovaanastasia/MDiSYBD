USE MDiSUBD;
GO
CREATE TRIGGER trg_VacancyClosed
ON [MDiSUBD].[dbo].[Vacancy]
AFTER UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Inserted WHERE Need IS NULL OR Need = '')
    BEGIN
        INSERT INTO [MDiSUBD].[dbo].[LogTable] ([Action], [Details], [Timestamp])
        SELECT 
            'Vacancy Closed',
            CONCAT('Vacancy_ID: ', Vacancy_ID, ', Name: ', Vacancy_name),
            GETDATE()
        FROM Inserted WHERE Need IS NULL OR Need = '';
    END;
END;


SELECT * FROM [MDiSUBD].[dbo].[LogTable];