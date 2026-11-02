CREATE DATABASE vuz
Go

USE vuz
Go

CREATE TABLE Fakultet (
    AbFak VARCHAR(10) PRIMARY KEY,
    NFak VARCHAR(100) NOT NULL
);
Go


CREATE TABLE Kafedra (
    ShifrKaf VARCHAR(10) PRIMARY KEY,
    NKaf VARCHAR(100) NOT NULL,
    AbFak_Kaf VARCHAR(10),
    FOREIGN KEY (AbFak_Kaf) REFERENCES Fakultet(AbFak)
);
Go

CREATE TABLE Sotrudnik (
    TabNom INT PRIMARY KEY,
    ShifrKaf_Sotr VARCHAR(10),
    FIO VARCHAR(150) NOT NULL,
    Dolgn VARCHAR(100),
    Zarplata DECIMAL(10, 2),
    TabNom_ruk INT, 
    FOREIGN KEY (ShifrKaf_Sotr) REFERENCES Kafedra(ShifrKaf),
    FOREIGN KEY (TabNom_ruk) REFERENCES Sotrudnik(TabNom)
);
Go


CREATE TABLE Spezialn (
    NSpez VARCHAR(20) PRIMARY KEY,
    NaprSpez VARCHAR(150) NOT NULL,
    Shifr_Spez VARCHAR(10),
    FOREIGN KEY (Shifr_Spez) REFERENCES Kafedra(ShifrKaf)
);
Go

CREATE TABLE Predmet (
    kod_pred INT PRIMARY KEY,
    Kol INT,
    Predmet VARCHAR(100) NOT NULL,
    Ispolnitel_kaf VARCHAR(10),
    FOREIGN KEY (Ispolnitel_kaf) REFERENCES Kafedra(ShifrKaf)
);
Go

CREATE TABLE Zakaz (
    N_Z VARCHAR(20), 
    Kod_Z INT,      
    PRIMARY KEY (N_Z, Kod_Z),
    FOREIGN KEY (N_Z) REFERENCES Spezialn(NSpez),
    FOREIGN KEY (Kod_Z) REFERENCES Predmet(kod_pred)
);
Go

CREATE TABLE ZavKaf (
    TabNom_K INT PRIMARY KEY,
    St_K INT, 
    FOREIGN KEY (TabNom_K) REFERENCES Sotrudnik(TabNom)
);
Go

CREATE TABLE Ingener (
    TabNom_IN INT PRIMARY KEY,
    Spec VARCHAR(100),
    FOREIGN KEY (TabNom_IN) REFERENCES Sotrudnik(TabNom)
);
Go

CREATE TABLE Prepodavatel (
    TabNom_Pr INT PRIMARY KEY,
    Zvanie VARCHAR(100),
    Stepen VARCHAR(100),
    FOREIGN KEY (TabNom_Pr) REFERENCES Sotrudnik(TabNom)
);
Go

CREATE TABLE Student (
    Reg_Nom INT PRIMARY KEY,
    Nom_Spez_St VARCHAR(20),
    Fio_stud VARCHAR(150) NOT NULL,
    FOREIGN KEY (Nom_Spez_St) REFERENCES Spezialn(NSpez)
);
Go

CREATE TABLE Ozenka (
    data DATE,
    Kod INT,       
    ReGNom INT,    
    Tab_Nom INT,  
    Auditoria VARCHAR(20),
    Ozenk_a INT,  
    PRIMARY KEY (data, Kod, ReGNom), 
    FOREIGN KEY (Kod) REFERENCES Predmet(kod_pred),
    FOREIGN KEY (ReGNom) REFERENCES Student(Reg_Nom),
    FOREIGN KEY (Tab_Nom) REFERENCES Prepodavatel(TabNom_Pr)
);


INSERT INTO Fakultet (AbFak, NFak) VALUES
('Гн', 'Гуманитарные Науки'),
('Ен', 'Естественные Науки'),
('ИТ', 'Информационные Технологии'),
('Фм', 'Физико Математический');

INSERT INTO Kafedra (ShifrKaf, NKaf, AbFak_Kaf) VALUES
('вм', 'Высшая Математика', 'ен'),
('ис', 'Информационные Системы', 'ит'),
('мм', 'Математическое Моделирование', 'фм'),
('оф', 'Общая Физика', 'ен'),
('пи', 'Прикладная Математика', 'ит'),
('эф', 'Экспериментальная Физика', 'фм');


