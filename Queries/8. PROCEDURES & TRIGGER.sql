USE project_sql;

SELECT * FROM customers;
SELECT * FROM professions;
SELECT * FROM cities;

/*-------------------- PROCEDURES --------------------*/

/*-------------------- SELECT --------------------*/
/* Example # 1 */

CREATE PROCEDURE show_information_cities
AS
BEGIN
	SELECT * FROM cities;
END;

EXECUTE show_information_cities

/* Example # 2: Where */

CREATE PROC show_information_cities2
@city_id INT
AS
BEGIN
	SELECT * FROM cities WHERE city_id = @city_id
END;

EXECUTE show_information_cities2 2


/*-------------------- INSERT --------------------*/

CREATE PROCEDURE InsertCustomer
    @customer_id INT,
    @name VARCHAR(30),
    @lastName VARCHAR(30),
    @phone VARCHAR(30),
    @age INT,
    @birthdate DATE,
    @genre CHAR(1),
    @earnings DECIMAL(18, 2),
    @expenditures DECIMAL(18, 2),
    @profession_id INT,
    @city_id INT
AS
BEGIN
    INSERT INTO [project_sql].[dbo].[customers] 
		(customer_id,name,lastName,phone,age,birthdate,genre,earnings,expenditures,profession_id,city_id
		)
    VALUES (
        @customer_id,@name,@lastName,@phone,@age,@birthdate,@genre,@earnings,@expenditures,@profession_id,@city_id
		);
END;

SELECT * FROM customers;

EXEC InsertCustomer 
    @customer_id = 9,
    @name = 'Matias',
    @lastName = 'Zoe',
    @phone = '333-1234',
    @age = 30,
    @birthdate = '1990-01-15',
    @genre = 'M',
    @earnings = 50000.00,
    @expenditures = 20000.00,
    @profession_id = 1,
    @city_id = 1;

-- Check
SELECT * FROM customers;
 

/*-------------------- UPDATED --------------------*/

CREATE PROCEDURE UpdateCustomer
    @customer_id INT,
    @name VARCHAR(30) = NULL,
    @lastName VARCHAR(30) = NULL,
    @phone VARCHAR(30) = NULL,
    @age INT = NULL,
    @birthdate DATE = NULL,
    @genre CHAR(1) = NULL,
    @earnings DECIMAL(18, 2) = NULL,
    @expenditures DECIMAL(18, 2) = NULL,
    @profession_id INT = NULL,
    @city_id INT = NULL
AS
BEGIN
    UPDATE [project_sql].[dbo].[customers]
    SET
        name = COALESCE(@name, name),
        lastName = COALESCE(@lastName, lastName),
        phone = COALESCE(@phone, phone),
        age = COALESCE(@age, age),
        birthdate = COALESCE(@birthdate, birthdate),
        genre = COALESCE(@genre, genre),
        earnings = COALESCE(@earnings, earnings),
        expenditures = COALESCE(@expenditures, expenditures),
        profession_id = COALESCE(@profession_id, profession_id),
        city_id = COALESCE(@city_id, city_id)
    WHERE customer_id = @customer_id;
END;

EXEC UpdateCustomer 
    @customer_id = 9,
    @name = 'John',
    @lastName = 'Smith',  -- Cambia el apellido
    @phone = NULL,        -- No se actualiza
    @age = 31,            -- Cambia la edad
    @birthdate = NULL,    -- No se actualiza
    @genre = 'M',         -- Se mantiene el género
    @earnings = 55000.00, -- Cambia los ingresos
    @expenditures = NULL, -- No se actualiza
    @profession_id = NULL, -- No se actualiza
    @city_id = 2;         -- Cambia la ciudad

-- Check
SELECT * FROM customers;
 



/*-------------------- DELETE --------------------*/

CREATE PROCEDURE DeleteCustomer
    @customer_id INT
AS
BEGIN
    DELETE FROM [project_sql].[dbo].[customers]
    WHERE customer_id = @customer_id;
END;

EXEC DeleteCustomer 
    @customer_id = 9;

-- Check
SELECT * FROM customers;



/*-------------------- TIGRERS (INSERT) --------------------*/


CREATE TABLE customer_audit (
    audit_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    inserted_at DATETIME
);


CREATE TRIGGER trg_after_insert_customers
ON customers
AFTER INSERT
AS
BEGIN
    -- Insertar el ID del nuevo cliente y la fecha actual en la tabla de auditoría
    INSERT INTO customer_audit (customer_id, inserted_at)
    SELECT i.customer_id, GETDATE()
    FROM inserted i;
END;

--- Check
INSERT INTO customers (customer_id, name, lastName, phone, age, birthdate, genre, earnings, expenditures, profession_id, city_id)
VALUES (10, 'John', 'Doe', '555-1234', 30, '1993-04-16', 'M', 50000, 20000, 1, 101);


SELECT * FROM customer_audit;




Create database sales;
use sales

create table sales (
[id_sale] int identity (1,1) primary Key,
[datetime] date,
[amount] int,
[totalSale] money);

create table stock (
[id_sale] int identity (1,1),
[total] int);

select * from sales;
select * from stock;

insert into sales values('04/16/2022', 25, 100000);
insert into sales values('04/16/2022', 10, 20000);
insert into sales values('04/16/2022', 30, 150000);

insert into stock values(15000);

/*--- trigger -----*/
create trigger total_stock
on sales 
for insert
as
begin
update stock set total = (select  sum(totalSale) from sales)
end

/*--- execute trigger -----*/
insert into sales values(getdate(), 40, 50000)