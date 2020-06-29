-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: efip
-- ------------------------------------------------------
-- Server version	10.4.13-MariaDB-1:10.4.13+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `efip`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `efip` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `efip`;

--
-- Table structure for table `articulo`
--

DROP TABLE IF EXISTS `articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `articulo` (
  `idproduct` double NOT NULL AUTO_INCREMENT,
  `barcode` varchar(16) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `precio` int(11) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `marca` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idproduct`),
  UNIQUE KEY `articulo_barcode_UN` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `idfactura` double NOT NULL AUTO_INCREMENT,
  `cuil` int(11) DEFAULT NULL,
  `numero_factura` int(11) unsigned NOT NULL,
  `nombre_completo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idfactura`),
  UNIQUE KEY `factura_numero_factura_UN` (`numero_factura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventario` (
  `idinventario` double NOT NULL AUTO_INCREMENT,
  `fecha_venc` date DEFAULT NULL,
  `sucursales_id` int(11) DEFAULT NULL,
  `barcode` varchar(16) DEFAULT NULL,
  `cantidad` int(11) unsigned NOT NULL,
  PRIMARY KEY (`idinventario`),
  KEY `sucursales_id` (`sucursales_id`),
  KEY `par_ind` (`barcode`),
  CONSTRAINT `inventario_articulo_barcode` FOREIGN KEY (`barcode`) REFERENCES `articulo` (`barcode`) ON DELETE CASCADE,
  CONSTRAINT `inventario_sucursales_id` FOREIGN KEY (`sucursales_id`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sucursales`
--

DROP TABLE IF EXISTS `sucursales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sucursales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `venta_de_articulo`
--

DROP TABLE IF EXISTS `venta_de_articulo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `venta_de_articulo` (
  `idventa` double NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `sucursales_id` int(11) DEFAULT NULL,
  `barcode` varchar(16) DEFAULT NULL,
  `cantidad` int(11) unsigned NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `numero_factura` int(11) DEFAULT NULL,
  PRIMARY KEY (`idventa`),
  KEY `venta_sucursales_id` (`sucursales_id`),
  KEY `venta_par_ind` (`barcode`),
  CONSTRAINT `venta_de_articulo_articulo_barcode` FOREIGN KEY (`barcode`) REFERENCES `articulo` (`barcode`) ON DELETE CASCADE,
  CONSTRAINT `venta_de_articulo_sucursales_id` FOREIGN KEY (`sucursales_id`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'efip'
--

--
-- Dumping routines for database 'efip'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_inventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `add_inventario`(IN in_fecha_venc date, IN in_barcode varchar(16), IN in_sucursales_id int(11), IN in_cantidad int )
begin
  IF EXISTS 
  (
  	SELECT DATE_FORMAT(inventario.fecha_venc , '%d/%m/%Y') AS fecha_venc , 
  	sucursales_id, 
  	barcode, 
  	cantidad 
  	FROM inventario 
  	WHERE barcode = in_barcode 
  	AND fecha_venc = in_fecha_venc 
  	AND sucursales_id = in_sucursales_id 
  ) THEN
    UPDATE inventario SET cantidad=cantidad+in_cantidad WHERE barcode = in_barcode AND fecha_venc = in_fecha_venc  AND sucursales_id = in_sucursales_id ;
  ELSE 
    INSERT INTO inventario (fecha_venc, sucursales_id, barcode, cantidad) VALUES(in_fecha_venc,in_sucursales_id ,in_barcode ,in_cantidad);
  END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `esta_es_la_posta` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `esta_es_la_posta`()
begin
  IF EXISTS (SELECT fecha_alta, fecha_venc, sucursales_id, barcode, cantidad FROM inventario WHERE barcode = '0800080008000800' AND fecha_venc = '2021-06-17' AND sucursales_id = '1') THEN
    UPDATE inventario SET cantidad=cantidad+450 WHERE barcode='0800080008000800' AND fecha_venc='2021-06-17' AND sucursales_id = '1';
  ELSE 
    INSERT INTO inventario (fecha_alta, fecha_venc, sucursales_id, barcode, cantidad) VALUES('2020-06-17','2021-06-17','1','0800080008000800','20');
  END IF;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-29 20:42:42
