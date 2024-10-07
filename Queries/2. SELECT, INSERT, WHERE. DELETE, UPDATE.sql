USE project_sql;

/*----------------------------INSERT---------------------------*/

EXEC sp_columns 'customers';

/*Valores completos*/

INSERT INTO customers VALUES ('Esperanza', 'Leguizam�n', '3115096815', 49, '10/28/1965', 'F');
INSERT INTO customers VALUES ('Yuly', 'Torres', '1000 11000', 21, '04-01-2001', 'F');
INSERT INTO customers VALUES ('Edwin', 'Torres', '3125516418', 31, '07-15-1991', 'M');
INSERT INTO customers VALUES ('Gustavo', 'Torres', '3014444523', 31, '12/05/1969', 'M')

/*Nulos o espacios*/
INSERT INTO customers VALUES ('Esperanza', 'Leguizam_n', '3115096815', 49, CONVERT(DATE,'10/28/1986'), null)

INSERT INTO  customers ([name], lastName, phone, age, birthdate)
						VALUES	('Mayerly', 'Munoz', '3153291538', 35, '06/11/1986' ),
								('Mayerly', 'Munoz', '3153291538', 35, '06-11-1986' )

INSERT INTO customers VALUES ('Gustavo', 'Torres', '3014444523', 31, '12/05/1969', NULL);
INSERT INTO customers VALUES ('Esperanza', '', '3115096815', 49, '10/28/1986', null)


/*----------------------------GETDATE()---------------------------*/
ALTER TABLE [project_sql].[dbo].[customers] ADD created_at DATETIME DEFAULT GETDATE();

INSERT INTO  customers ([name], lastName, phone, age)
						VALUES	('Miriam', 'Zapata', '3153291538', 31 );

SELECT * FROM customers;

-- ALTER TABLE customers DROP COLUMN created_at;
-- ALTER TABLE [project_sql].[dbo].[customers] DROP CONSTRAINT DF__customers__creat__48CFD27E;
-- ALTER TABLE customers DROP COLUMN created_at;


/*----------------------------SELECT ---------------------------*/

SELECT *  FROM INFORMATION_SCHEMA.TABLES 
			WHERE TABLE_NAME = 'customers';

SELECT COUNT(name) [count], AVG(age) [average], MAX(age) [maz], MIN(age) [min]
FROM customers;

SELECT SUM(age) FROM customers;

SELECT LEN(name) FROM customers;

SELECT * FROM customers;
SELECT COUNT(*) FROM customers;
SELECT DISTINCT[name],[lastName] FROM customers;
SELECT COUNT(DISTINCT CONCAT(name, lastName)) FROM customers;

SELECT TOP (3) * FROM [project_sql].[dbo].[customers];

ALTER TABLE [project_sql].[dbo].[customers] ADD customer_id INT IDENTITY(1,1);  
GO

SELECT TOP (3) * FROM [project_sql].[dbo].[customers]
	ORDER BY customer_id DESC;


/*----------------------------WHERE---------------------------*/

SELECT * FROM customers WHERE genre IS NULL
SELECT * FROM customers WHERE genre IS NOT NULL
SELECT * FROM customers WHERE lastName = ''
SELECT * FROM customers WHERE age = 31
SELECT * FROM customers WHERE lastName = 'Torres'
SELECT * FROM customers WHERE lastName LIKE   '%u%'
SELECT * FROM customers WHERE [name] LIKE   'E%'
SELECT * FROM customers WHERE [name] LIKE   '%y'
SELECT * FROM customers WHERE age >= 31 AND [name] = 'Edwin'
SELECT * FROM customers WHERE  genre IS NULL or age > 40

--- OR--

SELECT * FROM customers WHERE created_at >= '2024-10-05 00:00:00' 
						AND created_at <= '2024-10-05 11:31:59';

SELECT * FROM customers WHERE CONVERT(DATE, created_at) = '2024-10-05';
SELECT * FROM customers WHERE CAST(created_at AS DATE) = '2024-10-05';

