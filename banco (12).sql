-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-11-2021 a las 12:46:36
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `banco`
--
CREATE DATABASE IF NOT EXISTS `banco` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `banco`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarClientes` (IN `nombre` VARCHAR(50), IN `contraseña` VARCHAR(50), IN `numcuenta` VARCHAR(50), IN `dni` VARCHAR(9), IN `telefono` INT(9), IN `correo` VARCHAR(100))  INSERT INTO usuarios 
(`nombre`,`contraseña`,`tipo`,`idcuenta`,`dni`,`telefono`,`correo`) 
VALUES (nombre,contraseña,2,5555,dni,telefono,correo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertExtracto` (IN `fecha` DATE, IN `concepto` VARCHAR(250), IN `importe` DECIMAL(8,2), IN `idcuenta` INT(11))  INSERT INTO extracto (`fecha`,`concepto`,`importe`,`saldo`,`idcuenta`) VALUES (fecha,concepto,-importe,(SELECT cuentas.saldo FROM cuentas WHERE cuentas.id=idcuenta),idcuenta)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertExtractoFondos` (IN `fecha` DATE, IN `concepto` VARCHAR(250), IN `importe` DECIMAL(8,2), IN `idcuenta` INT(11))  INSERT INTO extracto (`fecha`,`concepto`,`importe`,`saldo`,`idcuenta`) VALUES (fecha,concepto,+importe,(SELECT cuentas.saldo FROM cuentas WHERE cuentas.id=idcuenta),idcuenta)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertFactura` (IN `numerofactura` INT(50), IN `idcuenta` INT(11), IN `proveedor` INT(11), IN `idproducto` INT(11), IN `precio` DECIMAL(8,2), IN `fecha` DATE, IN `cantidad` INT(100), IN `importe` DECIMAL(8,2))  INSERT INTO factura (`numerofactura`,`idcuenta`,`proveedor`,`idproducto`,`precio`,`fecha`,`cantidad`,`importe`) VALUES (numerofactura,idcuenta,proveedor,idproducto,precio,fecha,cantidad,importe)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertStock` (IN `idproducto` INT(11), IN `precio` DECIMAL(8,2), IN `stock` INT(50), IN `img` VARCHAR(250))  INSERT INTO mistock (`idproducto`,`precio`,`stock`,`img`) VALUES (idproducto,precio,stock,img)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarExtractoCuentas` (IN `cuenta` VARCHAR(50))  SELECT extracto.* FROM extracto, cuentas WHERE extracto.idcuenta=cuentas.id AND cuentas.id=cuenta ORDER BY extracto.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarFacturasProveedores` ()  SELECT f.id,f.numerofactura,c.numcuenta,pr.nombre AS proveedor,p.nombre as producto,f.precio,f.fecha,f.cantidad,f.importe FROM factura f, productos p, proveedor pr, provee pro, cuentas c WHERE  pr.id=pro.idproveedor AND pro.idproducto=p.id AND c.id=f.idcuenta AND p.id=f.idproducto ORDER BY f.id DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllMiStock` ()  SELECT m.id, p.nombre as producto, m.precio, m.stock FROM mistock m, productos p WHERE m.idproducto=p.id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProductos` ()  SELECT * FROM productos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProductosByProveedor` (IN `proveedor` INT(11))  SELECT p.* FROM productos p, provee pr, proveedor pro WHERE p.id=pr.idproducto AND pr.idproveedor=pro.id AND pro.id=proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProveedores` ()  SELECT * FROM proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectCuentasAdmin` ()  SELECT c.id, c.numcuenta, c.tipo, c.saldo FROM cuentas c, usuarios u WHERE u.tipo=1 AND u.idcuenta=c.id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCuentas` (IN `saldo` DECIMAL(8,2), IN `idcuenta` INT(11))  UPDATE cuentas SET cuentas.saldo=cuentas.saldo-saldo WHERE cuentas.id=idcuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCuentasFondos` (IN `saldo` DECIMAL(8,2), IN `idcuenta` INT(11))  UPDATE cuentas SET cuentas.saldo=cuentas.saldo+saldo WHERE cuentas.id=idcuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateStock` (IN `stock` INT(11), IN `idproducto` INT(11))  UPDATE mistock SET mistock.stock=mistock.stock+stock WHERE mistock.idproducto=idproducto$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `numcuenta` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `saldo` decimal(8,2) NOT NULL,
  `borrado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `numcuenta`, `tipo`, `saldo`, `borrado`) VALUES