INSERT INTO Sotrudnik (TabNom, ShifrKaf_Sotr, FIO, Dolgn, Zarplata, TabNom_ruk) VALUES
(101, 'пи', 'Приюров', 'зав.кафедрой', 3500.00, 101),
(102, 'пи', 'Семенов', 'преподаватель', 2500.00, 101),
(105, 'пи', 'Петров', 'преподаватель', 2500.00, 101),
(153, 'пи', 'Сидорова', 'инженер', 1500.00, 102),
(201, 'ис', 'Андреев', 'зав.кафедрой', 3500.00, 201),
(202, 'ис', 'Воронцов', 'преподаватель', 2500.00, 201),
(241, 'ис', 'Глухов', 'инженер', 2000.00, 201),
(242, 'ис', 'Чернов', 'инженер', 1500.00, 202),
(301, 'мм', 'Басов', 'зав.кафедрой', 3500.00, 301),
(302, 'мм', 'Сергеева', 'преподаватель', 2500.00, 301),
(401, 'оф', 'Волков', 'зав.кафедрой', 3500.00, 401),
(402, 'оф', 'Зайцев', 'преподаватель', 2500.00, 401),
(403, 'оф', 'Смирнов', 'преподаватель', 1500.00, 401),
(435, 'оф', 'Лисин', 'инженер', 2000.00, 402),
(501, 'вм', 'Кузнецов', 'зав.кафедрой', 3500.00, 501),
(502, 'вм', 'Ромашев', 'преподаватель', 2500.00, 501),
(503, 'вм', 'Соловьев', 'преподаватель', 2500.00, 501),
(601, 'эф', 'Зверев', 'зав.кафедрой', 3500.00, 601),
(602, 'эф', 'Сорокина', 'преподаватель', 2500.00, 601),
(614, 'эф', 'Григорьев', 'инженер', 2000.00, 602);


INSERT INTO Spezialn (NSpez, NaprSpez, Shifr_Spez) VALUES
('01.03.04', 'Прикладная Математика', 'мм'),
('09.03.02', 'Информационные системы и технологии', 'ис'),
('14.03.02', 'Ядерная физика и технологии', 'иф'), 
('38.03.05', 'Бизнес информатика', 'ис'),
('09.09.03', 'Прикладная информатика', 'пи');


INSERT INTO Predmet (kod_pred, Kol, Predmet, Ispolnitel_kaf) VALUES
(101, 320, 'Математика', 'вм'),
(102, 160, 'Информатика', 'пи'),
(103, 160, 'Физика', 'оф'),
(202, 120, 'База данных', 'ис'),
(204, 160, 'Электроника', 'эф'),
(205, 80, 'Программирование', 'пи'),
(209, 80, 'Моделирование', 'мм');


INSERT INTO Zakaz (N_Z, Kod_Z) VALUES
('01.03.04', 101),
('01.03.04', 205),
('01.03.04', 209),
('09.03.02', 101),
('09.03.02', 102),
('09.03.02', 103),
('09.03.02', 202),
('09.02.03', 205), 
('09.02.03', 209), 
('09.03.03', 101), 
('09.09.03', 102),
('09.09.03', 103),
('09.09.03', 205),
('09.09.03', 202),
('14.03.02', 101),
('14.03.02', 102),
('14.03.02', 103),
('14.03.02', 204),
('38.03.05', 101),
('38.03.05', 103),
('38.03.05', 202),
('38.03.05', 209);


INSERT INTO ZavKaf (TabNom_K, St_K) VALUES
(101, 15),
(201, 18),
(301, 20),
(401, 10),
(501, 18),
(601, 8);


INSERT INTO Ingener (TabNom_IN, Spec) VALUES
(153, 'электроник'),
(241, 'электроник'),
(242, 'программист'),
(435, 'электроник'),
(614, 'программист');


INSERT INTO Prepodavatel (TabNom_Pr, Zvanie, Stepen) VALUES
(101, 'профессор', 'д.т.н.'),
(102, 'доцент', 'к.ф.-м.н.'),
(105, 'доцент', 'к.т.н.'),
(201, 'профессор', 'д.ф.-м.н.'),
(202, 'доцент', 'к.ф.-м.н.'),
(301, 'профессор', 'д.т.н.'),
(302, 'доцент', 'к.т.н.'),
(401, 'профессор', 'д.т.н.'),
(402, 'доцент', 'к.т.н.'),
(403, 'ассистент', NULL),
(501, 'профессор', 'д.ф.-м.н.'),
(502, 'профессор', 'д.ф.-м.н.'),
(503, 'доцент', 'к.ф.-м.н.'),
(601, 'профессор', 'д.ф.-м.н.');


