/* 

ANTONIO BENITEZ MARTINEZ

EJERCICIO 4

Delimiter $$

Create procedure `pruebas_esqui` (cod_esq varchar(9))
Begin
	

	DECLARE a VARCHAR(30);
    DECLARE b INT(3);
    DECLARE c INT (3);
    Declare d Int (3);
    Declare e int (3);
    DECLARE SUMA int (3);
    DECLARE done INT(1) default (0);
    

    DECLARE cur CURSOR FOR SELECT cod_prueba FROM part_prueba_indi where Dni = cod_esq;
    DECLARE cur2 CURSOR FOR SELECT cod_prueba FROM part_prueba_equ pe, esquiador e where pe.COD_EQU = e.cod_equ AND e.DNI = cod_esq;
    

	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	DECLARE EXIT HANDLER FOR 1146
		BEGIN
			SET a = 'Tabla no encontrada';
			SELECT a 'Error';
		END;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			SET a = 'Error desconocido';
			SELECT a 'Error';
		END;
	DECLARE CONTINUE HANDLER FOR SQLWARNING BEGIN END;
	

	If cod_esq not in (Select Dni from esquiador) Then
		Select 'El esquiador no existe';
	

    Else 
		Select count(*) into b from part_prueba_indi pi where pi.DNI = cod_esq;
		If b = 0 then
			Select 'El esquiador no tiene pruebas individuales';
            
		Else 
			open cur;
			repeat
				fetch cur into d;
                IF NOT done then
				Select d 'Codigo prueba individual';
                End if;
            Until done
			End repeat;
            close cur;
            set done = 0;
		End If;
				
                
		Select count(*) into c FROM part_prueba_equ pe, esquiador e where pe.COD_EQU = e.cod_equ AND e.DNI = cod_esq;   
		If c = 0 then
			Select 'El esquiador no tiene pruebas de equipo';
		
        Else
			open cur2;
            repeat
				Fetch cur2 into e;
                IF NOT done then
				Select e 'Codigo prueba equipo';
                End if;
            Until done
            end repeat;
            close cur2;
        End if;
        
        Set suma = c + b;
        
        Select suma 'Numero total de pruebas';
		
        
       
	End if;
	
End$$


EJERCICIO 1

Delimiter $$
CREATE TRIGGER `esqui`.`esquiador_before_insert` BEFORE INSERT ON `esquiador` FOR EACH ROW
BEGIN
	Declare codigo int (3);
	Select cod_equ into codigo from equipo e where new.cod_equ = e.cod_equ;
	
    If codigo != new.cod_fed then
    
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, NO COINCIDE LA FEDERACION DEL EQUIPO CON LA DEL ESQUIADOR';
    
    end if;
	
END$$ 


DELIMITER $$
CREATE TRIGGER `esqui`.`esquiador_before_update` BEFORE UPDATE ON `esquiador` FOR EACH ROW
BEGIN
	Declare codigo int (3);
	Select cod_equ into codigo from equipo e where new.cod_equ = e.cod_equ;
	
    If codigo != new.cod_fed then
    
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, NO COINCIDE LA FEDERACION DEL EQUIPO CON LA DEL ESQUIADOR';
    
    end if;
	
END$$ 


EJERCICIO 2

Delimiter $$
CREATE TRIGGER `esqui`.`equipo_before_insert` Before insert On `equipo` for each row
Begin
	Declare a int (1);
    Declare b int (3);
    
    select count(*) into a from equipo where cod_entr = new.cod_entr;
	Select cod_fed into b from esquiador where DNI = new.cod_entr;
    
	If a = 1 then
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, EL ENTRENADOR YA TIENE ASIGNADO UN EQUIPO.';
    
    end if;
    
    If new.Cod_fed != b then
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, EL EQUIPO NO PERTENECE A LA FEDERACION DEL ENTRENADOR.';
    
    end if;
    
	
	
End$$



Delimiter $$

CREATE TRIGGER `esqui`.`equipo_before_update` Before update On `equipo` for each row
Begin
	Declare a int (1);
    Declare b int (3);
    
    select count(*) into a from equipo where cod_entr = new.cod_entr;
	Select cod_fed into b from esquiador where DNI = new.cod_entr;
    
	If a = 1 then
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, EL ENTRENADOR YA TIENE ASIGNADO UN EQUIPO.';
    
    end if;
    
    If new.Cod_fed != b then
    
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, EL EQUIPO NO PERTENECE A LA FEDERACION DEL ENTRENADOR.';
    
    end if;
    
	
	
End$$

EJERCICIO 3

Delimiter $$
Create Trigger `esqui`.`pista_compuesta_before_insert` before insert on `pista_compuesta` for each row
Begin
	
	DECLARE a int (5);
    
    Select cod_est into a from pista where n_pista = new.n_pista_comp;
    
    If new.Cod_est != a then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, LA PISTA NO PERTENECE A LA MISMA ESTACION QUE LA PISTA COMPUESTA.';
    End If;

	If NEW.n_pista = NEW.n_pista_comp then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, LA PISTA NO PUEDE ESTAR COMPUESTA POR ELLA MISMA.';        
	End If;


End$$


Delimiter $$
Create Trigger `esqui`.`pista_compuesta_before_update` before update on `pista_compuesta` for each row
Begin
	
	DECLARE a int (5);
    
    Select cod_est into a from pista where n_pista = new.n_pista_comp;
    
    If new.Cod_est != a then 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, LA PISTA NO PERTENECE A LA MISMA ESTACION QUE LA PISTA COMPUESTA.';
    End If;

	If NEW.n_pista = NEW.n_pista_comp then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'ERROR, LA PISTA NO PUEDE ESTAR COMPUESTA POR ELLA MISMA.';        
	End If;


End$$ */