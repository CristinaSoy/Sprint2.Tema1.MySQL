USE universidad;
-- queries BBDD universidad
-- NOTA:  s'inclou codi de consulta per facilitar seguiment: "Cons_No"

-- 1
SELECT 1 AS Cons_No, nombre, apellido1, apellido2 FROM persona
WHERE tipo = "alumno"
ORDER BY apellido1, apellido2, nombre;

-- 2
SELECT 2 AS Cons_No, nombre, apellido1, apellido2 FROM persona
WHERE tipo = "alumno" 
AND telefono IS NULL;

-- 3
SELECT 3 AS Cons_No, nombre, apellido1, apellido2 FROM persona
WHERE tipo = "alumno" 
AND fecha_nacimiento between '1999-01-01' AND '1999-12-31';

-- 4
SELECT 4 AS Cons_No, nombre, apellido1, apellido2 FROM persona
WHERE tipo = "profesor" 
AND telefono IS NULL
AND nif REGEXP "K$";

-- 5 assignatures del 1er quadrimestre, en el 3er curs del grau amb id 7
SELECT * FROM universidad.asignatura
WHERE cuatrimestre = 1
AND curso = 3
AND id_grado = 7;

-- 6 prof i nom depto 4 col asc by cognoms, nom
SELECT
	6 AS "Cons_No" ,
    p.apellido1,
    p.apellido2,
    p.nombre,
    d.nombre AS Nombre_Dpto
FROM universidad.profesor pr
JOIN persona p
	ON p.id = pr.id_profesor
JOIN departamento d
	ON pr.id_departamento = d.id
ORDER BY p.apellido1,
    p.apellido2,
    p.nombre;

-- 7 nom de les assignatures, 
-- any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT
	7 AS "Cons_No",
    a.nombre AS "Nombre_Asignatura",
	p.nif,
    c.anyo_inicio,
    c.anyo_fin
FROM 
	persona p
JOIN alumno_se_matricula_asignatura m
	ON m.id_alumno = p.id
JOIN asignatura a
	ON m.id_asignatura = a.id
JOIN curso_escolar c
	ON m.id_curso_escolar = c.id
WHERE p.nif = "26902806M";

-- 8 nom de tots els departaments amb professors/es que imparteixen 
-- asignatura en el Grau en Enginyeria Informàtica (Pla 2015)
SELECT DISTINCT
	8 AS "Cons_No",
    d.nombre AS Nombre_Dpto,
    g.nombre AS Nombre_grado
FROM grado g
JOIN asignatura a
	ON g.id = a.id_grado
JOIN profesor p
	ON a.id_profesor = p.id_profesor
JOIN departamento d
	ON d.id = p.id_departamento    
WHERE g.nombre REGEXP "Ingeniería Informática \\(Plan 2015\\)";

-- 9 alumnes matriculats a alguna asignatura al curs escolar 2018 2019
SELECT DISTINCT
	9 AS "Cons_No",
	p.apellido1,
    p.apellido2,
    p.nombre
FROM universidad.curso_escolar c
JOIN universidad.alumno_se_matricula_asignatura m
	ON c.id = m.id_curso_escolar
JOIN persona p
	ON m.id_alumno = p.id
WHERE anyo_inicio = 2018 and anyo_fin = 2019;

-- LEFT JOIN i RIGHT JOIN "Cons_No: LJ_n"

-- 1. noms de tots els professors/es i SUS departaments.
-- nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- order by departament, cognoms i el nom.

SELECT
	"LJ_01" AS "Cons_No",
	d.nombre AS Departamento, 
    p.apellido1,
    p.apellido2,
    p.nombre
FROM persona p
LEFT JOIN profesor pr
	ON p.id = pr.id_profesor
LEFT JOIN departamento d
	ON pr.id_departamento = d.id
WHERE p.tipo = "profesor"
ORDER BY 
	d.nombre, 
    p.apellido1,
    p.apellido2,
    p.nombre;
    
-- 2 llistat amb els professors/es que no estan associats a un departament
-- NOTA: no n'hi ha profs sense dept.
SELECT
	"LJ_2" AS "Cons_No",
	d.nombre AS Departamento, 
    p.apellido1,
    p.apellido2,
    p.nombre
FROM persona p
LEFT JOIN profesor pr
	ON p.id = pr.id_profesor
LEFT JOIN departamento d
	ON pr.id_departamento = d.id
WHERE p.tipo = "profesor"
	AND pr.id_departamento IS NULL
ORDER BY 
	d.nombre, 
    p.apellido1,
    p.apellido2,
    p.nombre;

-- 3 llistat amb els departaments que no tenen professors/es associats
SELECT
	"LJ_3" AS "Cons_No",
	d.id,
	d.nombre AS departamento
FROM universidad.departamento d
LEFT JOIN profesor pr
	ON d.id = pr.id_profesor
WHERE pr.id_profesor is null;

-- 4 professors/es que no imparteixen cap assignatura.
SELECT 
	"LF_4" AS "Cons_No",
    p.apellido1,
    p.apellido2,
    p.nombre
FROM universidad.persona p
LEFT JOIN profesor pr
	ON p.id = pr.id_profesor
LEFT JOIN asignatura a
	ON pr.id_profesor = a.id_profesor
WHERE p.tipo = "profesor"
AND a.id IS NULL;

-- 5 assignatures que no tenen un professor/a assignat
SELECT * FROM universidad.asignatura
WHERE id_profesor IS NULL;

-- 6 departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT
	"LJ_6" AS "Cons_No",
	d.id AS id_dpto,
	d.nombre AS nombre_depto
FROM universidad.departamento d
LEFT JOIN profesor pr
	ON d.id = pr.id_departamento
LEFT JOIN asignatura a
	ON pr.id_profesor=a.id_profesor
WHERE a.id IS NULL
