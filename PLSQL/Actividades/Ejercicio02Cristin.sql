CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio02Cristin`(cadena varchar(255))
BEGIN
    declare exit handler for sqlexception, sqlwarning
    begin
		select "Se ha producido un error inesperado" as "mensaje";
    end;
	select reverse(cadena);
END