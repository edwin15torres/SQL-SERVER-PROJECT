
/*Advanced Tutorials*/
/* https://www.youtube.com/watch?v=sG96DG_087I&list=PLi0CO7zvTezTiNH7kQz99h36j0rm0lWSM&index=7  */

/* -----------------SELECTIVE STRUCTURE----------------------------  */

use hardware_store;
select * from products

/* ----------------- IF ----------------------------  */
/* the following command answer the first option*/
declare 
	@brand varchar(30) = 'Tropical',
	@description varchar(30) = 'Martillo',
	@purchasePrice int = 200,
	@salePrice int = 300

if exists (select * from products where description = @description)
	begin
		print 'Already registered product'
	end
else
	begin
		insert into products values (@brand, @description, @purchasePrice, @salePrice)
		print 'Correctly registered product'
	end;

/* the following command answer the second option*/
declare 
	@brand varchar(30) = 'Tropical',
	@description varchar(30) = 'Thiner',
	@purchasePrice int = 200,
	@salePrice int = 300

if exists (select * from products where description = @description)
	begin
		print 'Already registered product'
	end
else
	begin
		insert into products values (@brand, @description, @purchasePrice, @salePrice)
		print 'Correctly registered product'
	end;

/* ----------------- CASE ----------------------------  */
use company;
select * from employees

/*  Example # 1 */
select id_employee, name, title, condition = 
case title
	when 'representante' then 'Es la cara de la empresa'
	when 'dir ventas' then 'Encargado de ventas'
	when 'dir general' then 'El jefe de la empresa'
	else 'No hay informacion del título'
	end
from employees

/*  Example # 2 */
select id_employee, name, office, Result = 
case
	when quota > sales then 'La cuota es MAYOR que la venta'
	when quota < sales then 'La cuota es menor que la venta'
	else 'No hay informacion de la couta del empleado'
	end
from employees

/* ----------------- WHILE ---------------------------  */
use company;

/*  Example # 1 */
declare @h int;
set @h = 0;

while @h <= 5
	begin
		print 'El valor es ' + cast(@h as char(3))
	    set @h = @h +1 
	end;
go

/*  Example # 2 */
declare @h int;
set @h = 0;

while @h <= 5
	begin
		print 'El valor es ' + cast(@h as char(3))
        if @h = 3
        break;
        else
	    set @h = @h +1 
	end;
go




/* -----------------TRY CATCH----------------------------  */

/* the following command works well */
begin try 
	declare @payment int 
	set @payment = 300
		print @payment
	end try
begin catch
	print 'Error al mostrar el valor'
	end catch

/* the following command doesn't work well */
begin try 
	declare @payment int 
	set @payment = 'trecientos'
		print @payment
	end try
begin catch
	print 'Error al mostrar el valor'
	end catch

/*to specify the error made this: */
begin try 
	declare @payment int 
	set @payment = 'hola'
		print @payment
	end try
begin catch
	print 'Error al mostrar el valor'
	print error_message()
	end catch


-- with


DECLARE @numero INT;
SET @numero = 2;

DECLARE @resultado NVARCHAR(MAX);
SET @resultado = '';


WHILE @numero <= 1000
BEGIN
    DECLARE @is_prime BIT;
    SET @is_prime = 1;
    DECLARE @divisor INT;
    SET @divisor = 2;

    WHILE @divisor <= SQRT(@numero)
    BEGIN
        IF @numero % @divisor = 0
        BEGIN
            SET @is_prime = 0;
            BREAK;
        END
        SET @divisor = @divisor + 1;
    END

    IF @is_prime = 1
    BEGIN
        SET @resultado = @resultado + CONVERT(NVARCHAR(MAX), @numero) + '&';
    END

    SET @numero = @numero + 1;
END

-- Remove the last ampersand (&) from the result
SET @resultado = LEFT(@resultado, LEN(@resultado) - 1);

PRINT @resultado;


---------------------KEY PRIMARY + KEY FOREIGH--------------------------
-- Create a sequence
CREATE SEQUENCE estacion_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647;

CREATE SEQUENCE tren_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647;

CREATE SEQUENCE trayecto_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647;

CREATE SEQUENCE pasajero_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647;

CREATE SEQUENCE viaje_id_seq
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 2147483647;