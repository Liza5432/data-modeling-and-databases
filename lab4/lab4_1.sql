USE TestDatabas

CREATE TABLE Table_uch1 (
    id INT PRIMARY KEY,
    fo VARCHAR(50),
    predmet VARCHAR(50),
    ush VARCHAR(30),
    ball DECIMAL(5, 1)
);


INSERT INTO Table_uch1 (id, fo, predmet, ush, ball) VALUES
(1, 'Иванова', 'математика', 'лицей', 98.5),
(2, 'Петров', 'физика', 'лицей', 99),
(3, 'Сидоров', 'математика', 'лицей', 88),
(4, 'Полухина', 'физика', 'гимназия', 78),
(5, 'Матвеева', 'химия', 'лицей', 92),
(6, 'Касимов', 'химия', 'гимназия', 68),
(7, 'Нестеров', 'математика', 'гимназия', 81),
(8, 'Авдеев', 'физика', 'лицей', 87),
(9, 'Никитина', 'химия', 'лицей', 94),
(10, 'Барышев', 'химия', 'лицей', 88)
Go

DECLARE @a INT, @b INT, @c INT
SET @a = 5
SET @b = 10
SET @c = @a + @b PRINT @c
Go

DECLARE @licey FLOAT, @gimm FLOAT, @diff FLOAT

SET @licey = ( SELECT MAX(ball) From Table_uch1
WHERE ush = 'Лицей')

SET @gimm =( SELECT MAX(ball) From Table_uch1
WHERE ush = 'Гимназия')

SET @diff = ABS(@licey - @gimm)
PRINT @diff
Go

DECLARE @maxp FLOAT, @minp FLOAT, @diff FLOAT
SELECT 
    @maxp = MAX(ball),
    @minp = MIN(ball)
FROM 
    Table_uch1
SET @diff = @maxp - @minp
PRINT @diff
Go

DECLARE @a1 INT, @b1 INT
SET @a1=RAND()*1000
SET @b1 = SQUARE(@a1)
PRINT @a1
PRINT @b1
Go

DECLARE @a2 INT=RAND() * 100, @b2 INT= RAND() * 100

IF @a2 > @b2
    PRINT '@a2 = ' + CAST(@a2 AS VARCHAR(3))
ELSE
    PRINT '@b2 = ' + CAST(@b2 AS VARCHAR(3))
   Go

DECLARE @a3 INT = RAND() * 100
IF @a3 % 3 = 0
    PRINT CAST(@a3 AS VARCHAR(3)) + ' делится на 3'
ELSE
    PRINT CAST(@a3 AS VARCHAR(3)) + ' не делится на 3'
Go

DECLARE @a4 INT = RAND() * 1000

WHILE @a4 % 5 = 0
    SET @a4 = @a4 / 5
IF @a4 = 1
    PRINT 'Да'
ELSE
    PRINT 'Нет'
Go

DECLARE @a5 INT = RAND() * 1000, @b5 INT = RAND() * 1000
PRINT '@a5 = ' + CAST(@a5 AS VARCHAR(4))
PRINT '@b5 = ' + CAST(@b5 AS VARCHAR(4))

WHILE @a5 != @b5
BEGIN
    IF @a5 > @b5
        SET @a5 = @a5 - @b5
    ELSE
        SET @b5 = @b5 - @a5
END
PRINT 'НОД = ' + CAST(@a5 AS VARCHAR(4))
Go

DECLARE @a6 INT = 5, @b6 INT = 10, @s INT = 0
WHILE @a6 <= @b6
BEGIN
    SET @s = @s + @a6
    SET @a6 = @a6 + 1
END
PRINT 'Сумма = ' + CAST(@s AS VARCHAR(5))
Go

DECLARE @N INT = RAND() * 10, @M INT = 1, @S1 INT = 0
WHILE @M <= 2 * @N - 1
BEGIN
    SET @S1 = @S1 + @M
    PRINT @S1
    SET @M = @M + 2
END
Go

DECLARE @A7 INT = RAND() * 5, @C7 INT = 1
DECLARE @B7 INT = @A7 + RAND() * 5
PRINT '@A7 = ' + CAST(@A7 AS CHAR(1)) + ', @B7 = ' + CAST(@B7 AS CHAR(1))
WHILE @A7 <= @B7
BEGIN
    PRINT REPLICATE(@A7, @C7)
    SET @A7 = @A7 + 1
    SET @C7 = @C7 + 1
END
Go

DECLARE @A8 INT = 10
WHILE @A8 < 100
BEGIN
    IF (@A8 % 4 = 0) AND (@A8 % 6 != 0)
        PRINT @A8
    SET @A8 = @A8 + 1
END
Go

DECLARE @D INT = 31, @M INT = 12
SET @D = CASE 
    WHEN @M IN (1, 3, 5, 7, 8, 10, 12) AND @D = 31 THEN 1
    WHEN @M IN (4, 6, 9, 11) AND @D = 30 THEN 1
    WHEN @M = 2 AND @D = 29 THEN 1
    ELSE @D + 1
END

SET @M = CASE
    WHEN @D = 1 AND @M = 12 THEN 1
    WHEN @D = 1 AND @M < 12 THEN @M + 1
    ELSE @M
