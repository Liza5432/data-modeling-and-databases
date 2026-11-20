USE Ucheb_11_Kravchenko
Go
--1

CREATE TRIGGER trig1 ON Student
FOR INSERT
AS 
BEGIN
  PRINT 'Запись добавлена'
END

--2

INSERT INTO Student (FIO, Data, spez, godpost) 
VALUES ('Цветкова Анастасия Сергеевна', '2005-05-12', 'Информатика', 2023)
GO

--3
CREATE TRIGGER trig2
ON Student
INSTEAD OF DELETE
AS
BEGIN
PRINT 'Нельзя удалить данные'
END

Go

--4
DELETE FROM Student
WHERE FIO = 'Цветкова Анастасия Сергеевна'
Go

--5

CREATE TABLE Студент_Архив1(
FIO NVARCHAR(40) NULL,
Data Date Null,
spez nVARCHAR(20) NULL,
godpost int NULL,
Удалено DATETIME NOT NULL )
Go

CREATE TRIGGER trig33
ON Student
FOR DELETE
AS 
BEGIN 
INSERT Студент_Архив1
SELECT Fio, Data, spez, godpost, GETDATE() AS Удалено
FROM DELETED
END
Go

CREATE TRIGGER trig31
ON Student
FOR DELETE
AS 
BEGIN
INSERT Студент_Архив1
SELECT Fio, Data, spez, godpost, GETDATE() AS Удалено
FROM DELETED
END
Go

DELETE FROM Student 
WHERE FIO = 'Иванов Иван Александрович' 
GO

SELECT * FROM Студент_Архив1
GO

