CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio12`(numero int)
BEGIN
 declare x int default 0;
   
   declare exit handler for 1146
        begin
            select 'La tabla no existe' Error;
        end;
   
    declare exit handler for not found
   begin
       select 'Empleado no encontrado' error;
	end;
   
	declare exit handler for sqlexception, sqlwarning
    begin
        select 'Error desconocido' error;
    end; 
    
      declare exit handler for 1451
    begin
    SELECT 'No se puede eliminar. Tiene cargo importante.';
    end;
    
  
    select count(*) into x from empleado;
    if x=0 then
		select 'La tabla esta vacia';
	else
	
		select numemp into x from empleado where numemp=numero;
		delete from empleado where numemp=numero;
        SELECT 'El empleado ha sido borrado satisfactoriamente';
	end if;
END