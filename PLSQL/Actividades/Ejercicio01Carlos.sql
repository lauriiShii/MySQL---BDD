CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio01Carlos`(cadenaE varchar(50), out cadenaS varchar(50))
BEGIN
			
DECLARE pos INT DEFAULT 1;
			
			
SET cadenaS = "";

			
WHILE pos<=CHAR_LENGTH(cadenaE) DO
				
SET cadenaS = CONCAT(cadenaS, UPPER(SUBSTRING(cadenaE, pos, 1)));
				
SET pos=pos+1;
			
END WHILE;
		
END