USE SchoolElectives

--1

CREATE TRIGGER trig_insert
ON Teacher
AFTER INSERT
AS
BEGIN
PRINT('Добавлен новый учитель')
END 
Go

INSERT INTO Teacher (first_name, last_name, middle_name, subject)
VALUES ('Ковалева', 'Мария', 'Олеговна', 'география')
Go

--2
CREATE TRIGGER trig_update
ON Student
AFTER UPDATE
AS
BEGIN
DECLARE @OldClass VARCHAR(10), @NewClass VARCHAR(10)
    
    SELECT @OldClass = class FROM deleted;
    SELECT @NewClass = class FROM inserted;
    
    IF @OldClass <> @NewClass
        PRINT 'Класс студента изменен с ' + @OldClass + ' на ' + @NewClass
END 
Go


UPDATE Student 
SET class = '9Д' 
WHERE student_id = 1
GO


--3
CREATE TRIGGER trig_delete
ON Student
AFTER DELETE
AS
BEGIN
    DECLARE @Remaining INT
    SELECT @Remaining = COUNT(*) FROM Student
    
    PRINT 'Вы удалили студента. Осталось студентов: ' + CAST(@Remaining AS VARCHAR)
END
GO

DELETE FROM Student WHERE student_id = 22
GO

--4
CREATE TRIGGER trig_zad6_Insert
ON zad6
INSTEAD OF INSERT
AS
BEGIN
    INSERT INTO Student ( last_name, first_name, middle_name, class, birth_year)
    VALUES ('Жук', 'Евгений', 'Олегович', '1А', 2015)
END
GO

INSERT INTO zad6 (last_name, first_name, middle_name, class) 
VALUES ( 'Иванов', 'Иван', 'Иванович', '11А')
GO

SELECT * FROM zad6
Go

--4.1
CREATE TRIGGER trg_Student_Insert
ON Student
INSTEAD OF INSERT
AS
BEGIN
    SELECT AVG(YEAR(GETDATE()) - birth_year) AS Средний_возраст
    FROM Student
END
GO

INSERT INTO Student (last_name, first_name, class, birth_year)
VALUES ('Петров', 'Петр', '11А', 2008)
GO
--5
CREATE TRIGGER trig_zad6_update
ON zad6
INSTEAD OF UPDATE
AS
BEGIN
    UPDATE Student
    SET class = '11В'
    WHERE student_id = 1
END
GO

UPDATE zad6 SET class = '10Г' WHERE student_id = 2
GO
SELECT * FROM zad6
Go
--5.1
CREATE TRIGGER trg_Student_Update
ON Student
INSTEAD OF UPDATE
AS
BEGIN
    SELECT class, COUNT(*) AS Количество_студентов
    FROM Student
    GROUP BY class
END
GO

UPDATE Student
SET class = '10А'
WHERE student_id = 5
GO
--6
CREATE TRIGGER trig_zad6_del
ON zad6
INSTEAD OF DELETE
AS
BEGIN

    PRINT 'Удаление студентов запрещено!'
    SELECT 
        class AS [Класс], 
        COUNT(*) AS [Количество студентов]
    FROM Student
    GROUP BY class
END
GO

DELETE FROM zad6 WHERE student_id = 23
GO

--6.1
CREATE TRIGGER trg_Student_Delete
ON Student
INSTEAD OF DELETE
AS
BEGIN
    SELECT TOP 1 WITH TIES
        student_id,
        last_name,
        first_name,
        middle_name,
        class,
        birth_year
    FROM Student
    ORDER BY birth_year ASC
END
GO

DELETE FROM Student
WHERE student_id = 1
GO

--7
CREATE PROCEDURE Proc_visits
    @StudentID INT,
    @VisitCount INT OUTPUT
AS
BEGIN
    SELECT @VisitCount = COUNT(*)
    FROM Attendance
    WHERE student_id = @StudentID
END
GO

DECLARE @Result INT
EXEC Proc_visits 
    @StudentID = 1, 
    @VisitCount = @Result OUTPUT

SELECT @Result AS [Всего посещений у студента]
GO

--8
CREATE PROCEDURE Proc_teacher
    @TeacherID INT,
    @LessonCount INT OUTPUT
AS
BEGIN
    SELECT @LessonCount = COUNT(*)
    FROM Schedule S
    INNER JOIN Elective E ON S.elective_id = E.elective_id
    WHERE E.teacher_id = @TeacherID
END
GO


DECLARE @Count INT

EXEC Proc_teacher
    @TeacherID = 1, 
    @LessonCount = @Count OUTPUT

SELECT @Count AS [Количество занятий у преподавателя]
GO


--9
BEGIN TRANSACTION

UPDATE Schedule
SET room_id = 2
WHERE schedule_id = 1;

COMMIT TRANSACTION
GO

SELECT * FROM Schedule
GO

--10
BEGIN TRANSACTION

INSERT INTO Enrollment (student_id, elective_id, enroll_date)
VALUES (5, 3, GETDATE());

COMMIT TRANSACTION
GO

SELECT * FROM Enrollment
GO

--11
BEGIN TRY
    BEGIN TRANSACTION

    UPDATE Auditorium
    SET capacity = -10
    WHERE room_id = 1

    COMMIT TRANSACTION;
    PRINT 'Вместимость аудитории успешно изменена'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Ошибка при изменении вместимости аудитории'
END CATCH
GO

--12
BEGIN TRY
    BEGIN TRANSACTION

    INSERT INTO Enrollment (student_id, elective_id, enroll_date)
    VALUES (4, 2, GETDATE())

    COMMIT TRANSACTION;
    PRINT 'Студент успешно записан на факультатив'
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
    PRINT 'Ошибка при записи на факультатив'
END CATCH
GO

SELECT * FROM Enrollment
GO