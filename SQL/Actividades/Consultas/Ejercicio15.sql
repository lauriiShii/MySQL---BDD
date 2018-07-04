-- a) La edad media de los trabajadores que tienen el mismo cargo. Se incluirá el
-- cargo en la salida.
SELECT AVG(year(now())-year(FNAC)), CARGO FROM empleado GROUP BY CARGO;

-- b) La fecha del contrato más antiguo de los empleados de cada oficina. Se incluirá
-- el número de cada oficina.
SELECT MIN(FCONTRATO), oficina FROM empleado, oficina WHERE OFICINA = CODOFICINA GROUP BY oficina;

-- c) De entre los empleados que tienen el mismo jefe se obtendrá la cuota máxima.
-- Se incluirá el código del jefe.
SELECT MAX(CUOTA), JEFE FROM empleado GROUP BY JEFE;

-- d) El número de empleados que tiene a su cargo cada empleado que es jefe. Se
-- incluirá el código del jefe. Implementa otra versión que además incluya el
-- nombre del jefe.
SELECT COUNT(NUMEMP), JEFE FROM empleado GROUP BY JEFE;

SELECT COUNT(e.NUMEMP), e.JEFE, j.NOMBRE FROM empleado e, empleado j 
WHERE e.JEFE = j.NUMEMP GROUP BY e.JEFE, j.NOMBRE;

-- e) Para cada región, la máxima venta de sus trabajadores.
SELECT REGION, MAX(e.VENTAS) FROM oficina, empleado e WHERE CODOFICINA = OFICINA GROUP BY REGION;

-- f) Para cada grupo de empleados que tengan la misma cuota se calculará la fecha de
-- contrato más antigua y más moderna. El resultado debe incluir la cuota. No se
-- tendrán en cuenta para calcular el resultado a los empleados cuya edad sea menor
-- de 35.
SELECT CUOTA, MIN(FCONTRATO), MAX(FCONTRATO) FROM empleado  GROUP BY CUOTA;

-- g) Para cada producto el importe total vendido.
SELECT l.IDPRODUCTO, SUM(IMPORTE) FROM producto p, lineaspedido l 
WHERE p.IDPRODUCTO = l.IDPRODUCTO GROUP BY l.IDPRODUCTO;

-- h) El importe total de cada producto vendido a partir de 1995. Se incluirá en la
-- salida el código del producto.
SELECT l.IDPRODUCTO, SUM(IMPORTE) FROM producto p, lineaspedido l, pedido pe 
WHERE p.IDPRODUCTO = l.IDPRODUCTO AND pe.NUMPEDIDO = l.NUMPEDIDO  AND FECHAPEDIDO > 1995  
GROUP BY l.IDPRODUCTO;

-- i) La cantidad total de cada producto vendido a partir de 1995. Se incluirá en la
-- salida el código del producto.
SELECT IDPRODUCTO,COUNT(IDPRODUCTO) FROM lineaspedido GROUP BY IDPRODUCTO;

-- j) El número de pedidos en los que se ha visto involucrado cada producto. Sólo se
-- tendrán en cuenta los productos cuyo precio sea mayor que 200 y menor que
-- 2000.
SELECT COUNT(NUMPEDIDO), p.IDPRODUCTO FROM lineaspedido l, producto p 
WHERE p.IDPRODUCTO = l.IDPRODUCTO AND PRECIO BETWEEN 200 AND 2000  GROUP BY p.IDPRODUCTO;

-- k) El importe medio que se ha vendido a cada cliente que tenga un límite de crédito
-- inferior a 50000. En la salida se incluirá el código del cliente.
SELECT AVG(IMPORTE), CLIENTE FROM cliente, pedido p, lineaspedido l 
WHERE CLIENTE = NUMCLIE AND p.NUMPEDIDO = l.NUMPEDIDO AND LIMCREDITO < 50000 GROUP BY CLIENTE;

-- l) El importe máximo que se ha vendido a cada cliente. Sólo se tendrán en cuenta
-- los clientes que tengan asignado un representante mayor de 40 años. En la salida
-- se incluirá el código del cliente.
SELECT MAX(IMPORTE), CLIENTE FROM cliente, pedido p, lineaspedido l, empleado 
WHERE CLIENTE = NUMCLIE AND p.NUMPEDIDO = l.NUMPEDIDO AND REPCLIE = NUMEMP AND year(now())-year(FNAC) > 25 
GROUP BY CLIENTE;

