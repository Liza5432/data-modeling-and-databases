--Аудиторная работа(хранимые процедуры)
--1
CREATE PROC PROC1
AS
BEGIN
    SELECT 
        @@Servername AS Сервер, @@Version AS ВерсияСУБД
        ,Db_Name() AS БазаДанных
        ,User AS ПользовательБД
        ,System_User AS СистемныйПользователь
END

EXEC PROC1
Go
--2
USE Ucheb_11_Kravchenko
CREATE PROC PROC2
    @Буква AS CHAR(1),
    @Количество AS INT OUTPUT
AS
BEGIN
    SELECT 
        @Количество = COUNT(*)
    FROM 
        Tabl_Kontinent$
    WHERE 
        CHARINDEX(@Буква, Nazvanie) > 0
END
GO

DECLARE @K AS INT
DECLARE @Б AS CHAR(1)
SET @Б = 'у'
EXECUTE PROC2 @Б, @K OUTPUT
SELECT 
    @K AS [Количество стран]
Go


--3
CREATE PROC PROC3
    @Колnt AS VARCHAR(50) = 'Европа'
AS
BEGIN
    SELECT TOP 3
        Nazvanie
        ,Stolica
        ,PL
        ,KolNas
        ,Kontinent
    FROM 
        Tabl_Kontinent$
    WHERE 
        Kontinent = @Колnt
    ORDER BY 
        PL
END
GO

EXECUTE PROC3 DEFAULT
Go 

--Самостоятельная работа(хранимые процедуры)
--1

CREATE PROC zad1
AS
BEGIN
SELECT  Nazvanie,Stolica,PL,KolNas ,Kontinent
    FROM 
        Tabl_Kontinent$
END 
GO

EXECUTE zad1
GO

--2
CREATE PROC zad2
@num AS INT, @count AS INT OUTPUT
AS
BEGIN
SET @count = LEN(CAST(ABS(@num) AS VARCHAR(20)))
END 
GO

DECLARE @res INT
EXECUTE zad2 @num = 123456, @count = @res OUTPUT
SELECT @res AS [Кол-во цифр]
Go

--3

CREATE PROC zad3
AS
BEGIN 
CREATE TABLE TestTabl (
 Nazvanie VARCHAR(50),
        Stolica VARCHAR(50),
        PL INT,
        KolNas INT,
        Kontinent VARCHAR(50))
INSERT INTO TestTabl (Nazvanie, Stolica, PL, KolNas, Kontinent)
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM Tabl_Kontinent$
WHERE Nazvanie LIKE 'К%'
END
GO

EXECUTE zad3
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent FROM TestTabl
GO

--Аудиторная работа(Определяемые пользователем функции)
--1

Create Function Fun1
(
    @A1 AS FLOAT,
    @B1 AS FLOAT
)
RETURNS TABLE
AS
RETURN (
    SELECT 
        Nazvanie
        ,Stolica
        ,PL
        ,KolNas
        ,Kontinent
    FROM 
        Tabl_Kontinent$
    WHERE 
        PL BETWEEN @A1 AND @B1
)
Go

SELECT *
FROM dbo.Fun1(100, 1000)
Go

--2

CREATE FUNCTION Fun2
(
    @Страна AS VARCHAR(50)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @S AS VARCHAR(50)
    SELECT 
        @S = Stolica
    FROM 
        Tabl_Kontinent$
    WHERE 
        Nazvanie = @Страна
        
    RETURN @S
END
Go

SELECT dbo.Fun2('Австрия')
Go

--3

CREATE FUNCTION Fun3
(
    @Население AS INT,
    @Площадь AS FLOAT
)
RETURNS FLOAT
AS
BEGIN
    DECLARE @P AS FLOAT
    SET @P = ROUND(CAST(@Население AS FLOAT) / @Площадь, 2)
    RETURN @P
END
GO

SELECT Nazvanie,
       Stolica,
       PL,
       KolNas,
       Kontinent,
       dbo.Fun3(KolNas, PL) AS Плотность
FROM 
       Tabl_Kontinent$

    Go


--Самостоятельная работа(Определяемые пользователем функции)
--1

CREATE FUNCTION Fun4 (
@num AS FLOAT
)
RETURNS TABLE
AS 
RETURN(
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
    FROM Tabl_Kontinent$
    WHERE PL < @num)
GO

SELECT * FROM dbo.Fun4(1000)
Go


--2

CREATE FUNCTION Fun5()
RETURNS TABLE
AS
RETURN(
    SELECT Nazvanie, ROUND(CAST(KolNas AS FLOAT) / PL, 2) AS [Плотность]
    FROM Tabl_Kontinent$
)
GO

SELECT * FROM dbo.Fun5()
GO