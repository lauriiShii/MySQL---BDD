CREATE DEFINER=`root`@`localhost` PROCEDURE `Ejercicio14`(cadena VARCHAR(30))
BEGIN
	DECLARE a VARCHAR(45);
    DECLARE b INT(3);
	DECLARE num INT(3);
	DECLARE patron VARCHAR(32);
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SET a = 'Error desconocido';
            SELECT a 'Error';
		END;
	DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;
    
    SELECT COUNT(*) INTO b FROM empleado;
    IF b = 0 THEN
		SELECT 'Tabla vacía';
	ELSE
		SET patron = CONCAT('%', cadena, '%');
		SELECT COUNT(*) INTO num FROM empleado WHERE nombre LIKE patron;
		IF num > 0 THEN
			SELECT numemp, nombre FROM empleado WHERE nombre LIKE patron;
			SELECT num 'Número de empleados que cumplen el patrón';
		ELSE
			SET a = 'No hay empleados que cumplan ese patrón';
			SELECT a 'Error';
		END IF;
	END IF;
END