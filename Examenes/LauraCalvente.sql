-- 1) Disparador/es que controlen que si un esquiador pertenece a un equipo
-- de su federaión
DELIMITER $$
	DROP TRIGGER IF EXISTS beforeEsquiadorInsert$$
    CREATE TRIGGER beforeEsquiadorInsert BEFORE INSERT ON esquiador
    FOR EACH ROW
		BEGIN
        
        DECLARE a INT(3);
        
        SELECT eq.cod_fed INTO a FROM equipo eq, esquiador es 
        WHERE eq.cod_equ = es.cod_equ;
			IF new.COD_FED != a THEN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La federación del esquiador no coincide con la del equipo';
			END IF;
            
		END $$
DELIMITER ;

DELIMITER $$
	DROP TRIGGER IF EXISTS beforeEsquiadorUpdate$$
    CREATE TRIGGER beforeEsquiadorInsert BEFORE UPDATE ON esquiador
    FOR EACH ROW
		BEGIN
        
        DECLARE a INT(3);
        
        SELECT eq.cod_fed INTO a FROM equipo eq, esquiador es 
        WHERE eq.cod_equ = es.cod_equ;
			IF new.COD_FED != a THEN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'La federación del esquiador no coincide con la del equipo';
			END IF;
            
		END $$
DELIMITER ;

-- 2) Disparador/es que controlen que un entrenador solo pueda entrenar a un 
-- equipo y que ese equipo sea de su federacion
DELIMITER $$
	DROP TRIGGER IF EXISTS beforeEquipoInsert$$
	CREATE TRIGGER beforeEquipoInsert BEFORE INSERT ON equipo 
    FOR EACH ROW
		BEGIN
        
		DECLARE a INT (1);
		DECLARE b INT (3);
		
		SELECT count(*) INTO a FROM equipo WHERE cod_entr = new.cod_entr;
		SELECT cod_fed INTO b FROM esquiador WHERE DNI = new.cod_entr;
		
		IF a = 1 THEN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'El entrenador ya se encuentra asignado a un equipo.';
		END IF;
		IF new.Cod_fed != b THEN
			SIGNAL SQLSTATE '45000' 
			SET MESSAGE_TEXT = 'El equipo no se corresponde con la federación del entrenador';
		END IF;
        
    END $$
DELIMITER ;

-- 3) Disparador/es que comprueben que una pista compuesta está formada solo de pistas
-- de su misma estacuin y que evite que una pista esté compuesta por ella misma.
DELIMITER $$
	DROP TRIGGER IF EXISTS beforePistaCompuestaInsert$$
	CREATE TRIGGER beforePistaCompuestaInsert BEFORE INSERT ON pista_compuesta 
    FOR EACH ROW
	BEGIN
		
		DECLARE a INT (5);
		
		SELECT cod_est INTO a FROM pista WHERE n_pista = new.n_pista_comp;
        
		IF new.Cod_est != a THEN 
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'La pista no pertenece a la misma estacion que la pista compuesta';
		END IF;

		IF NEW.n_pista = NEW.n_pista_comp THEN
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'La pista no puede componerse por ella misma';        
		END IF;
        
	END$$
DELIMITER ;

DELIMITER $$
	DROP TRIGGER IF EXISTS beforePistaCompuestaUpdate$$
	CREATE TRIGGER beforePistaCompuestaUpdate BEFORE UPDATE ON pista_compuesta FOR EACH ROW
	BEGIN
		
		DECLARE a INT (5);
		
		SELECT cod_est INTO a FROM pista WHERE n_pista = new.n_pista_comp;
		
		IF new.Cod_est != a THEN
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'pista y pista compuesta no pertenecen a la misma estación';
		END IF;

		IF NEW.n_pista = NEW.n_pista_comp THEN
			SIGNAL SQLSTATE '45000' 
            SET MESSAGE_TEXT = 'La pista no puede componerse por ella misma.';        
		END IF;
        
	END$$ 
DELIMITER ;

-- 4) Procedimiento que reciba como parámetro un codigo de esquiador y visualice los 
-- codifos de las pruebas individuales y/o en equipo en las que haya participado el 
-- esquiador. Al final obtener ek nºTotal de las mismas. (Usar cursor para
-- visualizar los codigos de las pruebas)
DELIMITER $$
	DROP PROCEDURE IF EXISTS apartado04$$
	CREATE PROCEDURE `apartado04`(codigo varchar(9))
	BEGIN
		DECLARE a VARCHAR(100);
		DECLARE b INT;
		DECLARE done INT(1) DEFAULT 0;
		DECLARE individual,equipo INT;
		DECLARE curPrueba CURSOR FOR SELECT dni, cod_prueba i, cod_prueba e FROM
		esquiador d, part_prueba_indi i, part_prueba_equ e 
		WHERE d.dni = codigo AND d.dni = i.dni AND d.cod_equ=e.cod_equ;
		 
		DECLARE EXIT HANDLER FOR 1146
			BEGIN
				SET a = 'Tabla no encontrada';
				SELECT a 'Mensaje';
			END;
		
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				SET a = 'Error desconocido';
				SELECT a 'Mensaje';
			END;

		DECLARE EXIT HANDLER FOR NOT FOUND
		BEGIN
		SET a = 'Codigo del esquiador/a no encontrado';
			SELECT a 'Mensaje';
		END;
		
		DECLARE CONTINUE HANDLER FOR SQLWARNING
		BEGIN
		END;
		
		SELECT COUNT(*) INTO b FROM esquiador;

		IF b = 0 THEN
		SET a = 'La tabla esquiador se encuentra vacía';
			SELECT a 'Mensaje';
		END IF;
		
		SELECT COUNT(*) INTO b FROM esquiador WHERE dni = codigo;
		
		IF b = 0 THEN
		SET a = 'No existe el esquiador/a';
			SELECT a 'Mensaje';
		ELSE
		
		OPEN curPrueba;
		
			repeat
				FETCH curPrueba INTO codigo,individual,equipo;
					IF NOT done THEN
				SELECT cod_prueba INTO individual FROM part_prueba_indi 
                WHERE dni = codigo;
						SELECT cod_prueba INTO equipo FROM part_prueba_equ e, esquiador d 
                        WHERE d.cod_equ = e.cod_equ AND dni = codigo;
				SELECT codigo 'COD.ESQUIADOR', individual 'PRUEBA INDIVIDUAL', equipo 'PRUEBA EQUIPO';
					END IF;
			  UNTIL done
			  END repeat;
		  CLOSE curPrueba;
		  
		SELECT SUM(cod_prueba) ' TOTAL PRUEBAS' FROM cod_prueba 
        WHERE cod_prueba IN ( SELECT cod_prueba FROM part_prueba_indi WHERE dni=codigo) 
        AND cod_prueba IN (SELECT cod_prueba FROM part_prueba_equ 
        WHERE cod_equ = (SELECT cod_equ FROM esquiador WHERE dni = codigo));
		
		END IF;
	END $$
DELIMITER ;
