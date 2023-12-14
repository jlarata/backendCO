-- MySQL dump 10.13  Distrib 8.0.35, for Linux (x86_64)
--
-- Host: localhost    Database: flask
-- ------------------------------------------------------
-- Server version	8.0.35-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `certificados`
--

DROP TABLE IF EXISTS `certificados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certificados` (
  `IdCertificado` int NOT NULL AUTO_INCREMENT,
  `Numero` int DEFAULT NULL,
  `IdObra` int DEFAULT NULL,
  `FechaDePresentacion` date DEFAULT NULL,
  PRIMARY KEY (`IdCertificado`),
  KEY `IdObra` (`IdObra`),
  CONSTRAINT `certificados_ibfk_1` FOREIGN KEY (`IdObra`) REFERENCES `obras` (`IdObra`)
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certificados`
--

LOCK TABLES `certificados` WRITE;
/*!40000 ALTER TABLE `certificados` DISABLE KEYS */;
INSERT INTO `certificados` VALUES (1,1,72,'2022-02-01'),(2,3,72,'2022-04-01'),(3,4,72,'2022-05-01'),(4,2,72,'2022-03-01'),(80,1,70,'2023-09-04'),(81,2,70,'2023-09-04'),(82,1,71,'2022-12-25'),(83,2,71,'2023-04-25'),(84,3,70,'2023-11-10'),(85,5,72,'2023-12-01'),(86,6,72,'2023-12-02'),(87,7,72,'2023-12-02'),(88,8,72,'2023-12-03'),(89,4,70,'2023-11-14'),(90,9,72,'2023-12-04'),(91,10,72,'2023-12-05'),(92,6,70,'2023-11-13'),(93,5,71,'2023-05-02');
/*!40000 ALTER TABLE `certificados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `films`
--

DROP TABLE IF EXISTS `films`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `films` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ccNumber` int DEFAULT NULL,
  `imgUrl` varchar(200) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `year` int DEFAULT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `director1` varchar(100) DEFAULT NULL,
  `director1Genre` varchar(1) DEFAULT NULL,
  `director2` varchar(100) DEFAULT NULL,
  `director2Genre` varchar(1) DEFAULT NULL,
  `director3` varchar(100) DEFAULT NULL,
  `director3Genre` varchar(1) DEFAULT NULL,
  `director4` varchar(100) DEFAULT NULL,
  `director4Genre` varchar(1) DEFAULT NULL,
  `score` float DEFAULT NULL,
  `host` varchar(30) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `films`
--

LOCK TABLES `films` WRITE;
/*!40000 ALTER TABLE `films` DISABLE KEYS */;
INSERT INTO `films` VALUES (1,66,'https://a.ltrbxd.com/resized/sm/upload/ct/sk/hw/s3/f8HomPJlyPGIWgBODNbWQrRgjxW-0-500-0-750-crop.jpg?v=6aa2690b2e','The Brown Bunny',2003,'EE.UU.','Vincent Gallo','m','','','','','','',8.5,'j','2015-09-25'),(2,67,'https://a.ltrbxd.com/resized/sm/upload/ct/sk/hw/s3/f8HomPJlyPGIWgBODNbWQrRgjxW-0-500-0-750-crop.jpg?v=6aa2690b2e','The Brown Bunny',2003,'EE.UU.','Vincent Gallo','m','','','','','','',8.5,'j','2015-09-25'),(3,68,'https://a.ltrbxd.com/resized/sm/upload/ct/sk/hw/s3/f8HomPJlyPGIWgBODNbWQrRgjxW-0-500-0-750-crop.jpg?v=6aa2690b2e','The Brown Bunny',2003,'EE.UU.','Vincent Gallo','m','','','','','','',8.5,'j','2015-09-25'),(4,69,'https://a.ltrbxd.com/resized/sm/upload/ct/sk/hw/s3/f8HomPJlyPGIWgBODNbWQrRgjxW-0-500-0-750-crop.jpg?v=6aa2690b2e','The Brown Bunny',2003,'EE.UU.','Vincent Gallo','m','','','','','','',8.5,'j','2015-09-25'),(5,69,'https://a.ltrbxd.com/resized/sm/upload/ct/sk/hw/s3/f8HomPJlyPGIWgBODNbWQrRgjxW-0-500-0-750-crop.jpg?v=6aa2690b2e','The Brown Bunny',2003,'EE.UU.','Vincent Gallo','m','Vincentine Galline','q','','','','',8.5,'j','2015-09-25');
/*!40000 ALTER TABLE `films` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inspectores`
--

DROP TABLE IF EXISTS `inspectores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inspectores` (
  `IdInspector` int NOT NULL AUTO_INCREMENT,
  `IdRevisor` int DEFAULT NULL,
  `NombreInspector` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IdInspector`),
  KEY `IdRevisor` (`IdRevisor`),
  CONSTRAINT `inspectores_ibfk_1` FOREIGN KEY (`IdRevisor`) REFERENCES `revisores` (`IdRevisor`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inspectores`
--

LOCK TABLES `inspectores` WRITE;
/*!40000 ALTER TABLE `inspectores` DISABLE KEYS */;
INSERT INTO `inspectores` VALUES (60,50,'Javier Perez'),(61,50,'Javier Perez Perales'),(62,50,'Juanjo');
/*!40000 ALTER TABLE `inspectores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obras`
--

DROP TABLE IF EXISTS `obras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obras` (
  `IdObra` int NOT NULL AUTO_INCREMENT,
  `IdRevisor` int DEFAULT NULL,
  `NombreObra` varchar(200) DEFAULT NULL,
  `Codificacion` varchar(50) DEFAULT NULL,
  `FechaContrato` date DEFAULT NULL,
  `FechaInicio` date DEFAULT NULL,
  `PlazoDias` int DEFAULT NULL,
  `IdInspector` int DEFAULT NULL,
  `FechaFin` date DEFAULT NULL,
  `Prorroga` date DEFAULT NULL,
  PRIMARY KEY (`IdObra`),
  KEY `IdRevisor` (`IdRevisor`),
  KEY `IdInspector` (`IdInspector`),
  CONSTRAINT `obras_ibfk_1` FOREIGN KEY (`IdRevisor`) REFERENCES `revisores` (`IdRevisor`),
  CONSTRAINT `obras_ibfk_2` FOREIGN KEY (`IdInspector`) REFERENCES `inspectores` (`IdInspector`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obras`
--

LOCK TABLES `obras` WRITE;
/*!40000 ALTER TABLE `obras` DISABLE KEYS */;
INSERT INTO `obras` VALUES (70,50,'Electrificación rural Calambru','CO-23-03','2023-06-01','2023-08-01',270,NULL,NULL,NULL),(71,50,'Instalación de ET Las Piedritas','CO-23-04','2022-11-22','2023-02-28',540,NULL,NULL,'2024-02-20'),(72,50,'Vinculación en 13,2 kV entre M. Otero y la Huinca Rodriguez','CO-21-16','2020-10-08','2021-04-01',5000,61,'2023-06-17',NULL),(73,50,'Obra de Prueba','CO-20-20',NULL,NULL,200,61,NULL,NULL);
/*!40000 ALTER TABLE `obras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisores`
--

DROP TABLE IF EXISTS `revisores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `revisores` (
  `IdRevisor` int NOT NULL AUTO_INCREMENT,
  `NombreRevisor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`IdRevisor`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisores`
--

LOCK TABLES `revisores` WRITE;
/*!40000 ALTER TABLE `revisores` DISABLE KEYS */;
INSERT INTO `revisores` VALUES (50,'Javi Revisa');
/*!40000 ALTER TABLE `revisores` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-14 14:14:07
