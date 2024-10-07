USE project_sql;

SELECT * FROM customers;

ALTER TABLE dbo.customers ADD earnings INT;
GO
ALTER TABLE dbo.customers ADD expenditures INT;
GO

--ALTER TABLE dbo.customers DROP COLUMN earnings;
--ALTER TABLE dbo.customers DROP COLUMN expenditures;

UPDATE customers SET earnings = FLOOR(1 + (RAND(CHECKSUM(NEWID())) * 100)) *100000;
UPDATE customers SET expenditures = FLOOR(1 + (RAND(CHECKSUM(NEWID())) * 100)) *10000 ;
SELECT * FROM customers;


/*--------------------CONCAT & CASTEO ----------------------*/

SELECT 'El ingreso de '+ CONCAT(name,' ' ,  lastName) + ' es ' + CAST(earnings AS VARCHAR(10))  AS 'Description' FROM customers;


/*--------------------TO OPERATE COLUMNS--------------------*/

SELECT CONCAT(name,' ' ,  lastName) nombre_completo, earnings, expenditures, (earnings - expenditures) savings 
	FROM customers;

SELECT CONCAT(name,' ' ,  lastName) nombre_completo, expenditures, expenditures *0.1  tasa
	FROM customers;

UPDATE customers SET  expenditures = expenditures *0.8 
SELECT * FROM customers;


/* To add a column with operator --------------------------- */
ALTER TABLE customers ADD savings int;
GO
SELECT * FROM customers;

UPDATE customers SET savings = earnings - expenditures
SELECT * FROM customers;

/* To delete a column  ------------------------------------- */
ALTER TABLE customers DROP COLUMN savings;
SELECT * FROM customers;

/*--------------------OPERATORS--------------------------------*/

SELECT COUNT(customer_id) [count] FROM customers WHERE earnings < 3000000;

SELECT * FROM customers WHERE NOT customer_id = 4
SELECT * FROM customers WHERE customer_id != 4

SELECT * FROM customers WHERE lastName = 'Smith' OR age < 30 
SELECT * FROM customers WHERE lastName = 'Smith' AND age < 30 
SELECT * FROM customers WHERE earnings > 3000000 and  age < 40
SELECT * FROM customers WHERE lastName = 'Smith' OR age < 30  ORDER BY [name] DESC

/* BETWEEN  --------------------------------------- */

SELECT * FROM customers WHERE age BETWEEN 25 AND 35;


/*--------------------GROUP BY--------------------------------*/

SELECT lastName, count(lastName) no_persons FROM customers
	GROUP BY lastName;


/*--------------------HAVING--------------------------------*/

SELECT lastName, count(lastName) no_persons FROM customers
	GROUP BY lastName
		HAVING  count(lastName) > 1;


