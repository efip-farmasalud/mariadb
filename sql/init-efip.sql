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
-- Dumping data for table `articulo`
--

LOCK TABLES `articulo` WRITE;
/*!40000 ALTER TABLE `articulo` DISABLE KEYS */;
INSERT INTO `articulo` VALUES (1,'0800080008000800','ibuprofeno',10,'ibuprofeno 600','una marca'),(2,'0800080008000801','paracetamol',10,'paracetamol 600','paracetamol marca'),(3,'0800080008000802','flexina',10,'flexina 600','flexina marca');
/*!40000 ALTER TABLE `articulo` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (1,'2021-06-17',1,'0800080008000800',10),(2,'2021-06-17',1,'0800080008000801',10),(3,'2021-07-20',1,'0800080008000802',10),(4,'2021-06-17',2,'0800080008000800',10),(5,'2021-06-17',2,'0800080008000801',10),(6,'2021-06-17',2,'0800080008000802',10),(7,'2021-06-17',3,'0800080008000800',10),(8,'2021-06-17',3,'0800080008000801',10),(9,'2021-06-17',3,'0800080008000802',10);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `sucursales`
--

LOCK TABLES `sucursales` WRITE;
/*!40000 ALTER TABLE `sucursales` DISABLE KEYS */;
INSERT INTO `sucursales` VALUES (1,'Sucursal Central','calle falsa 123','central'),(2,'Sucursal norte','calle norte 123','norte'),(3,'Sucursal sur','calle sur 123','sur');
/*!40000 ALTER TABLE `sucursales` ENABLE KEYS */;
UNLOCK TABLES;

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
-- Dumping data for table `venta_de_articulo`
--

LOCK TABLES `venta_de_articulo` WRITE;
/*!40000 ALTER TABLE `venta_de_articulo` DISABLE KEYS */;
/*!40000 ALTER TABLE `venta_de_articulo` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-29 20:18:16

