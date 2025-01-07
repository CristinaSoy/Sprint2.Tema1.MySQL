-- Consultas resumen: Cons_No: "CR_n"

-- 1 Numero total alumnos
SELECT 
	"CR_1" AS "Query_num",
	COUNT(id) FROM persona
WHERE tipo = "alumno";

-- 2 alumnes van néixer en 1999
SELECT 
	"CR_2" AS "Query_num",
	COUNT(id) 
FROM persona
WHERE tipo = "alumno"
AND fecha_nacimiento between '1999-01-01' AND '1999-12-31';

-- 3 quants/es professors/es hi ha en cada departament: nom del departament i nombre de professors/es 

SELECT 
	"CR_3" AS "Query_num",
	d.id AS id_dpto,
	d.nombre AS nombre_depto,
    -- pr.id_profesor
    count(pr.id_profesor) AS Cant_Profesores
FROM universidad.departamento d
JOIN profesor pr
	ON d.id = pr.id_departamento
GROUP BY d.id
ORDER BY count(pr.id_profesor) DESC;

-- 4 tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells inclosos deps sense profes
SELECT
	"CR_4" AS "Query_num",
	d.id AS id_dpto,
	d.nombre AS nombre_depto,
    COUNT(pr.id_profesor) AS cant_profes
FROM universidad.departamento d
LEFT JOIN profesor pr
	ON d.id = pr.id_departamento
LEFT JOIN asignatura a
	ON pr.id_profesor=a.id_profesor
GROUP BY d.id;

-- 5 nom de tots els graus existents i el nombre d'assignatures que té cadascun. 
-- inc. graus sense asignatures. ordenat de major a menor pel nombre d'assignatures
SELECT 
	"CR_5" AS "Cons_No",
	g.id AS id_grado,
	g.nombre AS nombre_grado,
    COUNT(a.id) AS cantidad_asignaturas
FROM universidad.grado g
LEFT JOIN asignatura a
	ON g.id = a.id_grado
GROUP BY  g.id
ORDER BY COUNT(a.id) DESC;

-- 6 nom dels graus existents i nombre d'assignatures dels graus amb més de 40 assignatures.
SELECT 
	"CR_6" AS "Cons_No",
	g.id AS id_grado,
	g.nombre AS nombre_grado,
    COUNT(a.id) AS cantidad_asignaturas
FROM universidad.grado g
LEFT JOIN asignatura a
	ON g.id = a.id_grado
GROUP BY  g.id
HAVING cantidad_asignaturas > 40
ORDER BY cantidad_asignaturas DESC;

-- 7 nom dels graus i la suma de crèdits que hi ha per a cada tipus d'assignatura
-- TRES columnes: nom  grau, tipus d'assignatura i suma dels crèdits de totes les assignatures d'aquest tipus
SELECT 
	"CR_7" AS "Cons_No",
	g.nombre AS nombre_grado,
    a.tipo,
    SUM(a.creditos)
FROM universidad.grado g
JOIN asignatura a
	ON g.id = a.id_grado
GROUP BY  g.nombre, a.tipo;

-- 8 quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars
-- dues columnes, any d'inici del curs escolar, nombre d'alumnes matriculats/des.
SELECT
	"CR_8" AS "Cons_No",
    c.anyo_inicio AS año_inicio,
    COUNT(id_alumno)
FROM
	(SELECT DISTINCT
		m.id_alumno,
		m.id_curso_escolar    
	FROM alumno_se_matricula_asignatura m) ma

JOIN curso_escolar c
	ON c.id = ma.id_curso_escolar
GROUP BY año_inicio

-- 9 NUM ASIG CADA PRO INC PRO SIN ASIG-
-- cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures
-- ordenat de major a menor pel nombre d'assignatures.

-- 10 dades de l'alumne més jove
SELECT 
	"CR_10" AS "Cons_No", 
    datos_alumno.*
FROM 
	( SELECT * FROM universidad.persona) datos_alumno
WHERE tipo = "alumno"
AND fecha_nacimiento = 
	(SELECT MAX(fecha_nacimiento)
    FROM universidad.persona)


-- 11  llistat amb els professors/es que tenen un departament associat i que no impartei-xen cap assignatura.