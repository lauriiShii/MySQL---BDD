CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio7`(fecha DATE)
BEGIN
declare exit handler for 1146
		begin
			select 'Tabla no encontrada';
				end;
	SELECT ejercicio6(fecha) 'Anio correspondiente';

END