INSERT INTO Student (Reg_Nom, Nom_Spez_St, Fio_stud) VALUES
(10101, '09.03.03', 'Николаева'), 
(10102, '09.03.03', 'Иванов'),    
(10103, '09.03.03', 'Крюков'),    
(20101, '09.03.02', 'Андреев'),
(20102, '09.03.02', 'Федоров'),
(30101, '14.03.02', 'Бондаренко'),
(30102, '14.03.02', 'Цветков'),
(30103, '14.03.02', 'Петров'),
(50101, '01.03.04', 'Сергеев'),
(50102, '01.03.04', 'Кудрявцев'),
(80101, '38.03.05', 'Макаров'),
(80102, '38.03.05', 'Яковлев');


INSERT INTO Ozenka (data, Kod, ReGNom, Tab_Nom, Auditoria, Ozenk_a) VALUES
('2022-06-05', 102, 10101, 102, 't505', 4),
('2022-06-05', 102, 10102, 102, 't505', 4),
('2022-06-05', 202, 20101, 202, 't506', 4),
('2022-06-05', 202, 20102, 202, 't506', 3),
('2022-06-07', 102, 30101, 105, 'f419', 3),
('2022-06-07', 102, 30102, 101, 't506', 4),
('2022-06-07', 102, 80101, 1002, 'м425', 5), 
('2022-06-09', 205, 80102, 402, 'м424', 4),
('2022-06-09', 209, 20101, 302, 'ф333', 3),
('2022-06-10', 101, 10102, 501, 't506', 4),
('2022-06-10', 204, 30102, 601, 'ф349', 5),
('2022-06-10', 209, 80101, 301, 'з105', 3),
('2022-06-10', 209, 80102, 301, 'з105', 4),
('2022-06-12', 101, 10101, 502, 'с324', 4),
('2022-06-15', 101, 30101, 503, 'ф417', 4),
('2022-06-15', 101, 50101, 501, 'ф201', 5),
('2022-06-15', 101, 50102, 501, 'ф201', 3),
('2022-06-15', 103, 10101, 403, 'ф414', 4),
('2022-06-15', 102, 10101, 102, 't505', 5);


SELECT
    F.Nfak AS Fakultet
    , K.Nkaf AS Kafedra FROM
Fakultet F, Kafedra K WHERE
F.ABfak = K.AbFak_Kaf
ORDER BY
    Fakultet, Kafedra
Go

SELECT
    F.Nfak AS Fakultet
    , K.Nkaf AS Kafedra
FROM
Fakultet F
INNER JOIN Kafedra K on
F.ABfak = K.AbFak_Kaf
ORDER BY
    Fakultet, Kafedra
Go

SELECT
    F.Nfak AS Fakultet
    , K.Nkaf AS Kafedra
FROM
Fakultet F
LEFT OUTER JOIN Kafedra K on
F.ABfak = K.AbFak_Kaf
ORDER BY
    Fakultet, Kafedra
Go


SELECT
    S.Fio_stud
    , P.NaprSpez
    , K.NKaf AS Kafedra
FROM
Student S
    INNER JOIN Spezialn P ON S.Nom_SpeZ_St = P.NSpez
    INNER JOIN Kafedra K ON P.Shifr_Spez = K.ShifrKaf
Go

SELECT
    S.FIO
    , S.Dolgn
    , S.Zarplata
    , P.FIO AS Руководитель
FROM
Sotrudnik S
    INNER JOIN Sotrudnik P ON S.TabNom = P.TabNom_ruk
    Go

    SELECT
    S.Fio_stud
FROM
Student S
    INNER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
GROUP BY
    S.Fio_stud
    Go

    SELECT
    S.Fio_stud

    , COUNT(O.Ozenk_a) AS [Количество экзаменов]
    , AVG(O.Ozenk_a) AS [Средний балл]
FROM
    Student S
    INNER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
GROUP BY
    S.Fio_stud
    Go


    SELECT
    S.FIO
    , S.Zarplata
    , Z.St_K
FROM
    Sotrudnik S
    INNER JOIN ZavKaf Z ON S.TabNom = Z.TabNom_K
    Go

    SELECT
    S.FIO,
    P.Stepen
FROM
    Sotrudnik S
