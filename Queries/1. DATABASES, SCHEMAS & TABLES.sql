SELECT @@VERSION;
GO
/*--------------------DATABASES--------------------*/

CREATE DATABASE project_sql;
GO

SELECT * FROM sys.databases 
	WHERE NAME LIKE '%sql%';

SELECT DB_NAME() AS current_database;


/*--------------------SCHEMAS--------------------*/

USE project_sql;
GO

CREATE SCHEMA dominio;
GO
-- CREATE SCHEMA schema_name AUTHORIZATION owner_name;
-- DROP SCHEMA dominio;
-- ALTER AUTHORIZATION ON SCHEMA::ventas TO juan;

SELECT * FROM sys.schemas;


/*--------------------TABLES--------------------*/

CREATE TABLE customers (
	[name] VARCHAR(30),
	[lastName] VARCHAR(30),
	[phone] VARCHAR(30),
	[age] INT,
	[birthdate] DATE);

CREATE TABLE dominio.customers (
	[name] VARCHAR(30),
	[lastName] VARCHAR(30),
	[phone] VARCHAR(30),
	[age] INT,
	[birthdate] DATE);

-- DROP TABLE dominio.customers;

SELECT * FROM sys.tables
	 WHERE name like '%to%'; 

/*--------------------OBJECT TYPES & COLUMNS--------------------*/

SELECT name, system_type_id, user_type_id
	FROM sys.types;

SELECT name, column_id, system_type_id, max_length, is_nullable FROM sys.columns
		WHERE object_id = OBJECT_ID('dominio.customers');

/*----------------------------------------------------------------*/
SELECT c.name AS column_name, t.name AS data_type, c.max_length, c.is_nullable
	FROM sys.columns c
	JOIN sys.types t 
		ON c.system_type_id = t.system_type_id
	WHERE c.object_id = OBJECT_ID('dominio.customers');

EXEC sp_columns 'customers';

/*To rename a table*/
EXEC sp_rename 'customers', 'costomers';
EXEC sp_rename 'costomers', 'customers';

/*To rename a column*/
EXEC sp_rename 'dbo.customers.name', 'nombre_completo', 'COLUMN';
EXEC sp_rename 'dbo.customers.nombre_completo', 'name', 'COLUMN';

/*Add, edit or delete a column*/
ALTER TABLE customers ADD genre VARCHAR(1);
ALTER TABLE customers ALTER COLUMN genre INT;
ALTER TABLE customers ALTER COLUMN genre VARCHAR(1);
ALTER TABLE customers DROP COLUMN genre;

ALTER TABLE customers ADD genre VARCHAR(1);



USE master;
DROP DATABASE project_sql;