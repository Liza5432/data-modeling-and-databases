USE Ucheb_11_Kravchenko

--1
SELECT FIO,LEN(FIO) AS Количество_символов
FROM Student
Go

--2
SELECT TRIM(FIO) AS ФИО, Data, spez, godpost
FROM Student
Go

--3
SELECT FIO, CHARINDEX('о', FIO) AS Позиция_о
FROM Student
Go

--4
SELECT FIO, LEFT(spez, 3) AS Спец_3
FROM Student
Go

--5
SELECT FIO, Data, REPLACE(spez, 'математика', 'прикладная математика') AS Спец, godpost
FROM Student
Go

--6
SELECT FIO, Data, UPPER(spez) AS Спец, godpost
FROM Student
Go

--7
SELECT FIO, REVERSE(FIO) AS ФИО_Обр
FROM Student
Go

--8
SELECT DISTINCT REPLICATE(spez, 4) AS Спец_4
FROM Student
Go

--9
SELECT 
    ABS(COS(PI())) AS Косинус_Пи, 
    ABS(SIN(PI())) AS Синус_Пи, 
    ABS(TAN(PI())) AS Тангенс_Пи, 
    ABS(COT(PI())) AS Котангенс_Пи
    Go

--10
SELECT 
    ROUND(123.456, 3) AS Окр3,
    ROUND(123.456, 2) AS Окр2,
    ROUND(123.456, 1) AS Окр1,
    ROUND(123.456, 0) AS Окр0,
    ROUND(123.456, -1) AS Окр_1,
    ROUND(123.456, -2) AS Окр_2,
    ROUND(123.456, -3) AS Окр_3
    Go

--11
SELECT CEILING(123.456) AS Больше, FLOOR(123.456) AS Меньше
Go

--12
SELECT 
    SQRT(25) AS Корень,
    SQUARE(25) AS Квадрат,
    POWER(25, 3) AS Куб
    Go

--13
SELECT GETDATE() AS Сейчас
Go

--14

SELECT DAY(GETDATE()) AS День, MONTH(GETDATE()) AS Месяц, YEAR(GETDATE()) AS Год,
       DATEPART(HOUR, GETDATE()) AS Час, DATEPART(MINUTE, GETDATE()) AS Минута,
       DATEPART(SECOND, GETDATE()) AS Секунда, DATEPART(QUARTER, GETDATE()) AS Квартал,
       DATEPART(WEEK, GETDATE()) AS Неделя, DATEPART(DAYOFYEAR, GETDATE()) AS День_года,
       DATEPART(WEEKDAY, GETDATE()) AS День_недели
    Go


--15
SELECT DATEADD(DAY, -100, GETDATE()) AS День_100_Назад
Go

--16
SELECT DATEDIFF(DAY, '18950708', '19710412') AS Количество_прожитых_дней
Go

--17
SELECT FIO,
       CASE MONTH(Data)
            WHEN 3 THEN 'Весна' WHEN 4 THEN 'Весна' WHEN 5 THEN 'Весна'
            WHEN 6 THEN 'Лето'  WHEN 7 THEN 'Лето'  WHEN 8 THEN 'Лето'
            WHEN 9 THEN 'Осень' WHEN 10 THEN 'Осень' WHEN 11 THEN 'Осень'
            ELSE 'Зима'
       END AS Времени_года
FROM Student
Go

--18
SELECT FIO, Data, spez, godpost,
       IIF(godpost - YEAR(Data) <= 18, 'Молодой', 'старше') AS Возраст_при_поступлении
FROM Student
Go

--19
SELECT FIO, Data,
       CASE
           WHEN (MONTH(Data) = 3 AND DAY(Data) >= 21) OR (MONTH(Data) = 4 AND DAY(Data) <= 19) THEN 'Овен'
           WHEN (MONTH(Data) = 4 AND DAY(Data) >= 20) OR (MONTH(Data) = 5 AND DAY(Data) <= 20) THEN 'Телец'
           WHEN (MONTH(Data) = 5 AND DAY(Data) >= 21) OR (MONTH(Data) = 6 AND DAY(Data) <= 20) THEN 'Близнецы'
           WHEN (MONTH(Data) = 6 AND DAY(Data) >= 21) OR (MONTH(Data) = 7 AND DAY(Data) <= 22) THEN 'Рак'
           WHEN (MONTH(Data) = 7 AND DAY(Data) >= 23) OR (MONTH(Data) = 8 AND DAY(Data) <= 22) THEN 'Лев'
           WHEN (MONTH(Data) = 8 AND DAY(Data) >= 23) OR (MONTH(Data) = 9 AND DAY(Data) <= 22) THEN 'Дева'
           WHEN (MONTH(Data) = 9 AND DAY(Data) >= 23) OR (MONTH(Data) = 10 AND DAY(Data) <= 22) THEN 'Весы'
           WHEN (MONTH(Data) = 10 AND DAY(Data) >= 23) OR (MONTH(Data) = 11 AND DAY(Data) <= 21) THEN 'Скорпион'
           WHEN (MONTH(Data) = 11 AND DAY(Data) >= 22) OR (MONTH(Data) = 12 AND DAY(Data) <= 21) THEN 'Стрелец'
           WHEN (MONTH(Data) = 12 AND DAY(Data) >= 22) OR (MONTH(Data) = 1 AND DAY(Data) <= 19) THEN 'Козерог'
           WHEN (MONTH(Data) = 1 AND DAY(Data) >= 20) OR (MONTH(Data) = 2 AND DAY(Data) <= 18) THEN 'Водолей'
           WHEN (MONTH(Data) = 2 AND DAY(Data) >= 19) OR (MONTH(Data) = 3 AND DAY(Data) <= 20) THEN 'Рыбы'
       END AS Знак_зодиака
FROM Student
Go

--Самостоятельная работа
--1

SELECT FIO, LEN(FIO) AS 'количество символов'
FROM Student
ORDER BY LEN(FIO) ASC
Go

--2
SELECT TRIM(FIO) AS FIO FROM Student
Go

--3
SELECT FIO, CHARINDEX('ов', FIO) AS 'номер позиции'
FROM Student
Go

--4
SELECT FIO, RIGHT(spez, 2) AS spez
FROM Student
Go

--5
SELECT 
    LEFT(FIO, CHARINDEX(' ', FIO) - 1) + ' ' + 
    SUBSTRING(FIO, CHARINDEX(' ', FIO) + 1, 1) + '. ' + 
    SUBSTRING(FIO, CHARINDEX(' ', FIO, CHARINDEX(' ', FIO) + 1) + 1, 1) + '.' AS ФИО_Инициалы
FROM Student
Go

--6
SELECT DISTINCT spez, REVERSE(spez) AS 'Специальность_Наоборот'
FROM Student
Go

--7
SELECT REPLICATE('Кравченко', 20)
Go

--8 
SELECT ROUND(ABS(POWER(SIN(PI() / 2), 2) - COS(3 * PI() / 2)), 2) AS Результат
Go

--9
SELECT DATEDIFF(DAY, GETDATE(), '20261231') AS Дней_до_конца_семестра
Go

--10
SELECT DATEDIFF(MONTH, '20260705', GETDATE()) 
Go

--11
SELECT DISTINCT spez, 
IIF(LEN(spez) > 10, 'длинный', 'короткий') AS Длина
FROM Student
Go