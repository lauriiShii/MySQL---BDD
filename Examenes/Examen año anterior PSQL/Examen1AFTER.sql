CREATE DEFINER=`root`@`localhost` TRIGGER `universidad`.`profesor_AFTER_INSERT` AFTER INSERT ON `profesor` FOR EACH ROW
BEGIN
	DECLARE a INT;
	SELECT COUNT(*) INTO a FROM profesor;
    
    IF a = 5 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, LA BASE DE DATOS SOLO SOPORTA HASTA 5 PROFESORES. ADQUIERA MYSQL PREMIUM POR SOLO 1000000€ al día';
	END IF;
    -- En el de after te deja porque no lo cuenta hasta después de hacer la inserción y el error no llega.
    -- Se arregla cambiando la condición a IF a > 5
END