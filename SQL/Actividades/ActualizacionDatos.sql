/**EJERCICIO 1**/
-- 1. Los datos de un empleado cuyo código será el 111, su nombre es Amadeo
-- Benítez López, su cargo es representante, su fecha de nacimiento
-- '12/09/1965', su jefe será el empleado 104 y su contrato tiene la fecha de hoy.
-- Aún no se ha asignado a ninguna oficina ni se han establecido cuota ni
-- ventas.
INSERT INTO empleado (NUMEMP, NOMBRE, FNAC, CARGO, JEFE, CODOFICINA) 
VALUES (110,'Benítez López, Antonio','1965-09-12', 'representante',3, 1);

-- Se tiene que poner la oficina tambien por las restrinciones de nuestra base de datos.
-- El contrato es TIMESTAN y como no null por lo que se genera sola.

-- 2. Los datos de una nueva oficina en la ciudad de Málaga, región sur. El
-- director será el empleado 105. Su código será 29. Aún no se conocen más
-- datos de la misma.
INSERT INTO oficina (CIUDAD,REGION,DIRECTOR,OFICINA)
VALUES ('Malaga','Sur', 1, 28);

-- 3. Los datos de un nuevo producto, añadiendo, en este mismo orden, el precio
-- será 200, la descripción manivela, su código 123 y sus existencias 20.
INSERT INTO producto (PRECIO, DESCRIPCION, IDPRODUCTO, EXISTENCIAS)
VALUES (200, 'manivela', 123, 20);

-- 4. Inserta en las tablas de pedidos y líneas de pedido, un pedido número 11223,
-- fecha actual, realizado por el cliente 2106. El producto pedido es el de
-- código 773c. Se piden 10 unidades del mismo, con un importe de 9750.
INSERT INTO pedido (NUMPEDIDO, CLIENTE) VALUES (11223, 1);
INSERT INTO lineaspedido VALUES(11223, 1,123,10,9750);

/**EJERCICIO 2**/
-- a) Los datos de un empleado cuyo código será el 111, su nombre es Benítez López,
-- Amadeo su cargo es representante, su fecha de nacimiento '12/09/1965', su jefe
-- será el empleado López Gómez, José y su contrato tiene la fecha de hoy. Aún no
-- se ha asignado a ninguna oficina ni se han establecido cuota ni ventas.
INSERT INTO empleado (NUMEMP, NOMBRE, CARGO) VALUES (129, 'López Gómez, José', 'jefe grupo');
INSERT INTO empleado (NUMEMP, NOMBRE, CARGO, FNAC, JEFE, FCONTRATO) 
SELECT 127, 'Béni Lop, Amadeo', 'representante', '1980-06-21', NUMEMP, NOW() FROM empleado
WHERE NOMBRE='López Gómez, José';

