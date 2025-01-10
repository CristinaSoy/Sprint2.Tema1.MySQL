CREATE DEFINER = CURRENT_USER TRIGGER `Optica`.`productos_pedidos_BEFORE_UPDATE` 
BEFORE UPDATE ON `productos_pedidos` 
FOR EACH ROW
BEGIN
	IF OLD.producto_pvp != NEW.producto_pvp THEN
		SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "No se puede modificar el precio";
	END IF;

END
