CREATE DEFINER=`root`@`localhost` PROCEDURE `Ejercicio15`(apellidos VARCHAR(30))
BEGIN
	DECLARE a VARCHAR(45);
	DECLARE suma INT(3) DEFAULT 0;
	DECLARE nom VARCHAR(30);
	DECLARE num INT(3);
	DECLARE done INT(1) DEFAULT 0;
	DECLARE patron VARCHAR(32) DEFAULT CONCAT('%', apellidos, '%');
    DECLARE cur CURSOR FOR SELECT numemp, SUBSTRING_INDEX(nombre, ',', 1) FROM empleado WHERE SUBSTRING_INDEX(nombre, ',', 1) LIKE patron;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SET a = 'Error desconocido';
            SELECT a 'Error';
		END;
	DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;
  
	SELECT COUNT(*) INTO suma FROM empleado;
	IF suma = 0 THEN
		SELECT 'Tabla vacía';
	ELSE
		SET suma = 0;
		OPEN cur;
		REPEAT
			FETCH cur INTO num, nom;
			IF NOT done THEN
				SELECT num, nom;
				SET suma = suma + 1;
			END IF;
		UNTIL done
		END REPEAT;
		CLOSE cur;
    
		IF suma > 0 THEN
			SELECT suma;
		ELSE
			SET a = 'No hay empleados que cumplan ese patrón';
			SELECT a 'Error';
		END IF;
    END IF;
END