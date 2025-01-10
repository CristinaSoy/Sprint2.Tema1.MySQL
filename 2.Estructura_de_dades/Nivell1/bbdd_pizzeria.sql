-- MySQL Script generated by MySQL Workbench
-- Fri Jan 10 19:57:18 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
-- Modelo BBDD Pizzeria
-- by Cristina Cardona
DROP SCHEMA IF EXISTS `Pizzeria` ;

-- -----------------------------------------------------
-- Schema Pizzeria
--
-- Modelo BBDD Pizzeria
-- by Cristina Cardona
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`direcciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`direcciones` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`direcciones` (
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
COMMENT = 'Alias d';

CREATE INDEX `ix_d_ ciudad` ON `Pizzeria`.`direcciones` (`ciudad` ASC) INVISIBLE;

CREATE INDEX `ix_d_cp` ON `Pizzeria`.`direcciones` (`cp` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`clientes` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NULL,
  `direccion_id` INT NULL COMMENT 'no obligatoria,',
  `tel` VARCHAR(15) NOT NULL COMMENT 'No es unico por lo mismo que el email.',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cl_direccion_id`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `Pizzeria`.`direcciones` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Alias cl';

CREATE INDEX `ix_cl_direccion` ON `Pizzeria`.`clientes` (`direccion_id` ASC) INVISIBLE;

CREATE INDEX `ix_cl_apellido1` ON `Pizzeria`.`clientes` (`apellido1` ASC) VISIBLE;

