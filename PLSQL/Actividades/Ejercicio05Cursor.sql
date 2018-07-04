CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio05Cursor`()
BEGIN

-- Declaramos variables
DECLARE nomb VARCHAR(30);
DECLARE fechaAlt DATE;
DECLARE hecho BOOLEAN DEFAULT 0;

-- Definicion consulta (cursor)
DECLARE cur CURSOR FOR SELECT nombre,fcontrato FROM empleado ORDER BY 1;

-- Mensajes de error
DECLARE EXIT HANDLER FOR 1146 SELECT 'No existe la tabla';
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET hecho=1;

-- Abrimos cursor
OPEN cur;

	-- Iniciamos nuestro bucle de lectura
	loop1: LOOP
    
		-- Obtenemos la primera fila en las variables correspondientes
		FETCH cur INTO nomb,fechaAlt;
        
        -- Si el cursor se quedó sin elementos,
		-- entonces nos salimos del bucle
		IF hecho THEN
		LEAVE loop1;
		END IF;

		-- Imprimimos fecha y nombre
		 -- SET CONCAT(SELECT nomb, fechaAlt);

	END LOOP loop1;
    
-- Cerramos cursor
CLOSE cur;

END