-- b) Crea una nueva tabla llamada InformeVentas en la BD Ventas. Dicha tabla estará
-- compuesta por un campo de tipo texto llamado Empleado, otro de tipo numérico
-- llamado CodOficina, y dos campos de tipo entero llamados VentasEmpleados y
-- VentasOficinas. No es necesario definir ninguna clave principal para esta tabla.
 CREATE TABLE `informeventas` (
  `EMPLEADO` varchar(30) NOT NULL,
  `CODOFICINA` int(10) DEFAULT NULL,
  `VENTASEMPLEADO` int(20) DEFAULT NULL,
  `VENTASOFICINA` int(20) DEFAULT NULL,
  PRIMARY KEY (`EMPLEADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- c) Inserta en la nueva tabla todos los empleados existentes en la tabla empleado con
-- sus códigos de oficinas correspondientes y con sus VentasOficina y
-- Ventasempleado con un valor de 50000 euros cada una de ellas.
INSERT INTO informeventas (EMPLEADO, CODOFICINA, VENTASEMPLEADO, VENTASOFICINA) 
SELECT NOMBRE, CODOFICINA, 50000, o.VENTAS FROM empleado e, oficina o WHERE e.CODOFICINA = o.OFICINA;

-- d) Insertar en la tabla InformeVentas los empleados de la oficina 50, sus datos serán
-- el nuevo código de oficina 80 y sus ventas de empleado correspondientes.
TRUNCATE informeventas;
INSERT INTO informeventas (EMPLEADO, CODOFICINA, VENTASEMPLEADO, VENTASOFICINA)
SELECT NOMBRE, 50, e.VENTAS, o.VENTAS FROM empleado e, oficina o WHERE e.CODOFICINA = o.OFICINA AND e.CODOFICINA=1;

-- e) Inserta en la tabla anterior los nombres de los empleados, los códigos de sus
-- oficinas y las ventas del mismo y de su oficina, para aquellos empleados que
-- hayan superado su cuota de ventas y tengan jefe.
TRUNCATE informeventas;
INSERT INTO informeventas (EMPLEADO, CODOFICINA, VENTASEMPLEADO, VENTASOFICINA)
SELECT NOMBRE, CODOFICINA, e.VENTAS, o.VENTAS FROM empleado e, oficina o 
WHERE e.CODOFICINA = o.OFICINA AND e.VENTAS > CUOTA AND JEFE IS NOT NULL;

-- f) Añade a la tabla anterior los nombres de los empleados que sean representantes
-- de algún cliente y las ventas de sus oficinas.
TRUNCATE informeventas;
INSERT INTO informeventas (EMPLEADO, VENTASOFICINA)
SELECT DISTINCT e.NOMBRE, o.VENTAS FROM empleado e, oficina o, cliente 
WHERE e.CODOFICINA = o.OFICINA AND NUMEMP = REPCLIE;

-- g) Añade a la tabla anterior los nombres de los empleados, los códigos de sus
-- oficinas y las ventas de su oficina, para aquellos empleados cuyos clientes hayan
-- pedido alguna vez un reostato o una red.
TRUNCATE informeventas;
INSERT INTO informeventas (EMPLEADO, VENTASOFICINA)
SELECT DISTINCT e.NOMBRE, o.VENTAS FROM empleado e, oficina o, pedido p, lineaspedido l, cliente, producto pr
WHERE e.CODOFICINA = o.OFICINA AND NUMEMP = REPCLIE  AND NUMCLIE = CLIENTE 
AND p.NUMPEDIDO = l.NUMPEDIDO AND l.IDPRODUCTO = pr.IDPRODUCTO AND DESCRIPCION = 'Muñeca Trapo';

TRUNCATE informeventas;
INSERT INTO informeventas (EMPLEADO, VENTASOFICINA)
SELECT e.NOMBRE, o.VENTAS FROM empleado e, oficina o
WHERE e.CODOFICINA = o.OFICINA AND NUMEMP IN (SELECT REPCLIE FROM cliente, pedido WHERE NUMCLIE = CLIENTE
AND NUMPEDIDO IN (SELECT NUMPEDIDO FROM lineaspedido l, producto p WHERE l.IDPRODUCTO = p.IDPRODUCTO AND DESCRIPCION = 'Muñeca Trapo' ));

-- h) Crea una nueva tabla llamada ResumenEmpleados en la BD Ventas. Dicha tabla
-- estará compuesta por un campo de tipo texto llamado Empleado y otro de tipo
-- numérico llamado CodOficina. No es necesario definir ninguna clave principal
-- para esta tabla.
CREATE TABLE `resumenempleados` (
  `EMPLEADO` int(3) DEFAULT NULL,
  `CODOFICINA` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- i) Inserta en esta tabla los nombres de empleados y códigos de oficina de la tabla
-- InformeVentas, de todos los empleados cuyas ventas supongan más de la mitad
-- de las ventas de su oficina y su contrato sea anterior a 1989.
TRUNCATE resumenempleados;
INSERT INTO resumenempleados
SELECT EMPLEADO, CODOFICINA  FROM informeventas WHERE VENTASEMPLEADO > VENTASOFICINA/2;

-- j) Añade a esta tabla los nombres de todos los representantes cuyos clientes hayan
-- realizado algún pedido con un importe mayor de 5000.
TRUNCATE resumenempleados;
INSERT INTO resumenempleados (EMPLEADO) SELECT DISTINCT e.NOMBRE FROM empleado e, pedido p, lineaspedido l, cliente 
WHERE REPCLIE=NUMEMP AND NUMCLIE=p.CLIENTE AND l.NUMPEDIDO=p.NUMPEDIDO HAVING (SELECT SUM(IMPORTE) FROM lineaspedido) > 50;

/**EJERCICIO 3**/
-- a) Añadir una nueva tabla, llamada ejercicio31, a la BD Ventas. Esta nueva tabla
-- contendrá los códigos de todos los productos existentes, sus precios y sus
-- existencias, así como el número total de unidades vendidas. A este último campo
-- se llamará cantidadvendida con valor 0 por defecto si el producto no se ha
-- vendido nunca.
CREATE TABLE `ejercicio31` (
  `PRODUCTO` varchar(6) NOT NULL,
  `PRECIO` int(4) DEFAULT NULL,
  `EXISTENCIAS` int(4) DEFAULT NULL,
  `CANTIDADVENDIDA` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PRODUCTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- b) Cambia todos los valores del campo cantidadvendida de la tabla anterior que
-- sean menores que 10 por el valor 0.
INSERT INTO ejercicio31 SELECT PRODUCTO, PRECIO, EXISTENCIAS, CANTIDADVENDIDA FROM producto, pedido, lineaspedido
WHERE 
-- c) Incrementa el nivel de existencias de todos los productos cuyo código comience
-- por 41 en 25 unidades.

-- d) Rebaja el precio a la mitad de los artículos cuyo código comienza por 2. No se
-- tocará el precio de un artículo si ya es menor de 100 €.

-- e) Incrementa en un 15% el precio de todos los productos de la tabla ejercicio31
-- para los que la cantidad vendida suponga al menos el 20% de las existencias
-- actuales.

-- f) Rebaja en un 5% el precio de todos los productos que cuesten menos de 1000 €
-- y cuyo nivel de existencias sea mayor del doble de la media de las existencias de
-- todos los productos.

-- g) Resta 10 al campo cantidadvendida de todos los productos que tengan un valor
-- en este campo mayor que 10 y para los cuales se hayan realizado al menos dos
-- ventas.

