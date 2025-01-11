USE tienda;
-- 1.
SELECT nombre FROM producto;

-- 2
SELECT nombre, precio FROM producto;

-- 3
SELECT * FROM producto;

-- 4 
SELECT nombre, 	precio AS precio_EUR, (precio * 1.03) AS precio_USD FROM producto;

-- 5
SELECT nombre AS "nom de 'producto'", precio AS euros, (precio * 1.03) AS "dòlars nord-americans" FROM producto;

-- 6
SELECT UPPER(nombre) AS NOMBRE, precio FROM producto;

-- 7 
SELECT LOWER(nombre) AS nombre, precio FROM producto;

-- 8
SELECT nombre, UPPER(LEFT(nombre,2)) FROM fabricante;

-- 9
SELECT nombre, ROUND(Precio, 0) AS Precio_redondeado FROM producto;

-- 10 
SELECT nombre, TRUNCATE(Precio, 0) AS Precio_truncado FROM producto;

-- 11
SELECT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo=producto.codigo_fabricante;

-- 12
SELECT DISTINCT fabricante.codigo FROM fabricante INNER JOIN producto ON fabricante.codigo=producto.codigo_fabricante;

-- 13
select NOMBRE 
FROM FABRICANTE ORDER BY NOMBRE;

-- 14
select NOMBRE FROM FABRICANTE ORDER BY NOMBRE DESC;

-- 15
select NOMBRE, precio from producto order by nombre, precio desc;

-- 16
select * from fabricante limit 5;

-- 17
select * from fabricante limit 3, 2;

-- 18
select NOMBRE, PRECIO FROM producto order by precio limit 1;

-- 19
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20
select NOMBRE from producto WHERE codigo_fabricante = 2;
-- 21
SELECT producto.nombre AS Nombre_Producto, precio, fabricante.nombre AS Nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22
SELECT producto.nombre AS Nombre_Producto, precio, fabricante.nombre AS Nombre_fabricante FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre;

-- 23
SELECT p.codigo AS Cod_Producto, p.nombre AS Nombre_Producto, f.codigo AS Cod_Fabricante, f.nombre AS Nombre_fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo;

-- 24
SELECT p.nombre AS Nombre_Producto, p.precio, f.nombre AS Nombre_fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;

-- 25
SELECT p.nombre AS Nombre_Producto, p.precio, f.nombre AS Nombre_fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;

-- 26
SELECT p.codigo, p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE LIKE "%LENOVO%";

-- 27
SELECT p.codigo, p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE LIKE "%Crucial%" AND p.precio > 200;

-- 28
SELECT p.codigo, p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE REGEXP "Asus|Hewlett-Packard|Seagate";

-- 29
SELECT p.codigo, p.nombre, p.precio, f.nombre AS fabricante_IN FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE IN ("Asus", "Hewlett-Packard", "Seagate");

-- 30
SELECT p.nombre, p.precio, f.nombre AS fabricante_IN FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE LIKE "%e";

-- 31
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE REGEXP "w";

-- 32
SELECT p.nombre, precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY precio DESC, p.nombre;

-- 33
SELECT DISTINCT f.codigo, f.nombre FROM fabricante f INNER JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 34
SELECT f.nombre AS Nombre_Fabricante, p.nombre AS Nombre_producto, p.precio FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35
SELECT f.nombre AS Nombre_Fabricante, p.nombre AS Nombre_producto, p.precio FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.codigo IS NULL;

-- 36
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "LENOVO");

-- 37
SELECT * FROM tienda.producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "LENOVO"));

-- 38
SELECT p.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "LENOVO" ORDER BY p.precio DESC LIMIT 1;

-- 39
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p INNER JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE F.NOMBRE LIKE "Hewlett-Packard" ORDER BY PRECIO LIMIT 1;


-- ------------------------------------
-- universitat
-- ------------------------------------

USE universidad;
-- queries BBDD universidad
-- NOTA:  s'inclou columna amb codi de consulta per facilitar seguiment: "Cons_No"


-- 1
SELECT 1 AS Cons_No, nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" ORDER BY apellido1, apellido2, nombre;

-- 2
SELECT 2 AS Cons_No, nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND telefono IS NULL;

-- 3
SELECT 3 AS Cons_No, nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 4
SELECT 4 AS Cons_No, nombre, apellido1, apellido2 FROM persona WHERE tipo = "profesor" AND telefono IS NULL AND nif REGEXP "K$";

