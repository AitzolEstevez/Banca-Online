-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 03-12-2021 a las 00:30:40
-- Versión del servidor: 10.4.14-MariaDB
-- Versión de PHP: 7.4.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `lauzeru5_banco2`
--
drop database if exists `lauzeru5_banco2`;
CREATE DATABASE IF NOT EXISTS `lauzeru5_banco2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `lauzeru5_banco2`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `createAdminUserFromCuenta` (IN `idcuenta` INT(11))  INSERT INTO usuarios (`nombre`,`contraseña`,`tipo`,`idcuenta`,`dni`) VALUES ('admin','admin',1,idcuenta,'45789532C')$$

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectCuentasAdmin` ()  SELECT c.id, c.numcuenta, c.tipo, c.saldo FROM cuentas c, usuarios u WHERE u.tipo=1 AND u.id=c.idusuario$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateAumentar` (IN `saldo` DECIMAL(8,2), IN `numcuenta` VARCHAR(50))  UPDATE cuentas SET cuentas.saldo=cuentas.saldo+saldo WHERE cuentas.numcuenta=numcuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCuentas` (IN `saldo` DECIMAL(8,2), IN `idcuenta` INT(11))  UPDATE cuentas SET cuentas.saldo=cuentas.saldo-saldo WHERE cuentas.id=idcuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateCuentasFondos` (IN `saldo` DECIMAL(8,2), IN `idcuenta` INT(11))  UPDATE cuentas SET cuentas.saldo=cuentas.saldo+saldo WHERE cuentas.id=idcuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `updateReducir` (IN `saldo` DECIMAL(8,2), IN `numcuenta` VARCHAR(50))  UPDATE cuentas SET cuentas.saldo=cuentas.saldo-saldo WHERE cuentas.numcuenta=numcuenta$$

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
  `borrado` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `numcuenta`, `tipo`, `saldo`, `borrado`, `idusuario`) VALUES
(41, '1547 8965 47 8541235698', 'Corriente', '-3252.99', 0, 24),
(42, '1234 5678 9012 3456', 'Crédito', '219.00', 0, 24),
(43, '12345678901234567890', 'Corriente', '97.00', 0, 24),
(44, '1234512345123451', 'Crédito', '0.00', 0, 24),
(45, '1234512345123452', 'Crédito', '0.00', 0, 24);

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
(249, '2021-12-01', 'Ingreso', '200.00', '200.00', 41),
(250, '2021-12-01', 'Ingreso', '100.00', '300.00', 41),
(251, '2021-12-01', 'Ingreso', '50.00', '50.00', 42),
(252, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-20.00', '220.00', 41),
(253, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-20.00', '220.00', 41),
(254, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-20.00', '220.00', 41),
(255, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '20.00', '80.00', 43),
(256, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-20.00', '220.00', 41),
(257, '2021-12-01', 'Transferencia de 12345678901234567890', '20.00', '80.00', 43),
(258, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '20.00', '80.00', 43),
(259, '2021-12-01', 'Transferencia de 12345678901234567890', '20.00', '80.00', 43),
(260, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-21.00', '136.00', 41),
(261, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-21.00', '136.00', 41),
(262, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-21.00', '136.00', 41),
(263, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '21.00', '134.00', 42),
(264, '2021-12-01', 'Transferencia de 1234 5678 9012 3456', '21.00', '134.00', 42),
(265, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '21.00', '134.00', 42),
(266, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-21.00', '136.00', 41),
(267, '2021-12-01', 'Transferencia de 12345678901234567890', '21.00', '134.00', 42),
(268, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-1.00', '135.00', 41),
(269, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '1.00', '81.00', 43),
(270, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '123.00', 41),
(271, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '123.00', 41),
(272, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '123.00', 41),
(273, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '2.00', '89.00', 43),
(274, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '123.00', 41),
(275, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '123.00', 41),
(276, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '123.00', 41),
(277, '2021-12-01', 'Transferencia de 12345678901234567890', '2.00', '93.00', 43),
(278, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '2.00', '93.00', 43),
(279, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '2.00', '93.00', 43),
(280, '2021-12-01', 'Transferencia de 1234 5678 9012 3456', '2.00', '93.00', 43),
(281, '2021-12-01', 'Transferencia de 12345678901234567890', '2.00', '93.00', 43),
(282, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '119.00', 41),
(283, '2021-12-01', 'Transferencia de 1547 8965 47 8541235698', '2.00', '95.00', 43),
(284, '2021-12-01', 'Transferencia a Selecciona una cuenta', '-2.00', '119.00', 41),
(285, '2021-12-01', 'Transferencia de 12345678901234567890', '2.00', '97.00', 43),
(286, '2021-12-02', 'Transferencia a Selecciona una cuenta', '-5.00', '119.00', 42),
(287, '2021-12-02', 'Transferencia a Selecciona una cuenta', '-5.00', '119.00', 42),
(288, '2021-12-02', 'Transferencia a Selecciona una cuenta', '-5.00', '119.00', 42),
(289, '2021-12-02', 'Transferencia de 12345678901234567890', '5.00', '134.00', 41),
(290, '2021-12-02', 'Transferencia de 1234 5678 9012 3456', '5.00', '134.00', 41),
(291, '2021-12-02', 'Transferencia de 1547 8965 47 8541235698', '5.00', '134.00', 41),
(292, '2021-12-02', 'Ingreso', '100.00', '219.00', 42),
(293, '2021-12-02', 'Ingreso', '5.00', '224.00', 42),
(294, '2021-12-02', 'DJI Mini 2', '-2295.00', '-2161.00', 41),
(295, '2021-12-02', 'Ingreso', '3.00', '3.00', 44),
(296, '2021-12-02', 'Transferencia a 1547 8965 47 8541235698', '-3.00', '0.00', 44),
(297, '2021-12-02', 'Transferencia de 1234512345123451', '3.00', '-2158.00', 41),
(298, '2021-12-02', 'Ingreso', '5.00', '-2153.00', 41),
(299, '2021-12-02', 'Transferencia a 1547 8965 47 8541235698', '-5.00', '219.00', 42),
(300, '2021-12-02', 'Transferencia de 1234 5678 9012 3456', '5.00', '-2148.00', 41),
(301, '2021-12-02', 'Ingreso', '5.00', '5.00', 45),
(302, '2021-12-02', 'Transferencia a 1547 8965 47 8541235698', '-5.00', '0.00', 45),
(303, '2021-12-02', 'Transferencia de 1234512345123452', '5.00', '-2143.00', 41),
(304, '2021-12-02', 'Ingreso', '3.00', '3.00', 45),
(305, '2021-12-02', 'DJI Mini 2', '-459.00', '-2602.00', 41),
(306, '2021-12-02', 'Ingreso', '5.00', '-2597.00', 41),
(307, '2021-12-02', 'Transferencia a 1547 8965 47 8541235698', '-3.00', '0.00', 45),
(308, '2021-12-02', 'Transferencia de 1234512345123452', '3.00', '-2594.00', 41),
(309, '2021-12-02', 'DJI Mini 2', '-459.00', '-3053.00', 41),
(310, '2021-12-03', 'Potensic T25 Drone', '-199.99', '-3252.99', 41);

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
(40, 931652, 41, 1, 1, '459.00', '2021-12-02', 5, '2295.00'),
(41, 928832, 41, 1, 1, '459.00', '2021-12-02', 1, '459.00'),
(42, 735678, 41, 1, 1, '459.00', '2021-12-02', 1, '459.00'),
(43, 232965, 41, 2, 7, '199.99', '2021-12-03', 1, '199.99');

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
(1, 1, '459.00', 707, 'https://m.media-amazon.com/images/I/51CsiIpZr+S._AC_SL1500_.jpg'),
(2, 2, '165.00', 195, 'https://m.media-amazon.com/images/I/712SzEkPzqL._AC_SL1478_.jpg'),
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
(1, 'DJI Mini 2', '459.00', 'https://www.cordobadigital.net/wp-content/uploads/2021/01/Mavicmini2.jpg'),
(2, 'DJI Mavic 3', '2099.00', 'https://www.macnificos.com/sites/files/styles/product_page_zoom/public/images/product/cpma045201-01-dji-mavic3dronflymorekit.jpg?itok=d7ivy_s-'),
(3, 'DJI Tello', '109.00', 'https://m.media-amazon.com/images/I/71iV6bxppQL._AC_SL1500_.jpghttps://cdn1.foto321.com/10111-large_default/drone-dji-tello.jpg'),
(4, 'DJI Spark', '320.00', 'https://i.blogs.es/02859f/dji-spark-alpine-white---front-3-4-1-/450_1000.jpg'),
(5, 'DJI Phantom 4 Pro', '1500.00', 'https://m.media-amazon.com/images/I/416nq1xvcwL._AC_SS450_.jpg'),
(6, 'DRONE PRO GPS 6K', '229.95', 'https://cdn.shopify.com/s/files/1/0527/0575/5303/products/6Kprodualcameradrone-Black_2000x.png?v=1628619800'),
(7, 'Potensic T25 Drone', '199.99', 'https://i1.wp.com/myactionreviews.com/wp-content/uploads/2020/03/pt25.jpg'),
(8, '4DRC F11 PRO', '107.38', 'https://imgaz.staticbg.com/thumb/large/oaupload/banggood/images/5E/E7/720ae794-ace9-4b5b-95c7-e496cc4521b8.jpg.webp'),
(9, 'Innjoo BlackEye 4K Dron', '108.75', 'https://thumb.pccomponentes.com/w-530-530/articles/34/349872/1906-innjoo-blackeye-4k-dron.jpg'),
(10, 'Denver DCW-380 Dron', '43.41', 'https://thumb.pccomponentes.com/w-530-530/articles/31/315183/1891-denver-dcw-380-dron.jpg'),
(11, 'Prixton Predator Drone', '59.95', 'https://img.pccomponentes.com/articles/25/256459/prixton-predator-drone-con-camara-03mp-913b4a18-5e42-4856-a65c-5ba1b1e2ae2f.jpg'),
(12, 'Denver DCW-360 Dron', '42.78', 'https://img.pccomponentes.com/articles/67/673659/1742-denver-dcw-360-dron.jpg'),
(13, 'Autel Robotic EVO II Pro 6K', '2580.94', 'https://img.pccomponentes.com/articles/34/340716/1931-autel-robotic-evo-ii-pro-6k-rugged-bundle.jpg'),
(14, 'DJI FPV', '1349.00', 'https://stormsend1.djicdn.com/tpc/uploads/carousel/image/d55541dae0fb81a6dae74c750bedeec8@ultra.jpg'),
(15, 'Phantom 4 Pro', '1999.00', 'https://m.media-amazon.com/images/I/416nq1xvcwL._AC_SS450_.jpg'),
(16, 'Inspire 2', '3399.00', 'https://stormsend1.djicdn.com/tpc/uploads/photos/405/large_9351802d-9e88-4bb6-979c-48fe81748a33.png'),
(17, 'Potensic Mini Drone', '59.49', 'https://www.worten.pt/i/31e7914861dd1276b45016bb68685a7ad4c47770.jpg'),
(18, 'Tomzon D28', '79.99', 'http://cdn.shopify.com/s/files/1/0570/5583/8363/products/potensic-d58hp-drone_f499d6b5-34d9-426e-8184-811ab4a28736.jpg'),
(19, 'Dragon Touch Drone', '71.99', 'https://www.dronesbaratosya.com/wp-content/uploads/2021/06/Dragon-Touch-Drones-baratos-1024x755.jpg'),
(20, 'Potensic Dreamer 4K Drone', '329.00', 'https://cdn.shopify.com/s/files/1/0570/5583/8363/products/potensic-p1-drone_1024x1024.jpg'),
(21, 'SG900S Mini Drone', '20.99', 'https://ae01.alicdn.com/kf/HTB1MqwZPCzqK1RjSZFjq6zlCFXaE/SG900S-Mini-Drone-GPS-Drones-con-c-mara-HD-20-minutos-de-tiempo-de-acci-n.jpg'),
(22, 'DJI Mavic Air', '749.00', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVZTrLcJhiLKHumwy26GricajwkFayupePjc3C5NNRyLJslY0nX_3YaDE0Il7Egz0YgBs&usqp=CAU'),
(23, 'Axis Gimbal Drone', '214.99', 'https://m.media-amazon.com/images/I/31iJpcV0RoL._SL500_.jpg'),
(24, ' JHGF Drone Flycam Quadcopter UAV', '957.82', 'https://m.media-amazon.com/images/I/41cZAQ-18LS._AC_SL1001_.jpg'),
(25, ' JHGF Drones Aerial Photography HD', '1352.50', 'https://m.media-amazon.com/images/I/51rmbgg+OsL._AC_SL1500_.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provee`
--

