-- a) Se pretende obtener una relación en la que aparezcan los datos de todas las
-- oficinas junto a los nombres y las edades de los directores de cada una de ellas
-- (si una oficina no tiene director entonces los datos de este aparecerán en blanco).
SELECT oficina.*, NOMBRE, year(now())-year(fnac)'Edad' FROM oficina 
LEFT JOIN empleado ON DIRECTOR=NUMEMP;

SELECT oficina.*, NOMBRE, year(now())-year(fnac)'Edad' FROM empleado 
RIGHT JOIN oficina ON DIRECTOR=NUMEMP;

-- b) Obtener una relación que contenga los nombres y cargos de los empleados así
-- como los códigos y la ciudad de las oficinas de los mismos que pertenezcan a la
-- región 'este'. Aparecerán también los empleados que no estén asignados a
-- ninguna oficina.
SELECT NOMBRE, CARGO, NUMEMP, CIUDAD, OFICINA FROM empleado  
LEFT JOIN oficina ON CODOFICINA = OFICINA WHERE REGION = 'este';

-- NO tiene sentido pedir que salga tambien los empleados que no tienen oficinas asignadas
-- ya que el codigo de oficinas en empleados no puede ser null y aunque pudiera la region del este 
-- impide que salga alguien sin oficina.

-- c) Una relación en la que aparezcan los empleados con los nombres de sus jefes,
-- aparecerán también los empleados que no tienen jefe.
SELECT e.*, j.NOMBRE 'nombre del jefe' FROM empleado e LEFT JOIN empleado j ON e.JEFE = j.NUMEMP;

