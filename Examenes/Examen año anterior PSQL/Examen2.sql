CREATE DEFINER=`root`@`localhost` TRIGGER `universidad`.`notaprac_AFTER_INSERT` AFTER INSERT ON `notaprac` FOR EACH ROW
BEGIN
	DECLARE mensaje VARCHAR(45);
    DECLARE maxAlumnos INT(3);
	DECLARE numAlumnos INT(3);
    SELECT nal INTO maxAlumnos FROM practica WHERE cpra = NEW.cpra;
    SELECT COUNT(*) INTO numAlumnos FROM practica WHERE cpra = NEW.cpra;
    
    IF maxAlumnos < numAlumnos THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, NÚMERO DE ALUMNOS AL MÁXIMO';
	ELSE
		IF NEW.nota < 0 OR NEW.nota > 10 THEN
			SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, NOTA INCORRECTA';
		END IF;
	END IF;
END