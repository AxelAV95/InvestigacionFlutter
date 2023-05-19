-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-05-2023 a las 00:42:02
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
-- Base de datos: `bdmanga`
--
CREATE DATABASE IF NOT EXISTS `bdmanga` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `bdmanga`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `eliminarManga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarManga` (IN `id` INT)  DELETE FROM `tbmanga` WHERE `mangaid` = id$$

DROP PROCEDURE IF EXISTS `insertarManga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarManga` (IN `nombre` VARCHAR(50), IN `tomo` INT)  INSERT INTO `tbmanga`(`manganombre`, `mangatomo`) VALUES (nombre,tomo)$$

DROP PROCEDURE IF EXISTS `modificarManga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarManga` (IN `id` INT, IN `nombre` VARCHAR(50), IN `tomo` INT)  UPDATE `tbmanga` SET `manganombre`=nombre,`mangatomo`= tomo WHERE `mangaid` = id$$

DROP PROCEDURE IF EXISTS `obtenerDatosManga`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerDatosManga` (IN `id` INT)  SELECT * FROM `tbmanga` WHERE `mangaid` = id$$

DROP PROCEDURE IF EXISTS `obtenerMangas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerMangas` ()  SELECT * FROM `tbmanga`$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbmanga`
--

DROP TABLE IF EXISTS `tbmanga`;
CREATE TABLE `tbmanga` (
  `mangaid` int(11) NOT NULL,
  `manganombre` varchar(255) NOT NULL,
  `mangatomo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tbmanga`
--

INSERT INTO `tbmanga` (`mangaid`, `manganombre`, `mangatomo`) VALUES
(1, 'Naruto', 122222),
(3, 'One piece', 1),
(4, 'Bleach', 1),
(5, 'Gintama', 1),
(6, 'Toradora', 1),
(7, 'Dragon', 2),
(13, 'Jigokuraku', 1),
(15, 'Bakemonogatari', 1),
(17, 'Kimetsu no yaiba', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbmanga`
--
ALTER TABLE `tbmanga`
  ADD PRIMARY KEY (`mangaid`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbmanga`
--
ALTER TABLE `tbmanga`
  MODIFY `mangaid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
