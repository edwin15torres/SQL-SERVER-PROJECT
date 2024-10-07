USE project_sql;

SELECT * FROM customers;
SELECT * FROM professions;
SELECT * FROM cities;

/* -----------------SUBQUERIES----------------------------  */

/*  -------------- Example # 1: Comparar con un valor ------------ */
SELECT CONCAT(name,' ' , lastName) AS Persona ,earnings FROM customers
	WHERE earnings > (SELECT AVG(earnings) FROM customers)


/*  -------------- Example # 2: Comparar con una lista - INCLUYENTE ------------*/
/*  IN  */

SELECT CONCAT(name,' ' , lastName) AS Persona, profession_id  FROM customers
	WHERE profession_id IN (SELECT profession_id FROM professions WHERE field NOT LIKE '%ing');

/*  ANY  */

SELECT CONCAT(name,' ' , lastName) AS Persona, profession_id  FROM customers
	WHERE profession_id =  ANY (SELECT profession_id FROM professions WHERE field NOT LIKE '%ing');

/*  -------------- Example # 3: Comparar con una lista - EXCLUYENTE ------------*/
/*  NOT IN  */

SELECT CONCAT(name,' ' , lastName) AS Persona, profession_id  FROM customers
	WHERE profession_id NOT IN (SELECT profession_id FROM professions WHERE field NOT LIKE '%ing');

	
/*  ALL  */
SELECT CONCAT(name,' ' , lastName) AS Persona, profession_id  FROM customers
	WHERE profession_id <> all (SELECT profession_id FROM professions WHERE field NOT LIKE '%ing');



/*  WITH  */

-- 1) Puedes dividir la consulta en partes más manejables, facilitando su comprensión.
-- 2) Es especialmente útil si necesitas hacer múltiples operaciones sobre un mismo conjunto de datos.
-- 3) Útil en consultas que requieren agrupaciones, filtros o cálculos intermedios.
-- 4) Puedes calcular totales o promedios en una CTE y luego utilizar esos resultados en una consulta principal.


-- #1 --------------------------------------------
	WITH CustomerAges AS (
		SELECT *
			FROM [project_sql].[dbo].[customers]
	)
	SELECT customer_id, name, lastName, age
		FROM CustomerAges
	WHERE age > (SELECT AVG(age) FROM CustomerAges);


-- #2 --------------------------------------------
	WITH CustomerEarnings AS (
		SELECT *
		FROM [project_sql].[dbo].[customers]
	)

	SELECT TOP (1000) customer_id, name, lastName, phone, age, birthdate, genre, earnings
		FROM CustomerEarnings
	WHERE earnings > (SELECT AVG(earnings) FROM CustomerEarnings);
