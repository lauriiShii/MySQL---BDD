CREATE DEFINER=`root`@`localhost` FUNCTION `ejercicio8`() RETURNS int(20)
BEGIN
    RETURN  YEAR((SELECT fnac FROM empleado));
END