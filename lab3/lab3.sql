USE Ucheb_11_Kravchenko
SELECT Nazvanie
      ,Stolica
      ,PL
      ,KolNas
      ,Kontinent
      ,ROUND(CAST(KolNas AS FLOAT) * 100 /
(
        SELECT
            SUM(KolNas)
        FROM
            Tabl_Kontinent$
        ), 3)
        AS Процент
FROM
    Tabl_Kontinent$
ORDER BY Процент DESC
Go

SELECT Nazvanie
      ,Stolica
      ,PL
      ,KolNas
      ,Kontinent
FROM
    Tabl_Kontinent$
WHERE
    KolNas > ( SELECT AVG(KolNas) FROM Tabl_Kontinent$)
    Go

SELECT  Nazvanie
      ,Stolica
      ,PL
      ,KolNas
      ,Kontinent
FROM
(
    SELECT
        Nazvanie
      ,Stolica
      ,PL
      ,KolNas
      ,Kontinent
    FROM
        Tabl_Kontinent$
    WHERE
        Nazvanie = 'Африка') A
WHERE
    KolNas > 50000000
Go

SELECT  Nazvanie
      ,Stolica
      ,PL
      ,KolNas
      ,Kontinent
      ,ROUND(CAST(KolNas AS FLOAT) * 100 /
      (
          SELECT
              SUM(KolNas)
          FROM
              Tabl_Kontinent$ B
          WHERE
              A.Kontinent = B.Kontinent
      ), 3) AS Процент
FROM
    Tabl_Kontinent$ A
ORDER BY
    Процент DESC
    Go

    SELECT  Nazvanie
      ,Stolica
      ,PL
      ,KolNas
      ,Kontinent
FROM
    Tabl_Kontinent$ A WHERE
    KolNas > (
        SELECT
            AVG(KolNas)
        FROM
            Tabl_Kontinent$ B
        WHERE
            B.Kontinent = A.Kontinent
        )
        Go

SELECT
    Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$ WHERE
    Kontinent IN (
        SELECT
            Kontinent       FROM
            Tabl_Kontinent$
        GROUP BY
            Kontinent       HAVING
            AVG(KolNas) > (
                SELECT
                    AVG(KolNas)
                FROM
                    Tabl_Kontinent$
                )
        )
        Go

SELECT
Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$ WHERE

    Kontinent = 'Азия'
    AND
    KolNas > ALL (
        SELECT  KolNas
        FROM  Tabl_Kontinent$
        WHERE
            Kontinent = 'Европа'
        )
        Go

    SELECT
Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$ WHERE
    Kontinent = 'Европа'
    AND
    KolNas > ANY (
        SELECT
        KolNas             FROM
        Tabl_Kontinent$
        WHERE
            Kontinent = 'Южная Америка'
        )
        Go

      
SELECT
Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$ WHERE
    Kontinent = 'Африка'
    AND
    EXISTS (
        SELECT
        *
        FROM
        Tabl_Kontinent$ WHERE
            Kontinent = 'Африка'
            AND
            KolNas > 100000000
        )
        Go

     
SELECT
Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$
WHERE
    Kontinent = (
        SELECT
        Kontinent
        FROM
        Tabl_Kontinent$
        WHERE
            Nazvanie = 'Ангола'
        )
        Go

    SELECT
Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$
WHERE

KolNas !> (
        SELECT
        KolNas
        FROM
        Tabl_Kontinent$
        WHERE
            Nazvanie = 'Ангола'
        )
        Go



SELECT
Nazvanie
    ,Stolica
    ,PL
    ,KolNas
    ,Kontinent
FROM
    Tabl_Kontinent$
WHERE
KolNas = (
        SELECT
            MAX(Мин_Hac)
        FROM
            (
            SELECT
                MIN(KolNas) AS Мин_Hac
            FROM
                Tabl_Kontinent$
            GROUP BY
                Kontinent
            ) A
        )
    Go

--Самостоятельная работа

SELECT Nazvanie,Stolica,PL,KolNas,Kontinent,
ROUND(CAST(PL AS FLOAT) * 100 /
(
        SELECT SUM(PL)
        FROM Tabl_Kontinent$), 3)
        AS Процент
FROM Tabl_Kontinent$
ORDER BY Процент DESC
Go

SELECT Nazvanie,Stolica,PL,KolNas,Kontinent,
ROUND(CAST(KolNas AS FLOAT) / PL, 3)
        AS Плотность
FROM Tabl_Kontinent$
WHERE CAST(KolNas AS FLOAT) / PL > (SELECT CAST(SUM(KolNas) AS FLOAT) / SUM(PL) FROM Tabl_Kontinent$)
Go

SELECT  Nazvanie,Stolica,PL ,KolNas,Kontinent
FROM
(
    SELECT
        Nazvanie,Stolica,PL,KolNas ,Kontinent
    FROM Tabl_Kontinent$
    WHERE Kontinent = 'Европа') A
WHERE KolNas < 5000000
Go


SELECT  Nazvanie,Stolica,PL,KolNas,Kontinent,ROUND(CAST(PL AS FLOAT) * 100 /
      (
          SELECT SUM(PL)
          FROM Tabl_Kontinent$ B
          WHERE A.Kontinent = B.Kontinent
      ), 3) AS Процент
FROM Tabl_Kontinent$ A
ORDER BY Процент DESC
    Go

SELECT  Nazvanie,Stolica,PL,KolNas,Kontinent
FROM Tabl_Kontinent$ A
WHERE PL > (
SELECT AVG(PL)  FROM Tabl_Kontinent$ B
WHERE A.Kontinent = B.Kontinent)
Go


SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$ A
WHERE (
    SELECT AVG(CAST(KolNas AS FLOAT) / PL) 
    FROM Tabl_Kontinent$ B 
    WHERE A.Kontinent = B.Kontinent
) > (
    SELECT CAST(SUM(KolNas) AS FLOAT) / SUM(PL) 
    FROM Tabl_Kontinent$
)
Go

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE Kontinent = 'Южная Америка' AND
KolNas > ALL (SELECT KolNas FROM Tabl_Kontinent$ WHERE Kontinent = 'Африка')
Go

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка' AND
KolNas > ANY (SELECT KolNas FROM Tabl_Kontinent$ WHERE Kontinent = 'Южная Америка')
Go

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка' AND
EXISTS (SELECT * FROM Tabl_Kontinent$
WHERE Kontinent = 'Африка'AND PL > 2000000)
Go

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE Kontinent = (
SELECT Kontinent FROM Tabl_Kontinent$ WHERE Nazvanie = 'Фиджи')
Go

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas <= (
SELECT KolNas FROM Tabl_Kontinent$ WHERE Nazvanie = 'Фиджи')
Go

SELECT Nazvanie, Stolica, PL, KolNas, Kontinent
FROM Tabl_Kontinent$
WHERE KolNas = (
SELECT MAX(KolNas_new) FROM (SELECT KolNas AS KolNas_new FROM Tabl_Kontinent$ 
WHERE PL IN (SELECT MIN(PL) FROM Tabl_Kontinent$
GROUP BY Kontinent)) A )

Go