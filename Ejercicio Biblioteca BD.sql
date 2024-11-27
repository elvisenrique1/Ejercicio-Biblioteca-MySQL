
-- 									******   Ejercicio Biblioteca (JOINS)   ******

-- Crear la base de datos biblioteca de acuerdo al siguiente esquema:

create database biblioteca;
use biblioteca;
show tables;

-- -------------    -------------------     -------------     
-- - libros    -    - prestamos       -     - socios    -    
-- -------------    -------------------     -------------     
-- - codigo PK -    - documento   PK FK -     - documento  PK -
-- - titulo    -    - codigo_libro PK FK -     - nombre    -
-- - autor     -    - fecha_prestamo   -       - domicilio -
-- -------------    - fecha_devolucion -     -------------
--                  -------------------                

create table libros(
	codigo int auto_increment,
    titulo varchar(50) not null,
    autor varchar(50) not null,
    primary key (codigo)
);

create table prestamos(
	documento char(8),
    codigo_libro int,
    fecha_prestamo date not null,
    fecha_devolucion date,
    primary key (documento, codigo_libro),
    foreign key (documento) references socios(documento),
    foreign key (codigo_libro) references libros(codigo)
);

create table socios(
	documento char(8),    
    nombre varchar(50) not null,
    domicilio varchar(50) not null,
    primary key (documento)
);

select * from libros;
select * from prestamos;
select * from socios;

-- Insertar 15 registros en cada tabla creada

INSERT INTO libros (titulo, autor) VALUES 
('Cien Años de Soledad', 'Gabriel García Márquez'), 
('Don Quijote de la Mancha', 'Miguel de Cervantes'), 
('La Casa de los Espíritus', 'Isabel Allende'), 
('El Alquimista', 'Paulo Coelho'), 
('1984', 'George Orwell'), 
('El Amor en los Tiempos del Cólera', 'Gabriel García Márquez'), 
('Rayuela', 'Julio Cortázar'), 
('El Principito', 'Antoine de Saint-Exupéry'), 
('Crónica de una Muerte Anunciada', 'Gabriel García Márquez'), 
('La Sombra del Viento', 'Carlos Ruiz Zafón'), 
('Ficciones', 'Jorge Luis Borges'), 
('Pedro Páramo', 'Juan Rulfo'), 
('La Hojarasca', 'Gabriel García Márquez'), 
('Ensayo sobre la Ceguera', 'José Saramago'), 
('Los Detectives Salvajes', 'Roberto Bolaño');

INSERT INTO prestamos (documento, codigo_libro, fecha_prestamo, fecha_devolucion) VALUES 
('12345678', 2, '2024-01-05', '2024-01-19'), 
('23456789', 2, '2024-01-10', '2024-01-24'), 
('34567890', 1, '2024-01-15', null),
('45678901', 4, '2024-01-20', '2024-02-03'), 
('56789012', 5, '2024-01-25', '2024-02-08'), 
('67890123', 6, '2024-01-30', null),
('78901234', 7, '2024-02-04', '2024-11-21'),
('89012345', 8, '2024-02-09', '2024-02-23'),
('90123456', 9, '2024-02-14', null),
('01234567', 10, '2024-11-21', '2024-03-04'),
('12345098', 11, '2024-02-24', '2024-11-25'), 
('87654321', 12, '2024-02-29', '2024-11-25'),
('76543210', 13, '2024-11-27', '2024-03-19'), 
('65432109', 14, '2024-11-10', '2024-03-24'), 
('54321098', 15, '2024-11-15', '2024-03-29');

INSERT INTO socios (documento, nombre, domicilio) VALUES
('12345678', 'Juan Pérez', 'Calle Falsa 123'),
('23456789', 'María González', 'Av. Siempre Viva 456'),
('34567890', 'Carlos Rodríguez', 'Calle de la Luna 789'),
('45678901', 'Lucía Martínez', 'Plaza del Sol 101'),
('56789012', 'José López', 'Callejón del Beso 202'),
('67890123', 'Ana Fernández', 'Camino Real 303'),
('78901234', 'Miguel Sánchez', 'Av. de los Poetas 404'),
('89012345', 'Marta Gómez', 'Ronda de los Ángeles 505'),
('90123456', 'David Díaz', 'Paseo de los Olmos 606'),
('01234567', 'Elena Torres', 'Camino del Rey 707'),
('98765432', 'Luis Ramírez', 'Calle de la Reina 808'),
('87654321', 'Paula Vargas', 'Plazuela de las Flores 909'),
('76543210', 'Javier Molina', 'Camino de Santiago 1010'),
('65432109', 'Carmen Castro', 'Av. del Parque 1111'),
('54321098', 'Ricardo Ortiz', 'Calle del Pino 1212');

-- Luego responder:

-- 1- qué libros (codigo, titulo, autor) se le prestaron a cada socio?
select		s.nombre, l.codigo, l.titulo, l.autor 
from 		socios s
join		prestamos p 
on			s.documento=p.documento
join		libros l
on 			l.codigo=p.codigo_libro
order by	s.nombre;

-- 2- Listar los socios (documento, nombre, domicilio) a los que se les prestaron libros de Java
select		s.documento, s.nombre, s.domicilio
from 		prestamos p
join		socios s
on			s.documento=p.documento
join		libros l
on 			l.codigo=p.codigo_libro
where 		l.titulo like '%Java%'
order by	s.nombre;

-- 3- Listar de libros (codigo,titulo,autor) que no fueron devueltos
select		l.codigo, l.titulo, l.autor
from 		prestamos p
join		socios s 
on			s.documento=p.documento
join		libros l
on 			l.codigo=p.codigo_libro
where 		p.fecha_devolucion is null
order by	l.autor;

-- 4- Lista de socios (documento, nombre, domicilio) que tienen libros sin devolver
select		s.documento, s.nombre, s.domicilio
from 		prestamos p
join		socios s
on			s.documento=p.documento
join		libros l
on 			l.codigo=p.codigo_libro
where 		p.fecha_devolucion is null
order by	s.nombre;

-- 5- Lista de socios (documento, nombre, domicilio) que tienen libros sin devolver y cuáles son esos libros
select		s.documento, s.nombre, s.domicilio, l.titulo
from 		prestamos p
join		socios s
on			s.documento=p.documento
join		libros l
on 			l.codigo=p.codigo_libro
where 		p.fecha_devolucion is null
order by	l.titulo;

-- 6- cantidad de libros sin devolver
select		count(*) cantidad_libros_sin_devolver
from 		prestamos p
join		libros l
on			p.codigo_libro=l.codigo
where		p.fecha_devolucion is null;

-- 7. Lista de libros que fueron prestados el día de hoy.
select		l.titulo, l.autor, p.fecha_prestamo
from 		prestamos p
join		libros l 
on 			p.codigo_libro=l.codigo
where		p.fecha_prestamo = curdate();

-- 8- Cantidad de libros que se prestaron este mes
select 		count(*) cantidad_libros_prestados
from 		prestamos p
join 		libros l
on 			p.codigo_libro=l.codigo
where		month(p.fecha_prestamo) = month(current_date());

-- 9- Cantidad de socios que tomaron libros prestados este mes
select 		count(distinct documento) socios_que_tomaron_libros_prestados
from 		prestamos p
where		month(p.fecha_prestamo) = month(current_date());