END

PRINT CAST(@D AS VARCHAR(2)) + '/' + CAST(@M AS VARCHAR(2))
Go


DECLARE @L INT, @N1 CHAR(13) = 'Нижневартовск'
SET @L = LEN(@N1)
WHILE @L > 0
BEGIN
    PRINT @N1
    SET @L = @L - 1
END
Go

DECLARE @L2 INT, @M2 INT, @N2 CHAR(13)
SET @N2 = 'Нижневартовск'
SET @L2 = LEN(@N2)
SET @M2 = @L2
WHILE @L2 > 0
BEGIN
    PRINT LEFT(@N2, @L2) + SPACE(2 * (@M2 - @L2)) + RIGHT(REVERSE(@N2), @L2) 
    SET @L2 = @L2 - 1
END
SET @L2 = 2
WHILE @L2 <= @M2
BEGIN
    PRINT LEFT(@N2, @L2) + SPACE(2 * (@M2 - @L2)) + RIGHT(REVERSE(@N2), @L2)
    SET @L2 = @L2 + 1
END
Go

--Самостоятельная работа
-- 1
DECLARE @a INT, @b INT, @c INT
SET @a = 5
SET @b = 4
SET @c = @a * @b PRINT @c
Go

--2
DECLARE @licey FLOAT, @gimn FLOAT, @diff FLOAT
SET @licey = (SELECT AVG(ball) FROM Table_uch1 WHERE ush = 'Лицей')
SET @gimn = (SELECT AVG(ball) FROM Table_uch1 WHERE ush = 'Гимназия')
SET @diff = ABS(@licey - @gimn)
PRINT @diff
Go

--3
DECLARE @count INT
SET @count = (SELECT COUNT(*) FROM Table_uch1)
IF @count % 2 = 0
    PRINT 'Количество строк (' + CAST(@count AS VARCHAR(10)) + ') - четное'
ELSE
    PRINT 'Количество строк (' + CAST(@count AS VARCHAR(10)) + ') - нечетное'
Go

--4
DECLARE @a INT = 1234 , @sum INT
SET @sum = (@a / 1000) + ((@a / 100) % 10) + ((@a / 10) % 10) + (@a % 10)
PRINT @sum
Go

--5

DECLARE @a INT=RAND() * 100, @b INT= RAND() * 100, @c INT= RAND() * 100
IF (@a < @b) AND (@a < @c)
     PRINT '@a = ' + CAST(@a AS VARCHAR(3))
ELSE IF (@b < @a) AND (@b < @c)
     PRINT '@b = ' + CAST(@b AS VARCHAR(3))
ELSE
     PRINT '@c = ' + CAST(@c AS VARCHAR(3))
Go 

--6
DECLARE @a INT=RAND() * 100

IF @a % 11 = 0 
    PRINT CAST(@a AS VARCHAR(3)) + ' делится на 11'
ELSE 
    PRINT CAST(@a AS VARCHAR(3)) + ' не делится на 11'

GO

--7

DECLARE @N INT = RAND() * 1000

WHILE @N % 3 = 0
    SET @N = @N / 3
IF @N = 1
    PRINT 'Да'
ELSE
    PRINT 'Нет'
Go

--8

DECLARE @a INT = RAND() * 100, @b INT = RAND() * 100
DECLARE @temp_a INT = @a, @temp_b INT = @b, @nod INT, @nok INT

PRINT 'a = ' + CAST(@a AS VARCHAR(3)) + ', b = ' + CAST(@b AS VARCHAR(3))

WHILE @temp_b != 0
BEGIN
    SET @nod = @temp_b
    SET @temp_b = @temp_a % @temp_b
    SET @temp_a = @nod
END


SET @nok = (@a * @b) / @temp_a
PRINT 'НОК = ' + CAST(@nok AS VARCHAR(5))
Go

--9
DECLARE @A INT = RAND() * 100, @B INT = RAND() * 100, @sum_sq INT = 0
PRINT 'A = ' + CAST(@A AS VARCHAR(3)) + ', B = ' + CAST(@B AS VARCHAR(3))

WHILE @A <= @B
BEGIN
    SET @sum_sq = @sum_sq + SQUARE(@A) 
    SET @A = @A + 1
END

PRINT 'Сумма квадратов = ' + CAST(@sum_sq AS VARCHAR(5))
Go

--10
DECLARE @num INT = 1

WHILE 1 = 1 
BEGIN
   
    IF (@num % 2 = 1) AND 
       (@num % 3 = 1) AND 
       (@num % 4 = 1) AND 
       (@num % 5 = 1) AND 
       (@num % 6 = 1) AND 
       (@num % 7 = 0)
    BEGIN
        PRINT 'Искомое число: ' + CAST(@num AS VARCHAR(4))
        BREAK
    END
    
    SET @num = @num + 1
END

GO

--11
DECLARE @surname VARCHAR(20) = 'Кравченко'
DECLARE @len INT = LEN(@surname)
DECLARE @i INT = 1

PRINT  ' букв: ' + CAST(@len AS VARCHAR(2)) 

WHILE @i <= @len
BEGIN
    PRINT  @surname
    SET @i = @i + 1
END

GO