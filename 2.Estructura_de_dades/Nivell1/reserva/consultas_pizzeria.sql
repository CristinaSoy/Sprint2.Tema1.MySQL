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

INSERT INTO pizzeria.empleados (id, nif, nombre, apellido1, apellido2, tel, tienda_id)
VALUES
(1, '42152363G', 'Pedro', 'Martínez', 'Vega', '610111222', 1),
(2, '40152300G','Lucía', 'Hernández', 'Ortiz', '610333444', 2),
(3, '49152399G','Javier', 'Díaz', 'Gil', '610555666', 3),
(4, '45152333G','Claudia', 'Ramírez', 'Rojas', '610777888', 4),
(5, '47152322G','Daniel', 'Santos', 'Castro', '610999000', 5);

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