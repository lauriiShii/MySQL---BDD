CREATE DEFINER=`root`@`localhost` FUNCTION `ejercicio6`(fecha date) RETURNS int(20)
BEGIN
    RETURN  YEAR(fecha) ;
END