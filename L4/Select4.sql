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


--                                                          �������1
-- 1 ������: ��������� ���������� � �����������, ��������� � �����������, ��� ��� ������ �������� '1'.
SELECT [Name], Adress, Phone, Category_Name, Cars_name, Code, Instraction, [Description], Photo
  
-- �� ������� Suppiier (����������)
FROM [MDiSUBD].[dbo].[Suppiier] 

-- ���������� ���������� � �������� Supply (��������) �� ���� Suppiier_ID
INNER JOIN [MDiSUBD].[dbo].[Supply] ON ([Suppiier].Suppiier_ID = [Supply].Suppiier_ID)

-- ������ ���������� � �������� Cars (����������) �� ���� Car_ID
                                  RIGHT JOIN [MDiSUBD].[dbo].[Cars] ON ([Cars].Car_ID = [Supply].Car_ID)

-- ������ ���������� � �������� Categories (���������) �� ���� Category_ID
                  RIGHT JOIN [MDiSUBD].[dbo].[Categories] ON ([Categories].Category_ID = [Cars].Category_ID) 

-- ��������� ����������, ��� ���� Code �������� '1' 
WHERE Code LIKE '%1%' 

-- ��������� ���������� �� ���� Adress � ��������� �������
ORDER BY Adress DESC;



-- 2 ������: ��������� ���������� �� ������� � �������������.
SELECT Title, Rating, Need, Reviews_Data, [User_Name], (FirstName + ' ' + LastName) AS [Name]
  
-- �� ������� Review (������)
FROM [MDiSUBD].[dbo].[Review] 

-- ����� ���������� � �������� User (������������) �� ���� User_ID
Left JOIN [MDiSUBD].[dbo].[User] ON ([Review].[User_ID] = [User].[User_ID]);



-- 3 ������:  ��������� ���������� ������� ��� ������� ������������, ��� ���������� ������� ������ 1.
-- ��������� ������:  ������� ���������� ������� ��� ������� ������������
--  �������� User_ID � ������� ���������� ������� (COUNT(FirstName)) ��� Rew_Count, ��������� �� User_ID

SELECT [User_ID], [Rew_Count]
  FROM
	(SELECT [Review].[User_ID], COUNT(FirstName) AS [Rew_Count]
		 FROM [MDiSUBD].[dbo].[Review] Left JOIN [MDiSUBD].[dbo].[User] ON ([Review].[User_ID] = [User].[User_ID]) 
		 GROUP BY [Review].[User_ID])
				AS [File] WHERE [Rew_Count] > 1;

-- ������� ������: ��������� ���������� ���������� �������, �������� ������ ������������� � ����������� ������� > 1.
--  ��������� ���������� �������  ��������� ��� [File]


--                                                                         �������2 
--������� � JOIN ���������� ����
-- ������ 1: INNER JOIN -  ��������� ���������� � ������������� � �� �������
-- ������������ INNER JOIN ��� ��������� ������ ��� �������������, ������� �������� ������.
SELECT u.User_ID, u.User_Name, r.Title AS ReviewTitle, r.Rating
FROM [User] AS u
INNER JOIN Review AS r ON u.User_ID = r.User_ID;

-- ������ 2: FULL OUTER JOIN - ��������� ���������� � ���� ������������� � ���� ������� � ������������ ������
-- ������������ FULL OUTER JOIN ��� ��������� ���� ������������� � ���� �������, ���������� �� ����, ���� �� ����� ����� ����.
--  � SQL Server FULL OUTER JOIN  ����������� � ������� UNION ALL �� LEFT � RIGHT JOIN.
SELECT u.User_ID, u.User_Name, r.Title AS ReviewTitle, r.Rating
FROM[User] AS u
LEFT OUTER JOIN Review AS r ON u.User_ID = r.User_ID
UNION ALL
SELECT u.User_ID, u.User_Name, r.Title AS ReviewTitle, r.Rating
FROM [User] AS u
RIGHT OUTER JOIN Review AS r ON u.User_ID = r.User_ID
WHERE u.User_ID IS NULL; --������� ���������


-- ������ 3: CROSS JOIN - ��������� ���� ��������� ���������� ������������� � ����������
-- ������������ CROSS JOIN ��� ��������� ���� ��������� ���������� ������������� � ����������.  
SELECT u.User_ID, u.User_Name, p.Code AS PromoCode
FROM [User] AS u
CROSS JOIN PromoCode AS p;


--                                                                                �������3
-- ������� � GROUP BY 
--������������� ������ �� �������� � ��������� ���������� ������� ��� ������� ��������.
SELECT Rating, COUNT(Review_ID) AS Review_Count
FROM [MDiSUBD].[dbo].[Review]
GROUP BY Rating;

-- ������ 2: HAVING, GROUP BY + ���������� ������� -  ������� ������� ������� � ���������� ������� ��� ������� ������������
SELECT u.[User_ID], u.[User_Name], AVG(r.Rating) AS AverageRating, COUNT(*) AS ReviewCount
FROM [User] AS u
LEFT JOIN Review AS r ON u.[User_ID] = r.[User_ID]
GROUP BY u.[User_ID], u.[User_Name]
HAVING COUNT(*) > 1; -- ��������� ����������, �������� ������ ������������� � ����� ��� ����� �������

-- ������ 3: UNION - ����������� ����������� ��������  (������: ����������� ������������� � ������� ���������)
SELECT User_ID, User_Name, [Status]
FROM [User]
WHERE [Status] = 'active'
UNION
SELECT User_ID, User_Name, [Status]
FROM [User]
WHERE [Status] = 'inactive';

--                                                                                 �������4
-- ������ 1: EXISTS -  �������� ������� ������� � ������������
SELECT u.User_Name
FROM [User] AS u
WHERE EXISTS ( SELECT 1
        FROM Review AS r
        WHERE r.[User_ID] = u.[User_ID]
    );

-- ������ 2: CASE -  ���������� ����� ������� � �������������� �������� �������������
SELECT
    *,
    CASE
        WHEN Age < 25 THEN '�������'
        WHEN Age BETWEEN 25 AND 50 THEN '������� �������'
        ELSE '�������'
    END AS AgeCategory
FROM
    [User];


--������ 3:  ������ ������������� EXISTS ��� �������� �������  ������������  � ��������� ��������
-- ��������, ���� �� ������ � �������������, ������� �� �����  ����������
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