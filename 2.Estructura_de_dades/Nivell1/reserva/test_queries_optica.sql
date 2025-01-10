-- CONSULTAS DE PRUEBA

-- consulta: •	Llista el total de compres d’un client/a.

SELECT
	c.nombre, c.apellido1, c.apellido2,
	sum(gv.unidades) AS unidades_vendidas
FROM optica.clientes c
JOIN ventas v
	ON c.id = v.cliente_id
JOIN gafas_vendidas gv
	ON gv.venta_id = v.id
-- WHERE c.id =  "3" si el que es vol es el total de compres "d'un" client deixariem aquesta clausula i trauriem group by
GROUP BY c.id;

-- consulta: Llista les diferents ulleres que ha venut un empleat durant un any
SELECT
	e.nombre, e.apellido1, e.apellido2,
    gv.gafa_id AS gafas_id,
    g.nombre AS nombre_gafas,
	sum(gv.unidades) AS unidades_vendidas
FROM optica.empleados e
JOIN ventas v
	ON e.id = v.empleado_id
JOIN gafas_vendidas gv
	ON gv.venta_id = v.id
JOIN gafas g
	ON g.id = gv.gafa_id
    
WHERE e.id =  "3"
AND v.fecha_venta BETWEEN "2024-01-01 00:00:01" AND "2024-12-31 23:59:59"
GROUP BY gv.gafa_id;

-- consulta: Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica

SELECT
	p.nombre AS proveedor,
    m.nombre AS marca,
	sum(gv.unidades) AS unidades_vendidas
FROM optica.proveedores p
JOIN marcas m
	ON 	p.id = m.proveedor_id
JOIN gafas g
	on m.id = g.marca_id
JOIN gafas_vendidas gv
	ON gv.venta_id = g.id
GROUP BY p.id, m.id;
