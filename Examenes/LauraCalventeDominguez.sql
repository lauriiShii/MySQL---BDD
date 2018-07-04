/*** LAURA CALVENTE DOMINGUEZ - EXAMEN 2ºTRIMESTRE ****/

-- 1) Ordenes de creacion de las tablas prueba_individual, prueba_equipo, part_prueba_indi, part_prueba_eq,pista_compueta.
-- Prueba
CREATE TABLE `prueba` (
  `COD_PRUEBA` int(3) NOT NULL,
  `NOM_PRUEBA` varchar(30) DEFAULT NULL,
  `FEC_PRUEBA` date DEFAULT NULL,
  `MODALIDAD` enum('1','2') DEFAULT NULL,
  `COD_EST` int(5) DEFAULT NULL,
  `N_PISTA` int(2) DEFAULT NULL,
  `COD_TIPO` int(2) DEFAULT NULL,
  PRIMARY KEY (`COD_PRUEBA`),
  UNIQUE KEY `NOM_PRUEBA_UNIQUE` (`NOM_PRUEBA`),
  KEY `FK_PISTA_PRUEBA_idx` (`N_PISTA`),
  KEY `FK_TIPOPRUEBA_PRUEBA_idx` (`COD_TIPO`),
  KEY `FK_PISTA_PRUEBA_idx1` (`COD_EST`,`N_PISTA`),
  CONSTRAINT `FK_PISTA_PRUEBA` FOREIGN KEY (`COD_EST`, `N_PISTA`) REFERENCES `pista` (`COD_EST`, `N_PISTA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_TIPOPRUEBA_PRUEBA` FOREIGN KEY (`COD_TIPO`) REFERENCES `tipoprueba` (`COD_TIPO`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Prueba individual
CREATE TABLE `prueba_individual` (
  `COD_PRUEBA` int(3) NOT NULL,
  `MAX_PART` int(3) DEFAULT NULL,
  PRIMARY KEY (`COD_PRUEBA`),
  CONSTRAINT `FK_PRUEBA_INDIVIDUAL_PRUEBA` FOREIGN KEY (`COD_PRUEBA`) REFERENCES `prueba` (`COD_PRUEBA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Prueba equipo
CREATE TABLE `prueba_equipo` (
  `COD_PRUEBA` int(3) NOT NULL,
  `MAX_EQU` int(3) DEFAULT NULL,
  PRIMARY KEY (`COD_PRUEBA`),
  CONSTRAINT `FK_PRUEBA_PRUEBA_EQUIPO` FOREIGN KEY (`COD_PRUEBA`) REFERENCES `prueba` (`COD_PRUEBA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Parte prueba individual
CREATE TABLE `part_prueba_indi` (
  `DNI` varchar(9) NOT NULL,
  `COD_PRUEBA` int(3) NOT NULL,
  `TIEMPO` time DEFAULT NULL,
  `POSICION` int(3) DEFAULT NULL,
  PRIMARY KEY (`DNI`,`COD_PRUEBA`),
  KEY `FK_PRUEBA_PART_PRUEBA_INDI_idx` (`COD_PRUEBA`),
  CONSTRAINT `FK_ESQUIADOR_PART_PRUEBA_INDI` FOREIGN KEY (`DNI`) REFERENCES `esquiador` (`DNI`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PRUEBA_INDIVIDUAL_PART_PRUEBA_INDI` FOREIGN KEY (`COD_PRUEBA`) REFERENCES `prueba_individual` (`COD_PRUEBA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- Parte prueba equipo
CREATE TABLE `part_prueba_equ` (
  `COD_EQU` int(5) NOT NULL,
  `COD_PRUEBA` int(3) NOT NULL,
  `TIEMPO` time DEFAULT NULL,
  `POSICION` int(3) DEFAULT NULL,
  PRIMARY KEY (`COD_EQU`,`COD_PRUEBA`),
  KEY `FK_PRUEBA_COMPUESTA_PART_PRUEBA_EQU_idx` (`COD_PRUEBA`),
  CONSTRAINT `FK_EQUIPO_PART_PRUEBA_EQUI` FOREIGN KEY (`COD_EQU`) REFERENCES `equipo` (`COD_EQU`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_PRUEBA_COMPUESTA_PART_PRUEBA_EQU` FOREIGN KEY (`COD_PRUEBA`) REFERENCES `prueba_equipo` (`COD_PRUEBA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Pista compuesta
CREATE TABLE `pista_compuesta` (
  `COD_EST_COMP` int(5) NOT NULL,
  `N_PISTA_COMP` int(2) NOT NULL,
  `COD_EST` int(5) NOT NULL,
  `N_PISTA` int(2) NOT NULL,
  KEY `FK_ESTACION_PISTA_COMPUESTA_idx` (`COD_EST`),
  KEY `FK_PISTA_PISTA_COMPUESTA_idx` (`N_PISTA`),
  KEY `FK_PISTA_PISTA_COMPUESTA_idx1` (`COD_EST`,`N_PISTA`),
  CONSTRAINT `FK_PISTA_PISTA_COMPUESTA` FOREIGN KEY (`COD_EST`, `N_PISTA`) REFERENCES `pista` (`COD_EST`, `N_PISTA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- 2) Todos los datos de las pruebas en las que se haya participado algun esquiador perteneciente a la federacion de andalucia.
SELECT * FROM prueba WHERE COD_PRUEBA IN 
(SELECT COD_PRUEBA FROM part_prueba_indi WHERE DNI IN 
(SELECT DNI FROM esquiador WHERE COD_FED IN 
(SELECT COD_FED FROM federacion WHERE COM_FED = 'Andalucia'))) 
OR COD_PRUEBA IN
(SELECT COD_PRUEBA FROM part_prueba_equ WHERE COD_EQU IN 
(SELECT COD_EQU FROM esquiador WHERE COD_FED IN 
(SELECT COD_FED FROM federacion WHERE COM_FED = 'Andalucia'))) ;

-- 3) Mostrar los codigos de las estaciones en las que hayan celebrado alguna prueba
SELECT COD_EST FROM estacion WHERE COD_EST IN (SELECT COD_EST FROM prueba);

-- 4) Total de pruebas individuales cuyo nº max de participantes sea mayor de 10
SELECT COUNT(*) FROM prueba_individual WHERE MAX_PART > 10;

-- 5) Codigo de estacion con menor numero de pistas
SELECT COD_EST FROM pista GROUP BY COD_EST ORDER BY COUNT(N_PISTA) LIMIT 1;

-- 6) Todos los datos de la federacion con la media de edad de sus esquiadores mayor.
SELECT federacion.* FROM federacion, esquiador ORDER BY AVG(YEAR(NOW())-YEAR(F_NAC)) DESC;

-- 7) Dni de los esquiadores que participen en las modalidades de quipo e individuales
SELECT DNI FROM esquiador WHERE DNI IN (SELECT DNI FROM part_prueba_indi) AND COD_EQU IN (SELECT COD_EQU FROM part_prueba_equ);

-- 8) Para cada estacion su codigo, nº pista, y nº de pistas que componen a la anterior,
--  si la pista no es compuesta sale un 0 en nº de pistas que la componen
SELECT p.COD_EST, p.N_PISTA, COUNT(pc.N_PISTA) FROM pista p, pista_compuesta pc GROUP BY 1,2;

-- 9) Listado de todos los datos de los equipos y datos de la federacion a la que pertenecen
SELECT e.*, f.* FROM equipo e, federacion f, esquiador es WHERE e.COD_EQU = es.COD_EQU and es.COD_FED = f.COD_FED;

-- 10) listado de dni de los esquiadores que participen en todas las pruebas individuales
SELECT DNI FROM part_prueba_indi p, prueba pr WHERE p.COD_PRUEBA = pr.COD_PRUEBA GROUP BY 1
HAVING COUNT(DISTINCT r.COD_PRUEBA) = (SELECT COUNT(*) FROM prueba);

-- 11) Listado de pruebas individuales y por equipo con su nº de participantes
SELECT DISTINCT p.*, MAX_PART, MAX_EQU FROM prueba p, prueba_individual pi, prueba_equipo pe 
WHERE p.COD_PRUEBA = pe.COD_PRUEBA OR p.COD_PRUEBA = pi.COD_PRUEBA;

-- 12) los 10 esquiadores mas mayores
SELECT *, YEAR(NOW())-YEAR(F_NAC) FROM esquiador WHERE YEAR(now())-YEAR(F_NAC) ORDER BY F_NAC DESC LIMIT 10;

-- 13) Segun grado de dificultad, visualizar el nº total de pistas
SELECT DIFIC, COUNT(N_PISTA) FROM pista GROUP BY 1;

-- 14) Federaciones con su total de federados. Incluir aquellas federaciones que  no tengan en 
-- este momento insertados ningun federado teniendo que salir 0 en el total de federaos.
SELECT f.*, COUNT(DNI) FROM federacion f, esquiador e GROUP BY 1;

-- 15) Todos los datos de los esquiadores que participen exclusivamente en pruebas de equipo
SELECT e.* FROM esquiador e, part_prueba_equ p WHERE e.COD_EQU = p.COD_EQU;

-- 16) Dni de entrenadores que entrenen a mas de 2 equipos
SELECT COD_ENTR FROM equipo GROUP BY COD_ENTR HAVING count(COD_ENTR) >= 2; 

-- 17) Listados en orden ascendente las denominaciones de cada uno de los distintos tipos de pruebas
-- con total de pruebas de cada uno de sus tipos


-- 18) Todos los datos de los equipos que hayan participado en alguna prueba en la que hayan resultado vencedores
SELECT * FROM equipo WHERE COD_EQU IN (SELECT COD_EQU FROM part_prueba_equ WHERE posicion = 1);

-- 19) Todos los datos de cada entrenador y de los equipos entrenados por ellos
SELECT * FROM esquiador es LEFT JOIN equipo eq ON es.COD_EQU = eq.COD_EQU WHERE DNI = COD_ENTR; 

-- 20) Listado de pistas no compuestas de la estacion de Formigal
SELECT p.N_PISTA FROM pista p, estacion e WHERE LOC = 'Formigal' 
AND p.COD_EST = e.COD_EST AND e.COD_EST NOT IN (SELECT COD_EST FROM pista_compuesta);

-- 21) Orden de creacion de la primera pista en la estacion de kandanchu con los datos que correspondan
-- de la pista 1 de ka estacion de Formigal
INSERT INTO estacion VALUES (12, 'Kandanc','Isa','Valencia',956749049,1);
INSERT INTO pista (COD_EST, N_PISTA, KMS, DIFIC) SELECT p.COD_EST, N_PISTA, KMS, DIFIC FROM pista p, estacion e 
WHERE p.COD_EST = e.COD_EST AND NOM_EST = 'Sierra Nevada' AND N_PISTA = 1;
