CREATE DATABASE  IF NOT EXISTS `pesquisatudo` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `pesquisatudo`;
-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: pesquisatudo
-- ------------------------------------------------------
-- Server version	5.6.44

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
-- Table structure for table `consultas`
--

DROP TABLE IF EXISTS `consultas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `placa` varchar(8) COLLATE utf8_bin NOT NULL,
  `retorno` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  `data_consulta` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_consultas_usuario_idx` (`usuario_id`),
  KEY `idx_consultas_placa` (`placa`),
  CONSTRAINT `fk_consultas_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consultas`
--

LOCK TABLES `consultas` WRITE;
/*!40000 ALTER TABLE `consultas` DISABLE KEYS */;
INSERT INTO `consultas` VALUES (1,1,'ATO-6461',NULL,'2020-06-20 17:12:58'),(2,1,'ATO-6461',NULL,'2020-06-12 17:12:58'),(3,1,'ATO-6461',NULL,'2020-06-12 17:12:58'),(4,2,'RLA-6102',NULL,'2020-06-12 17:18:58'),(5,2,'ATO-6991',NULL,'2020-06-13 17:14:58'),(6,4,'MLO-6461',NULL,'2020-05-20 17:13:58'),(7,4,'ATD-6461',NULL,'2020-05-14 17:19:58'),(8,5,'ATO-6461',NULL,'2020-04-20 17:10:58'),(9,3,'AGO-6462',NULL,'2020-04-17 17:10:58'),(10,1,'www-6461',NULL,'2020-03-19 17:11:58'),(11,2,'ATO-1461',NULL,'2020-03-20 17:12:58'),(12,3,'ATO-6461',NULL,'2020-02-20 17:13:58'),(13,1,'RSO-6461',NULL,'2020-02-23 17:14:58'),(14,2,'www-2000',NULL,'2020-01-28 17:15:58'),(15,5,'ATO-3461',NULL,'2020-01-30 17:16:58'),(16,5,'APU-6461',NULL,'2020-06-20 17:17:58'),(17,3,'ATO-6461',NULL,'2020-05-20 17:18:58'),(18,2,'ATJ-9461',NULL,'2020-04-20 17:19:58'),(19,2,'DGU-6461',NULL,'2020-01-20 17:20:58'),(20,3,'ATU-6961',NULL,'2020-02-20 17:22:58'),(21,3,'ATO-6468',NULL,'2020-03-20 17:24:58'),(22,2,'DHP-6461',NULL,'2020-05-20 17:30:58'),(23,1,'API-6461',NULL,'2020-06-20 17:12:58'),(24,1,'APP-6461',NULL,'2020-02-20 17:32:58'),(25,5,'AMO-6461',NULL,'2020-01-20 19:12:58'),(26,5,'MMO-6461',NULL,'2020-06-20 17:12:58'),(27,2,'SPO-6468',NULL,'2020-06-20 17:12:58'),(28,2,'ATO-6467',NULL,'2020-06-20 17:12:58'),(29,3,'ATO-6466',NULL,'2020-02-21 18:12:58'),(30,5,'ATO-6465',NULL,'2020-06-20 17:12:58'),(31,3,'MMO-0094',NULL,'2020-06-22 17:12:58'),(32,3,'ATO-6463',NULL,'2020-06-20 17:12:58'),(33,4,'ATO-6462',NULL,'2020-06-20 17:12:58'),(34,1,'ATO-6461',NULL,'2020-06-20 17:12:58'),(35,1,'ATO-6460',NULL,'2020-06-20 17:12:58'),(36,3,'ATO-6469',NULL,'2020-06-20 17:12:58'),(37,1,'ATO-6468',NULL,'2020-06-20 11:12:58'),(38,1,'ATO-6467',NULL,'2020-06-20 17:12:58'),(39,5,'ATO-6466',NULL,'2020-06-16 12:12:58'),(40,1,'ATO-6465',NULL,'2020-06-20 17:12:58'),(41,2,'ATO-6464',NULL,'2020-06-20 12:12:58'),(42,2,'ATO-6463',NULL,'2020-04-20 17:12:58'),(43,1,'PRS-6462',NULL,'2020-03-20 13:12:58'),(44,5,'SSH-6461',NULL,'2020-06-19 17:12:58'),(45,4,'ATO-6460',NULL,'2020-02-20 14:12:58'),(46,3,'ATO-6469',NULL,'2020-01-27 17:12:58'),(47,3,'PTO-6468',NULL,'2020-06-20 16:12:58'),(48,1,'ATO-6467',NULL,'2020-09-28 17:12:58'),(49,1,'PSD-6466',NULL,'2020-06-20 17:12:58'),(50,5,'MBA-6467',NULL,'2020-04-29 17:12:58'),(51,5,'ATO-6466',NULL,'2020-06-20 17:12:58'),(52,1,'KKK-6465',NULL,'2020-06-20 17:12:58');
/*!40000 ALTER TABLE `consultas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transacoes`
--

DROP TABLE IF EXISTS `transacoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transacoes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `data_transacao` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_captura` datetime DEFAULT NULL,
  `bandeira` enum('Boleto','Elo','Mastercard','Visa') COLLATE utf8_bin NOT NULL DEFAULT 'Boleto',
  `situacao` enum('Pendente','Recusado','Aprovado') COLLATE utf8_bin NOT NULL DEFAULT 'Pendente',
  `token` varchar(90) COLLATE utf8_bin DEFAULT NULL,
  `valor` decimal(5,2) NOT NULL DEFAULT '0.00',
  `qt_consultas` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_transacoes_usuario_idx` (`usuario_id`),
  KEY `idx_transacoe_bandeira` (`bandeira`),
  KEY `idx_situacao` (`situacao`),
  CONSTRAINT `fk_transacoes_usuario` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transacoes`
--

LOCK TABLES `transacoes` WRITE;
/*!40000 ALTER TABLE `transacoes` DISABLE KEYS */;
INSERT INTO `transacoes` VALUES (1,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(2,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,4),(3,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(4,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Mastercard','Aprovado',NULL,0.00,3),(5,5,'2020-06-22 23:11:09',NULL,'Visa','Recusado',NULL,0.00,1),(6,2,'2020-06-22 23:11:09',NULL,'Elo','Recusado',NULL,0.00,2),(7,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(8,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Visa','Aprovado',NULL,0.00,1),(9,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(10,2,'2020-06-22 23:11:09',NULL,'Boleto','Pendente',NULL,0.00,4),(11,2,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(12,1,'2020-06-22 23:11:09',NULL,'Boleto','Pendente',NULL,0.00,1),(13,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,12),(14,3,'2020-06-22 23:11:09',NULL,'Elo','Recusado',NULL,0.00,1),(15,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Visa','Aprovado',NULL,0.00,1),(16,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Visa','Aprovado',NULL,0.00,2),(17,3,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(18,4,'2020-06-22 23:11:09',NULL,'Elo','Recusado',NULL,0.00,1),(19,2,'2020-06-22 23:11:09',NULL,'Boleto','Pendente',NULL,0.00,3),(20,2,'2020-06-22 23:11:09',NULL,'Boleto','Pendente',NULL,0.00,1),(21,5,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(22,3,'2020-06-22 23:11:09',NULL,'Elo','Recusado',NULL,0.00,1),(23,4,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(24,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(25,5,'2020-06-22 23:11:09',NULL,'Boleto','Pendente',NULL,0.00,1),(26,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(27,5,'2020-02-10 12:05:58','2020-02-10 12:06:18','Mastercard','Aprovado',NULL,0.00,1),(28,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(29,1,'2020-06-22 23:11:09',NULL,'Mastercard','Recusado',NULL,0.00,1),(30,2,'2020-06-22 23:11:09',NULL,'Mastercard','Recusado',NULL,0.00,1),(31,2,'2020-02-10 12:05:58','2020-02-10 12:06:18','Mastercard','Aprovado',NULL,0.00,1),(32,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,8),(33,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,2),(34,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Mastercard','Aprovado',NULL,0.00,1),(35,5,'2020-06-22 23:11:11',NULL,'Visa','Recusado',NULL,0.00,1),(36,2,'2020-06-22 23:11:11',NULL,'Elo','Recusado',NULL,0.00,1),(37,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,1),(38,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Visa','Aprovado',NULL,0.00,1),(39,1,'2020-02-10 12:05:58','2020-02-10 12:06:18','Elo','Aprovado',NULL,0.00,18),(40,2,'2020-06-22 23:11:11',NULL,'Boleto','Pendente',NULL,0.00,1),(41,2,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,2),(42,1,'2020-06-22 23:11:11',NULL,'Boleto','Pendente',NULL,0.00,1),(43,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(44,3,'2020-06-22 23:11:11',NULL,'Elo','Recusado',NULL,0.00,4),(45,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Visa','Aprovado',NULL,0.00,1),(46,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Visa','Aprovado',NULL,0.00,1),(47,3,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,98),(48,4,'2020-06-22 23:11:11',NULL,'Elo','Recusado',NULL,0.00,1),(49,2,'2020-06-22 23:11:11',NULL,'Boleto','Pendente',NULL,0.00,1),(50,2,'2020-06-22 23:11:11',NULL,'Boleto','Pendente',NULL,0.00,100),(51,5,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(52,3,'2020-06-22 23:11:11',NULL,'Elo','Recusado',NULL,0.00,1),(53,4,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(54,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(55,5,'2020-06-22 23:11:11',NULL,'Boleto','Pendente',NULL,0.00,1),(56,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(57,5,'2020-03-18 15:15:48','2020-02-18 15:16:18','Mastercard','Aprovado',NULL,0.00,1),(58,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(59,1,'2020-06-22 23:11:11',NULL,'Mastercard','Recusado',NULL,0.00,1),(60,2,'2020-06-22 23:11:11',NULL,'Mastercard','Recusado',NULL,0.00,1),(61,2,'2020-03-18 15:15:48','2020-02-18 15:16:18','Mastercard','Aprovado',NULL,0.00,1),(62,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(63,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(64,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Mastercard','Aprovado',NULL,0.00,20),(65,5,'2020-06-22 23:11:12',NULL,'Visa','Recusado',NULL,0.00,1),(66,2,'2020-06-22 23:11:12',NULL,'Elo','Recusado',NULL,0.00,2),(67,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,3),(68,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Visa','Aprovado',NULL,0.00,1),(69,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(70,2,'2020-06-22 23:11:12',NULL,'Boleto','Pendente',NULL,0.00,2),(71,2,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,2),(72,1,'2020-06-22 23:11:12',NULL,'Boleto','Pendente',NULL,0.00,2),(73,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(74,3,'2020-06-22 23:11:12',NULL,'Elo','Recusado',NULL,0.00,1),(75,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Visa','Aprovado',NULL,0.00,1),(76,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Visa','Aprovado',NULL,0.00,1),(77,3,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,2),(78,4,'2020-06-22 23:11:12',NULL,'Elo','Recusado',NULL,0.00,3),(79,2,'2020-06-22 23:11:12',NULL,'Boleto','Pendente',NULL,0.00,1),(80,2,'2020-06-22 23:11:12',NULL,'Boleto','Pendente',NULL,0.00,3),(81,5,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(82,3,'2020-06-22 23:11:12',NULL,'Elo','Recusado',NULL,0.00,3),(83,4,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,1),(84,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,5),(85,5,'2020-06-22 23:11:12',NULL,'Boleto','Pendente',NULL,0.00,1),(86,1,'2020-03-18 15:15:48','2020-02-18 15:16:18','Elo','Aprovado',NULL,0.00,2),(87,5,'2020-05-04 17:15:48','2020-05-04 17:16:18','Mastercard','Aprovado',NULL,0.00,1),(88,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,3),(89,1,'2020-06-22 23:11:12',NULL,'Mastercard','Recusado',NULL,0.00,1),(90,2,'2020-06-22 23:11:12',NULL,'Mastercard','Recusado',NULL,0.00,1),(91,2,'2020-05-04 17:15:48','2020-05-04 17:16:18','Mastercard','Aprovado',NULL,0.00,5),(92,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(93,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,2),(94,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Mastercard','Aprovado',NULL,0.00,2),(95,5,'2020-06-22 23:11:14',NULL,'Visa','Recusado',NULL,0.00,1),(96,2,'2020-06-22 23:11:14',NULL,'Elo','Recusado',NULL,0.00,1),(97,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(98,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Visa','Aprovado',NULL,0.00,1),(99,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(100,2,'2020-06-22 23:11:14',NULL,'Boleto','Pendente',NULL,0.00,1),(101,2,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(102,1,'2020-06-22 23:11:14',NULL,'Boleto','Pendente',NULL,0.00,1),(103,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(104,3,'2020-06-22 23:11:14',NULL,'Elo','Recusado',NULL,0.00,1),(105,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Visa','Aprovado',NULL,0.00,1),(106,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Visa','Aprovado',NULL,0.00,1),(107,3,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(108,4,'2020-06-22 23:11:14',NULL,'Elo','Recusado',NULL,0.00,1),(109,2,'2020-06-22 23:11:14',NULL,'Boleto','Pendente',NULL,0.00,1),(110,2,'2020-06-22 23:11:14',NULL,'Boleto','Pendente',NULL,0.00,1),(111,5,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(112,3,'2020-06-22 23:11:14',NULL,'Elo','Recusado',NULL,0.00,1),(113,4,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(114,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(115,5,'2020-06-22 23:11:14',NULL,'Boleto','Pendente',NULL,0.00,1),(116,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(117,5,'2020-05-04 17:15:48','2020-05-04 17:16:18','Mastercard','Aprovado',NULL,0.00,1),(118,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1),(119,1,'2020-06-22 23:11:14',NULL,'Mastercard','Recusado',NULL,0.00,1),(120,2,'2020-06-22 23:11:14',NULL,'Mastercard','Recusado',NULL,0.00,1),(121,2,'2020-05-04 17:15:48','2020-05-04 17:16:18','Mastercard','Aprovado',NULL,0.00,1),(122,1,'2020-05-04 17:15:48','2020-05-04 17:16:18','Elo','Aprovado',NULL,0.00,1);
/*!40000 ALTER TABLE `transacoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(60) COLLATE utf8_bin NOT NULL,
  `senha` varchar(250) COLLATE utf8_bin NOT NULL,
  `data_cadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'victor','17a821dfa961c93a6c586ca257750fb2','2020-06-22 22:50:56'),(2,'cecilia','b92e66c96ce18ecfb535c57925de5c7d','2020-06-22 22:52:35'),(3,'ricardo','f2a46c2e2f0b81c20b9ed0a7643d179f','2020-06-22 22:52:48'),(4,'camila','f3afb9b5ac631e37d41570c8288b29ea','2020-06-22 22:52:59'),(5,'jose','90e528618534d005b1a7e7b7a367813f','2020-06-22 22:53:09'),(6,'Agnaldo','ee809f9e2cea864a09a3a0a40671b0b9','2020-06-22 23:55:45');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'pesquisatudo'
--

--
-- Dumping routines for database 'pesquisatudo'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-22 21:55:31
