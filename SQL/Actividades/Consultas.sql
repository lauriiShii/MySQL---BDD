/**************CONSULTAS*********************/

/**Ejercicio 1***/
-- a) Seleccionar el nombre de todos los empleados.
SELECT NOMBRE FROM empleado;
-- b) Seleccionar el cargo y el número de oficina de todos empleados.
SELECT CARGO, CODOFICINA 'numero oficina' FROM empleado;
-- c) Seleccionar la fecha del contrato y el nombre de los empleados que no superaron
-- su cuota de ventas.
SELECT FCONTRATO 'fecha contrato', NOMBRE FROM empleado WHERE CUOTA > VENTAS;
-- d) Seleccionar los códigos de las oficinas cuyas ventas superaron los 500000 euros
-- y que además sean del norte.
SELECT OFICINA 'codigo oficina' FROM oficina WHERE VENTAS > 500000 AND REGION = "NORTE";

/**Ejercicio 2**/
-- a) Seleccionar el nombre de todos los empleados, haciendo que aparezca como
-- cargo de la columna “Nombre de empleado”.

-- b) Seleccionar el número de oficina, con encabezado “Número de oficina”, la
-- ciudad, con encabezado “Ciudad de destino” y la región, de todas las oficinas
-- cuyo objetivo de venta sea menor de 400000.