(1, '15478965478541235698', 'corriente', '4451.42', 0),
(2, '34567897432456787654', 'crédito', '8708.10', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `extracto`
--

CREATE TABLE `extracto` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `concepto` varchar(100) DEFAULT NULL,
  `importe` decimal(8,2) NOT NULL,
  `saldo` decimal(8,2) DEFAULT NULL,
  `idcuenta` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `extracto`
--

INSERT INTO `extracto` (`id`, `fecha`, `concepto`, `importe`, `saldo`, `idcuenta`) VALUES
(6, '2021-10-12', 'sadasdas', '50.00', '49950.00', 1),
(7, '2021-11-09', 'adasdsad', '50.00', '0.00', 2),
(8, '2021-11-12', 'Sansisco D15 Mini Drone', '-825.00', '39175.00', 1),
(9, '2021-11-12', 'Sansisco D15 Mini Drone', '-825.00', '38350.00', 1),
(10, '2021-11-12', 'DJI Mini 2', '-918.00', '37432.00', 1),
(11, '2021-11-12', 'Sansisco D15 Mini Drone', '-330.00', '-330.00', 2),
(12, '2021-11-12', 'DJI Mini 2', '-3672.00', '-4002.00', 2),
(13, '2021-11-12', 'DJI Mini 2', '-918.00', '36514.00', 1),
(14, '2021-11-12', 'DJI Mini 2', '-2295.00', '34219.00', 1),
(15, '2021-11-12', 'DJI Mini 2', '-2295.00', '31924.00', 1),
(16, '2021-11-12', 'DJI Mini 2', '-918.00', '31006.00', 1),
(17, '2021-11-15', 'DJI Mini 2', '-3213.00', '27793.00', 1),
(18, '2021-11-15', 'Sansisco D15 Mini Drone', '-825.00', '26968.00', 1),
(43, '2021-11-15', 'Ingreso', '12568.00', '39576.00', 1),
(44, '2021-11-15', 'Sansisco D15 Mini Drone', '-825.00', '38751.00', 1),
(45, '2021-11-15', 'Sansisco D15 Mini Drone', '-9900.00', '28851.00', 1),
(46, '2021-11-15', 'Ingreso', '9900.00', '38751.00', 1),
(47, '2021-11-15', 'Sansisco D15 Mini Drone', '-165.00', '38586.00', 1),
(48, '2021-11-15', 'DJI Mini 2', '-459.00', '38127.00', 1),
(49, '2021-11-15', 'Ingreso', '1.00', '38128.00', 1),
(50, '2021-11-15', 'DJI Mini 2', '-3672.00', '34456.00', 1),
(51, '2021-11-15', 'Ingreso', '0.05', '34456.05', 1),
(52, '2021-11-15', 'Ingreso', '1.00', '34457.05', 1),
(53, '2021-11-15', 'Ingreso', '1.00', '34458.05', 1),
(54, '2021-11-15', 'Ingreso', '1.00', '34459.05', 1),
(55, '2021-11-15', 'Ingreso', '1.00', '34460.05', 1),
(56, '2021-11-15', 'Ingreso', '1.00', '34461.05', 1),
(57, '2021-11-15', 'Ingreso', '2.00', '34463.05', 1),
(58, '2021-11-17', 'Sansisco D15 Mini Drone', '-825.00', '33638.05', 1),
(59, '2021-11-17', 'Ingreso', '10.00', '33648.05', 1),
(60, '2021-11-17', 'Ingreso', '100.00', '-3902.00', 2),
(61, '2021-11-17', 'DJI Mini 2', '-2295.00', '31353.05', 1),
(62, '2021-11-17', 'Sansisco D15 Mini Drone', '-825.00', '-4727.00', 2),
(63, '2021-11-17', 'Sansisco D15 Mini Drone', '-825.00', '30528.05', 1),
(64, '2021-11-17', 'Ingreso', '5.00', '30533.05', 1),
(65, '2021-11-17', 'DJI Mini 2', '-45900.00', '-15366.95', 1),
(66, '2021-11-17', 'Ingreso', '20000.00', '4633.05', 1),
(67, '2021-11-17', 'Sansisco D15 Mini Drone', '-825.00', '3808.05', 1),
(68, '2021-11-17', 'Sansisco D15 Mini Drone', '-825.00', '2983.05', 1),
(69, '2021-11-17', 'Sansisco D15 Mini Drone', '-825.00', '2158.05', 1),
(70, '2021-11-17', 'DJI Mini 2', '-918.00', '322.05', 1),
(71, '2021-11-17', 'DJI Mini 2', '-918.00', '322.05', 1),
(72, '2021-11-17', 'Sansisco D15 Mini Drone', '-165.00', '157.05', 1),
(73, '2021-11-17', 'DJI Mini 2', '-459.00', '-301.95', 1),
(74, '2021-11-17', 'Sansisco D15 Mini Drone', '-165.00', '-466.95', 1),
(75, '2021-11-17', 'Sansisco D15 Mini Drone', '-165.00', '-631.95', 1),
(76, '2021-11-17', 'DJI Mini 2', '-918.00', '-1549.95', 1),
(77, '2021-11-17', 'DJI Mini 2', '-918.00', '-2467.95', 1),
(78, '2021-11-17', 'DJI Mini 2', '-918.00', '-3385.95', 1),
(79, '2021-11-17', 'DJI Mini 2', '-459.00', '-3844.95', 1),
(80, '2021-11-17', 'DJI Mini 2', '-459.00', '-4303.95', 1),
(81, '2021-11-17', 'DJI Mini 2', '-459.00', '-4762.95', 1),
(82, '2021-11-17', 'DJI Mini 2', '-459.00', '-5221.95', 1),
(83, '2021-11-17', 'DJI Mini 2', '-459.00', '-5680.95', 1),
(84, '2021-11-17', 'DJI Mini 2', '-459.00', '-6139.95', 1),
(85, '2021-11-17', 'DJI Mini 2', '-459.00', '-6598.95', 1),
(86, '2021-11-17', 'Sansisco D15 Mini Drone', '-165.00', '-6763.95', 1),
(87, '2021-11-17', 'DJI Mini 2', '-459.00', '-7222.95', 1),
(88, '2021-11-17', 'DJI Mini 2', '-459.00', '-7681.95', 1),
(89, '2021-11-17', 'Sansisco D15 Mini Drone', '-165.00', '-7846.95', 1),
(90, '2021-11-17', 'DJI Mini 2', '-459.00', '-8305.95', 1),
(91, '2021-11-17', 'DJI Mini 2', '-459.00', '-8764.95', 1),
(92, '2021-11-17', 'Sansisco D15 Mini Drone', '-165.00', '-8929.95', 1),
(93, '2021-11-17', 'DJI Mini 2', '-459.00', '-9388.95', 1),
(94, '2021-11-17', 'Ingreso', '10000.00', '611.05', 1),
(95, '2021-11-18', 'Sansisco D15 Mini Drone', '-165.00', '446.05', 1),
(96, '2021-11-18', 'DJI Mini 2', '-918.00', '-471.95', 1),
(97, '2021-11-22', 'Ingreso', '1000.00', '528.05', 1),
(98, '2021-11-24', 'Ingreso', '1.00', '529.05', 1),
(99, '2021-11-24', 'Ingreso', '2.00', '531.05', 1),
(100, '2021-11-24', 'Ingreso', '999999.99', '999999.99', 1),
(101, '2021-11-25', 'Ingreso', '1.00', '-4726.00', 2),
(102, '2021-11-25', 'Ingreso', '2.00', '-4724.00', 2),
(103, '2021-11-25', 'Ingreso', '3.00', '-4721.00', 2),
(104, '2021-11-25', 'Ingreso', '4.00', '-4717.00', 2),
(105, '2021-11-25', 'DJI Mini 2', '-2295.00', '-7012.00', 2),
(106, '2021-11-25', 'Ingreso', '8000.00', '988.00', 2),
(107, '2021-11-26', 'DJI Mini 2', '-459.00', '999540.99', 1),
(108, '2021-11-26', 'DJI Mini 2', '-459.00', '999081.99', 1),
(109, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '998916.99', 1),
(110, '2021-11-26', 'DJI Mini 2', '-459.00', '998457.99', 1),
(111, '2021-11-26', 'Sansisco D15 Mini Drone', '-495.00', '997962.99', 1),
(112, '2021-11-26', 'DJI Mini 2', '-458541.00', '539421.99', 1),
(113, '2021-11-26', 'DJI Mini 2', '-458541.00', '80880.99', 1),
(114, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '80715.99', 1),
(115, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '80550.99', 1),
(116, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '80385.99', 1),
(117, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '80220.99', 1),
(118, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '80055.99', 1),
(119, '2021-11-26', 'DJI Mini 2', '-459.00', '79596.99', 1),
(120, '2021-11-26', 'DJI Mini 2', '-459.00', '79137.99', 1),
(121, '2021-11-26', 'Sansisco D15 Mini Drone', '-165.00', '78972.99', 1),
(122, '2021-11-26', 'DJI Mini 2', '-459.00', '78513.99', 1),
(123, '2021-11-26', 'DJI Mini 2', '-459.00', '78054.99', 1),
(124, '2021-11-29', 'Ingreso', '100.00', '78154.99', 1),
(125, '2021-11-29', 'Ingreso', '150.00', '78304.99', 1),
(126, '2021-11-29', 'Ingreso', '1.00', '78305.99', 1),
(127, '2021-11-29', 'Ingreso', '3.00', '991.00', 2),
(128, '2021-11-29', 'Ingreso', '3.00', '994.00', 2),
(129, '2021-11-29', 'Ingreso', '5.00', '999.00', 2),
(130, '2021-11-29', 'Ingreso', '7.00', '1006.00', 2),
(131, '2021-11-29', 'Ingreso', '8.00', '1014.00', 2),
(132, '2021-11-29', 'Ingreso', '12.00', '1026.00', 2),
(133, '2021-11-29', 'Ingreso', '88.00', '1114.00', 2),
(134, '2021-11-29', 'Ingreso', '125.00', '1239.00', 2),
(135, '2021-11-29', 'Ingreso', '2555.00', '3794.00', 2),
(136, '2021-11-29', 'Ingreso', '2.00', '78307.99', 1),
(137, '2021-11-29', 'Ingreso', '3.00', '78310.99', 1),
(138, '2021-11-29', 'Ingreso', '4.00', '78314.99', 1),
(139, '2021-11-29', 'Ingreso', '5.00', '78319.99', 1),
(140, '2021-11-29', 'Ingreso', '6.00', '78325.99', 1),
(141, '2021-11-29', 'Sansisco D15 Mini Drone', '-165.00', '78160.99', 1),
(142, '2021-11-29', 'Sansisco D15 Mini Drone', '-330.00', '77830.99', 1),
(143, '2021-11-29', 'DJI Mini 2', '-459.00', '77371.99', 1),
(144, '2021-11-29', 'DJI Mini 2', '-2754.00', '74617.99', 1),
(145, '2021-11-29', 'DJI Mini 2', '-45900.00', '28717.99', 1),
(146, '2021-11-29', 'DJI Mini 2', '-22950.00', '5767.99', 1),
(147, '2021-11-29', 'DJI Mini 2', '-11475.00', '-5707.01', 1),
(148, '2021-11-29', 'DJI Mini 2', '-4590.00', '-10297.01', 1),
(149, '2021-11-29', 'Ingreso', '20000.00', '9702.99', 1),
(150, '2021-11-29', 'DJI Mini 2', '-2295.00', '7407.99', 1),
(151, '2021-11-29', 'DJI Mini 2', '-918.00', '6489.99', 1),
(152, '2021-11-29', 'DJI Mini 2', '-3672.00', '2817.99', 1),
(153, '2021-11-29', 'Ingreso', '1000.00', '3817.99', 1),
(154, '2021-11-29', 'Ingreso', '200.00', '4017.99', 1),
(155, '2021-11-29', 'Ingreso', '50.00', '4067.99', 1),
(156, '2021-11-29', 'Ingreso', '3.00', '4070.99', 1),
(157, '2021-11-29', 'Ingreso', '5.00', '4075.99', 1),
(158, '2021-11-29', 'Ingreso', '5.00', '4080.99', 1),
(159, '2021-11-29', 'Ingreso', '5.00', '4085.99', 1),
(160, '2021-11-29', 'Ingreso', '5.00', '4090.99', 1),
(161, '2021-11-29', 'Ingreso', '5.00', '4095.99', 1),
(162, '2021-11-29', 'Ingreso', '5.00', '4100.99', 1),
(163, '2021-11-29', 'Ingreso', '5.00', '4105.99', 1),
(164, '2021-11-29', 'Ingreso', '5.00', '4110.99', 1),
(165, '2021-11-29', 'Ingreso', '5.00', '4115.99', 1),
(166, '2021-11-29', 'Ingreso', '5.00', '4120.99', 1),
(167, '2021-11-29', 'Ingreso', '5.00', '4125.99', 1),
(168, '2021-11-29', 'Ingreso', '6.00', '4131.99', 1),
(169, '2021-11-29', 'Ingreso', '7.00', '4138.99', 1),
(170, '2021-11-29', 'Ingreso', '2.00', '4140.99', 1),
(171, '2021-11-29', 'Ingreso', '3.00', '4143.99', 1),
(172, '2021-11-29', 'Ingreso', '4.00', '4147.99', 1),
(173, '2021-11-29', 'Ingreso', '1.00', '4148.99', 1),
(174, '2021-11-29', 'Ingreso', '2.00', '4150.99', 1),
(175, '2021-11-29', 'Ingreso', '3.00', '4153.99', 1),
(176, '2021-11-29', 'Ingreso', '4.00', '4157.99', 1),
(177, '2021-11-29', 'Ingreso', '3.00', '4160.99', 1),
(178, '2021-11-29', 'Ingreso', '4.00', '4164.99', 1),
(179, '2021-11-29', 'Ingreso', '5.00', '4169.99', 1),
(180, '2021-11-29', 'Ingreso', '6.00', '4175.99', 1),
(181, '2021-11-29', 'Ingreso', '5.00', '4180.99', 1),
(182, '2021-11-29', 'Ingreso', '5.00', '4185.99', 1),
(183, '2021-11-29', 'Ingreso', '5.00', '4190.99', 1),
(184, '2021-11-29', 'Ingreso', '5.00', '4195.99', 1),
(185, '2021-11-29', 'Ingreso', '5.00', '4200.99', 1),
(186, '2021-11-29', 'Ingreso', '5.00', '4205.99', 1),
(187, '2021-11-29', 'Ingreso', '6.00', '4211.99', 1),
(188, '2021-11-29', 'Ingreso', '20.00', '4231.99', 1),
(189, '2021-11-29', 'Ingreso', '5.00', '4236.99', 1),
(190, '2021-11-29', 'Ingreso', '6.00', '4242.99', 1),
(191, '2021-11-29', 'Ingreso', '8.00', '4250.99', 1),
(192, '2021-11-29', 'Ingreso', '6.00', '3800.00', 2),
(193, '2021-11-29', 'Ingreso', '8.00', '3808.00', 2),
(194, '2021-11-29', 'Ingreso', '6.00', '3814.00', 2),
(195, '2021-11-29', 'Ingreso', '69.00', '4319.99', 1),
(196, '2021-11-29', 'Ingreso', '1.21', '4321.20', 1),
(197, '2021-11-29', 'Ingreso', '5.20', '4326.40', 1),
(198, '2021-11-29', 'Ingreso', '5.02', '4331.42', 1),
(199, '2021-11-29', 'Ingreso', '5.10', '3819.10', 2),
(200, '2021-11-29', 'Ingreso', '2.00', '3821.10', 2),
(201, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-331.00', '1683.42', 1),
(202, '2021-11-29', 'Transferencia de 15478965478541235698', '331.00', '6469.10', 2),
(203, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '1681.42', 1),
(204, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '6471.10', 2),
(205, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-681.00', '-361.58', 1),
(206, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-681.00', '-361.58', 1),
(207, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-681.00', '-361.58', 1),
(208, '2021-11-29', 'Transferencia de 15478965478541235698', '681.00', '8514.10', 2),
(209, '2021-11-29', 'Transferencia de 15478965478541235698', '681.00', '8514.10', 2),
(210, '2021-11-29', 'Transferencia de 34567897432456787654', '681.00', '8514.10', 2),
(211, '2021-11-29', 'Ingreso', '5000.00', '4638.42', 1),
(212, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4636.42', 1),
(213, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4636.42', 1),
(214, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8516.10', 2),
(215, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8516.10', 2),
(216, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4634.42', 1),
(217, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4634.42', 1),
(218, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8518.10', 2),
(219, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8518.10', 2),
(220, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4633.42', 1),
(221, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8520.10', 2),
(222, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4632.42', 1),
(223, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8520.10', 2),
(224, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4620.42', 1),
(225, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4620.42', 1),
(226, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4620.42', 1),
(227, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4620.42', 1),
(228, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4620.42', 1),
(229, '2021-11-29', 'Transferencia de 34567897432456787654', '2.00', '8532.10', 2),
(230, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8532.10', 2),
(231, '2021-11-29', 'Transferencia de 34567897432456787654', '2.00', '8532.10', 2),
(232, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8532.10', 2),
(233, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4620.42', 1),
(234, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8532.10', 2),
(235, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8532.10', 2),
(236, '2021-11-29', 'Ingreso', '1.00', '4621.42', 1),
(237, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4619.42', 1),
(238, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8534.10', 2),
(239, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4619.42', 1),
(240, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8534.10', 2),
(241, '2021-11-29', 'Ingreso', '1.00', '4620.42', 1),
(242, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4616.42', 1),
(243, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4616.42', 1),
(244, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8538.10', 2),
(245, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8538.10', 2),
(246, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-3.00', '4604.42', 1),
(247, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-3.00', '4604.42', 1),
(248, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-3.00', '4604.42', 1),
(249, '2021-11-29', 'Transferencia de 15478965478541235698', '3.00', '8550.10', 2),
(250, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-3.00', '4604.42', 1),
(251, '2021-11-29', 'Transferencia de 15478965478541235698', '3.00', '8550.10', 2),
(252, '2021-11-29', 'Transferencia de 34567897432456787654', '3.00', '8550.10', 2),
(253, '2021-11-29', 'Transferencia de 15478965478541235698', '3.00', '8550.10', 2),
(254, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4580.42', 1),
(255, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4580.42', 1),
(256, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4580.42', 1),
(257, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4580.42', 1),
(258, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4580.42', 1),
(259, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4580.42', 1),
(266, '2021-11-29', 'Ingreso', '20.00', '4600.42', 1),
(267, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-5.00', '4595.42', 1),
(268, '2021-11-29', 'Transferencia de 15478965478541235698', '5.00', '8555.10', 2),
(269, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4592.42', 1),
(270, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4592.42', 1),
(271, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4592.42', 1),
(272, '2021-11-29', 'Transferencia de 34567897432456787654', '1.00', '8558.10', 2),
(273, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8558.10', 2),
(274, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8558.10', 2),
(275, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-2.00', '4590.42', 1),
(276, '2021-11-29', 'Transferencia de 15478965478541235698', '2.00', '8560.10', 2),
(277, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-3.00', '4587.42', 1),
(278, '2021-11-29', 'Transferencia de 15478965478541235698', '3.00', '8563.10', 2),
(279, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4575.42', 1),
(280, '2021-11-29', 'Transferencia de 15478965478541235698', '4.00', '8575.10', 2),
(281, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4575.42', 1),
(282, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-4.00', '4575.42', 1),
(283, '2021-11-29', 'Transferencia de 34567897432456787654', '4.00', '8575.10', 2),
(284, '2021-11-29', 'Transferencia de 15478965478541235698', '4.00', '8575.10', 2),
(285, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-5.00', '8555.10', 2),
(286, '2021-11-29', 'Transferencia de 34567897432456787654', '5.00', '4595.42', 1),
(287, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-5.00', '8555.10', 2),
(288, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-5.00', '8555.10', 2),
(289, '2021-11-29', 'Transferencia de 15478965478541235698', '5.00', '4595.42', 1),
(290, '2021-11-29', 'Transferencia de 34567897432456787654', '5.00', '4595.42', 1),
(291, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-5.00', '8555.10', 2),
(292, '2021-11-29', 'Transferencia de 15478965478541235698', '5.00', '4595.42', 1),
(293, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4591.42', 1),
(294, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4591.42', 1),
(295, '2021-11-29', 'Transferencia de 34567897432456787654', '1.00', '8559.10', 2),
(296, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4590.42', 1),
(297, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4590.42', 1),
(298, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8559.10', 2),
(299, '2021-11-29', 'Transferencia de 34567897432456787654', '1.00', '8560.10', 2),
(300, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4590.42', 1),
(301, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8560.10', 2),
(302, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8560.10', 2),
(303, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4587.42', 1),
(304, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8563.10', 2),
(305, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4587.42', 1),
(306, '2021-11-29', 'Transferencia de 34567897432456787654', '1.00', '8563.10', 2),
(307, '2021-11-29', 'Transferencia a Selecciona una cuenta', '-1.00', '4587.42', 1),
(308, '2021-11-29', 'Transferencia de 15478965478541235698', '1.00', '8563.10', 2),
(309, '2021-11-30', 'Ingreso', '2.00', '8565.10', 2),
(310, '2021-11-30', 'Ingreso', '4.00', '8569.10', 2),
(311, '2021-11-30', 'Ingreso', '3.00', '4590.42', 1),
(312, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4585.42', 1),
(313, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8574.10', 2),
(314, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4583.42', 1),
(315, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8576.10', 2),
(316, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4583.42', 1),
(317, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8576.10', 2),
(318, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4582.42', 1),
(319, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8577.10', 2),
(320, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4580.42', 1),
(321, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4580.42', 1),
(322, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8579.10', 2),
(323, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8579.10', 2),
(324, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4577.42', 1),
(325, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4577.42', 1),
(326, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8582.10', 2),
(327, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4577.42', 1),
(328, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8582.10', 2),
(329, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8582.10', 2),
(330, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4576.42', 1),
(331, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8583.10', 2),
(332, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4571.42', 1),
(333, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8588.10', 2),
(334, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4561.42', 1),
(335, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8598.10', 2),
(336, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4561.42', 1),
(337, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8598.10', 2),
(338, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-4.00', '4549.42', 1),
(339, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-4.00', '4549.42', 1),
(340, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-4.00', '4549.42', 1),
(341, '2021-11-30', 'Transferencia de 15478965478541235698', '4.00', '8610.10', 2),
(342, '2021-11-30', 'Transferencia de 15478965478541235698', '4.00', '8610.10', 2),
(343, '2021-11-30', 'Transferencia de 15478965478541235698', '4.00', '8610.10', 2),
(344, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4548.42', 1),
(345, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8611.10', 2),
(346, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4544.42', 1),
(347, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4544.42', 1),
(348, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8615.10', 2),
(349, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8615.10', 2),
(350, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-3.00', '4535.42', 1),
(351, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-3.00', '4535.42', 1),
(352, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-3.00', '4535.42', 1),
(353, '2021-11-30', 'Transferencia de 15478965478541235698', '3.00', '8624.10', 2),
(354, '2021-11-30', 'Transferencia de 15478965478541235698', '3.00', '8624.10', 2),
(355, '2021-11-30', 'Transferencia de 15478965478541235698', '3.00', '8624.10', 2),
(356, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4534.42', 1),
(357, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8625.10', 2),
(358, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4530.42', 1),
(359, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4530.42', 1),
(360, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8629.10', 2),
(361, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8629.10', 2),
(362, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4529.42', 1),
(363, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8630.10', 2),
(364, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4525.42', 1),
(365, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8632.10', 2),
(366, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4525.42', 1),
(367, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8634.10', 2),
(368, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4524.42', 1),
(369, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8635.10', 2),
(370, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4522.42', 1),
(371, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8637.10', 2),
(372, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4522.42', 1),
(373, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8637.10', 2),
(374, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-10.00', '4502.42', 1),
(375, '2021-11-30', 'Transferencia de 15478965478541235698', '10.00', '8647.10', 2),
(376, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-10.00', '4492.42', 1),
(377, '2021-11-30', 'Transferencia de 15478965478541235698', '10.00', '8657.10', 2),
(378, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-10.00', '4492.42', 1),
(379, '2021-11-30', 'Transferencia de 15478965478541235698', '10.00', '8667.10', 2),
(380, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4487.42', 1),
(381, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8672.10', 2),
(382, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4477.42', 1),
(383, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8682.10', 2),
(384, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-5.00', '4477.42', 1),
(385, '2021-11-30', 'Transferencia de 15478965478541235698', '5.00', '8682.10', 2),
(386, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4476.42', 1),
(387, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8683.10', 2),
(388, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4474.42', 1),
(389, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8685.10', 2),
(390, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-2.00', '4472.42', 1),
(391, '2021-11-30', 'Transferencia de 15478965478541235698', '2.00', '8687.10', 2),
(392, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-3.00', '4469.42', 1),
(393, '2021-11-30', 'Transferencia de 15478965478541235698', '3.00', '8690.10', 2),
(394, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-3.00', '4466.42', 1),
(395, '2021-11-30', 'Transferencia de 15478965478541235698', '3.00', '8693.10', 2),
(396, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-3.00', '4463.42', 1),
(397, '2021-11-30', 'Transferencia de 15478965478541235698', '3.00', '8696.10', 2),
(398, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4462.42', 1),
(399, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8697.10', 2),
(400, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4461.42', 1),
(401, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8698.10', 2),
(402, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4460.42', 1),
(403, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8699.10', 2),
(404, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4459.42', 1),
(405, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8700.10', 2),
(406, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4458.42', 1),
(407, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8701.10', 2),
(408, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4457.42', 1),
(409, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8702.10', 2),
(410, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4456.42', 1),
(411, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8703.10', 2),
(412, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4455.42', 1),
(413, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8704.10', 2),
(414, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4454.42', 1),
(415, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8705.10', 2),
(416, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4453.42', 1),
(417, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8706.10', 2),
(418, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4452.42', 1),
(419, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8707.10', 2),
(420, '2021-11-30', 'Transferencia a Selecciona una cuenta', '-1.00', '4451.42', 1),
(421, '2021-11-30', 'Transferencia de 15478965478541235698', '1.00', '8708.10', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `numerofactura` int(50) NOT NULL,
  `idcuenta` int(11) NOT NULL,
  `proveedor` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` int(11) NOT NULL,
  `importe` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `numerofactura`, `idcuenta`, `proveedor`, `idproducto`, `precio`, `fecha`, `cantidad`, `importe`) VALUES
(28, 322317, 1, 1, 1, '459.00', '2021-11-17', 5, '2295.00'),
(29, 385788, 2, 2, 2, '165.00', '2021-11-17', 5, '825.00'),
(30, 711971, 1, 2, 2, '165.00', '2021-11-17', 5, '825.00'),
(31, 192729, 1, 1, 1, '459.00', '2021-11-17', 100, '45900.00'),
(32, 175031, 1, 2, 2, '165.00', '2021-11-17', 5, '825.00'),
(33, 819533, 1, 2, 2, '165.00', '2021-11-17', 5, '825.00'),
(34, 885199, 1, 2, 2, '165.00', '2021-11-17', 5, '825.00'),
(35, 409231, 1, 1, 1, '459.00', '2021-11-17', 2, '918.00'),
(36, 318361, 1, 1, 1, '459.00', '2021-11-17', 2, '918.00'),
(37, 501451, 1, 2, 2, '165.00', '2021-11-17', 1, '165.00'),
(38, 197175, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(39, 343502, 1, 2, 2, '165.00', '2021-11-17', 1, '165.00'),
(40, 700131, 1, 2, 2, '165.00', '2021-11-17', 1, '165.00'),
(41, 282456, 1, 1, 1, '459.00', '2021-11-17', 2, '918.00'),
(42, 172245, 1, 1, 1, '459.00', '2021-11-17', 2, '918.00'),
(43, 139923, 1, 1, 1, '459.00', '2021-11-17', 2, '918.00'),
(44, 786892, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(45, 663706, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(46, 687786, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(47, 882106, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(48, 541302, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(49, 730183, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(50, 920851, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(51, 394894, 1, 2, 2, '165.00', '2021-11-17', 1, '165.00'),
(52, 359161, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(53, 650615, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(54, 964593, 1, 2, 2, '165.00', '2021-11-17', 1, '165.00'),
(55, 707580, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(56, 548703, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(57, 601454, 1, 2, 2, '165.00', '2021-11-17', 1, '165.00'),
(58, 247947, 1, 1, 1, '459.00', '2021-11-17', 1, '459.00'),
(59, 448793, 1, 2, 2, '165.00', '2021-11-18', 1, '165.00'),
(60, 822439, 1, 1, 1, '459.00', '2021-11-18', 2, '918.00'),
(61, 110960, 2, 1, 1, '459.00', '2021-11-25', 5, '2295.00'),
(62, 147053, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(63, 269485, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(64, 939629, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(65, 619822, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(66, 916795, 1, 2, 2, '165.00', '2021-11-26', 3, '495.00'),
(67, 671290, 1, 1, 1, '459.00', '2021-11-26', 999, '458541.00'),
(68, 102216, 1, 1, 1, '459.00', '2021-11-26', 999, '458541.00'),
(69, 642312, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(70, 183243, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(71, 306085, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(72, 883746, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(73, 948823, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(74, 474383, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(75, 112433, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(76, 972622, 1, 2, 2, '165.00', '2021-11-26', 1, '165.00'),
(77, 323258, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(78, 741131, 1, 1, 1, '459.00', '2021-11-26', 1, '459.00'),
(79, 365962, 1, 2, 2, '165.00', '2021-11-29', 1, '165.00'),
(80, 922370, 1, 2, 2, '165.00', '2021-11-29', 2, '330.00'),
(81, 332673, 1, 1, 1, '459.00', '2021-11-29', 1, '459.00'),
(82, 255880, 1, 1, 1, '459.00', '2021-11-29', 6, '2754.00'),
(83, 223996, 1, 1, 1, '459.00', '2021-11-29', 100, '45900.00'),
(84, 455808, 1, 1, 1, '459.00', '2021-11-29', 50, '22950.00'),
(85, 344416, 1, 1, 1, '459.00', '2021-11-29', 25, '11475.00'),
(86, 145124, 1, 1, 1, '459.00', '2021-11-29', 10, '4590.00'),
(87, 520300, 1, 1, 1, '459.00', '2021-11-29', 5, '2295.00'),
(88, 337296, 1, 1, 1, '459.00', '2021-11-29', 2, '918.00'),
(89, 931969, 1, 1, 1, '459.00', '2021-11-29', 8, '3672.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mistock`
--

CREATE TABLE `mistock` (
  `id` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `stock` int(50) NOT NULL,
  `img` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mistock`
--

INSERT INTO `mistock` (`id`, `idproducto`, `precio`, `stock`, `img`) VALUES
(1, 1, '459.00', 2507, 'https://m.media-amazon.com/images/I/51CsiIpZr+S._AC_SL1500_.jpg'),
(2, 2, '165.00', 233, 'https://m.media-amazon.com/images/I/712SzEkPzqL._AC_SL1478_.jpg'),
(3, 3, '55.00', 200, 'https://m.media-amazon.com/images/I/71iV6bxppQL._AC_SL1500_.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `img` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `precio`, `img`) VALUES
(1, 'DJI Mini 2', '459.00', 'https://m.media-amazon.com/images/I/51CsiIpZr+S._AC_SL1500_.jpg'),
(2, 'Sansisco D15 Mini Drone', '165.00', 'https://m.media-amazon.com/images/I/712SzEkPzqL._AC_SL1478_.jpg'),
(3, 'tech rc Mini Drone', '55.00', 'https://m.media-amazon.com/images/I/71iV6bxppQL._AC_SL1500_.jpg'),
(4, '4DRC V2 Mini Drone', '52.00', 'https://m.media-amazon.com/images/I/61-Ko3r2daL._AC_SL1193_.jpg'),
(5, 'DJI Air 2S- Drone', '999.00', 'https://m.media-amazon.com/images/I/41HUFP++OOS._AC_SL1126_.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provee`
--

CREATE TABLE `provee` (
  `id` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provee`
--

INSERT INTO `provee` (`id`, `idproveedor`, `idproducto`, `cantidad`) VALUES
(3, 1, 1, 50),
(4, 2, 2, 60);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id`, `nombre`) VALUES
(1, 'amazon'),
(2, 'pccomponentes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `contraseña` varchar(50) NOT NULL,
  `tipo` int(10) NOT NULL,
  `idcuenta` int(11) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `telefono` int(9) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `contraseña`, `tipo`, `idcuenta`, `dni`, `telefono`, `correo`) VALUES
(1, 'admin', 'admin', 1, 1, '45789532C', 641578452, 'admin@admin.com'),
(2, 'admin', 'admin', 1, 2, '45789532C', 641578452, 'admin@admin.com');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numcuenta` (`numcuenta`);

--
-- Indices de la tabla `extracto`
--
ALTER TABLE `extracto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idcuenta` (`idcuenta`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idproducto` (`idproducto`),
  ADD KEY `idcuenta` (`idcuenta`);

--
-- Indices de la tabla `mistock`
--
ALTER TABLE `mistock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `provee`
--
ALTER TABLE `provee`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idproveedor` (`idproveedor`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idcuenta` (`idcuenta`),
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `extracto`
--
ALTER TABLE `extracto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=422;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT de la tabla `mistock`
--
ALTER TABLE `mistock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `provee`
--
ALTER TABLE `provee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `extracto`
--
ALTER TABLE `extracto`
  ADD CONSTRAINT `extracto_ibfk_1` FOREIGN KEY (`idcuenta`) REFERENCES `cuentas` (`id`);

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `factura_ibfk_3` FOREIGN KEY (`idcuenta`) REFERENCES `cuentas` (`id`);

--
-- Filtros para la tabla `mistock`
--
ALTER TABLE `mistock`
  ADD CONSTRAINT `mistock_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `provee`
--
ALTER TABLE `provee`
  ADD CONSTRAINT `provee_ibfk_1` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`id`),
  ADD CONSTRAINT `provee_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idcuenta`) REFERENCES `cuentas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
