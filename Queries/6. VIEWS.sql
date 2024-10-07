USE project_sql;

SELECT * FROM customers;
SELECT * FROM professions;
SELECT * FROM cities;

/* -----------------CREATE VIEW----------------------------  */

-- #1 -----------------------------------------
CREATE VIEW customers_list
	AS
	SELECT name, lastName, genre FROM customers;

-- Check list
SELECT * FROM customers_list

-- #2 -----------------------------------------
CREATE VIEW dominio.customers_list
	AS
	SELECT name, lastName, age FROM dominio.customers;

-- Check list
SELECT * FROM dominio.customers_list

INSERT INTO [dominio].[customers] (name, lastName, phone, age, birthdate)
VALUES
    ('John', 'Doe', '555-1234', 30, '1992-05-15'),
    ('Jane', 'Smith', '555-5678', 25, '1997-10-20'),
    ('Michael', 'Johnson', '555-9012', 40, '1982-03-08');

SELECT * FROM dominio.customers_list

/* -----------------ALTER VIEW----------------------------  */

ALTER VIEW dominio.customers_list
	AS
	SELECT LastName, age FROM dominio.customers;

SELECT * FROM dominio.customers_list

/* how to read the query structure  */
sp_helptext customers_list

/* -----------------DROP VIEW----------------------------  */

DROP VIEW dominio.customers_list;


/* how to encryprt the query structure  */
CREATE VIEW dominio.customers_list with encryption
	AS
	SELECT name, lastName, age FROM dominio.customers;

SELECT * FROM dominio.customers_list



/* -----------------UPDATE VIEW----------------------------  */

-- #1 -----------------------------------------
UPDATE dominio.customers_list SET age = 100  WHERE	lastName = 'Smith'
SELECT * FROM dominio.customers_list
SELECT name, lastName, age FROM dominio.customers

-- #2 -----------------------------------------
/* using "check option"  */
CREATE VIEW dominio.customers_list2
	AS
	SELECT name, lastName, age FROM dominio.customers
	WHERE	lastName = 'Smith'
	WITH CHECK OPTION

SELECT * FROM dominio.customers_list2

INSERT INTO dominio.customers_list2 values ( 'juan','Smith',13)
/* the previos command works well */
INSERT INTO dominio.customers_list2 values ( 'juan','Otro',16)
/* the previos command doesn't work well */


-- #3 -----------------------------------------
/* without "check option"  */
CREATE VIEW dominio.customers_list3
	AS
	SELECT name, lastName, age FROM dominio.customers
	WHERE	lastName = 'Smith'

SELECT * FROM dominio.customers_list3

INSERT INTO dominio.customers_list3 values ( 'juan','Smith',13)
/* the previos command works well */
INSERT INTO dominio.customers_list3 values ( 'juan','Otro',16)
/* the previos command doesn't work well */

SELECT * FROM dominio.customers_list3