SELECT * FROM customers WHERE CONVERT(TIME, created_at) BETWEEN '11:29:00' AND '11:33:00';
SELECT * FROM customers WHERE CAST(created_at AS TIME) BETWEEN '11:29:00' AND '11:33:00';



/*----------------------------DELETE---------------------------*/

DELETE FROM customers WHERE lastName = 'Torres'
DELETE FROM customers WHERE genre = ''
DELETE FROM customers WHERE age < 40;
DELETE FROM customers WHERE birthdate IS NULL

/*DELETE an especific row*/
SELECT * FROM customers;

;WITH CTE AS ( SELECT *, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS row_num FROM customers )
DELETE FROM CTE WHERE row_num = 5;

SELECT * FROM customers;


/*----------------------------TRUNCATE---------------------------*/

-- DELETE FROM customers;
-- TRUNCATE TABLE customers;


/*------------------------------ UPDATE --------------------------*/

UPDATE customers SET lastName = REPLACE(lastName, 'leguizam?n', 'leguizamon');
UPDATE customers SET lastName ='Leguizamon' WHERE lastName = 'Leguizam_n'

UPDATE customers SET age = 52 WHERE [name] = 'Gustavo' AND [lastName] = 'Torres'

UPDATE customers SET name = 'Andrea', lastName='Leguizamon' WHERE age = 21
UPDATE customers SET phone = '3125516418' WHERE lastName = 'Torres' AND  name = 'Gustavo'
UPDATE customers SET age = 50 WHERE age = 31 AND name = 'Gustavo';

SELECT * FROM customers


/*---------------------------- ID & NOT NULL-----------------------*/

/*Indentity: campo autonumerico*/
CREATE TABLE usuario( 
    id int identity, 
    name varchar(30));

INSERT INTO usuario VALUES('Ramon')
INSERT INTO usuario VALUES('Josefa')
INSERT INTO usuario VALUES('Julian')
INSERT INTO usuario VALUES('Angela')
INSERT INTO usuario VALUES('Juliana')
INSERT INTO usuario VALUES(NULL)

SELECT * FROM usuario;

DROP TABLE usuario;

CREATE TABLE usuario(
     id int identity(5,5), 
     name varchar(30) NOT NULL)

INSERT INTO usuario VALUES('Ramon')
INSERT INTO usuario VALUES('Josefa')
INSERT INTO usuario VALUES('Julian')
INSERT INTO usuario VALUES('Angela')
INSERT INTO usuario VALUES('Juliana')
INSERT INTO usuario VALUES(NULL)

SELECT * FROM usuario;

/*------------------------BULK INSERT---------------------------*/

DROP TABLE customers;

CREATE TABLE customers (
	[customer_id] int, 
	[name] varchar(30),
	[lastName] varchar(30),
	[phone] varchar(30),
	[age] int,
	[birthdate] date,
	genre varchar(3)
	);

-- Verifica si el directorio existe
EXEC xp_fileexist 'D:\Uniandes\1_SQL\SQL SERVER PROJECT\modelo\customers.csv';

BULK INSERT dbo.customers
	FROM 'D:\Uniandes\1_SQL\SQL SERVER PROJECT\modelo\customers.csv'
		WITH (
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n', 
			FIRSTROW = 2,
			CODEPAGE = '65001'
		);

SELECT * FROM customers;


-- bcp "SELECT * FROM dbo.customers" queryout "D:\Uniandes\1_SQL\SQL Server\Scripts\customers_export.csv" -c -t, -T -S "DESKTOP-US0NNJK"
-- bcp "SELECT * FROM dbo.customers" queryout "D:\Uniandes\1_SQL\SQL Server\Scripts\customers_export.csv" -c -t, -U "tuUsuario" -P "tuContraseña" -S "NombreServidorSQL"
-- bcp dbo.customers out 'D:\Uniandes\1_Platzi\0. SQL\SQL Server\Scripts\exported_customers.csv' -c -t',' -T