-- m) Para cada producto, la mayor edad de los empleados que lo vendieron. Se
-- incluirá en el resultado el código del producto.
SELECT IDPRODUCTO, MAX(year(now())-year(FNAC)) FROM lineaspedido l, pedido p, cliente, empleado 
WHERE l.NUMPEDIDO = p.NUMPEDIDO AND CLIENTE = NUMCLIE AND REPCLIE = NUMEMP GROUP BY IDPRODUCTO;

-- n) Para cada producto, el mayor objetivo de las oficinas de los empleados que lo
-- vendieron. Se incluirá en el resultado el código del producto.
SELECT IDPRODUCTO, MAX(o.OBJETIVO) FROM lineaspedido l, pedido p, cliente, empleado, oficina o 
WHERE l.NUMPEDIDO = p.NUMPEDIDO AND CODOFICINA = OFICINA AND CLIENTE = NUMCLIE AND REPCLIE = NUMEMP GROUP BY IDPRODUCTO;

-- o) Seleccionar el número de pedido e importe de los tres pedidos de menor importe.
SELECT NUMPEDIDO, SUM(IMPORTE) FROM lineaspedido GROUP BY NUMPEDIDO ORDER BY SUM(IMPORTE) LIMIT 3;

-- p) Seleccionar el número de pedido e importe de los 10 pedidos más actuales.
SELECT l.NUMPEDIDO, SUM(IMPORTE) FROM lineaspedido l, pedido p WHERE l.NUMPEDIDO = p.NUMPEDIDO 
GROUP BY l.NUMPEDIDO ORDER BY FECHAPEDIDO LIMIT 4;

-- q) Lista código de cliente, número de pedido, fecha del pedido e importe total de
-- aquellos clientes cuyo límite de crédito sea mayor de 40000.
SELECT NUMCLIE, p.NUMPEDIDO, FECHAPEDIDO, SUM(IMPORTE) FROM cliente, lineaspedido l, pedido p WHERE NUMCLIE = CLIENTE AND
l.NUMPEDIDO = p.NUMPEDIDO AND LIMCREDITO > 200 GROUP BY p.NUMPEDIDO, NUMCLIE, FECHAPEDIDO;

-- r) Listar los pedidos mostrando su número, importe, nombre de cliente y el límite
-- de crédito del cliente.
SELECT l.NUMPEDIDO, SUM(IMPORTE), NOMBRE, LIMCREDITO FROM pedido p, lineaspedido l, cliente
WHERE  l.NUMPEDIDO = p.NUMPEDIDO AND NUMCLIE = CLIENTE GROUP BY l.NUMPEDIDO, NOMBRE, LIMCREDITO;

-- s) Listar los pedidos superiores a 25000 de importe incluyendo el nombre del
-- empleado que tomó el pedido y el nombre del cliente que lo solicitó.

-- t) Listar los códigos de los empleados que tienen algún pedido con importe
-- superior a 10000 o que tengan una cuota inferior a 10000.

-- u) Halla la suma de los importes de las líneas de los pedidos en los que se haya
-- solicitado el producto con descripción 'Manivela'.

-- v) La suma de las ventas de los empleados de cada oficina. Se incluirá en el
-- resultado el código de cada oficina. No se incluirán en el resultado las oficinas
-- cuyas ventas totales sean menores de 200000. Hacerlo con HAVING y sin
-- HAVING.

-- w) La suma de las unidades vendidas de cada producto vendido al cliente 1234. No
-- se incluirán en el resultado final aquellas filas cuya suma de unidades al
-- cuadrado sea menor de 1000.

-- x) Por cada empleado, sacar la media del limite de crédito de sus clientes, el código
-- del empleado y su nombre. No se tendrán en cuenta los clientes cuyo límite de
-- crédito sea inferior a 30000. Deben salir aquellos empleados cuyo nombre
-- empiecen por M o A. Por último ordena el resultado por el promedio.