CREATE INDEX `ix_tel` ON `Pizzeria`.`clientes` (`tel` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`productos` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo_producto` ENUM("pizza", "burguer", "bebida") NOT NULL,
  `pvp` DECIMAL(10,2) NOT NULL COMMENT 'decimal(10,2) 10 digitos permite uso de monedas de poco valor comparadas con euro.',
  `descripcion` VARCHAR(500) NULL,
  `imagen` VARCHAR(3000) NULL COMMENT 'Se almacenará la url de la imagen',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Alias tabla = p';

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Pizzeria`.`productos` (`nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`tiendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`tiendas` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`tiendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion_id` INT NOT NULL COMMENT 'Podria darse el caso de que en una misma dirección se decide gestionar \"dos tiendas\" como dos unidades de negocio separadas, por ejemplo dos socios que quieren desglosar su gestión. Parece raro pero es muy común.\nPor eso, no marco el campo direccion_id como único en esta tabla.',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_t_direccion_id`
    FOREIGN KEY (`direccion_id`)
    REFERENCES `Pizzeria`.`direcciones` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Alias t';

CREATE UNIQUE INDEX `nombre_UNIQUE` ON `Pizzeria`.`tiendas` (`nombre` ASC) VISIBLE;

CREATE INDEX `ix_t_direccion_id` ON `Pizzeria`.`tiendas` (`direccion_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tienda_id` INT NOT NULL,
  `cliente_id` INT NOT NULL,
  `fecha_y_hora_pedido` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Es grava automaticament la data de creació de la comanda',
  `Forma_entrega` ENUM("domicilio", "recogida") NOT NULL,
  `importe_pedido` DECIMAL(10,2) NOT NULL COMMENT 'Este campo debe calcularse mediante el formulario de recepción del pedido a partir de los campos de la tabla  productos_pedidos y productos',
   PRIMARY KEY (`id`),
  CONSTRAINT `fk_pe_cliente_id`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `Pizzeria`.`clientes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pe_tienda_id`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `Pizzeria`.`tiendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'alias tabla = pe';

CREATE INDEX `ix_pedidos_cliente_id` ON `Pizzeria`.`pedidos` (`cliente_id` ASC) VISIBLE;

CREATE INDEX `ix_pe_tienda_id` ON `Pizzeria`.`pedidos` (`tienda_id` ASC) INVISIBLE;

CREATE INDEX `ix_pe_fecha_y_hora` ON `Pizzeria`.`pedidos` (`fecha_y_hora_pedido` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`productos_pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`productos_pedidos` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`productos_pedidos` (
  `pedido_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `unidades` INT NOT NULL,
  `producto_pvp` DECIMAL(10,2) NOT NULL COMMENT 'Se obtiene de la tabla productos mediante una consulta trigger y se bloquea para que no se pueda modificar manualmente.',
  `importe` DECIMAL(10,2) GENERATED ALWAYS AS (unidades * producto_pvp) STORED,
  PRIMARY KEY (`pedido_id`, `producto_id`),
  CONSTRAINT `fk_p_pe_pedido_id`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `Pizzeria`.`pedidos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_p_pe_producto_id`
    FOREIGN KEY (`producto_id`)
    REFERENCES `Pizzeria`.`productos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Alias tabla = p_pe\ntabla para detallar las lineas de pedido.\npk compuesta';

CREATE INDEX `ix_p_pe_producto_id` ON `Pizzeria`.`productos_pedidos` (`producto_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`empleados` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tienda_id` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `tel` VARCHAR(9) NOT NULL,
  `empleo` ENUM("cocina", "reparto") NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_e_tienda_id`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `Pizzeria`.`tiendas` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Alias e';

CREATE UNIQUE INDEX `nif_UNIQUE` ON `Pizzeria`.`empleados` (`nif` ASC) VISIBLE;

CREATE UNIQUE INDEX `tel_UNIQUE` ON `Pizzeria`.`empleados` (`tel` ASC) VISIBLE;

CREATE INDEX `ix_e_tienda_id` ON `Pizzeria`.`empleados` (`tienda_id` ASC) VISIBLE;

CREATE INDEX `ix_e_apellido1` ON `Pizzeria`.`empleados` (`apellido1` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`entregas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`entregas` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`entregas` (
  `pedido_id` INT NOT NULL,
  `repartidor_id` INT NULL,
  `fecha_y_hora_entrega` TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
  `entregado` TINYINT NULL,
  PRIMARY KEY (`pedido_id`),
  CONSTRAINT `fk_en_repartidor_id`
    FOREIGN KEY (`repartidor_id`)
    REFERENCES `Pizzeria`.`empleados` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_en_pedido_id`
    FOREIGN KEY (`pedido_id`)
    REFERENCES `Pizzeria`.`pedidos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Alias en\nSolo para pedidos a domicilio.\nEl repartidor es Not Null porque cuando se crea el registro aun no está asignado.\nCuando se produce una entrega, se cambia el valor de \"entregado\" a 1. \nEsto acciona un trigger que graba la \"fecha y hora de entrega\" con la hora actual y bloquea el registro para que no se pueda modificar.';

CREATE INDEX `ix_en_repartidor_id` ON `Pizzeria`.`entregas` (`repartidor_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `pedido_id_UNIQUE` ON `Pizzeria`.`entregas` (`pedido_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `Pizzeria`.`categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`categorias` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Alias c\nSolo aplica a las pizzas';


-- -----------------------------------------------------
-- Table `Pizzeria`.`categoria_pizzas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Pizzeria`.`categoria_pizzas` ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`categoria_pizzas` (
  `pizza_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`pizza_id`),
  CONSTRAINT `fk_cp_pizza_id`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `Pizzeria`.`productos` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cp_categoria_id`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `Pizzeria`.`categorias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Alias cp\nSe desglosa de la tabla productos porque solo aplica a las pizzas';

CREATE INDEX `ix_cp_pizza_id` ON `Pizzeria`.`categoria_pizzas` (`pizza_id` ASC) VISIBLE;

CREATE INDEX `ix_cp_categoria_id` ON `Pizzeria`.`categoria_pizzas` (`categoria_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
USE `Pizzeria`;


-- -----------------------------------------------------
-- triggers
-- -----------------------------------------------------

DELIMITER $$

-- Trigger para bloquear modificaciones en el precio de productos_pedidos
DROP TRIGGER IF EXISTS `Pizzeria`.`productos_pedidos_BEFORE_UPDATE` $$
CREATE DEFINER = CURRENT_USER TRIGGER `Pizzeria`.`productos_pedidos_BEFORE_UPDATE` 
BEFORE UPDATE ON `productos_pedidos` 
FOR EACH ROW
BEGIN
	IF OLD.producto_pvp != NEW.producto_pvp THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "No se puede modificar el precio";
	END IF;
END$$

-- Trigger para asignar el precio desde la tabla productos al insertar
DROP TRIGGER IF EXISTS `Pizzeria`.`productos_pedidos_BEFORE_INSERT` $$
CREATE DEFINER = CURRENT_USER TRIGGER `Pizzeria`.`productos_pedidos_BEFORE_INSERT` 
BEFORE INSERT ON `productos_pedidos` 
FOR EACH ROW
BEGIN
	DECLARE encuentra_pvp DECIMAL(10, 2);
   
    SELECT pvp INTO encuentra_pvp
    FROM productos
    WHERE id = NEW.producto_id;
    
    SET NEW.producto_pvp = encuentra_pvp;
END$$

-- Trigger para asignar fecha y hora de entrega en la tabla entregas
USE `Pizzeria`$$
DROP TRIGGER IF EXISTS `Pizzeria`.`entregas_BEFORE_UPDATE` $$
USE `Pizzeria`$$
CREATE DEFINER = CURRENT_USER TRIGGER `Pizzeria`.`entregas_BEFORE_UPDATE` BEFORE UPDATE ON `entregas` FOR EACH ROW
BEGIN
     -- Bloquear modificaciones si el pedido ya ha sido entregado
    IF OLD.entregado = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El pedido ya se ha entregado y no se puede modificar.';
    END IF;
    
    -- Registrar la fecha y hora de entrega cuando "entregado" pase de 0 a 1
    IF NEW.entregado = 1 AND OLD.entregado = 0 THEN
        SET NEW.fecha_y_hora_entrega = CURRENT_TIMESTAMP;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- CARREGA DE DADES
-- -----------------------------------------------------

INSERT INTO pizzeria.direcciones (id, calle, numero, piso, puerta, cp, ciudad, pais)
VALUES
(1, 'Carrer Balmes', 45, '3', 'B', '08007', 'Barcelona', 'España'),
(2, 'Carrer Esperanza', 101, '1', 'A', '09008', 'Manresa', 'España'),
(3, 'Gran Via de les Corts Honrades', 685, '2', 'C', '09010', 'Manresa', 'España'),
(4, 'Passeig de Gràcia', 12, '4', 'D', '08009', 'Barcelona', 'España'),
(5, 'Carrer de la Libertad', 200, 'Bajo', '1', '08036', 'Barcelona', 'España'),
(6, 'Carrer Pau Claris', 92, '4', 'A', '08010', 'Barcelona', 'España'),
(7, 'Carrer Aragó', 150, '2', 'B', '08011', 'Barcelona', 'España'),
(8, 'Rambla Catalunya', 120, '3', 'C', '08008', 'Barcelona', 'España'),
(9, 'Carrer Villarroel', 75, '5', 'D', '08011', 'Barcelona', 'España'),
(10, 'Carrer Consell de Cent', 250, 'Bajo', '1', '08007', 'Barcelona', 'España');

INSERT INTO pizzeria.tiendas (id, nombre, direccion_id)
VALUES
(1, 'Pizzería Gràcia', 1),
(2, 'Pizzería Eixample', 2),
(3, 'Pizzería Sants', 3),
(4, 'Pizzería Les Corts', 4),
(5, 'Pizzería Poblenou', 5);


INSERT INTO pizzeria.clientes (id, nombre, apellido1, apellido2, direccion_id, tel)
VALUES
(1, 'Juan', 'Pérez', 'López', 6, '666111222'),
(2, 'María', 'González', 'Martínez', 7, '666333444'),
(3, 'Carlos', 'Sánchez', 'Ruiz', 8, '666555666'),
(4, 'Laura', 'Fernández', 'Hernández', 9, '666777888'),
(5, 'Ana', 'García', 'Morales', 10, '666999000');

INSERT INTO `Pizzeria`.`empleados` (tienda_id, nombre, apellido1, apellido2, nif, tel, empleo)
VALUES
(1, 'Pedro', 'López', 'Martínez', '42152363G', '610111222', 'cocina'),
(2, 'Laura', 'Pla', 'Fernández', '40152300H', '610333444', 'reparto'),
(3, 'Carlos', 'Pérez', 'Sánchez', '49152399J', '610555666', 'cocina'),
(4, 'Ana', 'Hernández', 'García', '45152333K', '610777888', 'reparto'),
(5, 'Juan', 'Ramírez', 'Rodríguez', '47152322L', '610999000', 'cocina');

INSERT INTO pizzeria.productos (id, nombre, tipo_producto, pvp, descripcion, imagen)
VALUES
(1, 'Pizza Margarita', 'Pizza', 8.50, 'Pizza clásica con tomate y mozzarella', 'https://example.com/imagenes/pizza_margarita.jpg'),
(2, 'Pizza Carbonara', 'Pizza', 9.50, 'Pizza con nata, bacon y queso', 'https://example.com/imagenes/pizza_carbonara.jpg'),
(3, 'Pizza Cuatro Quesos', 'Pizza', 10.00, 'Pizza con una mezcla de cuatro quesos', 'https://example.com/imagenes/pizza_cuatro_quesos.jpg'),
(4, 'Pizza Pepperoni', 'Pizza', 9.00, 'Pizza con pepperoni y mozzarella', 'https://example.com/imagenes/pizza_pepperoni.jpg'),
(5, 'Pizza Vegetal', 'Pizza', 8.00, 'Pizza con verduras frescas', 'https://example.com/imagenes/pizza_vegetal.jpg'),
(6, 'Coca-Cola', 'Bebida', 1.50, 'Refresco de cola', 'https://example.com/imagenes/coca_cola.jpg'),
(7, 'Agua Mineral', 'Bebida', 1.00, 'Botella de agua mineral', 'https://example.com/imagenes/agua_mineral.jpg'),
(8, 'Fanta Naranja', 'Bebida', 1.50, 'Refresco de naranja', 'https://example.com/imagenes/fanta_naranja.jpg'),
(9, 'Cerveza', 'Bebida', 2.00, 'Cerveza artesanal', 'https://example.com/imagenes/cerveza.jpg'),
(10, 'Té Helado', 'Bebida', 1.80, 'Refresco de té helado con limón', 'https://example.com/imagenes/te_helado.jpg'),
(11, 'Hamburguesa Clásica', 'Burguer', 6.00, 'Hamburguesa con carne, lechuga, tomate y queso', 'https://example.com/imagenes/hamburguesa_clasica.jpg'),
(12, 'Hamburguesa BBQ', 'Burguer', 7.50, 'Hamburguesa con salsa barbacoa y cebolla caramelizada', 'https://example.com/imagenes/hamburguesa_bbq.jpg'),
(13, 'Hamburguesa Vegana', 'Burguer', 8.00, 'Hamburguesa con base vegetal, lechuga y tomate', 'https://example.com/imagenes/hamburguesa_vegana.jpg'),
(14, 'Cheeseburger', 'Burguer', 6.50, 'Hamburguesa con doble queso', 'https://example.com/imagenes/cheeseburger.jpg'),
(15, 'Hamburguesa Picante', 'Burguer', 7.00, 'Hamburguesa con jalapeños y salsa picante', 'https://example.com/imagenes/hamburguesa_picante.jpg');



INSERT INTO pizzeria.categorias (id, nombre)
VALUES
(1, 'Clásicas'),
(2, 'Especiales'),
(3, 'Vegetarianas');

INSERT INTO pizzeria.categoria_pizzas (pizza_id, categoria_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 3);

INSERT INTO pizzeria.pedidos (id, tienda_id, cliente_id, fecha_y_hora_pedido, forma_entrega, importe_pedido)
VALUES
(1, 1, 1, '2024-01-01 12:30:00', 'domicilio', 25.50),
(2, 2, 2, '2024-01-02 13:00:00', 'recogida', 19.00),
(3, 3, 3, '2024-01-03 14:00:00', 'domicilio', 28.00),
(4, 4, 4, '2024-01-04 15:30:00', 'domicilio', 15.00),
(5, 5, 5, '2024-01-05 16:00:00', 'recogida', 20.00);

INSERT INTO pizzeria.productos_pedidos (pedido_id, producto_id, unidades)
VALUES
(1, 1, 2),  -- Pedido 1, Pizza Margarita, 2 unidades
(1, 6, 3),  -- Pedido 1, Coca-Cola, 3 unidades
(2, 2, 1),  -- Pedido 2, Pizza Carbonara, 1 unidad
(2, 7, 2),  -- Pedido 2, Agua Mineral, 2 unidades
(3, 3, 1),  -- Pedido 3, Pizza Cuatro Quesos, 1 unidad
(3, 8, 2),  -- Pedido 3, Fanta Naranja, 2 unidades
(4, 4, 1),  -- Pedido 4, Pizza Pepperoni, 1 unidad
(4, 9, 2),  -- Pedido 4, Cerveza, 2 unidades
(5, 5, 1),  -- Pedido 5, Pizza Vegetal, 1 unidad
(5, 10, 1); -- Pedido 5, Té Helado, 1 unidad

INSERT INTO pizzeria.entregas (pedido_id, repartidor_id, fecha_y_hora_entrega, entregado)
VALUES
(1, 1, '2024-01-01 13:00:00', 1),
(2, 2, '2024-01-02 13:30:00', 1),
(3, 3, '2024-01-03 14:30:00', 1),
(4, 4, '2024-01-04 16:00:00', 1),
(5, 5, NULL, 0); -- pedido no entregado, 
				 -- la fecha y hora de entrega será fijada por el trigger cuando se declare que el pedido ha sido entregado
                 
-- -----------------------------------------------------
-- CONSULTES DE TEST
-- -----------------------------------------------------              

--	Productes de tipus “Begudes” venuts en una determinada localitat.

SELECT
	p.tipo_producto,
    d.ciudad,
    SUM(p_pe.unidades) AS unidades_vendidas	
FROM pizzeria.productos_pedidos p_pe
JOIN productos p
	ON p.id = p_pe.producto_id
JOIN pedidos pe
	ON pe.id = p_pe.pedido_id
JOIN tiendas t
	ON t.id = pe.tienda_id
JOIN direcciones d
	ON d.id = t.direccion_id
WHERE p.tipo_producto = "bebida"
AND d.ciudad = "Barcelona"
GROUP BY p.tipo_producto; 

-- comandes  efectuades per un determinat empleat

SELECT
	e.nombre, e.apellido1, e.apellido2,    
	COUNT(en.pedido_id) AS pedidos_entregados
FROM pizzeria.entregas en
JOIN empleados e
	ON e.id = en.repartidor_id

WHERE e.apellido1 = "Pla"
AND en.entregado = 1
GROUP BY e.id;