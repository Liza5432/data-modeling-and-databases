--1
USE Ucheb_11_Kravchenko
GO

CREATE VIEW PR1 AS
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas < 5000000 AND PL > 100000;
GO

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM PR1;
GO

--2
CREATE VIEW PR2
(
    Kontinent,
    PL,
    KolNas
)
AS
SELECT Kontinent, SUM(PL), SUM(KolNas)
FROM Tabl_Kontinent$
GROUP BY Kontinent;
GO

SELECT Kontinent, PL, KolNas
FROM PR2;
GO

--3

USE vuz;
GO


CREATE VIEW PR3
(
    Фамилия,
    Должность,
    Звание,
    Степень,
    Кафедра,
    Зарплата
)
AS
SELECT
    FIO,
    Dolgn,
    Zvanie,
    Stepen,
    Nkaf,
    Zarplata
FROM Sotrudnik C
INNER JOIN Prepodavatel P ON C.Tabnom = P.Tabnom_Pr
INNER JOIN Kafedra K ON C.ShifrKaf_Sotr = K.ShifrKaf;
GO

SELECT
    Фамилия,
    Должность,
    Звание,
    Степень,
    Кафедра,
    Зарплата
FROM PR3;
GO

--4
DECLARE @PR4 TABLE
(
    [Номер недели] INT,
    [Дата начала] DATE,
    [Дата конца] DATE
);
DECLARE @T AS DATE, @N INT = 1;
SET @T = CAST(YEAR(GETDATE()) AS CHAR(4)) + '0101';
WHILE DATEPART(WEEKDAY, @T) > 1
    SET @T = DATEADD(DAY, -1, @T);
WHILE YEAR(@T) < YEAR(DATEADD(YEAR, 1, GETDATE()))
BEGIN
    INSERT INTO @PR4
    VALUES (@N, @T, DATEADD(DAY, 6, @T));
    SET @T = DATEADD(DAY, 7, @T);
    SET @N = @N + 1;
END;
SELECT
    [Номер недели],
    [Дата начала],
    [Дата конца]
FROM @PR4;
GO

--5

USE Ucheb_11_Kravchenko
GO

DECLARE @PR5 TABLE
(
    Название VARCHAR(50),
    Столица VARCHAR(50),
    Площадь FLOAT,
    Население BIGINT,
    Континент VARCHAR(50)
);
INSERT INTO @PR5
SELECT
    Nazvanie,
    Stolica,
    PL,
    KolNas,
    Kontinent
FROM Tabl_Kontinent$
WHERE PL * 1000 < (SELECT AVG(PL) FROM Tabl_Kontinent$);
SELECT
    Название,
    Столица,
    Площадь,
    Население,
    Континент
FROM @PR5;
GO


--6
USE vuz;
GO

SELECT
    DATENAME(MONTH, data) AS [Название месяца],
    COUNT(DISTINCT Kod) AS [Количество экзаменов],
    COUNT(DISTINCT RegNom) AS [Количество студентов]
INTO #PR6
FROM Ozenka
GROUP BY DATENAME(MONTH, data);
SELECT * FROM #PR6;
GO

--7
USE Ucheb_11_Kravchenko
GO

CREATE TABLE ##PR7
(
    Название VARCHAR(50),
    Плотность FLOAT
);
INSERT INTO ##PR7
(
    Название,
    Плотность
)
SELECT
    Nazvanie,
    ROUND(KolNas / PL, 0) AS Плотность
FROM Tabl_Kontinent$;
SELECT * FROM ##PR7;
GO

--8
USE vuz;
GO

WITH C3K AS
(
    SELECT
        K.Nkaf AS Кафедра,
        K.ShifrKaf,
        AVG(C.Zarplata) AS [Средняя зарплата по кафедре]
    FROM Sotrudnik C
    INNER JOIN Kafedra K ON C.ShifrKaf_Sotr = K.ShifrKaf
    GROUP BY K.Nkaf, K.ShifrKaf
)
SELECT
    C.FIO,
    C.Zarplata,
    C3K.Кафедра,
    C3K.[Средняя зарплата по кафедре]
FROM Sotrudnik C
INNER JOIN C3K ON C.ShifrKaf_Sotr = C3K.ShifrKaf
WHERE C.Zarplata < C3K.[Средняя зарплата по кафедре];
GO


--Самостоятельная работа
--1
USE Ucheb_11_Kravchenko
GO

CREATE VIEW zad1 AS
SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка' AND KolNas > 10000000 AND PL > 500000;
GO

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM zad1;
GO

