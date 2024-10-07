SELECT DB_NAME() AS current_database;
SELECT * FROM sys.schemas;
EXEC sp_columns 'customers';
EXEC sp_rename 'customers', 'costomers';
EXEC sp_rename 'dbo.customers.name', 'nombre_completo', 'COLUMN';
ALTER TABLE customers ALTER COLUMN genre VARCHAR(1);
INSERT INTO customers VALUES ('Yuly', 'Torres', '1000 11000', 21, '04-01-2001', 'F');

SELECT * FROM customers WHERE created_at >= '2024-10-05 00:00:00' 
						AND created_at <= '2024-10-05 11:31:59';

SELECT * FROM customers WHERE CONVERT(DATE, created_at) = '2024-10-05';
SELECT * FROM customers WHERE CAST(created_at AS DATE) = '2024-10-05';

SELECT * FROM customers WHERE CONVERT(TIME, created_at) BETWEEN '11:29:00' AND '11:33:00';
SELECT * FROM customers WHERE CAST(created_at AS TIME) BETWEEN '11:29:00' AND '11:33:00';

UPDATE customers SET lastName = REPLACE(lastName, 'leguizam?n', 'leguizamon');
int identity(5,5)

UPDATE customers SET earnings = FLOOR(1 + (RAND(CHECKSUM(NEWID())) * 100)) ;
SET profession_id = FLOOR(1 + (RAND(CHECKSUM(NEWID())) * 16));

SELECT lastName, count(lastName) no_persons FROM customers
	GROUP BY lastName
		HAVING  count(lastName) > 1;

BULK INSERT dbo.professions
	FROM 'D:\Uniandes\1_SQL\SQL SERVER PROJECT\modelo\professions.csv'
		WITH (
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '\n', 
			FIRSTROW = 2,
			CODEPAGE = '65001'
		);


WITH CustomerAges AS (
		SELECT *
			FROM [project_sql].[dbo].[customers]
	)
	SELECT customer_id, name, lastName, age
		FROM CustomerAges
	WHERE age > (SELECT AVG(age) FROM CustomerAges);