CREATE DEFINER=`root`@`localhost` FUNCTION `ejericio11`(fecha1 date, fecha2 date) RETURNS float
BEGIN
    RETURN edad(fecha1, fecha2)/3;
END