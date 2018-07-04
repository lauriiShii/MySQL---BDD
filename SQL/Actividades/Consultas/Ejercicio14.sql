-- a) Se pretende calcular la media de las edades de los empleados mayores de 50 años. 
-- Este resultado aparecerá con el cargo “Media de mayores”.
SELECT AVG(year(now())-year(FNAC))'Media de mayores' FROM empleado WHERE year(now())-year(FNAC) > 50;

-- b) Halla la suma de las cuotas de los empleados que trabajan en las oficinas de 
-- Valencia o de Castellón.
SELECT SUM(CUOTA) FROM empleado, oficina 
WHERE CODOFICINA = OFICINA AND CIUDAD IN ('Cadiz', 'Malaga');

SELECT SUM(CUOTA) FROM empleado, oficina 
WHERE codoficina = oficina AND (CIUDAD = 'Cadiz' OR CIUDAD = 'Malaga');

SELECT SUM(CUOTA) FROM empleado 
WHERE codoficina IN (SELECT OFICINA FROM oficina WHERE CIUDAD IN ('Cadiz', 'Malaga'));

-- c) Halla la suma de los importes del pedido 12345.
SELECT SUM(IMPORTE) FROM lineaspedido WHERE NUMPEDIDO = 1;

-- d) Queremos visualizar el número de filas obtenido al realizar el producto cartesiano 
-- de la tabla pedidos y la tabla clientes.
SELECT COUNT(*) FROM pedido, cliente;

-- e) Visualizar la mayor edad de entre los empleados contratados antes de 1988.
SELECT MAX(year(now())-year(FNAC)) FROM empleado WHERE year(FCONTRATO) < 2017;

-- f) Visualizar la mayor edad de los empleados cuya oficina esté en la zona este o en 
-- la ciudad de A Coruña.
SELECT MAX(year(now())-year(FNAC)) FROM empleado, oficina 
WHERE codoficina = oficina AND (REGION='este' OR CIUDAD='Malaga') GROUP BY CIUDAD, REGION;

-- g) Visualizar la fecha del último pedido que hizo el cliente 1234.
SELECT MAX(FECHAPEDIDO) FROM pedido WHERE CLIENTE = 2;

-- h) Visualizar la media de los importes asociados al producto bisagra.
SELECT AVG(IMPORTE) FROM lineaspedido l, producto p 
WHERE l.IDPRODUCTO = p.IDPRODUCTO AND DESCRIPCION = 'carrito';

SELECT AVG(IMPORTE) FROM lineaspedido 
WHERE IDPRODUCTO = (SELECT IDPRODUCTO FROM producto WHERE DESCRIPCION = 'carrito');

SELECT AVG(importe) FROM lineaspedido l INNER JOIN producto p 
ON l.IDPRODUCTO = p.IDPRODUCTO WHERE DESCRIPCION = 'carrito';

