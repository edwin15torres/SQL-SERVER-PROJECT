USE project_sql;

/*--------------------TABLAS-------------------------------*/

-- customers--------------------------
-- profession_id
ALTER TABLE customers ADD profession_id INT;
GO

UPDATE customers
SET profession_id = FLOOR(1 + (RAND(CHECKSUM(NEWID())) * 16));
SELECT * FROM customers;

-- city_id
ALTER TABLE customers ADD city_id INT;
GO

UPDATE customers
SET city_id = FLOOR(1 + (RAND(CHECKSUM(NEWID())) * 4));
SELECT * FROM customers;

-- professions--------------------------
CREATE TABLE professions (
	[profession_id] int IDENTITY(1,1), 
	[name] varchar(30),
	[field] varchar(35)
	);

BULK INSERT dbo.professions
	FROM 'D:\Uniandes\1_SQL\SQL SERVER PROJECT\modelo\professions.csv'
		WITH (
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n', 
			FIRSTROW = 2,
			CODEPAGE = '65001'
		);

CREATE TABLE cities (
	[city_id] int IDENTITY(1,1), 
	[name] varchar(30)
	);

BULK INSERT dbo.cities
	FROM 'D:\Uniandes\1_SQL\SQL SERVER PROJECT\modelo\cities.csv'
		WITH (
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n', 
			FIRSTROW = 2,
			CODEPAGE = '65001'
		);

SELECT * FROM professions;
SELECT * FROM cities;

/*-------------------- INNER JOIN --------------------*/
-- Solo devuelve las filas que tienen coincidencias en ambas tablas.

-- Caso 1:
SELECT * FROM dbo.customers 
		INNER JOIN dbo.professions 
			ON customers.profession_id = professions.profession_id

-- Caso 2
SELECT * FROM dbo.customers AS c 
		INNER JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id

-- Caso 3:
SELECT CONCAT(c.name, ' ', c.lastName) AS completed_name, p.name AS profession_name
	FROM dbo.customers AS c 
		INNER JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id
	WHERE age > 30;

-- Caso 4:
SELECT CONCAT(c.name, ' ', c.lastName) AS completed_name, p.name AS profession_name, ci.name
	FROM dbo.customers AS c 
		INNER JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id
		INNER JOIN dbo.cities AS ci
			ON c.city_id = ci.city_id
	WHERE age > 30 AND ci.name = 'Cali'


/*-------------------- LEFT/RIGHT INNER JOIN --------------------*/

SELECT * FROM dbo.customers AS c 
		INNER JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id

-- LEFT OUTER JOIN: Devuelve todas las filas de la tabla de la izquierda (customers), y las filas coincidentes de la tabla de la derecha (professions). Si no hay coincidencia, las columnas de professions contendrán NULL   
SELECT * FROM dbo.customers AS c 
		LEFT JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id

SELECT * FROM dbo.customers AS c 
		RIGHT JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id


/*-------------------- FULL OUTER JOIN --------------------*/

-- FULL JOIN (o FULL OUTER JOIN): Devuelve todas las filas cuando hay coincidencias en cualquiera de las dos tablas. Si no hay coincidencia, las columnas de la tabla correspondiente tendrán NULL.

SELECT * FROM dbo.customers AS c 
		FULL JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id;


/*---------------------- CROSS JOIN ------------------------*/

-- CROSS JOIN: Devuelve el producto cartesiano de las dos tablas, lo que significa que cada fila de la tabla customers se combina con todas las filas de la tabla professions.
SELECT * FROM dbo.customers AS c 
		CROSS JOIN dbo.professions AS p;



/*-------------------------- ANTI JOIN ----------------------------*/

SELECT * FROM dbo.customers AS c 
		LEFT JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id
		WHERE p.profession_id IS NULL;

SELECT * FROM dbo.customers AS c 
		RIGHT JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id
		WHERE c.profession_id IS NULL;

SELECT * FROM dbo.customers AS c 
		FULL JOIN dbo.professions AS p
			ON c.profession_id = p.profession_id
		WHERE c.profession_id IS NULL
		OR p.profession_id IS NULL;

