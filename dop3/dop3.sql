USE SchoolElectives

SELECT last_name, first_name, middle_name FROM Student
WHERE birth_year = 2010
UNION ALL
SELECT last_name, first_name, middle_name FROM Teacher
WHERE subject = 'Математика'
Go

SELECT S.last_name, S.first_name, S.middle_name 
FROM Student S WHERE S.birth_year = 2009 
UNION ALL
SELECT S.last_name, S.first_name, S.middle_name 
FROM Attendance A 
INNER JOIN Student S ON A.student_id = S.student_id 
WHERE A.date = '2026-09-01'
Go


SELECT room_id FROM Schedule WHERE weekday = 'Понедельник'
INTERSECT
SELECT room_id FROM Schedule WHERE weekday = 'Среда'
Go

SELECT A.student_id, S.last_name, S.first_name
FROM Attendance A
JOIN Student S ON A.student_id = S.student_id
WHERE A.date = '2026-09-01'

INTERSECT

SELECT A.student_id, S.last_name, S.first_name
FROM Attendance A
JOIN Student S ON A.student_id = S.student_id
WHERE A.present = 1
Go


SELECT room_id FROM Auditorium
EXCEPT
SELECT room_id FROM Schedule WHERE weekday = 'Пятница'
Go

SELECT room_id FROM Auditorium
EXCEPT 
SELECT room_id FROM Auditorium WHERE room_number LIKE '1%'
Go


SELECT elective_id 
FROM Enrollment 
GROUP BY elective_id 
HAVING COUNT(*) > (SELECT COUNT(*) FROM Student WHERE class = '11Б')
Go

SELECT student_id 
FROM Enrollment 
WHERE elective_id IN (SELECT elective_id FROM Elective WHERE directive = 'Математика')
Go

SELECT S.last_name, S.first_name 
FROM Student S
WHERE EXISTS (
    SELECT * 
    FROM Attendance A 
    WHERE A.student_id = S.student_id AND A.present = 0)
    Go

SELECT room_number FROM Auditorium 
WHERE room_id < ANY (
    SELECT room_id 
    FROM Schedule 
    WHERE weekday = 'Понедельник'
)
Go