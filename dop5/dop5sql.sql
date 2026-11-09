USE SchoolElectives
GO
--1
CREATE VIEW zad1  AS
SELECT 
    E.directive AS [Название факультатива],
    COUNT(En.student_id) AS [Количество студентов]
FROM Elective E
INNER JOIN Enrollment En ON E.elective_id = En.elective_id
GROUP BY E.directive;

SELECT * FROM zad1;
Go

-- 2
CREATE VIEW zad2 AS
SELECT 
    student_id,
    COUNT(*) AS [Всего посещений]
FROM Attendance
GROUP BY student_id;
GO

SELECT * FROM zad2;
GO

--3
CREATE VIEW zad3 AS
SELECT 
    T.last_name,
    T.first_name,
    T.middle_name,
    E.directive, 
    S.weekday, 
    S.start_time
FROM Teacher T
INNER JOIN Elective E ON T.teacher_id = E.teacher_id
INNER JOIN Schedule S ON E.elective_id = S.elective_id
Go

SELECT * FROM zad3;
Go

--4
CREATE VIEW zad4 AS
SELECT 
    S.class, 
    COUNT(A.attendance_id) AS [Всего прогулов]
FROM Student S
INNER JOIN Attendance A ON S.student_id = A.student_id
WHERE A.present = 0
GROUP BY S.class
GO

SELECT * FROM zad4;
GO

--5
CREATE VIEW zad5 AS
SELECT 
    T.last_name,
    T.first_name,
    E.directive
FROM Teacher T
INNER JOIN Elective E ON T.teacher_id = E.teacher_id
GO

SELECT * FROM zad5;

Go

--6
CREATE VIEW zad6 AS
SELECT 
    student_id, 
    last_name, 
    first_name, 
    middle_name, 
    class
FROM Student
GO

UPDATE zad6
SET class = '11В'
WHERE student_id = 1
GO

SELECT * FROM zad6;
Go


--7
CREATE VIEW zad7 AS
SELECT 
    attendance_id, 
    date, 
    present, 
    student_id
FROM Attendance
GO

INSERT INTO zad7 ( date, present, student_id)
VALUES ('2026-10-01', 1, 1)
Go

SELECT * FROM zad7;
Go

--8
CREATE VIEW zad8 AS
SELECT 
    teacher_id,
    last_name,
    first_name,
    middle_name,
    subject
FROM Teacher
GO

INSERT INTO zad8 (last_name, first_name, middle_name, subject)
VALUES ('Сидоров', 'Алексей', 'Петрович', 'Математика')
GO

DELETE FROM zad8
WHERE last_name = 'Сидоров'
GO

SELECT * FROM zad8
GO


--9
DECLARE @MyStudents TABLE (
    student_id INT,
    last_name VARCHAR(50),
    first_name VARCHAR(50)
);

INSERT INTO @MyStudents (student_id, last_name, first_name)
SELECT student_id, last_name, first_name 
FROM Student 
WHERE class = '11Б';

SELECT * FROM @MyStudents;
GO

--10
CREATE TABLE #ElectiveStats (
    directive VARCHAR(100),
    student_count INT
);

INSERT INTO #ElectiveStats (directive, student_count)
SELECT E.directive, COUNT(En.student_id)
FROM Elective E
LEFT JOIN Enrollment En ON E.elective_id = En.elective_id
GROUP BY E.directive;

SELECT * FROM #ElectiveStats;
GO

--11
CREATE TABLE ##MondaySchedule (
    elective_id INT,
    room_id INT,
    start_time TIME
);

INSERT INTO ##MondaySchedule (elective_id, room_id, start_time)
SELECT elective_id, room_id, start_time
FROM Schedule
WHERE weekday = 'Понедельник';

SELECT * FROM ##MondaySchedule;
GO

--12
WITH Visits AS (
    SELECT 
        S.student_id, 
        S.last_name, 
        S.first_name, 
        COUNT(*) AS VisitCount
    FROM Student S
    INNER JOIN Attendance A ON S.student_id = A.student_id
    GROUP BY S.student_id, S.last_name, S.first_name
)
SELECT 
    last_name, 
    first_name, 
    VisitCount
FROM Visits 
WHERE VisitCount > 1;
GO