CREATE DEFINER=`root`@`localhost` FUNCTION `ejercicio10`(fecha1 date, fecha2 date) RETURNS int(11)
BEGIN
    declare a int;
    declare b int;
    set a=anio(fecha1);
    set b=anio(fecha2);
RETURN a-b;
END