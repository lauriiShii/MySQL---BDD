CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio04`(nomE varchar(255))
BEGIN
	declare x varchar(255);
    declare i int default 1;
    declare tabla_vacia condition for sqlstate "45000";
    
    declare exit handler for tabla_vacia 
		begin 
			select "La tabla empleado está vacía" as "Mensaje";
        end;
	declare exit handler for 1146 -- Tabla no existe.
		begin 
			select "La tabla no existe" as "Mensaje";
		end;
	declare exit handler for not found 
		begin 
			select "No se ha encontrado el empleado." as "mensaje";
		end;
	declare exit handler for sqlexception, sqlwarning
		begin
			select "Se ha producido un error inesperado" as "Mensaje";
        end;
	
    select count(*) into i from empleado;
	if (i = 0) then 
		signal tabla_vacia;
	end if;
    
    select nombre into x from empleado where nombre = nomE;
	select * from empleado where nombre = nomE;
END