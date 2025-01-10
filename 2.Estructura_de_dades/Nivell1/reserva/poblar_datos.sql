--  poblar datos de las tablas


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




