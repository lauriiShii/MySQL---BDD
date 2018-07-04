/*1.- Procedimiento que dada una cadena la convierta a mayúsculas.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS whileProcedure$$
CREATE PROCEDURE whileProcedure(cadena VARCHAR(255))
BEGIN
	declare exit handler for sqlexception, sqlwarning
    begin
		select 'error' as 'mensaje';
    end;
    SElect UPPER(cadena);
END $$
DELIMITER ;
call whileProcedure("joaquin");



/*2.- Procedimiento que invierta una cadena.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS invertir$$
CREATE PROCEDURE invertir(cad varchar(255))
BEGIN
DECLARE pos INT;
        DECLARE cadena VARCHAR(255);
		SET cadena="";
		SET pos=CHAR_LENGTH(cad);
	WHILE pos>0 DO
		SET cadena=CONCAT(cadena, UPPER(SUBSTRING(cad, pos, 1)));
		SET pos=pos-1;
	END WHILE;
    SELECT cadena;
END $$
DELIMITER ;
CALL invertir("Hola mundo");



/*3.- Procedimiento que cambie de oficina a un determinado empleado cuyo código será
pasado en la llamada.*/
DELIMITER $$
	DROP PROCEDURE IF EXISTS procedurep$$
	CREATE PROCEDURE procedurep(codemp int, numof int)
	BEGIN
 	declare x, y int default 0;
        select count(*) into x from empleado where numemp=codEmp;
        select count(*) into y from oficina where oficina=numof;
        if x=1 and y=1 then
		update empleado set codoficina=numof where codemp=numemp;
            	select * from empleado where numemp=codemp;
		elseif x=0 or y=0 then
			select "Falla algún dato";
		end if;
END $$
DELIMITER ;
CALL procedurep(27, 12);

DELIMITER $$
	DROP PROCEDURE IF EXISTS procedurep$$
	CREATE PROCEDURE procedurep(codemp int, numof int)
	BEGIN
	declare x, y int default 0;
	declare exit handler for not found
    begin
		if (x=0) then
			select 'error en el codigo';
		elseif (y=0) then
			select 'error en la oficina';
		end if;
    end;
        select numemp into x from empleado where numemp=codEmp;
        select oficina into y from oficina where oficina=numof;
		update empleado set codoficina=numof where codemp=numemp;
END $$
DELIMITER ;
CALL procedurep(26799, 12);



/*4.- Procedimiento en el que a partir del nombre de un empleado se muestren los datos del
mismo.*/
DELIMITER $$
	DROP PROCEDURE IF EXISTS procedurep$$
	CREATE PROCEDURE procedurep(codEmp int)
	BEGIN
 	declare x int default 0;
    declare exit handler for not found
    begin
		if (x=0) then
			select 'error en el codigo' error;
		end if;
    end;
    declare exit handler for sqlexception, sqlwarning
    begin
		select 'error desconocido' error;
    end;
        select numemp into x from empleado where numemp=codEmp;
        select * from empleado where numemp=codEmp;
END $$
DELIMITER ;
CALL procedurep(222);



/*5.- Procedimiento que muestre un listado ordenado de nombres y fechas de alta de los
empleados.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS procedurep$$
CREATE PROCEDURE procedurep()
	BEGIN
    declare j int;
    declare tabla_vacia condition for sqlstate "45000";
    declare exit handler for tabla_vacia
    begin
        select 'tabla vacia' error;
	end ;
		select count(*) into j from empleado;
        if j=0 then
			signal tabla_vacia;
        end if;
 		select nombre,fcontrato from empleado order by nombre;
END $$
DELIMITER ;
CALL procedurep();



/*6.- Escribir una función que reciba una fecha y devuelva el año correspondiente a esa
fecha.*/
CREATE DEFINER=`root`@`localhost` FUNCTION `anio`(fecha date) RETURNS int(20)
BEGIN
	RETURN year(fecha);
END



/*7.- Escribir un procedimiento que haga uso del procedimiento anterior.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS procedurep2$$
CREATE PROCEDURE procedurep2(fecha date)
BEGIN
declare exit handler for sqlexception, sqlwarning
    begin
		select 'error desconocido' error;
    end;
 	select anio(fecha);
END $$
DELIMITER ;
CALL procedurep2("2015-04-19");



/*9.- Procedimiento que muestre los años de nacimiento de todos los empleados usando la
función anterior.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS procedurep2$$
CREATE PROCEDURE procedurep2()
BEGIN
declare x int;
    declare tabla_vacia condition for sqlstate "45000";
    declare exit handler for tabla_vacia
    begin
        select 'tabla vacia' error;
	end ;
    declare exit handler for sqlexception, sqlwarning
    begin
		select 'error desconocido' error;
    end;
		select count(*) into x from empleado;
        if x=0 then
			signal tabla_vacia;
        end if;
 	select anio(fnac) 'años de nacimiento' from empleado;
END $$
DELIMITER ;
CALL procedurep2();



/*10.- Función que devuelva el nº de años completos que hay entre dos fechas pasadas por
parámetros.*/
CREATE DEFINER=`root`@`localhost` FUNCTION `edad`(fecha1 date, fecha2 date) RETURNS int(11)
BEGIN
    declare a int;
    declare b int;
    set a=anio(fecha1);
    set b=anio(fecha2);
RETURN a-b;
END



/*11.- Escribir una función que haciendo uso de la función anterior, devuelva el nº de trienios
que hay entre las dos fechas.*/
CREATE DEFINER=`root`@`localhost` FUNCTION `trienios`(fecha1 date, fecha2 date) RETURNS float
BEGIN
	RETURN edad(fecha1, fecha2)/3;
END



/*12.- Procedimiento que permita borrar un empleado cuyo nº se pasará en la llamada.*/
DELIMITER $$
DROP PROCEDURE IF EXISTS procedurep$$
CREATE PROCEDURE procedurep(numero int)
BEGIN
	declare x int default 0;
	declare exit handler for not found
    begin
		if (x=0) then
			select 'error en el numero de empleado' error;
		end if;
    end;
    declare exit handler for sqlexception, sqlwarning
    begin
		select 'error desconocido' error;
    end;
	select numemp into x from empleado where numemp=numero;
	delete from empleado where numemp=numero;
END $$
DELIMITER ;
CALL procedurep(365);
