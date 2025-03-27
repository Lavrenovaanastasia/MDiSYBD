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

-- ������ 1: ������� ���� �������� �� ������� Sales, ��� Car_ID ����� 1.
-- ���������� ��� ������ � ��������, ��������� � ����������� � ID 1.
-- * ��������, ��� ���������� ��� �������.
SELECT *
  FROM [MDiSUBD].[dbo].[Sales] 
  WHERE Car_ID = 1;


-- ������ 2: ������� ������� Cars_name �� ������� Cars.
-- ��������� ������ �������� ����������� �� ������� Cars.
SELECT Cars_name
  FROM [MDiSUBD].[dbo].[Cars];


-- ������ 3: �������� ����� �� ������� Sales, ��� Car_ID ����� 1.
-- ��������� ��� ������ � ��������, ��������� � ����������� � ID 1.
-- ������ ��������� � ���� ��������, ��� ��� �� ���������� ������� ������.  
-- ������������� ������������ ��������� ����������� ����� ����������� ����� ��������.
DELETE FROM [MDiSUBD].[dbo].[Sales] 
  WHERE (Car_ID = 1);


-- ������ 4: ���������� ������� Car_ID � ������� Sales.
-- ��� ������, ��� Car_ID ����� 2, ����� �������� �� Car_ID = 1.
UPDATE [MDiSUBD].[dbo].[Sales] 
  SET Car_ID = 1 
  WHERE (Car_ID = 2);


-- ������ 5: ������� ���� �������� �� ������� Review, ��������������� �� ������� Title � ��������� �������.
-- ��������� ��� ������, ��������������� �� �������� �� Z �� A.
SELECT *
  FROM [MDiSUBD].[dbo].[Review] 
  ORDER BY [Title] DESC;

-- ������ � �������� �������
SELECT *,
REVERSE(Questions) as Questions_name
FROM [MDiSUBD].[dbo].[Questions]

-- ����������� �������
SELECT User_ID, User_Name, [Status]
FROM [MDiSUBD].[dbo].[User]
WHERE [Status] = 'active'

-- DESC ������� ������� � �������� �������
SELECT *
FROM [MDiSUBD].[dbo].[Questions]
ORDER BY [Questions_ID] DESC
-- LIKE ����� � ������� ������
SELECT * 
FROM [MDiSUBD].[dbo].[Questions]
WHERE Questions LIKE '%�����%';

-- BETWEEN �������� (������ � AND)
SELECT * 
FROM [MDiSUBD].[dbo].[Questions] 
WHERE Questions_Data BETWEEN '2024-12-01' AND '2024-12-31';

-- DISTINCT-������� �������
SELECT DISTINCT Questions 
FROM [MDiSUBD].[dbo].[Questions] ;

-- CONCAT - �����������
SELECT CONCAT(FirstName, ' ', LastName) AS [Name] FROM [MDiSUBD].[dbo].[User];

-- AS -��������������
SELECT Questions AS QuestionText 
FROM [MDiSUBD].[dbo].[Questions] ;

-- CASE- �������� ��������� � ���������� ������ �������� � ����������� �� ����������
SELECT CASE
  WHEN Answer = 'Yes' THEN '��'
  WHEN Answer = 'No' THEN '���'
  ELSE '����������'
END AS AnswerText
FROM [MDiSUBD].[dbo].[Questions];

-- ASC - ��������� ���������� � ������� ����������� ���������� �������
SELECT * 
FROM [MDiSUBD].[dbo].[Questions] 
ORDER BY Questions_Data ASC;

-- IN - ����������� �� �������� ���������� ������� ������ ��������
SELECT * 
FROM [MDiSUBD].[dbo].[Questions] 
WHERE Questions IN ('Everything okay?', 'How fast can I get the service?');

-- TOP - ���������� �����
SELECT TOP 3 * FROM [MDiSUBD].[dbo].[Questions];


-- OFFSET- ���������� ������
SELECT * FROM [MDiSUBD].[dbo].[Questions] 
ORDER BY Questions_Id 
    OFFSET 2 ROWS
    FETCH NEXT 3 ROWS ONLY;