CREATE TABLE `provee` (
  `id` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `provee`
--

INSERT INTO `provee` (`id`, `idproveedor`, `idproducto`, `cantidad`) VALUES
(1, 1, 1, NULL),
(2, 1, 2, NULL),
(3, 1, 3, NULL),
(4, 1, 4, NULL),
(5, 1, 5, NULL),
(6, 2, 6, NULL),
(7, 2, 7, NULL),
(8, 2, 8, NULL),
(9, 2, 9, NULL),
(10, 2, 10, NULL),
(11, 3, 11, NULL),
(12, 3, 12, NULL),
(13, 3, 13, NULL),
(14, 3, 14, NULL),
(15, 3, 15, NULL),
(16, 4, 16, NULL),
(17, 4, 17, NULL),
(18, 4, 18, NULL),
(19, 4, 19, NULL),
(20, 4, 20, NULL),
(21, 5, 21, NULL),
(22, 5, 22, NULL),
(23, 5, 23, NULL),
(24, 5, 24, NULL),
(25, 5, 25, NULL);

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
(2, 'pccomponentes'),
(3, 'Aliexpress'),
(4, 'Worten'),
(5, 'Corte Inglés');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `contraseña` varchar(50) NOT NULL,
  `tipo` int(10) NOT NULL,
  `dni` varchar(9) NOT NULL,
  `telefono` int(9) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `contraseña`, `tipo`, `dni`, `telefono`, `correo`) VALUES
(24, 'admin', 'admin', 1, '454545A', NULL, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numcuenta` (`numcuenta`),
  ADD KEY `idusuario` (`idusuario`);

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
  ADD KEY `id` (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cuentas`
--
ALTER TABLE `cuentas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `extracto`
--
ALTER TABLE `extracto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=311;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `mistock`
--
ALTER TABLE `mistock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT de la tabla `provee`
--
ALTER TABLE `provee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cuentas`
--
ALTER TABLE `cuentas`
  ADD CONSTRAINT `cuentas_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`id`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
