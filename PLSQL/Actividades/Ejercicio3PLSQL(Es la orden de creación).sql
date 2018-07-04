DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiaroficina`(codem int (3),codof int (2))
BEGIN
	declare exit handler for 1146
		begin
			select 'Tabla no encontrada';
		end;
    if codof not in (select oficina from oficina) then 
		select'El codigo de oficina no existe';
        
		 else if codem not in (select numemp from empleado) then 
			select'El codigo de empleado no existe';
			
            else if (select codoficina from empleado where numemp=codem)=codof then
			select 'El empleado ya esta en esa oficina';
		 else
			update empleado set codoficina=codof where numemp=codem;
         end if;   
		end if;
    end if;
END$$
DELIMITER ;
