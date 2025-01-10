CREATE DEFINER = CURRENT_USER TRIGGER `Optica`.`entregas_BEFORE_UPDATE` BEFORE UPDATE ON `entregas` FOR EACH ROW
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

    
END