-- 5
SELECT * FROM universidad.asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6
SELECT 6 AS "Cons_No", p.apellido1, p.apellido2, p.nombre, d.nombre AS Nombre_Dpto FROM universidad.profesor pr JOIN persona p ON p.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7
SELECT 7 AS "Cons_No", a.nombre AS "Nombre_Asignatura", p.nif, c.anyo_inicio, c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura m ON m.id_alumno = p.id JOIN asignatura a ON m.id_asignatura = a.id JOIN curso_escolar c ON m.id_curso_escolar = c.id WHERE p.nif = "26902806M";

-- 8
SELECT DISTINCT 8 AS "Cons_No", d.nombre AS Nombre_Dpto, g.nombre AS Nombre_grado FROM grado g JOIN asignatura a ON g.id = a.id_grado JOIN profesor p ON a.id_profesor = p.id_profesor JOIN departamento d ON d.id = p.id_departamento WHERE g.nombre REGEXP "Ingeniería Informática \\(Plan 2015\\)";

-- 9
SELECT DISTINCT 9 AS "Cons_No", p.apellido1, p.apellido2, p.nombre FROM universidad.curso_escolar c JOIN universidad.alumno_se_matricula_asignatura m ON c.id = m.id_curso_escolar JOIN persona p ON m.id_alumno = p.id WHERE anyo_inicio = 2018 AND anyo_fin = 2019;

-- LEFT JOIN i RIGHT JOIN "Cons_No: LJ_n"

-- LJ_01
SELECT "LJ_01" AS "Cons_No", d.nombre AS Departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE p.tipo = "profesor" ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- LJ_2
SELECT "LJ_2" AS "Cons_No", d.nombre AS Departamento, p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE p.tipo = "profesor" AND pr.id_departamento IS NULL ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- LJ_3
SELECT "LJ_3" AS "Cons_No", d.id, d.nombre AS departamento FROM universidad.departamento d LEFT JOIN profesor pr ON d.id = pr.id_profesor WHERE pr.id_profesor IS NULL;

-- LJ_4
SELECT "LF_4" AS "Cons_No", p.apellido1, p.apellido2, p.nombre FROM universidad.persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = "profesor" AND a.id IS NULL;

-- LJ_5
SELECT * FROM universidad.asignatura WHERE id_profesor IS NULL;

-- LJ_6
SELECT DISTINCT "LJ_6" AS "Cons_No", d.id AS id_dpto, d.nombre AS nombre_depto FROM universidad.departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id IS NULL;

-- ---------------------------
-- consultes resum 
-- ---------------------------

-- CR_1
SELECT "CR_1" AS "Query_num", COUNT(id) FROM persona WHERE tipo = "alumno";

-- CR_2
SELECT "CR_2" AS "Query_num", COUNT(id) FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- CR_3
SELECT "CR_3" AS "Query_num", d.id AS id_dpto, d.nombre AS nombre_depto, COUNT(pr.id_profesor) AS Cant_Profesores FROM universidad.departamento d JOIN profesor pr ON d.id = pr.id_departamento GROUP BY d.id ORDER BY COUNT(pr.id_profesor) DESC;

-- CR_4
SELECT "CR_4" AS "Query_num", d.id AS id_dpto, d.nombre AS nombre_depto, COUNT(pr.id_profesor) AS cant_profes FROM universidad.departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor GROUP BY d.id;

-- CR_5
SELECT "CR_5" AS "Cons_No", g.id AS id_grado, g.nombre AS nombre_grado, COUNT(a.id) AS cantidad_asignaturas FROM universidad.grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id ORDER BY COUNT(a.id) DESC;

-- CR_6
SELECT "CR_6" AS "Cons_No", g.id AS id_grado, g.nombre AS nombre_grado, COUNT(a.id) AS cantidad_asignaturas FROM universidad.grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id HAVING cantidad_asignaturas > 40 ORDER BY cantidad_asignaturas DESC;

-- CR_7
SELECT "CR_7" AS "Cons_No", g.nombre AS nombre_grado, a.tipo, SUM(a.creditos) FROM universidad.grado g JOIN asignatura a ON g.id = a.id_grado GROUP BY g.nombre, a.tipo;

-- CR_8
SELECT "CR_8" AS "Cons_No", c.anyo_inicio AS año_inicio, COUNT(id_alumno) FROM (SELECT DISTINCT m.id_alumno, m.id_curso_escolar FROM alumno_se_matricula_asignatura m) ma JOIN curso_escolar c ON c.id = ma.id_curso_escolar GROUP BY año_inicio;

-- CR_9
SELECT "CR_9" AS "Cons_No", p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS num_asignaturas FROM persona p LEFT JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY COUNT(a.id) DESC;

-- CR_10
SELECT "CR_10" AS "Cons_No", datos_alumno.* FROM (SELECT * FROM universidad.persona) datos_alumno WHERE tipo = "alumno" AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM universidad.persona);
