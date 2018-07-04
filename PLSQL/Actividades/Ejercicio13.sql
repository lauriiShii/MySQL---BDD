CREATE DEFINER=`root`@`localhost` PROCEDURE `ejercicio13`()
BEGIN
 declare x int;
    
   declare exit handler for 1146
        begin
            select 'La tabla no existe' Error;
        end;
        
    declare exit handler for sqlexception, sqlwarning
        begin
            select 'Se ha producido un error desconocido' Error;
        end;
     
    select nombre, ventas from empleado order by 2 desc limit 5; 
END