CREATE DEFINER = CURRENT_USER TRIGGER `Optica`.`productos_pedidos_BEFORE_INSERT` 
BEFORE INSERT ON `productos_pedidos` 
FOR EACH ROW
BEGIN
	DELCARE encuentra_precio DECIMAL(10, 2);
    
    SELECT pvp INTO encuentra_precio
    FROM productos
    WHERE id = NEW.producto_id;
    
    SET NEW.producto_pvp = encuentra_pvp;
END
