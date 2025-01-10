-- MySQL Script generated by MySQL Workbench
-- Fri Jan 10 12:31:57 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optica
-- -----------------------------------------------------
-- Modelo BBDD Optica "Cul d'ampolla"
-- by Cristina Cardona
DROP SCHEMA IF EXISTS `Optica` ;

-- -----------------------------------------------------
-- Schema Optica
--
-- Modelo BBDD Optica "Cul d'ampolla"
-- by Cristina Cardona
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optica` DEFAULT CHARACTER SET utf8mb4 ;
USE `Optica` ;

-- -----------------------------------------------------
-- Table `Optica`.`direcciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`direcciones` ;

CREATE TABLE IF NOT EXISTS `Optica`.`direcciones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `calle` VARCHAR(50) NOT NULL COMMENT 'tipo de via y nombre',
  `numero` VARCHAR(15) NOT NULL,
  `piso` VARCHAR(5) NULL,
  `puerta` VARCHAR(5) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(5) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'alias d';

CREATE INDEX `ix_d_ciudad` ON `Optica`.`direcciones` (`ciudad` ASC) INVISIBLE;

CREATE INDEX `ix_d_cp` ON `Optica`.`direcciones` (`cp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`proveedores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`proveedores` ;

CREATE TABLE IF NOT EXISTS `Optica`.`proveedores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nif` VARCHAR(9) NOT NULL COMMENT 'o cif si es una persona jurídica',
  `nombre` VARCHAR(45) NOT NULL COMMENT 'o razon social si es una persona juridica',
  `nombre_persona_de_contacto` VARCHAR(45) NOT NULL COMMENT 'Nombre de la persona de contacto, al igual que el tel y el fax,\nno han de ser unicos puesto que un proveedor puede funcionar con varias razones sociales y tener la misma persona y datos de contacto.\nPor otra parte, en principio un proveedor solo tiene unos datos de contacto. ',
  `direccion_id` INT NOT NULL,
  `tel` VARCHAR(11) NOT NULL,
  `fax` VARCHAR(11) NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_p_direccion_id`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `Optica`.`direcciones` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'alias p';

CREATE UNIQUE INDEX `nif_UNIQUE` ON `Optica`.`proveedores` (`nif` ASC) VISIBLE;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Optica`.`proveedores` (`nombre` ASC) VISIBLE;

CREATE INDEX `ix_p_direccion_id` ON `Optica`.`proveedores` (`direccion_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `Optica`.`proveedores` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`clientes` ;

CREATE TABLE IF NOT EXISTS `Optica`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `referido_por_cliente_id` INT NULL,
  `direccion_id` INT NULL COMMENT 'no obligatoria,',
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `email` VARCHAR(45) NOT NULL COMMENT 'No es unico porque una parte de la clientela de las opticas está en una franja de edad i/o tiene determinadas dificultades de visión que hacen que dejen el email de un familiar que también puede ser cliente de la óptica.',
  `tel` VARCHAR(15) NOT NULL COMMENT 'No es unico por lo mismo que el email.',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_c_referido_por_cliente_id`
    FOREIGN KEY (`referido_por_cliente_id`)
    REFERENCES `Optica`.`clientes` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_c_direccion_id`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `Optica`.`direcciones` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `ix_c_direccion` ON `Optica`.`clientes` (`direccion_id` ASC) INVISIBLE;

CREATE INDEX `ix_c_apellido1` ON `Optica`.`clientes` (`apellido1` ASC) VISIBLE;

CREATE INDEX `ix_c_email` ON `Optica`.`clientes` (`email` ASC) VISIBLE;

