-- Create tables
CREATE TABLE estacion (
    id INT DEFAULT NEXT VALUE FOR estacion_id_seq PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100)
);

CREATE TABLE tren (
    id int default next value for tren_id_seq PRIMARY KEY,
	capacidad int,
    modelo varchar(30)
	);

-- CREATE TABLE tren (
--     id int IDENTITY(1,1) PRIMARY KEY,
--     modelo varchar(30),
--     capacidad int
-- );

CREATE TABLE pasajero (
    id int default next value for pasajero_id_seq PRIMARY KEY,
    nombre varchar(100),
    direccion_residencia varchar(100),
    fecha_nacimiento date
);

CREATE TABLE trayecto (
    id int default next value for trayecto_id_seq PRIMARY KEY,
    id_tren int,
    id_estacion int,
    FOREIGN KEY (id_tren) REFERENCES tren(id),
    FOREIGN KEY (id_estacion) REFERENCES estacion(id)
);

CREATE TABLE viaje (
    id int default next value for viaje_id_seq PRIMARY KEY,
    id_pasajero int,
    id_trayecto int,
    inicio date,
    fin date,
    FOREIGN KEY (id_pasajero) REFERENCES pasajero(id),
    FOREIGN KEY (id_trayecto) REFERENCES trayecto(id)
);

select * from estacion;
select * from tren;
select * from pasajero;
select * from trayecto;
select * from viaje;

drop table viaje;
drop table pasajero;
drop table trayecto;
drop table estacion;
drop table tren;

---------------------INSERT + CASCADE--------------------------

INSERT INTO dbo.estacion (nombre,direccion)
VALUES 
    ('Estación Centro','St 1# 12'),
    ('Estación Norte','St 100# 112');

INSERT INTO transportes.dbo.tren (capacidad,modelo)
VALUES 
    (100,'Modelo 1'),
    (100,'Modelo 2')
;

-- ALTER TABLE transportes.dbo.trayecto ADD COLUMN nombre varchar(50); --> postgres
ALTER TABLE transportes.dbo.trayecto ADD  nombre varchar(50);
INSERT INTO trayecto (id_tren,id_estacion,nombre)
VALUES
    (1,1,'Ruta 1'),
    (2,2,'Ruta 2')
;
-- INSERT INTO trayecto (id_tren,id_estacion,nombre)
-- VALUES
--     (12,1,'Ruta 1'),
--     (2,22,'Ruta 2')
-- ;

INSERT INTO dbo.pasajero (nombre,fecha_nacimiento,direccion_residencia)
VALUES
    ('José Ordoñez','1987-1-3','St 100# 12'),
    ('Ángel Quintero','1987-1-12','St 101# 12'),
    ('Rafel Castillo','1977-1-12','St 102# 12');

INSERT INTO dbo.viaje (id_pasajero,id_trayecto,inicio,fin)
 VALUES
    (1,1,'2019-01-02','2019-01-02'),
    (2,1,'2019-01-03','2019-01-03'),
    (2,2,'2019-01-04','2019-01-04'),
    (3,2,'2019-01-04','2019-01-04')
;

select * from estacion;
select * from tren;
select * from pasajero;

select * from trayecto;
select * from viaje;

---------------------CONTRAINT--------------------------

-- Drop existing foreign key constraints
ALTER TABLE trayecto
DROP CONSTRAINT trayecto_estacion_fkey;

-- ALTER TABLE public.trayecto
-- DROP CONSTRAINT viaje_id_train_fkey;

-- Add new foreign key constraints
ALTER TABLE trayecto
ADD CONSTRAINT trayecto_estacion_fkey FOREIGN KEY (id_estacion) REFERENCES estacion (id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE trayecto
ADD CONSTRAINT trayecto_tren_fkey FOREIGN KEY (id_tren) REFERENCES tren (id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE viaje
ADD CONSTRAINT viaje_trayecto_fkey FOREIGN KEY (id_trayecto) REFERENCES trayecto (id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE viaje
ADD CONSTRAINT viaje_pasajero_fkey FOREIGN KEY (id_pasajero) REFERENCES pasajero (id)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Disable identity insert on the 'id' column
-- SET IDENTITY_INSERT tren OFF;
-- Update the 'id' column
-- UPDATE tren SET id = 1 WHERE id = 2;
-- Re-enable identity insert on the 'id' column
-- SET IDENTITY_INSERT tren ON;

---------------------DELETE + CASCADE--------------------------

select * from estacion;
select * from tren;
select * from pasajero;

select * from trayecto;
select * from viaje;

DELETE FROM [dbo].[estacion] WHERE id = 2;
UPDATE estacion SET id = 1  WHERE id =10;

DELETE FROM [dbo].[tren] WHERE id = 1;
UPDATE tren SET id= 1 WHERE id = 10

INSERT INTO dbo.trayecto (id_tren,id_estacion,nombre)
		VALUES(2,1,'Ruta 2')

INSERT INTO dbo.viaje (id_pasajero,id_trayecto,inicio,fin)
 VALUES
    (1,3,'2019-01-02','2019-01-02'),
    (2,3,'2019-01-03','2019-01-03');

DELETE FROM [dbo].[pasajero] WHERE id = 2;
UPDATE pasajero SET id= 10 WHERE id = 1;

UPDATE trayecto SET id= 30 WHERE id = 3;
DELETE FROM [dbo].[trayecto] WHERE id = 30;




---------------------UPDATE + CASCADE--------------------------









-- Step 1: Disable identity insert
SET IDENTITY_INSERT tren ON;

-- Step 2: Perform the update
UPDATE tren SET id = 5 WHERE id = 4;

-- Step 3: Re-enable identity insert
SET IDENTITY_INSERT tren OFF;
