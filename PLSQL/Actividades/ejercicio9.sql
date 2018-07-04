CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio9`()
BEGIN
declare x int;
   declare exit handler for 1146
		begin
			select 'Tabla no encontrada';
				end;
    declare exit handler for sqlexception, sqlwarning
    begin
        select 'Error desconocido' error;
    end;
        select count(*) into x from empleado;
       
       if x=0 then
            SELECT 'Tabla vacia';
        end if;
        
    select ejercicio6(fnac) 'Anios de nacimiento' from empleado;
END