USE tienda;
-- 1.
SELECT nombre FROM producto;

-- 2
SELECT nombre, precio 
FROM producto;

-- 3
SELECT * FROM producto;

-- 4 
SELECT nombre, 
	precio AS precio_EUR, 
	(precio * 1.03) AS precio_USD
FROM producto;

-- 5
SELECT nombre AS "nom de 'producto'", 
	precio AS euros, 
	(precio * 1.03) AS "dòlars nord-americans"
FROM producto;

-- 6
SELECT UPPER(nombre) AS NOMBRE,
precio
FROM producto;

-- 7 
SELECT LOWER(nombre) AS nombre,
precio
FROM producto;

-- 8
SELECT nombre, UPPER(LEFT(nombre,2))
FROM fabricante;

-- 9
SELECT nombre, ROUND(Precio, 0) AS Precio_redondeado
FROM producto;

-- 10 
SELECT nombre, 
TRUNCATE(Precio, 0) AS Precio_truncado
FROM producto;

-- 11
SELECT fabricante.codigo 
FROM fabricante
INNER JOIN producto
ON fabricante.codigo=producto.codigo_fabricante;

-- 12
SELECT DISTINCT fabricante.codigo
FROM fabricante
INNER JOIN producto
ON fabricante.codigo=producto.codigo_fabricante;

-- 13
select NOMBRE 
FROM FABRICANTE
ORDER BY NOMBRE;

-- 14
select NOMBRE 
FROM FABRICANTE
ORDER BY NOMBRE DESC;

-- 15
select NOMBRE, precio 
from producto
order by nombre, precio desc;

-- 16
select * from fabricante limit 5;

-- 17
select * from fabricante limit 3, 2;

-- 18
select NOMBRE, PRECIO 
FROM producto
order by precio
limit 1;

-- 19
SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 1;

-- -- 20
select NOMBRE from producto
WHERE codigo_fabricante = 2;


