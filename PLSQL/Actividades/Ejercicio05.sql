CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio05`()
BEGIN
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
	declare exit handler for sqlwarning, sqlexception 
    begin
		select "Se ha producido un error inesperado" as "mensaje";
    end;
    
    select count(*) into i from empleado;
    if (i = 0) then 
		signal tabla_vacia;
    end if;
	select * from empleado order by nombre, fcontrato;
END