USE SchoolElectives

--1
CREATE PROC Proc1
@className VARCHAR(10)
AS 
BEGIN
SELECT last_name, first_name, middle_name
    FROM Student
    WHERE class = @ClassName
END
Go

EXECUTE Proc1 '11Б'
GO

--2

CREATE PROCEDURE Proc2
    @TeacherLastName VARCHAR(50)
AS
BEGIN
    SELECT E.directive, S.weekday, S.start_time
    FROM Elective E
    INNER JOIN Teacher T ON E.teacher_id = T.teacher_id
    LEFT JOIN Schedule S ON E.elective_id = S.elective_id
    WHERE T.last_name = @TeacherLastName
END
GO

EXECUTE Proc2 'Зайцева'
Go

--3

CREATE PROCEDURE Proc3
    @Class VARCHAR(10),
    @Count INT OUTPUT
AS
BEGIN
    SELECT @Count = COUNT(*)
    FROM Student
    WHERE class = @Class
END
GO

DECLARE @MyCount INT
EXEC Proc3 @Class = '11Б', @Count = @MyCount OUTPUT
SELECT @MyCount AS [Студентов в классе]
GO

--4

CREATE PROCEDURE Proc4
    @StudentID INT,
    @Visits INT OUTPUT
AS
BEGIN
    SELECT @Visits = COUNT(*)
    FROM Attendance
    WHERE student_id = @StudentID
END
GO

DECLARE @Result INT
EXECUTE Proc4 @StudentID = 1, @Visits = @Result OUTPUT
SELECT @Result AS [Всего посещений];
GO

--5

CREATE FUNCTION Func5 (@ID INT)
RETURNS VARCHAR(150)
AS
BEGIN
    DECLARE @FullName VARCHAR(150)
   
    SELECT @FullName = last_name + ' ' + first_name + ' ' + middle_name
    FROM Student
    WHERE student_id = @ID
    
    RETURN @FullName
END
GO

SELECT dbo.Func5(5) 
GO

--6
CREATE FUNCTION Func6 (@ID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Name VARCHAR(100)
    
    SELECT @Name = directive
    FROM Elective
    WHERE elective_id = @ID
    
    RETURN ISNULL(@Name, 'Не найден')
END
GO

SELECT dbo.Func6(9)
GO

--7

CREATE FUNCTION Func7 ()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        class AS [Класс],
        COUNT(*) AS [Количество студентов]
    FROM Student
    GROUP BY class
)
GO

SELECT * FROM dbo.Func7()
GO

--8

CREATE FUNCTION Func8(@StudentID INT, @StartDate DATE, @EndDate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT date, present
    FROM Attendance
    WHERE student_id = @StudentID
      AND date BETWEEN @StartDate AND @EndDate
)
GO


SELECT * FROM dbo.Func8(1, '2026-09-01', '2026-11-11')
GO