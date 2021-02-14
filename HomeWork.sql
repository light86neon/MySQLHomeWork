# 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
SELECT * FROM client WHERE LENGTH(FirstName) < 6;

# 2. +Вибрати львівські відділення банку.+
SELECT * FROM department WHERE DepartmentCity = 'Lviv';

# 3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
SELECT * FROM client WHERE Education = 'high';

# 4. +Виконати сортування у зворотньому порядку над таблицею Заявка
# і вивести 5 останніх елементів.
SELECT * FROM application ORDER BY idApplication DESC LIMIT 5;

#5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
SELECT * FROM client
WHERE (LastName LIKE '%OV')
OR (LastName LIKE '%OVA');

# 6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
SELECT * FROM department WHERE DepartmentCity = 'Kyiv';

# -- 7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.
SELECT FirstName, Passport FROM client ORDER BY FirstName;

# 8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
SELECT * FROM application LEFT JOIN client ON idClient= idApplication WHERE CreditState = 'Not returned' AND  sum > 5000;

#9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
SELECT COUNT(idClient) FROM client WHERE Department_idDepartment = 2;

#10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
SELECT Sum, Client_idClient, LastName FROM application JOIN client ON Client_idClient GROUP BY Client_idClient ;

# 11. Визначити кількість заявок на крдеит для кожного клієнта.
SELECT Client_idClient, FirstName, Sum FROM client AS c JOIN application as a ON c.idClient = a.Client_idClient GROUP BY FirstName;

# 12. Визначити найбільший та найменший кредити.
SELECT max(Sum), min(Sum) FROM application;

#13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
 SELECT COUNT(app.Sum) FROM application app JOIN client ON client.idClient = app.Client_idClient WHERE Education ='high';

#14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
SELECT *, AVG(application.Sum) AS sumAVG
FROM client
JOIN application ON client.idClient = application.idApplication
GROUP BY idClient
ORDER BY sumAVG DESC LIMIT 1;

#15. Вивести відділення, яке видало в кредити найбільше грошей
SELECT d.idDepartment, d.DepartmentCity, SUM(a.Sum) FROM department d
JOIN client c ON d.idDepartment = c.Department_idDepartment
JOIN application a ON c.idClient = a.Client_idClient
GROUP BY d.DepartmentCity ORDER BY SUM(a.Sum) DESC LIMIT 1;

#16. Вивести відділення, яке видало найбільший кредит.
SELECT DepartmentCity FROM application
JOIN department ON application.idApplication = department.idDepartment
ORDER BY Sum DESC
LIMIT 1;

#17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
UPDATE application, client SET application.Sum = '6000'
WHERE client.idClient = application.Client_idClient
AND client.Education ='high';

#18. Усіх клієнтів київських відділень пересилити до Києва.
UPDATE client
SET city = 'Kyiv'
WHERE NOT city = 'Kyiv';

#19. Видалити усі кредити, які є повернені.
DELETE FROM application WHERE CreditState LIKE 'R%';


#20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.
DELETE FROM client WHERE FirstName LIKE '_[a,e,i,o,u]%';

/* Знайти максимальний неповернений кредит.*/
SELECT MAX(Sum) AS Debitor FROM application
WHERE CreditState LIKE 'Not returned';

/*Знайти клієнта, сума кредиту якого найменша*/
SELECT idclient FROM application
JOIN client ON application.client_idClient = client.idClient
ORDER BY Sum LIMIT 1;

#місто чувака який набрав найбільше кредитів
SELECT City FROM client  JOIN application a
ON idClient = Client_idClient
GROUP BY City ORDER BY COUNT(a.Sum)
DESC LIMIT 1;
