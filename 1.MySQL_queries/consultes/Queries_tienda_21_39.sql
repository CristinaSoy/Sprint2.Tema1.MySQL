USE tienda;

-- 21
select producto.nombre AS Nombre_Producto, precio, fabricante.nombre AS Nombre_fabricante
FROM producto
inner join fabricante
on producto.codigo_fabricante = fabricante.codigo;

-- 22
select producto.nombre AS Nombre_Producto, precio, fabricante.nombre AS Nombre_fabricante
FROM producto
inner join fabricante
on producto.codigo_fabricante = fabricante.codigo
order by fabricante.nombre;

-- 23 codi del producte, nom del producte, codi del fabricant i nom del fabricant
select p.codigo AS Cod_Producto,
p.nombre AS Nombre_Producto, 
f.codigo AS Cod_Fabricante,
f.nombre AS Nombre_fabricante
FROM producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo;

-- 24 nom del producte, el seu preu i el nom del seu fabricant, del producte més barat
select 
p.nombre AS Nombre_Producto, 
p.precio,
f.nombre AS Nombre_fabricante
FROM producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
order by p.precio 
limit 1;

-- 25 nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
select 
p.nombre AS Nombre_Producto, 
p.precio,
f.nombre AS Nombre_fabricante
FROM producto p
inner join fabricante f
on p.codigo_fabricante = f.codigo
order by p.precio desc
limit 1;

-- 26 tots els productes del fabricant Lenovo.
select p.codigo, p.nombre, p.precio, f.nombre as fabricante FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE LIKE "%LENOVO%";

-- 27 productes del fabricant Crucial que tinguin un preu major que 200 €.
select p.codigo, p.nombre, p.precio, f.nombre as fabricante FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE LIKE "%Crucial%" AND p.precio>200;

-- 28 fabricants Asus, Hewlett-Packard i Seagate. Sense utilitzar l'operador IN.
select p.codigo, p.nombre, p.precio, f.nombre as fabricante FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE regexp "Asus|Hewlett-Packard|Seagate";

-- 29 fabricants Asus, Hewlett-Packard i Seagate. Amb operador IN.
select p.codigo, p.nombre, p.precio, f.nombre as fabricante_IN FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE in ("Asus", "Hewlett-Packard", "Seagate");

-- 30 llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
select p.nombre, p.precio, f.nombre as fabricante_IN FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE LIKE "%e";

-- 31 nom i el preu de tots els productes dels fabricants dels quals contingui el caràcter w en el seu nom.
select p.nombre, p.precio, f.nombre as fabricante FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE regexp "w";

-- 32 nom de producte, preu i nom de fabricant, productes amb preu major o igual a 180 €.
-- Ordenat pel preu (desc) i pel nom (asc)
select p.nombre, precio, f.nombre as fabricante 
FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE p.precio >= 180
order by precio DESC, p.nombre;

-- 33 codi i el nom de fabricant amb productes
select distinct f.codigo, f.nombre
FROM fabricante f
inner join producto p
on f.codigo=p.codigo_fabricante;

-- 34
SELECT 
	f.nombre AS Nombre_Fabricante, 
	p.nombre AS Nombre_producto,
	p.precio
FROM fabricante f
LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante;

-- 35
SELECT 
	f.nombre AS Nombre_Fabricante, 
	p.nombre AS Nombre_producto,
	p.precio
FROM fabricante f
LEFT JOIN producto p
ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- 36 productes del fabricant Lenovo. (Sense utilitzar INNER JOIN).
SELECT *
FROM producto
WHERE codigo_fabricante = (
	SELECT codigo
    FROM fabricante
    WHERE nombre = "LENOVO");

-- 37 productes amb mateix preu que el producte més car de Lenovo. (Sense fer servir INNER JOIN).
SELECT * 
FROM tienda.producto
WHERE precio = 
	(SELECT MAX(precio) FROM producto
    WHERE codigo_fabricante = (
		SELECT codigo
        FROM fabricante
		WHERE nombre = "LENOVO"
        )
	);

-- 38 producte més car del fabricant Lenovo 559
SELECT
	p.nombre
FROM producto p, fabricante f
	WHERE p.codigo_fabricante = f.codigo 
	AND f.nombre = "LENOVO"
	ORDER BY p.precio DESC 
	LIMIT 1;
 
-- 39 més barat del fabricant Hewlett-Packard.
select p.nombre, p.precio, f.nombre as fabricante FROM producto p
inner join fabricante f
on p.codigo_fabricante=f.codigo
WHERE F.NOMBRE LIKE "Hewlett-Packard"
ORDER BY PRECIO LIMIT 1;

-- 40 , 41

