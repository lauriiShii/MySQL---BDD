-- a) Selecciona todos los campos de la tabla clientes junto a los datos de los pedidos
-- que han realizado.
SELECT * FROM cliente INNER JOIN pedido ON CLIENTE = NUMCLIE;

SELECT * FROM cliente, pedido WHERE CLIENTE = NUMCLIE;

-- b) Selecciona todos los campos de la tabla clientes junto a los datos de los pedidos
-- que han realizado, incluyéndose únicamente la fecha de cada pedido y el número
-- del pedido. Sólo se incluirán en el resultado a los clientes cuyo límite de crédito
-- sea mayor que 40000.
SELECT cliente.*, NUMPEDIDO, FECHAPEDIDO FROM cliente, pedido 
WHERE CLIENTE = NUMCLIE AND LIMCREDITO > 100;

-- c) Seleccionar el nombre de cliente, su límite de crédito, así como el nombre de su
-- representante y la región a la que pertenece la oficina de éste.
SELECT c.NOMBRE 'CLIENTE', LIMCREDITO, e.NOMBRE 'REPRESENTANTE', REGION 
FROM cliente c, empleado e, oficina
WHERE REPCLIE =  NUMEMP AND CODOFICINA = OFICINA;

-- d) Seleccionar el nombre de empleado (con el cargo “Nombre de empleado”), la
-- fecha de su contrato, el código de su oficina, el nombre de la ciudad de la
-- oficina, así como el nombre del jefe del empleado (con el cargo “Nombre del
-- jefe”).
SELECT e.NOMBRE 'Nombre de empleado', e.FCONTRATO, e.CODOFICINA, CIUDAD, j.NOMBRE 'Nombre del jefe' 
FROM empleado e, empleado j, oficina WHERE e.CODOFICINA = OFICINA AND j.NUMEMP = e.JEFE;

-- e) Seleccionar el número de cada pedido, su fecha y su importe, así como la ciudad
-- en la que se encuentra la oficina del representante que tiene asignado. No se
-- incluirán en el resultado los datos de pedidos cuyo importe sea inferior a 40000
-- ni superior a 60000.
SELECT l.NUMPEDIDO, FECHAPEDIDO, SUM(IMPORTE) FROM pedido p, lineaspedido l 
WHERE p.NUMPEDIDO = l.NUMPEDIDO GROUP BY l.NUMPEDIDO, FECHAPEDIDO 
HAVING SUM(IMPORTE) > 200 AND SUM(IMPORTE) < 60000 ;

SELECT l.NUMPEDIDO, FECHAPEDIDO, SUM(IMPORTE), CIUDAD 
FROM pedido p, lineaspedido l, empleado, oficina, cliente
WHERE p.NUMPEDIDO = l.NUMPEDIDO AND OFICINA = CODOFICINA 
AND NUMCLIE = CLIENTE AND REPCLIE = NUMEMP
GROUP BY l.NUMPEDIDO, FECHAPEDIDO, CIUDAD 
HAVING SUM(IMPORTE) > 200 AND SUM(IMPORTE) < 60000 ;

-- truco del almendruqui, se agrupa por las columnas que se va a mostrar tenga 
-- sentido o no para evitar posibles fallos.

-- en oracle es obligatorio agrupar por todo lo que se muestra sino no funciona