INNER JOIN Prepodavatel P ON S.TabNom = P.TabNom_Pr
WHERE
    P.Stepen IN ('к.ф.-м.н.', 'д.ф.-м.н.')
    Go

    SELECT DISTINCT
        PR.Predmet AS Дисциплина
        , S.FIO
        , S.Dolgn
        , P.Stepen
        , O.data
        , O.Auditoria FROM
    Ozenka O
        INNER JOIN Predmet PR ON O.Kod = PR.kod_pred
        INNER JOIN Sotrudnik S ON O.Tab_Nom = S.TabNom
    INNER JOIN Prepodavatel P ON O.Tab_Nom = P.TabNom_Pr ORDER BY
        O.data
        Go

        SELECT
    S.fio
    , COUNT(O.data) AS [Количество экзаменов]
FROM
    Ozenka O
    INNER JOIN Sotrudnik S ON O.Tab_Nom = S.TabNom
GROUP BY
    S.fio
    Go


    SELECT
    S.Fio_stud
FROM
    Student S
    LEFT OUTER JOIN Ozenka O ON S.Reg_Nom = O.ReGNom
WHERE
    O.ReGNom IS NULL
    Go

    SELECT 
    S.Fio_stud, Sp.NaprSpez, K.NKaf, K.AbFak_Kaf
FROM 
    Student S
    INNER JOIN Spezialn Sp ON S.Nom_Spez_St = Sp.NSpez
    INNER JOIN Kafedra K ON Sp.Shifr_Spez = K.ShifrKaf
WHERE 
    K.AbFak_Kaf = 'ит';
    Go

SELECT S.TabNom, S.FIO, P.TabNom, P.FIO
FROM Sotrudnik S
LEFT JOIN Sotrudnik P on S.TabNom_ruk = P.TabNom  AND S.TabNom <> S.TabNom_ruk 
Go

SELECT S.Fio_stud, COUNT(*) AS [Количество экзаменов]
FROM Student S
INNER JOIN Ozenka O on S.Reg_Nom = O.RegNom
GROUP BY S.Fio_stud
HAVING COUNT(*) >= 2
Go

SELECT S.FIO, S.Zarplata FROM Sotrudnik S
INNER JOIN Ingener I on S.TabNom = I.TabNom_IN
WHERE S.Zarplata < 2000
Go

SELECT DISTINCT S.Fio_stud  FROM Student S
INNER JOIN Ozenka O on S.Reg_Nom = O.RegNom
WHERE O.Auditoria = 't505'
Go

SELECT S.Reg_Nom, S.Fio_stud, COUNT(*) AS [количество сданных экзаменов],
 AVG(O.Ozenk_A) AS [ср балл]
 FROM Student S
 INNER JOIN Ozenka O ON S.Reg_Nom = O.RegNom
 GROUP BY S.Fio_stud, S.Reg_Nom
 HAVING AVG(O.Ozenk_A)  >= 4
 Go

 SELECT S.FIO, S.Zarplata, P.Stepen FROM Sotrudnik S 
 INNER JOIN ZavKaf Z on S.TabNom = Z.TabNom_K
 INNER JOIN Prepodavatel P on Z.TabNom_K = P.TabNom_Pr
 Go

 SELECT S.FIO FROM Sotrudnik S 
 INNER JOIN Prepodavatel P on S.TabNom = P.TabNom_Pr
 WHERE P.Zvanie = 'профессор'
 Go

 SELECT Pr. Predmet, S.FIO, S.Dolgn, P.Stepen, O.data, O.Auditoria FROM Sotrudnik S
 INNER JOIN Prepodavatel P on S.TabNom = P.TabNom_Pr
 INNER JOIN Ozenka O ON S.TabNom = O.Tab_Nom   
INNER JOIN Predmet Pr ON O.Kod = Pr.kod_pred   
 WHERE O.data BETWEEN '2022-06-05' AND '2022-06-10'
 ORDER BY O.data ASC
 Go

 SELECT S.FIO, COUNT(*) AS [кол-во принятых экзаменов] FROM Sotrudnik S
 INNER JOIN Prepodavatel P on S.TabNom = P.TabNom_Pr
 INNER JOIN Ozenka O on P.TabNom_Pr = O.Tab_Nom
 GROUP BY S.FIO
 HAVING COUNT(*) >= 3
 Go

 SELECT S.Fio_stud 
FROM Student S 
LEFT JOIN Ozenka O ON S.Reg_Nom = O.ReGNom AND O.data = '2022-06-10'
WHERE O.ReGNom IS NULL;
Go