--2
CREATE VIEW zad2
(
    Kontinent, PL,KolNas
)
AS
SELECT Kontinent, AVG(PL) AS SredPL, AVG(CAST(KolNas AS FLOAT) / PL) AS SredPlotn
FROM Tabl_Kontinent$
GROUP BY Kontinent;
GO

SELECT Kontinent, PL, KolNas
FROM zad2;
GO


--3

USE vuz;
GO

CREATE VIEW zad3
(
    Фамилия,
    Должность,
    Звание,
    Степень,
    Кафедра,
    Количество_экзаменов
)
AS
SELECT C.FIO, C.Dolgn, P.Zvanie, P.Stepen, K.Nkaf, COUNT(O.data) AS Exams
FROM Sotrudnik C
INNER JOIN Prepodavatel P ON C.TabNom = P.TabNom_Pr
INNER JOIN Kafedra K ON C.ShifrKaf_Sotr = K.ShifrKaf
LEFT  JOIN Ozenka  O ON P.TabNom_Pr = O.Tab_Nom
GROUP BY C.FIO, C.Dolgn, P.Zvanie, P.Stepen, K.Nkaf
GO

SELECT
    Фамилия, Должность, Звание,Степень, Кафедра, Количество_экзаменов
FROM zad3
GO


--4

DECLARE @PR4 TABLE
(
    [Номер месяца]    INT,
    [Название месяца] VARCHAR(20),
    [Количество дней] INT
);

DECLARE @M INT = 1;
DECLARE @D DATE;

WHILE @M <= 12
BEGIN
    SET @D = CAST(CAST(YEAR(GETDATE()) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(@M AS VARCHAR(2)), 2) + '-01' AS DATE);

    INSERT INTO @PR4
    VALUES (@M, DATENAME(MONTH, @D), DAY(EOMONTH(@D)));

    SET @M = @M + 1;
END;

SELECT [Номер месяца], [Название месяца], [Количество дней]
FROM @PR4;

--5
USE Ucheb_11_Kravchenko
GO

DECLARE @PR5 TABLE
(
    Название VARCHAR(50),
    Столица VARCHAR(50),
    Площадь FLOAT,
    Население BIGINT,
    Континент VARCHAR(50)
);
INSERT INTO @PR5
SELECT
    Nazvanie,
    Stolica,
    PL,
    KolNas,
    Kontinent
FROM Tabl_Kontinent$ A
WHERE PL * 100 < (SELECT AVG(PL) FROM Tabl_Kontinent$ B
WHERE A.Kontinent = B.Kontinent);
SELECT
    Название,
    Столица,
    Площадь,
    Население,
    Континент
FROM @PR5;
GO

--6
USE vuz;
GO

SELECT
    DATEPART(WEEK, data) AS [Номер недели],
    COUNT(DISTINCT Kod) AS [Количество экзаменов],
    COUNT(DISTINCT RegNom) AS [Количество студентов]
INTO #zad6
FROM Ozenka
GROUP BY DATEPART(WEEK, data);
SELECT * FROM #zad6;
GO

--7


USE Ucheb_11_Kravchenko
GO

CREATE TABLE ##zad7
(
    Континент VARCHAR(50),
    Наибольшая_площадь FLOAT,
    Наименьшая_площадь FLOAT
);
INSERT INTO ##zad7
(
    Континент,
    Наибольшая_площадь,
    Наименьшая_площадь
)
SELECT
    Kontinent,
    MAX(PL) AS Наибольшая_площадь,
    MIN(PL) AS Наименьшая_площадь
FROM Tabl_Kontinent$
GROUP BY Kontinent;

SELECT * FROM ##zad7
GO

--8
USE vuz;
GO

WITH zad8 AS
(
    SELECT
        F.Nfak AS Факультет,
        F.ABfak,
        AVG(C.Zarplata) AS [Средняя зарплата по факультету]
     FROM Sotrudnik C
     INNER JOIN Kafedra K ON C.ShifrKaf_Sotr = K.ShifrKaf
     INNER JOIN Fakultet F ON K.AbFaK_Kaf = F.ABfak
    GROUP BY F.NFak, F.AbFak
)
SELECT
    C.FIO,
    C.Zarplata,
    zad8.Факультет,
    zad8.[Средняя зарплата по факультету]
FROM Sotrudnik C
INNER JOIN Kafedra K ON C.ShifrKaf_Sotr = K.ShifrKaf
INNER JOIN Fakultet F ON K.AbFaK_Kaf = F.ABfak
INNER JOIN zad8 ON F.Nfak = zad8.Факультет
WHERE C.Zarplata < zad8.[Средняя зарплата по факультету];
GO


--9
USE Ucheb_11_Kravchenko;
GO
DROP VIEW zad1, zad2
GO

USE vuz;
GO
DROP VIEW zad3;
GO