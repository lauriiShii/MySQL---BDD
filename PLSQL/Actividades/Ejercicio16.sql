CREATE DEFINER=`root`@`localhost` PROCEDURE `Ejercicio16`()
BEGIN
	DECLARE a VARCHAR(30);
    DECLARE b INT(3);
    DECLARE c INT(3);
	DECLARE e INT(1);
	DECLARE done INT(1) DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT oficina FROM oficina;
	DECLARE cur2 CURSOR FOR	SELECT numemp, ventas FROM empleado WHERE codoficina = b ORDER BY ventas;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	DECLARE EXIT HANDLER FOR 1146
		BEGIN
			SET a = 'Tabla no encontrada';
            SELECT a 'Error';
		END;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SET a = 'Error desconocido';
            SELECT a 'Error';
		END;
	DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;
    
    SELECT COUNT(*) INTO b FROM oficina;
	IF b = 0 THEN
		SELECT 'Tabla vacía';
	ELSE
		OPEN cur;
		REPEAT
			FETCH cur INTO b;
			IF NOT done THEN
				SELECT b 'Número de la oficina';
				SET e = 0;
                OPEN cur2;
                REPEAT
					FETCH cur2 INTO b, c;
					IF NOT done and e < 2 THEN
						SELECT b 'Numemp', c 'Ventas';
						SET e = e + 1;
					END IF;
				UNTIL done OR e >= 2
				END REPEAT;
                CLOSE cur2;
                SET done = 0;

				IF e = 0 THEN
					SELECT 'No hay empleados' INTO a;
					SELECT a 'Error';
				END IF;
			END IF;
		UNTIL done
		END REPEAT;
		CLOSE cur;
	END IF;
END