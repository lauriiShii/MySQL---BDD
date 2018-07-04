SELECT nmat FROM notaprac GROUP BY 1 HAVING COUNT(*) =
(SELECT COUNT(*) FROM practica WHERE cur =
(SELECT cur FROM matricula WHERE mat = nmat));