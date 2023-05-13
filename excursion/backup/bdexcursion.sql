-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-05-2023 a las 04:11:40
-- Versión del servidor: 10.4.20-MariaDB
-- Versión de PHP: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdexcursion`
--
CREATE DATABASE IF NOT EXISTS `bdexcursion` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bdexcursion`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `eliminarExcursion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarExcursion` (IN `id` INT)  BEGIN
    DECLARE `existencia` INT;
    DECLARE `eliminado` INT DEFAULT 0;
    
    SELECT COUNT(*) INTO `existencia` FROM `tbexcursion` WHERE `excursionid` = id;
    
    IF `existencia` > 0 THEN
        DELETE FROM `tbexcursion` WHERE `excursionid` = id;
        SET `eliminado` = 1;
    ELSE
        SET `eliminado` = 0;
    END IF;
    
    SELECT `eliminado`;
END$$

DROP PROCEDURE IF EXISTS `insertarExcursion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarExcursion` (IN `descripcion` VARCHAR(255), IN `fecha` DATE, IN `precio` FLOAT, IN `estado` INT, IN `lugar` VARCHAR(255), IN `cantidad` INT)  INSERT INTO `tbexcursion`( `excursiondescripcion`, `excursionfecha`, `excursionprecio`, `excursionestado`, `excursionlugar`, `excursioncapacidad`) VALUES (descripcion,fecha,precio,estado,lugar,cantidad)$$

DROP PROCEDURE IF EXISTS `modificarExcursion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarExcursion` (IN `id` INT, IN `descripcion` VARCHAR(255), IN `fecha` DATE, IN `estado` INT, IN `lugar` VARCHAR(255), IN `capacidad` INT, IN `precio` FLOAT)  BEGIN
    DECLARE existencia INT;
    DECLARE modificado INT DEFAULT 0;
    
    SELECT COUNT(*) INTO existencia FROM tbexcursion WHERE excursionid = id;
    IF existencia > 0 THEN
        UPDATE tbexcursion SET 
            excursiondescripcion = descripcion,
            excursionfecha = fecha,
            excursionprecio = precio,
            excursionestado = estado,
            excursionlugar = lugar,
            excursioncapacidad = capacidad 
        WHERE excursionid = id;
        SET modificado = 1;
    ELSE
        SET modificado = 0;
    END IF;
    SELECT modificado;
END$$

DROP PROCEDURE IF EXISTS `obtenerDatosExcursion`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerDatosExcursion` (IN `id` INT)  SELECT * FROM `tbexcursion` 
INNER JOIN `tbestado` 
ON `tbexcursion`.excursionestado = `tbestado`.estadoid 
WHERE `excursionid` = id$$

DROP PROCEDURE IF EXISTS `obtenerEstados`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerEstados` ()  SELECT * FROM tbestado$$

DROP PROCEDURE IF EXISTS `obtenerExcursiones`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerExcursiones` ()  SELECT * FROM `tbexcursion`$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbestado`
--

DROP TABLE IF EXISTS `tbestado`;
CREATE TABLE `tbestado` (
  `estadoid` int(11) NOT NULL,
  `estadodescripcion` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbestado`
--

INSERT INTO `tbestado` (`estadoid`, `estadodescripcion`) VALUES
(1, 'Planificada'),
(2, 'En curso'),
(3, 'Cancelada'),
(4, 'Completada'),
(5, 'Pendiente de confirmación');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbexcursion`
--

DROP TABLE IF EXISTS `tbexcursion`;
CREATE TABLE `tbexcursion` (
  `excursionid` int(11) NOT NULL,
  `excursiondescripcion` varchar(255) NOT NULL,
  `excursionfecha` date NOT NULL,
  `excursionprecio` float NOT NULL,
  `excursionestado` int(4) NOT NULL,
  `excursionlugar` varchar(255) NOT NULL,
  `excursioncapacidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbexcursion`
--

INSERT INTO `tbexcursion` (`excursionid`, `excursiondescripcion`, `excursionfecha`, `excursionprecio`, `excursionestado`, `excursionlugar`, `excursioncapacidad`) VALUES
(1, 'Excursión al Volcán Arenal', '2023-05-20', 0, 1, 'La Fortuna, Alajuela', 20),
(2, 'Tour de avistamiento de ballenas', '2023-06-12', 0, 2, 'Bahía Drake, Puntarenas', 10),
(3, 'Caminata en el bosque nuboso de Monteverde', '2023-07-05', 0, 3, 'Monteverde, Puntarenas', 15),
(4, 'Rapidos del Río Pacuare', '2023-08-10', 0, 4, 'Turrialba, Cartago', 8),
(5, 'Kayak en el Golfo de Nicoya', '2023-09-03', 0, 5, 'Isla Chira, Guanacaste', 12);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbestado`
--
ALTER TABLE `tbestado`
  ADD PRIMARY KEY (`estadoid`);

--
-- Indices de la tabla `tbexcursion`
--
ALTER TABLE `tbexcursion`
  ADD PRIMARY KEY (`excursionid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbestado`
--
ALTER TABLE `tbestado`
  MODIFY `estadoid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tbexcursion`
--
ALTER TABLE `tbexcursion`
  MODIFY `excursionid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
