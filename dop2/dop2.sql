USE SchoolElectives

SELECT 
    S.first_name AS [Имя],
    S.last_name AS [Фамилия],
    S.middle_name AS [Отчество],
    E.name AS [Название факультатива]
FROM 
    Student S
    INNER JOIN Enrollment En ON S.student_id = En.student_id
    INNER JOIN Elective E ON En.elective_id = E.elective_id
Go


SELECT  T.first_name, T.last_name, T.middle_name
FROM Elective E
INNER JOIN Teacher T ON E.teacher_id = T.teacher_id
WHERE E.directive = 'математика'
Go

SELECT E.directive, Sch.weekday
FROM Elective E
LEFT JOIN Schedule Sch ON E.elective_id = Sch.elective_id
Go

SELECT S.last_name, En.elective_id
FROM Student S
LEFT JOIN Enrollment En ON S.student_id = En.student_id
WHERE S.class = '11Б'
Go

SELECT A.date, S.last_name, S.first_name
FROM Student S
RIGHT JOIN Attendance A ON S.student_id = A.student_id
Go


SELECT A.room_number,S.weekday,S.start_time,S.elective_id
FROM Schedule S
RIGHT JOIN Auditorium A ON S.room_id = A.room_id
Go

SELECT  E.directive ,En.student_id 
FROM Elective E
FULL OUTER JOIN Enrollment En ON E.elective_id = En.elective_id
Go

SELECT S.last_name, S.first_name, En.elective_id
FROM Student S
FULL OUTER JOIN Enrollment En ON S.student_id = En.student_id
Go

SELECT T.last_name,T.first_name, T.middle_name, A.room_number
FROM Teacher T
CROSS JOIN Auditorium A
WHERE A.room_number LIKE '2%'
Go

SELECT  S.last_name, S.first_name, S.middle_name, E.directive
FROM Student S
CROSS JOIN Elective E
Go