-- a) Listar las oficinas del este indicando para cada una de ellas su número, ciudad, 
-- números y nombres de sus empleados. Hacer una versión en la que aparecen 
-- sólo las que tienen empleados y otra en las que aparezcan también las 
-- oficinas del este que no tienen empleados.
SELECT OFICINA, CIUDAD, NUMEMP, NOMBRE FROM oficina, empleado WHERE OFICINA = CODOFICINA 
AND REGION='este';

SELECT OFICINA, CIUDAD, NUMEMP, NOMBRE FROM oficina LEFT JOIN empleado ON OFICINA = CODOFICINA 
WHERE REGION='este';

-- b) Listar los pedidos mostrando su número, nombre del cliente y el límite de crédito del cliente correspondiente.
SELECT NUMPEDIDO, NOMBRE, LIMCREDITO FROM pedido, cliente WHERE CLIENTE = NUMCLIE;

-- c) Listar los datos de cada uno de los empleados, la ciudad y región en donde trabaja.
SELECT empleado.*, CIUDAD, REGION FROM empleado, oficina WHERE CODOFICINA = OFICINA;

-- d) Listar las oficinas con objetivo superior a 600.000 indicando para cada una de ellas 
-- el nombre de su director.
SELECT OFICINA, NOMBRE FROM oficina, empleado WHERE OBJETIVO > 600000  AND NUMEMP = DIRECTOR;

SELECT OFICINA, NOMBRE FROM oficina LEFT JOIN empleado ON  NUMEMP = DIRECTOR WHERE OBJETIVO > 600000;

-- e) Hallar los empleados que realizaron su primer pedido el mismo día en que fueron contratados.
SELECT e.* FROM  empleado e, pedido, cliente 
WHERE FCONTRATO = FECHAPEDIDO AND NUMEMP = REPCLIE AND NUMCLIE = CLIENTE;

-- f) Listar los empleados con una cuota superior a la de su jefe; para cada empleado 
-- sacar sus datos y el número, nombre y cuota de su jefe.
SELECT e.*, j.NOMBRE, j.JEFE, j.CUOTA FROM empleado e, empleado j 
WHERE e.JEFE = j.NUMEMP AND e.CUOTA > j.CUOTA;