CREATE INDEX `fk_c_referido_por_cliente_id_idx` ON `Optica`.`clientes` (`referido_por_cliente_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`user` ;

CREATE TABLE IF NOT EXISTS `Optica`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `Optica`.`marcas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`marcas` ;

CREATE TABLE IF NOT EXISTS `Optica`.`marcas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `proveedor_id` INT NULL COMMENT 'Nulo mientra no exista un proveedor para esa marca.',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_m_proveedor_id`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `Optica`.`proveedores` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `ix_m_proveedor_id` ON `Optica`.`marcas` (`proveedor_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Optica`.`marcas` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`gafas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`gafas` ;

CREATE TABLE IF NOT EXISTS `Optica`.`gafas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `marca_id` INT NOT NULL,
  `graduacion_izdo` DECIMAL(4,2) NOT NULL,
  `graduacion_dcho` DECIMAL(4,2) NOT NULL,
  `color_izdo` VARCHAR(45) NOT NULL,
  `color_dcho` VARCHAR(45) NOT NULL,
  `tipo_montura` ENUM("Flotante", "Pasta", "Metálica") NOT NULL,
  `pvp` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_g_marca_id`
    FOREIGN KEY (`marca_id`)
    REFERENCES `Optica`.`marcas` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Optica`.`gafas` (`nombre` ASC) VISIBLE;

CREATE INDEX `fk_g_marca_id_idx` ON `Optica`.`gafas` (`marca_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`empleados` ;

CREATE TABLE IF NOT EXISTS `Optica`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL COMMENT 'No es demana el nif. Però és necessari.',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `nif_UNIQUE` ON `Optica`.`empleados` (`nif` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`ventas` ;

CREATE TABLE IF NOT EXISTS `Optica`.`ventas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT NOT NULL,
  `fecha_venta` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Es grava automaticament la data de creació del registre.',
  `empleado_id` INT NOT NULL,
  `num_factura` VARCHAR(8) NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_v_cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Optica`.`clientes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_v_empleado_id`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `Optica`.`empleados` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_v_cliente_id_idx` ON `Optica`.`ventas` (`cliente_id` ASC) VISIBLE;

CREATE INDEX `fk_v_empleado_id_idx` ON `Optica`.`ventas` (`empleado_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Optica`.`gafas_vendidas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Optica`.`gafas_vendidas` ;

CREATE TABLE IF NOT EXISTS `Optica`.`gafas_vendidas` (
  `venta_id` INT NOT NULL,
  `gafa_id` INT NOT NULL,
  `unidades` INT NOT NULL,
  PRIMARY KEY (`venta_id`, `gafa_id`),
  CONSTRAINT `fk_gv_venta_id`
    FOREIGN KEY (`venta_id`)
    REFERENCES `Optica`.`ventas` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_gv_gafa_id`
    FOREIGN KEY (`gafa_id`)
    REFERENCES `Optica`.`gafas` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `fk_gv_gafa_id_idx` ON `Optica`.`gafas_vendidas` (`gafa_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- ----------------------------------------------
-- POBLAR DATOS DE LAS TABLAS
-- MySQL Script generated by Cristina Cardona
-- ----------------------------------------------

INSERT INTO direcciones (calle, numero, piso, puerta, ciudad, cp, pais)
VALUES
    ('Calle Gran Vía', '10', '4', 'B', 'Madrid', '28013', 'España'),
    ('Avenida de la Constitución', '25', '2', 'A', 'Sevilla', '41001', 'España'),
    ('Carrer de Balmes', '120', '3', 'C', 'Barcelona', '08008', 'España'),
    ('Plaza del Pilar', '1', '1', 'D', 'Zaragoza', '50003', 'España'),
    ('Calle Alcalá', '50', '5', 'E', 'Madrid', '28014', 'España'),
    ('Avenida del Puerto', '8', 'B', '3', 'Valencia', '46023', 'España');
    
INSERT INTO proveedores (nif, nombre, nombre_persona_de_contacto, direccion_id, tel, fax, email)
VALUES
    ('A12345678', 'Opticas Madrid', 'Juan Pérez', 1, '910123456', '910654321', 'contacto@opticasmadrid.es'),
    ('B87654321', 'Lentes Sevilla', 'Ana López', 2, '954123456', '954654321', 'info@lentesevilla.es'),
    ('C11223344', 'Vision BCN', 'Carla Martínez', 3, '931123456', '931654321', 'ventas@visionbcn.es'),
    ('D99887766', 'Gafas Zgz', 'Luis García', 4, '976123456', '976654321', 'soporte@gafaszgz.es');
    
INSERT INTO clientes (nombre, apellido1, apellido2, referido_por_cliente_id, direccion_id, fecha_registro, email, tel)
VALUES
	('Carlos', 'Hernández', 'López', NULL, 1, NOW(), 'carlos.hernandez@gmail.com', '600123456'),
	('María', 'García', 'Pérez', NULL, 2, NOW(), 'maria.garcia@gmail.com', '610654321'),
	('Marta', 'Sánchis', 'Martín', 2, 3, NOW(), 'marta@hotmail.com', '628987654'),
	('Carmen', 'Hernández', 'Ruano', 3, 4, NOW(), 'carmen@yahoo.com', '680456789');

INSERT INTO marcas (nombre, proveedor_id)
VALUES
    ('VisionPro', 1),
    ('OptiMax', 2),
    ('LentesPlus', 3),
    ('ClearView', 3);
    
INSERT INTO gafas (nombre, marca_id, graduacion_izdo, graduacion_dcho, color_izdo, color_dcho, tipo_montura, pvp)
VALUES
    ('Gafa VisionPro Modelo A', 1, 1.5, 1.75, 'Negro', 'Negro', 'pasta', 120.50),
    ('Gafa OptiMax Modelo B', 2, 2.0, 2.25, 'Azul', 'Azul', 'metálica', 135.00),
    ('Gafa LentesPlus Modelo C', 3, 0.5, 0.75, 'Rojo', 'Rojo', 'pasta', 98.75),
    ('Gafa ClearView Modelo D', 4, 1.0, 1.25, 'Verde', 'Verde', 'flotante', 150.00);

INSERT INTO empleados (nombre, apellido1, apellido2, nif)
VALUES
    ('Antonio', 'López', 'Martínez', '12345678A'),
    ('Beatriz', 'Gómez', 'Hernández', '87654321B'),
    ('Carlos', 'Pérez', 'García', '45678912C'),
    ('Diana', 'Ruiz', 'Fernández', '78912345D');

INSERT INTO ventas (cliente_id, fecha_venta, empleado_id, num_factura)
VALUES
    (1, '2024-03-10 10:30:00', 3, 'F001'),
    (2, '2024-05-10 11:00:00', 2, 'F002'),
    (3, '2024-07-10 11:30:00', 3, 'F003'),
    (4, '2024-09-10 12:00:00', 1, 'F004');
    
INSERT INTO gafas_vendidas (venta_id, gafa_id, unidades)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 1),
    (4, 4, 3);


-- ----------------------------------------------
-- CONSULTAS DE PRUEBA
-- MySQL Script generated by Cristina Cardona
-- ----------------------------------------------


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
