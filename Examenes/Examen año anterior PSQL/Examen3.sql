CREATE DEFINER=`root`@`localhost` PROCEDURE `Ejercicio3`(codigo VARCHAR(6))
BEGIN
	DECLARE a VARCHAR(45);
	DECLARE numAlumnos INT(3);
    DECLARE numParticipantes INT(3);
    DECLARE grado INT(1);
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
    
	IF codigo != ALL(SELECT cpra FROM practica) THEN
		SELECT 'No existe esa práctica';
	ELSE
		SELECT COUNT(*) INTO numAlumnos FROM notaprac WHERE cpra = codigo;
        IF numAlumnos = 0 THEN
			SELECT 'No hay alumnos en esta práctica';
        ELSE
			SELECT nal, gra INTO numParticipantes, grado FROM practica WHERE cpra = codigo;		
			IF numAlumnos = numParticipantes AND grado < 3 THEN
				UPDATE practica SET gra = gra + 1 WHERE cpra = codigo;
                COMMIT;
			END IF;
		END IF;
	END IF;
END