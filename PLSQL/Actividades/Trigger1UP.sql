CREATE DEFINER=`root`@`localhost` TRIGGER `ventas`.`empleado_AFTER_UPDATE` AFTER UPDATE ON `empleado` FOR EACH ROW
BEGIN
	DECLARE a VARCHAR(500);
    
    SET a = CONCAT('[Fecha: ', NOW(), '] [N: ', OLD.numemp, '] [Nombre: ', OLD.nombre, '] [Acción: MODIFICACIÓN]');
    
    IF OLD.numemp != NEW.numemp THEN
        SET a = CONCAT(a, '[Numemp nuevo = ', NEW.numemp ,' | Numemp antiguo = ', OLD.numemp, ']');
	END IF;
    IF OLD.nombre != NEW.nombre THEN
        SET a = CONCAT(a, '[Nombre nuevo = ', NEW.nombre ,' | Nombre antiguo = ', OLD.nombre, ']');
	END IF;
    IF OLD.fnac != NEW.fnac THEN
        SET a = CONCAT(a, '[FNAC nueva = ', NEW.fnac ,' | FNAC antigua = ', OLD.fnac, ']');
	END IF;
    IF OLD.codoficina != NEW.codoficina THEN
        SET a = CONCAT(a, '[Oficina nueva = ', NEW.codoficina ,' | Nueva antigua = ', OLD.codoficina, ']');
	END IF;
    IF OLD.cargo != NEW.cargo THEN
        SET a = CONCAT(a, '[Cargo nuevo = ', NEW.cargo ,' | Cargo antiguo = ', OLD.cargo, ']');
	END IF;
    IF OLD.fcontrato != NEW.fcontrato THEN
        SET a = CONCAT(a, '[FContrato nueva = ', NEW.fcontrato ,' | FContrato antigua = ', OLD.fcontrato, ']');
	END IF;
    IF OLD.jefe != NEW.jefe THEN
        SET a = CONCAT(a, '[Jefe nuevo = ', NEW.jefe ,' | Jefe antiguo = ', OLD.jefe, ']');
	END IF;
    IF OLD.cuota != NEW.cuota THEN
        SET a = CONCAT(a, '[Cuota nueva = ', NEW.cuota ,' | Cuota antigua = ', OLD.cuota, ']');
	END IF;
    IF OLD.ventas != NEW.ventas THEN
        SET a = CONCAT(a, '[Venta nueva = ', NEW.ventas ,' | Venta antigua = ', OLD.ventas, ']');
	END IF;
    
    INSERT INTO auditemple(col1) VALUES (a);
END