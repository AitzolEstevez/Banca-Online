-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-11-2021 a las 13:08:23
-- Versión del servidor: 10.4.21-MariaDB
-- Versión de PHP: 8.0.10

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarExtractoCuentas` (IN `cuenta` VARCHAR(50))  SELECT extracto.* FROM extracto, tiene, cuentas WHERE extracto.id=tiene.idextracto AND tiene.idcuenta=cuentas.id AND cuentas.numcuenta=cuenta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarFacturasClientes` ()  SELECT f.id,f.numerofactura,f.nombre AS cliente,c.numcuenta,p.nombre as producto,f.precio,f.fecha,f.cantidad,f.importe FROM factura f, productos p, cuentas c WHERE c.id=f.idcuenta AND p.id=f.idproducto AND f.idcuenta is not null$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarFacturasProveedores` ()  SELECT f.id,f.numerofactura,f.nombre AS proveedor,p.nombre as producto,f.precio,f.fecha,f.cantidad,f.importe FROM factura f, productos p WHERE p.id=f.idproducto AND f.idcuenta is null$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllMiStock` ()  SELECT m.id, p.nombre as producto, m.precio, m.stock FROM mistock m, productos p WHERE m.idproducto=p.id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProductos` ()  SELECT * FROM productos$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProductosByProveedor` (IN `proveedor` INT(11))  SELECT p.* FROM productos p, provee pr, proveedor pro WHERE p.id=pr.idproducto AND pr.idproveedor=pro.id AND pro.id=proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllProveedores` ()  SELECT * FROM proveedor$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectAllUsuarios` ()  SELECT * FROM usuarios$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `SelectCuentasAdmin` ()  SELECT c.id, c.numcuenta, c.tipo, c.interes, c.negociado FROM cuentas c, usuarios u WHERE u.tipo=1 AND u.idcuenta=c.id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas`
--

CREATE TABLE `cuentas` (
  `id` int(11) NOT NULL,
  `numcuenta` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `interes` decimal(8,2) DEFAULT NULL,
  `negociado` decimal(8,2) DEFAULT NULL,
  `borrado` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuentas`
--

INSERT INTO `cuentas` (`id`, `numcuenta`, `tipo`, `interes`, `negociado`, `borrado`) VALUES
(1, '15478965478541235698', 'normal', NULL, NULL, 0),
(2, '34567897432456787654', 'crédito', '7.00', '50000.00', 0),
(3, '78541236589541256983', 'normal', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `extracto`
--

CREATE TABLE `extracto` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `concepto` varchar(100) DEFAULT NULL,
  `importe` decimal(8,2) NOT NULL,
  `saldo` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `extracto`
--

INSERT INTO `extracto` (`id`, `fecha`, `concepto`, `importe`, `saldo`) VALUES
(2, '2021-10-12', 'asdasdasdsa', '50.00', '50000.00'),
(4, '2021-10-12', 'dsgreheh', '50.00', '-45950.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

CREATE TABLE `factura` (
  `id` int(11) NOT NULL,
  `numerofactura` int(50) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `idcuenta` int(11) DEFAULT NULL,
  `idproducto` int(11) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `fecha` date NOT NULL,
  `cantidad` int(11) NOT NULL,
  `importe` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `numerofactura`, `nombre`, `idcuenta`, `idproducto`, `precio`, `fecha`, `cantidad`, `importe`) VALUES
(7, 518936, 'cliente1', 3, 1, '459.00', '2021-10-13', 5, '2295.00'),
(8, 620374, 'pccomponentes', NULL, 2, '165.00', '2021-10-12', 5, '825.00'),
(9, 516982, 'amazon', NULL, 3, '55.00', '2021-10-11', 5, '275.00'),
(10, 684752, 'cliente1', 3, 5, '50.00', '2021-11-27', 5, '3000.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mistock`
--

CREATE TABLE `mistock` (
  `id` int(11) NOT NULL,
  `idproducto` int(11) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `stock` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `mistock`
--

INSERT INTO `mistock` (`id`, `idproducto`, `precio`, `stock`) VALUES
(1, 1, '459.00', 120),
(2, 2, '165.00', 100),
(3, 3, '55.00', 200);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operaciones`
--

CREATE TABLE `operaciones` (
  `id` int(11) NOT NULL,
  `idcuenta` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `importe` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Estructura de tabla para la tabla `tiene`
--

CREATE TABLE `tiene` (
  `id` int(11) NOT NULL,
  `idextracto` int(11) DEFAULT NULL,
  `idcuenta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tiene`
--

INSERT INTO `tiene` (`id`, `idextracto`, `idcuenta`) VALUES
(12, 2, 1),
(13, 4, 2);

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
(2, 'admin', 'admin', 1, 2, '45789532C', 641578452, 'admin@admin.com'),
(3, 'cliente1', '1234', 2, 3, '45783421D', 652365875, 'cliente1@gmail.com');

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
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `factura`
--
ALTER TABLE `factura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `dni` (`idcuenta`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indices de la tabla `mistock`
--
ALTER TABLE `mistock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idproducto` (`idproducto`);

--
-- Indices de la tabla `operaciones`
--
ALTER TABLE `operaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idcuenta` (`idcuenta`);

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
-- Indices de la tabla `tiene`
--
ALTER TABLE `tiene`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idextracto` (`idextracto`),
  ADD KEY `idcuenta` (`idcuenta`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `factura`
--
ALTER TABLE `factura`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `mistock`
--
ALTER TABLE `mistock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `operaciones`
--
ALTER TABLE `operaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT de la tabla `tiene`
--
ALTER TABLE `tiene`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

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
-- Filtros para la tabla `operaciones`
--
ALTER TABLE `operaciones`
  ADD CONSTRAINT `operaciones_ibfk_1` FOREIGN KEY (`idcuenta`) REFERENCES `cuentas` (`id`);

--
-- Filtros para la tabla `provee`
--
ALTER TABLE `provee`
  ADD CONSTRAINT `provee_ibfk_1` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`id`),
  ADD CONSTRAINT `provee_ibfk_2` FOREIGN KEY (`idproducto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `tiene`
--
ALTER TABLE `tiene`
  ADD CONSTRAINT `tiene_ibfk_1` FOREIGN KEY (`idextracto`) REFERENCES `extracto` (`id`),
  ADD CONSTRAINT `tiene_ibfk_2` FOREIGN KEY (`idcuenta`) REFERENCES `cuentas` (`id`),
  ADD CONSTRAINT `tiene_ibfk_3` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`id`),
  ADD CONSTRAINT `tiene_ibfk_4` FOREIGN KEY (`dniusuario`) REFERENCES `usuarios` (`dni`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`idcuenta`) REFERENCES `cuentas` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
