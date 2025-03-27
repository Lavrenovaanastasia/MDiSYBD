CREATE TABLE [MDiSUBD].[dbo].[Questions] 
(
Questions_ID INT PRIMARY KEY IDENTITY,
Questions VARCHAR(255),
Answer VARCHAR(255),
Questions_Data DATE
)

CREATE TABLE [MDiSUBD].[dbo].[Vacancy] 
(
Vacancy_ID INT PRIMARY KEY IDENTITY,
Vacancy_name VARCHAR(255),
Vacancy_discriprion VARCHAR(255),
Need VARCHAR(255)
)


CREATE TABLE [MDiSUBD].[dbo].[PromoCode] 
(
Promo_ID INT PRIMARY KEY IDENTITY,
Code VARCHAR(20),
Discount INT NULL
)

CREATE TABLE [MDiSUBD].[dbo].[User] 
(
[User_ID] INT PRIMARY KEY IDENTITY,
[User_Name] VARCHAR(255) NOT NULL,
PasswordHash VARCHAR(60)NOT NULL,
[Status] VARCHAR(10),
Email VARCHAR(255) NOT NULL,
FirstName VARCHAR(255),
LastName VARCHAR(255),
Age INT NOT NULL DEFAULT 18,
Phone VARCHAR(20),
Adress VARCHAR(255)
)
CREATE TABLE [MDiSUBD].[dbo].[Review] 
(
Review_ID INT PRIMARY KEY IDENTITY,
[User_ID] INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[User] ([User_ID]) ON DELETE CASCADE,
Title VARCHAR(255),
Rating INT DEFAULT 0,
Need VARCHAR(255),
Reviews_Data DATE
)


CREATE TABLE [MDiSUBD].[dbo].[UserDiscaunts] 
(
ID INT PRIMARY KEY IDENTITY,
[User_ID] INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[User] ([User_ID]) ON DELETE SET NULL NULL,
Promo_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[PromoCode]  (Promo_ID) ON DELETE SET NULL NULL
)



CREATE TABLE [MDiSUBD].[dbo].[Contact] 
(
Contact_ID INT PRIMARY KEY IDENTITY,
[User_ID] INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[User] ([User_ID]) ON DELETE CASCADE,
Discription VARCHAR(255),
Photo VARCHAR(220),
Phone_worker VARCHAR(70)
)

CREATE TABLE [MDiSUBD].[dbo].[Department]
(
Dep_ID INT PRIMARY KEY IDENTITY,
Number VARCHAR(20),
Dep_adress VARCHAR(255),
[Open] VARCHAR(9),
[Close] VARCHAR(9)
)
CREATE TABLE [MDiSUBD].[dbo].[Categories]
(
Category_ID INT PRIMARY KEY IDENTITY,
Category_name VARCHAR(255)
)

CREATE TABLE [MDiSUBD].[dbo].[Cars]
(
Car_ID INT PRIMARY KEY IDENTITY,
Category_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Categories] (Category_ID) ON DELETE SET NULL NULL,
Cars_name VARCHAR(255),
Code VARCHAR(100),
Instraction VARCHAR(255),
[Description] VARCHAR(255),
Photo VARCHAR(220)
)

CREATE TABLE [MDiSUBD].[dbo].[DepartmentCar]
(
Depcar_ID INT PRIMARY KEY IDENTITY,
Dep_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Department] (Dep_ID) ON DELETE SET NULL NULL,
Car_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Cars] (Car_ID) ON DELETE SET NULL NULL,
Quantity INT NULL
)

CREATE TABLE [MDiSUBD].[dbo].[Sales]
(
Sale_ID INT PRIMARY KEY IDENTITY,
Promo_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[PromoCode] (Promo_ID) ON DELETE SET NULL NULL,
[User_ID] INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[User] ([User_ID]) ON DELETE CASCADE,
Dep_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Department] (Dep_ID) ON DELETE SET NULL NULL,
Car_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Cars] (Car_ID) ON DELETE SET NULL NULL,
[Data] DATE,
Quantity INT NULL,
Price FLOAT NOT NULL DEFAULT 0
)

CREATE TABLE [MDiSUBD].[dbo].[Suppiier] 
(
Suppiier_ID INT PRIMARY KEY IDENTITY,
[Name] VARCHAR(120),
Adress VARCHAR(120),
Phone VARCHAR(70)
)

CREATE TABLE [MDiSUBD].[dbo].[Supply]
(
Car_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Cars] (Car_ID) ON DELETE CASCADE,
Suppiier_ID INT FOREIGN KEY REFERENCES [MDiSUBD].[dbo].[Suppiier] (Suppiier_ID) ON DELETE CASCADE,
)

/*Для среднего рейтинга*/
CREATE TABLE [MDiSUBD].[dbo].[ServiceRating] (
    AverageRating FLOAT DEFAULT 0,
    TotalReviews INT DEFAULT 0
)


CREATE TABLE [MDiSUBD].[dbo].[LogTable]
(
    Log_ID INT PRIMARY KEY IDENTITY,
    [Action] NVARCHAR(255),
    [Details] NVARCHAR(MAX),
    [Timestamp] DATETIME
);

CREATE TABLE SalesAnalysis (
    TotalSales FLOAT
);



