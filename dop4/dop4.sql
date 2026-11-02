USE SchoolElectives

DECLARE @TargetClass VARCHAR(10) = '11Б';

SELECT last_name, first_name, middle_name 
FROM Student 
WHERE class = @TargetClass
Go

DECLARE @StartDate DATE = '2026-09-01'
DECLARE @EndDate DATE = '2026-09-10'

SELECT student_id, date 
FROM Attendance 
WHERE date BETWEEN @StartDate AND @EndDate
Go


DECLARE @EmptyElectives INT
SELECT @EmptyElectives = COUNT(*) 
FROM Elective 
WHERE elective_id NOT IN (SELECT elective_id FROM Enrollment)

IF @EmptyElectives > 0
    PRINT 'Количество пустых факультативов: ' + CAST(@EmptyElectives AS VARCHAR)
ELSE
    PRINT 'Все факультативы имеют записанных студентов'
Go

DECLARE @ID INT = 1
DECLARE @LastName VARCHAR(50)

WHILE @ID <= 100
BEGIN
    SELECT @LastName = last_name FROM Student WHERE student_id = @ID
    
    IF @LastName = 'Иванов'
    BEGIN
        PRINT 'Найден Иванов с ID = ' + CAST(@ID AS VARCHAR);
        BREAK
    END
    
    SET @ID = @ID + 1;
END

Go

DECLARE @ID INT = 1
WHILE @ID <= 20
BEGIN
    IF @ID NOT IN (SELECT student_id FROM Attendance)
    BEGIN
        SET @ID = @ID + 1
        CONTINUE
    END
    
    PRINT 'Студент с ID ' + CAST(@ID AS VARCHAR) + ' имеет посещаемость'
    SET @ID = @ID + 1
END
Go


SELECT last_name, first_name, birth_year,
    YEAR(GETDATE()) - birth_year AS [Возраст]
FROM Student
WHERE birth_year IS NOT NULL
Go

SELECT elective_id,start_time,
    DATEDIFF(minute, '12:00:00', start_time) AS [Минут после полудня]
FROM Schedule
WHERE weekday = 'Вторник'AND start_time > '09:00:00'
Go

SELECT directive, LEN(directive) AS [Длина названия]
FROM Elective
Go

SELECT  directive, LOWER(REPLACE(directive, 'а', '*')) AS [Название с заменами]
FROM Elective
Go

SELECT last_name,SUBSTRING(last_name, 1, 4) AS [Первые 4 буквы]
FROM Student
Go

SELECT directive,CHARINDEX('а', directive) AS [Позиция буквы а]
FROM Elective
Go

SELECT student_id,POWER(student_id, 2) AS [Квадрат ID]
FROM Student
Go

SELECT  birth_year,CEILING(birth_year / 3.0)
FROM Student
Go

SELECT  birth_year, ABS(birth_year - 2026) 
FROM Student
Go

SELECT  birth_year,
    FLOOR(SQRT(CAST(birth_year AS FLOAT))) AS [Корень из года]
FROM Student
Go