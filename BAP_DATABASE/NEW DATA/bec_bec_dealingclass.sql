CREATE DATABASE  IF NOT EXISTS `bec` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bec`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: bec
-- ------------------------------------------------------
-- Server version	5.7.13-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bec_dealingclass`
--

DROP TABLE IF EXISTS `bec_dealingclass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bec_dealingclass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class_name_id` int(11) NOT NULL,
  `staff_name_id` int(11) NOT NULL,
  `Subject_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `BEC_dealingclass_class_name_id_aaaaac6c_fk_BEC_class_id` (`class_name_id`),
  KEY `BEC_dealingclass_staff_name_id_cd439851_fk_BEC_staff_id` (`staff_name_id`),
  CONSTRAINT `BEC_dealingclass_class_name_id_aaaaac6c_fk_BEC_class_id` FOREIGN KEY (`class_name_id`) REFERENCES `bec_class` (`id`),
  CONSTRAINT `BEC_dealingclass_staff_name_id_cd439851_fk_BEC_staff_id` FOREIGN KEY (`staff_name_id`) REFERENCES `bec_staff` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bec_dealingclass`
--

LOCK TABLES `bec_dealingclass` WRITE;
/*!40000 ALTER TABLE `bec_dealingclass` DISABLE KEYS */;
INSERT INTO `bec_dealingclass` VALUES (1,1,30,'IEM'),(2,1,3,'DA-II'),(3,1,16,'CS-II'),(4,1,13,'STM'),(5,1,3,'DA-II LAB'),(6,1,16,'CS-II LAB'),(7,1,39,'PROJECT'),(8,2,31,'IEM'),(9,2,5,'DA-II'),(10,2,10,'CS-II'),(11,2,23,'STM'),(12,2,5,'DA-II LAB'),(13,2,10,'CS-II LAB'),(14,2,41,'PROJECT'),(15,3,32,'IEM'),(16,3,13,'DA-II'),(17,3,21,'CS-II'),(18,3,14,'STM'),(19,3,13,'DA-II LAB'),(20,3,21,'CS-II LAB'),(21,3,40,'PROJECT'),(22,4,22,'IDA'),(23,4,7,'CD'),(24,4,25,'CN'),(25,4,15,'EP-II'),(26,4,11,'C&MAD'),(27,4,18,'ACA'),(28,4,22,'IDA LAB'),(29,4,15,'EP-II LAB'),(30,4,11,'C&MAD LAB'),(31,5,5,'IDA'),(32,5,9,'CD'),(33,5,21,'CN'),(34,5,15,'EP-II'),(35,5,12,'C&MAD'),(36,5,6,'ACA'),(37,5,5,'IDA LAB'),(38,5,15,'EP-II LAB'),(39,5,12,'C&MAD LAB'),(40,6,6,'IDA'),(41,6,4,'CD'),(42,6,23,'CN'),(43,6,14,'EP-II'),(44,6,25,'C&MAD'),(45,6,18,'ACA'),(46,6,6,'IDA LAB'),(47,6,14,'EP-II LAB'),(48,6,25,'C&MAD LAB'),(49,7,33,'P&S'),(50,7,8,'PE&HV'),(51,7,26,'CO'),(52,7,24,'DAA'),(53,7,12,'GUI'),(54,7,17,'WT'),(55,7,24,'DAA LAB'),(56,7,12,'GUI LAB'),(57,7,17,'WT LAB'),(58,8,34,'P&S'),(59,8,2,'PE&HV'),(60,8,26,'CO'),(61,8,10,'DAA'),(62,8,11,'GUI'),(63,8,19,'WT'),(64,8,10,'DAA LAB'),(65,8,11,'GUI LAB'),(66,8,19,'WT LAB'),(67,9,35,'P&S'),(68,9,8,'PE&HV'),(69,9,22,'CO'),(70,9,4,'DAA'),(71,9,9,'GUI'),(72,9,27,'WT'),(73,9,4,'DAA LAB'),(74,9,9,'GUI LAB'),(75,9,27,'WT LAB');
/*!40000 ALTER TABLE `bec_dealingclass` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-08 16:24:39
