-- MySQL dump 10.13  Distrib 5.5.15, for Win32 (x86)
--
-- Host: localhost    Database: footprint32_development
-- ------------------------------------------------------
-- Server version	5.5.15

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
-- Table structure for table `active_admin_comments`
--

DROP TABLE IF EXISTS `active_admin_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `active_admin_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `resource_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  `author_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `namespace` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_admin_notes_on_resource_type_and_resource_id` (`resource_type`,`resource_id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `active_admin_comments`
--

LOCK TABLES `active_admin_comments` WRITE;
/*!40000 ALTER TABLE `active_admin_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `active_admin_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `activities`
--

DROP TABLE IF EXISTS `activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `activity_type` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `target_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_activities_on_target_id_and_target_type` (`target_id`,`target_type`),
  KEY `index_activities_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activities`
--

LOCK TABLES `activities` WRITE;
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` VALUES (7,5,1,18,'Review','2012-12-04 20:20:34','2012-12-04 20:20:34'),(9,5,7,12,'ProfilePhoto','2012-12-04 20:33:48','2012-12-04 20:33:48'),(11,5,7,13,'ProfilePhoto','2012-12-04 20:40:59','2012-12-04 20:40:59'),(12,5,1,19,'Review','2012-12-04 20:41:35','2012-12-04 20:41:35'),(13,5,1,20,'Review','2012-12-04 21:07:13','2012-12-04 21:07:13'),(14,5,1,21,'Review','2012-12-04 21:09:00','2012-12-04 21:09:00'),(15,5,1,22,'Review','2012-12-04 21:10:56','2012-12-04 21:10:56'),(16,5,1,23,'Review','2012-12-04 21:11:00','2012-12-04 21:11:00'),(17,5,1,24,'Review','2012-12-04 21:11:04','2012-12-04 21:11:04'),(18,5,1,25,'Review','2012-12-08 20:47:58','2012-12-08 20:47:58'),(19,5,1,26,'Review','2012-12-08 20:53:36','2012-12-08 20:53:36'),(21,6,3,2,'ReviewVote','2012-12-25 09:17:44','2012-12-25 09:17:44'),(22,5,2,20,'Photo','2012-12-25 09:32:34','2012-12-25 09:32:34'),(23,5,7,9,'ProfilePhoto','2013-02-01 20:32:21','2013-02-01 20:32:21'),(32,5,5,11,'FavoritePlace','2013-02-11 19:36:18','2013-02-11 19:36:18'),(34,6,1,29,'Review','2013-02-18 18:31:13','2013-02-18 18:31:13'),(35,6,5,12,'FavoritePlace','2013-02-23 18:18:43','2013-02-23 18:18:43'),(36,9,5,13,'FavoritePlace','2013-02-24 10:23:14','2013-02-24 10:23:14'),(37,5,1,30,'Review','2013-03-09 11:50:23','2013-03-09 11:50:23'),(38,10,5,14,'FavoritePlace','2013-03-12 10:47:15','2013-03-12 10:47:15'),(39,5,2,21,'Photo','2013-03-17 16:16:46','2013-03-17 16:16:46'),(40,5,2,22,'Photo','2013-03-17 16:19:08','2013-03-17 16:19:08'),(41,5,2,23,'Photo','2013-03-17 16:21:10','2013-03-17 16:21:10'),(42,5,2,24,'Photo','2013-03-17 16:22:44','2013-03-17 16:22:44'),(43,5,2,25,'Photo','2013-03-17 16:25:42','2013-03-17 16:25:42'),(44,5,2,26,'Photo','2013-03-17 16:25:47','2013-03-17 16:25:47'),(45,5,2,27,'Photo','2013-03-29 20:49:25','2013-03-29 20:49:25'),(46,5,2,28,'Photo','2013-03-31 15:59:24','2013-03-31 15:59:24'),(47,5,2,29,'Photo','2013-03-31 15:59:31','2013-03-31 15:59:31'),(48,5,2,30,'Photo','2013-03-31 15:59:38','2013-03-31 15:59:38'),(49,5,2,31,'Photo','2013-04-01 06:32:44','2013-04-01 06:32:44'),(50,5,2,32,'Photo','2013-04-01 06:32:50','2013-04-01 06:32:50'),(51,5,1,31,'Review','2013-04-07 09:28:52','2013-04-07 09:28:52'),(52,5,1,32,'Review','2013-04-07 09:50:48','2013-04-07 09:50:48'),(53,5,1,33,'Review','2013-04-07 14:07:15','2013-04-07 14:07:15'),(54,5,2,33,'Photo','2013-04-08 20:30:31','2013-04-08 20:30:31'),(55,5,2,34,'Photo','2013-04-08 20:32:40','2013-04-08 20:32:40'),(56,6,4,1,'VisitedPlace','2013-04-27 12:52:26','2013-04-27 12:52:26'),(57,5,2,35,'Photo','2013-05-04 11:18:24','2013-05-04 11:18:24'),(58,5,2,36,'Photo','2013-05-04 11:18:30','2013-05-04 11:18:30'),(59,5,2,37,'Photo','2013-05-04 11:21:06','2013-05-04 11:21:06'),(60,5,2,38,'Photo','2013-05-04 11:21:12','2013-05-04 11:21:12'),(61,5,2,39,'Photo','2013-05-04 11:34:07','2013-05-04 11:34:07'),(62,5,2,40,'Photo','2013-05-04 11:34:18','2013-05-04 11:34:18'),(63,5,2,41,'Photo','2013-05-04 11:41:54','2013-05-04 11:41:54'),(64,5,2,42,'Photo','2013-05-04 11:42:04','2013-05-04 11:42:04'),(65,5,2,43,'Photo','2013-05-04 11:47:21','2013-05-04 11:47:21'),(66,5,2,44,'Photo','2013-05-04 11:47:26','2013-05-04 11:47:26'),(67,5,2,45,'Photo','2013-05-04 11:49:48','2013-05-04 11:49:48'),(68,5,1,34,'Review','2013-05-05 11:45:07','2013-05-05 11:45:07'),(69,5,1,35,'Review','2013-05-05 11:46:09','2013-05-05 11:46:09'),(70,5,4,2,'VisitedPlace','2013-05-09 11:50:00','2013-05-09 11:50:00'),(71,5,7,32,'ProfilePhoto','2013-05-09 12:55:49','2013-05-09 12:55:49'),(72,5,1,36,'Review','2013-05-11 12:27:50','2013-05-11 12:27:50'),(73,5,1,37,'Review','2013-05-11 12:30:13','2013-05-11 12:30:13'),(74,5,1,38,'Review','2013-05-11 12:47:42','2013-05-11 12:47:42'),(75,5,1,39,'Review','2013-05-11 12:47:55','2013-05-11 12:47:55'),(76,5,2,46,'Photo','2013-05-11 14:05:04','2013-05-11 14:05:04'),(77,5,2,47,'Photo','2013-05-11 14:07:19','2013-05-11 14:07:19'),(78,5,2,48,'Photo','2013-05-11 14:09:49','2013-05-11 14:09:49'),(79,5,2,49,'Photo','2013-05-11 14:30:08','2013-05-11 14:30:08'),(80,5,2,50,'Photo','2013-05-11 14:31:57','2013-05-11 14:31:57'),(82,5,2,51,'Photo','2013-05-20 06:26:51','2013-05-20 06:26:51'),(83,5,2,52,'Photo','2013-05-20 06:29:28','2013-05-20 06:29:28'),(84,5,2,53,'Photo','2013-05-20 06:37:18','2013-05-20 06:37:18'),(85,5,2,54,'Photo','2013-05-20 06:38:47','2013-05-20 06:38:47'),(86,5,2,55,'Photo','2013-05-20 06:39:46','2013-05-20 06:39:46'),(87,5,2,56,'Photo','2013-05-20 06:40:42','2013-05-20 06:40:42'),(88,5,2,57,'Photo','2013-05-20 07:39:53','2013-05-20 07:39:53'),(89,5,2,58,'Photo','2013-05-20 07:53:18','2013-05-20 07:53:18'),(90,5,2,59,'Photo','2013-05-20 08:06:04','2013-05-20 08:06:04'),(91,5,2,60,'Photo','2013-05-20 08:12:33','2013-05-20 08:12:33'),(92,5,2,61,'Photo','2013-05-20 08:16:57','2013-05-20 08:16:57'),(93,5,2,62,'Photo','2013-05-20 08:18:24','2013-05-20 08:18:24'),(94,5,2,63,'Photo','2013-05-20 08:19:35','2013-05-20 08:19:35'),(95,5,2,64,'Photo','2013-05-20 08:42:04','2013-05-20 08:42:04'),(96,5,2,65,'Photo','2013-05-20 09:36:58','2013-05-20 09:36:58'),(97,5,2,66,'Photo','2013-05-20 09:38:12','2013-05-20 09:38:12'),(98,5,2,67,'Photo','2013-05-20 09:39:21','2013-05-20 09:39:21'),(99,5,2,68,'Photo','2013-05-20 09:40:28','2013-05-20 09:40:28'),(100,5,2,69,'Photo','2013-05-25 08:49:56','2013-05-25 08:49:56'),(101,5,2,70,'Photo','2013-05-25 08:51:12','2013-05-25 08:51:12'),(102,5,2,71,'Photo','2013-05-25 08:52:54','2013-05-25 08:52:54'),(103,5,2,72,'Photo','2013-05-25 09:02:09','2013-05-25 09:02:09'),(104,5,2,73,'Photo','2013-05-25 09:02:53','2013-05-25 09:02:53'),(105,5,2,74,'Photo','2013-05-25 09:05:44','2013-05-25 09:05:44'),(106,5,3,3,'ReviewVote','2013-05-25 17:08:44','2013-05-25 17:08:44'),(107,5,2,75,'Photo','2013-05-26 13:19:54','2013-05-26 13:19:54'),(108,5,2,76,'Photo','2013-05-26 13:31:49','2013-05-26 13:31:49'),(111,5,2,79,'Photo','2013-05-26 14:11:33','2013-05-26 14:11:33'),(112,5,2,80,'Photo','2013-05-26 14:11:39','2013-05-26 14:11:39'),(114,5,4,2,'VisitedPlace','2013-05-30 13:36:25','2013-05-30 13:36:25'),(115,5,4,2,'VisitedPlace','2013-05-30 13:40:18','2013-05-30 13:40:18'),(116,5,1,40,'Review','2013-06-01 09:16:30','2013-06-01 09:16:30'),(117,5,1,41,'Review','2013-06-01 09:17:50','2013-06-01 09:17:50'),(118,5,1,42,'Review','2013-06-01 09:17:53','2013-06-01 09:17:53'),(119,5,1,43,'Review','2013-06-11 19:42:02','2013-06-11 19:42:02'),(120,5,1,44,'Review','2013-06-11 19:43:39','2013-06-11 19:43:39'),(121,5,1,45,'Review','2013-06-11 19:52:49','2013-06-11 19:52:49'),(122,5,1,46,'Review','2013-06-11 20:02:49','2013-06-11 20:02:49'),(123,6,1,47,'Review','2013-06-11 20:18:28','2013-06-11 20:18:28'),(124,6,1,48,'Review','2013-06-11 20:20:13','2013-06-11 20:20:13'),(125,6,1,49,'Review','2013-06-11 20:28:19','2013-06-11 20:28:19'),(126,6,1,50,'Review','2013-06-11 20:33:53','2013-06-11 20:33:53'),(127,5,1,51,'Review','2013-06-22 14:57:50','2013-06-22 14:57:50');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin@example.com','$2a$10$evWwbOzqdJh54/pyloAA5e9K7ptMnQI96AbMkhNTr3WAB1W4XWq1C',NULL,NULL,NULL,6,'2013-06-14 20:29:53','2013-05-30 12:02:08','127.0.0.1','127.0.0.1','2013-05-11 16:32:12','2013-06-14 20:29:53');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Education','2013-02-16 11:36:05','2013-02-16 11:36:05',NULL),(2,'Entertainment','2013-02-16 11:36:37','2013-02-16 11:36:37',NULL),(3,'Food','2013-02-16 11:36:44','2013-02-16 11:36:44',NULL),(4,'Health','2013-02-16 11:36:53','2013-02-16 11:36:53',NULL),(5,'Nightlife','2013-02-16 11:36:59','2013-02-16 11:36:59',NULL),(6,'Other','2013-02-16 11:37:04','2013-02-16 11:37:04',NULL),(7,'Residence','2013-02-16 11:37:10','2013-02-16 11:37:10',NULL),(8,'Shop','2013-02-16 11:37:15','2013-02-16 11:37:15',NULL),(9,'Sport','2013-02-16 11:37:21','2013-02-16 11:37:21',NULL),(10,'Travel','2013-02-16 11:37:28','2013-02-16 11:37:28',NULL),(14,'School','2013-02-16 12:31:48','2013-02-23 10:40:12',1),(15,'Library','2013-02-16 12:32:28','2013-02-16 12:32:28',1),(18,'Bird park','2013-02-16 12:36:31','2013-02-16 12:36:31',2),(19,'Casino','2013-02-16 12:36:38','2013-02-16 12:36:38',2),(21,'Cinema','2013-02-16 12:36:58','2013-02-16 12:36:58',2),(31,'Art museum','2013-02-16 12:38:29','2013-02-16 12:38:29',2),(32,'Museum','2013-02-16 12:38:36','2013-02-16 12:38:36',2),(36,'Science museum','2013-02-16 12:41:47','2013-02-16 12:41:47',2),(39,'Live music','2013-02-16 12:43:59','2013-02-16 12:43:59',2),(41,'Planetarium','2013-02-16 12:44:15','2013-02-16 12:44:15',2),(42,'Theater','2013-02-16 12:44:44','2013-02-16 12:44:44',2),(43,'Theme park','2013-02-16 12:44:51','2013-02-16 12:44:51',2),(44,'Water park','2013-02-16 12:44:57','2013-02-16 12:44:57',2),(45,'Zoo','2013-02-16 12:45:03','2013-02-16 12:45:03',2),(46,'Cafetaria','2013-02-16 12:45:22','2013-02-16 12:45:22',3),(47,'Cafe','2013-02-16 12:52:26','2013-02-16 12:52:26',3),(50,'Kebab','2013-02-16 12:53:44','2013-02-16 12:53:44',3),(52,'pizzaria','2013-02-16 12:54:20','2013-02-16 12:54:20',3),(53,'Restaurant','2013-02-16 12:54:30','2013-02-16 12:54:30',3),(67,'Vegetarian restaurant','2013-02-16 12:58:08','2013-02-16 12:58:08',3),(68,'Teahouse','2013-02-16 12:58:19','2013-02-16 12:58:19',3),(70,'Pharmacy','2013-02-16 12:59:22','2013-02-16 12:59:22',4),(71,'Dentist','2013-02-16 12:59:28','2013-02-16 12:59:28',4),(72,'Doctor','2013-02-16 12:59:35','2013-02-16 12:59:35',4),(73,'Hospital','2013-02-16 12:59:42','2013-02-16 12:59:42',4),(76,'Sauna','2013-02-16 13:02:04','2013-02-16 13:02:04',4),(77,'Spa','2013-02-16 13:02:09','2013-02-16 13:02:09',4),(80,'Bar','2013-02-16 13:02:49','2013-02-16 13:02:49',5),(81,'Beer garden','2013-02-16 13:02:57','2013-02-16 13:02:57',5),(82,'Wine bar','2013-02-16 13:04:24','2013-02-16 13:04:24',5),(84,'Old bridge','2013-02-16 13:05:46','2013-02-16 13:05:46',6),(85,'Castle','2013-02-16 13:05:53','2013-02-16 13:05:53',6),(86,'Cathedral','2013-02-16 13:06:01','2013-02-16 13:06:01',6),(89,'Church','2013-02-16 13:06:19','2013-02-16 13:06:19',6),(97,'Firemen','2013-02-16 13:07:17','2013-02-16 13:07:17',6),(99,'Fountain','2013-02-16 13:07:27','2013-02-16 13:07:27',6),(100,'Geyser','2013-02-16 13:07:41','2013-02-16 13:07:41',6),(101,'Glacier','2013-02-16 13:07:46','2013-02-16 13:07:46',6),(102,'Hotsping','2013-02-16 13:07:53','2013-02-16 13:07:53',6),(103,'Information center','2013-02-16 13:08:07','2013-02-16 13:08:07',6),(106,'Lighthouse','2013-02-16 13:08:38','2013-02-16 13:08:38',6),(108,'Monument','2013-02-16 13:08:57','2013-02-16 13:08:57',6),(109,'Mosquee','2013-02-16 13:09:04','2013-02-16 13:09:04',6),(113,'Pagoda','2013-02-16 13:09:58','2013-02-16 13:09:58',6),(114,'Palace','2013-02-16 13:10:03','2013-02-16 13:10:03',6),(115,'Parking','2013-02-16 13:10:38','2013-02-16 13:10:38',6),(116,'Playground','2013-02-16 13:10:53','2013-02-16 13:10:53',6),(117,'Police','2013-02-16 13:11:03','2013-02-16 13:11:03',6),(118,'Postal','2013-02-16 13:11:11','2013-02-16 13:11:11',6),(120,'Pyramid','2013-02-16 13:11:23','2013-02-16 13:11:23',6),(121,'Ruins','2013-02-16 13:11:28','2013-02-16 13:11:28',6),(123,'Statue','2013-02-16 13:11:58','2013-02-16 13:11:58',6),(124,'Summer camp','2013-02-16 13:12:05','2013-02-16 13:12:05',6),(126,'Temple','2013-02-16 13:12:22','2013-02-16 13:12:22',6),(127,'Hindu temple','2013-02-16 13:12:33','2013-02-16 13:12:33',6),(129,'Toilets','2013-02-16 13:12:58','2013-02-16 13:12:58',6),(130,'Tower','2013-02-16 13:13:02','2013-02-16 13:13:02',6),(133,'Waterfall','2013-02-16 13:13:21','2013-02-16 13:13:21',6),(134,'Watermill','2013-02-16 13:13:26','2013-02-16 13:13:26',6),(135,'Windmill','2013-02-16 13:13:32','2013-02-16 13:13:32',6),(136,'Wind turbine','2013-02-16 13:13:38','2013-02-16 13:13:38',6),(137,'World heritage site','2013-02-16 13:13:49','2013-02-16 13:13:49',6),(141,'Hostel','2013-02-16 13:14:37','2013-02-16 13:14:37',7),(142,'Hotel','2013-02-16 13:14:40','2013-02-16 13:14:40',7),(143,'Lodging','2013-02-16 13:14:45','2013-02-16 13:14:45',7),(144,'Motel','2013-02-16 13:14:50','2013-02-16 13:14:50',7),(145,'Villa','2013-02-16 13:14:55','2013-02-16 13:14:55',7),(146,'Youth hostel','2013-02-16 13:15:04','2013-02-16 13:15:04',7),(148,'Auto shop','2013-02-16 13:15:37','2013-02-16 13:15:37',8),(149,'Bakery','2013-02-16 13:15:44','2013-02-16 13:15:44',3),(150,'Barber','2013-02-16 13:16:23','2013-02-16 13:16:23',8),(152,'Butcher','2013-02-16 13:16:38','2013-02-16 13:16:38',8),(154,'Women\'s clothing','2013-02-16 13:17:37','2013-02-16 13:17:37',8),(155,'Men\'s clothing','2013-02-16 13:17:45','2013-02-16 13:17:45',8),(156,'Convenience store','2013-02-16 13:17:57','2013-02-16 13:17:57',8),(157,'Department store','2013-02-16 13:18:07','2013-02-16 13:18:07',8),(159,'Electronic store','2013-02-16 13:18:33','2013-02-16 13:18:33',8),(160,'Fastfood','2013-02-16 13:19:51','2013-02-16 13:19:51',3),(162,'Filling station','2013-02-16 13:21:37','2013-02-16 13:21:37',8),(163,'Flower shop','2013-02-16 13:21:46','2013-02-16 13:21:46',8),(165,'Grocery','2013-02-16 13:21:57','2013-02-16 13:21:57',8),(166,'Ice cream','2013-02-16 13:22:43','2013-02-16 13:22:43',3),(167,'Jewelry','2013-02-16 13:23:25','2013-02-16 13:23:25',8),(169,'Market','2013-02-16 13:23:34','2013-02-16 13:23:34',8),(170,'Movie rental','2013-02-16 13:23:41','2013-02-16 13:23:41',8),(171,'Music store','2013-02-16 13:23:47','2013-02-16 13:23:47',8),(174,'Supermarket','2013-02-16 13:25:40','2013-02-16 13:25:40',8),(175,'Tailor','2013-02-16 13:25:46','2013-02-16 13:25:46',8),(179,'Travel agency','2013-02-16 13:26:51','2013-02-16 13:26:51',8),(184,'Baseball','2013-02-16 13:27:35','2013-02-16 13:27:35',9),(185,'Basketball','2013-02-16 13:27:40','2013-02-16 13:27:40',9),(186,'Billiard','2013-02-16 13:27:46','2013-02-16 13:27:46',9),(187,'Bowling','2013-02-16 13:27:52','2013-02-16 13:27:52',9),(193,'Fitness center','2013-02-16 13:28:27','2013-02-16 13:28:27',9),(194,'Golf','2013-02-16 13:28:33','2013-02-16 13:28:33',9),(196,'Horse riding','2013-02-16 13:28:46','2013-02-16 13:28:46',9),(199,'Ice hockey','2013-02-16 13:29:12','2013-02-16 13:29:12',9),(200,'Ice skating','2013-02-16 13:29:17','2013-02-16 13:29:17',9),(205,'Paintball','2013-02-16 13:29:51','2013-02-16 13:29:51',9),(213,'Soccer','2013-02-16 13:30:56','2013-02-16 13:30:56',9),(214,'Squash','2013-02-16 13:31:00','2013-02-16 13:31:00',9),(216,'Swimming','2013-02-16 13:31:16','2013-02-16 13:31:16',9),(218,'Tennis','2013-02-16 13:31:35','2013-02-16 13:31:35',9),(219,'Volleyball','2013-02-16 13:31:43','2013-02-16 13:31:43',9),(221,'Airport','2013-02-16 13:32:07','2013-02-16 13:32:07',10),(222,'Bus station','2013-02-16 13:32:14','2013-02-16 13:32:14',10),(223,'Cable car','2013-02-16 13:32:20','2013-02-16 13:32:20',10),(224,'Car rental','2013-02-16 13:32:27','2013-02-16 13:32:27',10),(225,'Cruise ship','2013-02-16 13:32:35','2013-02-16 13:32:35',10),(226,'Ferry','2013-02-16 13:32:41','2013-02-16 13:32:41',10),(227,'Funicolar','2013-02-16 13:32:47','2013-02-16 13:32:47',10),(228,'Harbor','2013-02-16 13:32:53','2013-02-16 13:32:53',10),(232,'Train station','2013-02-16 13:33:18','2013-02-16 13:33:18',10),(233,'Tramway','2013-02-16 13:33:25','2013-02-16 13:33:25',10),(235,'eww','2013-06-15 08:59:06','2013-06-15 08:59:06',1),(236,'12e','2013-06-15 09:42:37','2013-06-15 09:44:11',5),(237,'mm','2013-06-15 09:46:16','2013-06-15 09:46:16',10);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_hierarchies`
--

DROP TABLE IF EXISTS `category_hierarchies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category_hierarchies` (
  `ancestor_id` int(11) NOT NULL,
  `descendant_id` int(11) NOT NULL,
  `generations` int(11) NOT NULL,
  UNIQUE KEY `index_category_hierarchies_on_ancestor_id_and_descendant_id` (`ancestor_id`,`descendant_id`),
  KEY `index_category_hierarchies_on_descendant_id` (`descendant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_hierarchies`
--

LOCK TABLES `category_hierarchies` WRITE;
/*!40000 ALTER TABLE `category_hierarchies` DISABLE KEYS */;
INSERT INTO `category_hierarchies` VALUES (1,1,0),(1,12,1),(1,13,1),(1,14,1),(1,15,1),(1,235,1),(2,2,0),(2,16,1),(2,17,1),(2,18,1),(2,19,1),(2,20,1),(2,21,1),(2,22,1),(2,23,1),(2,24,1),(2,25,1),(2,26,1),(2,27,1),(2,28,1),(2,29,1),(2,30,1),(2,31,1),(2,32,1),(2,33,1),(2,34,1),(2,35,1),(2,36,1),(2,37,1),(2,38,1),(2,39,1),(2,40,1),(2,41,1),(2,42,1),(2,43,1),(2,44,1),(2,45,1),(3,3,0),(3,46,1),(3,47,1),(3,48,1),(3,49,1),(3,50,1),(3,51,1),(3,52,1),(3,53,1),(3,54,1),(3,55,1),(3,56,1),(3,57,1),(3,58,1),(3,59,1),(3,60,1),(3,61,1),(3,62,1),(3,63,1),(3,64,1),(3,65,1),(3,66,1),(3,67,1),(3,68,1),(3,160,1),(3,161,1),(3,166,1),(3,176,1),(3,235,1),(4,4,0),(4,69,1),(4,70,1),(4,71,1),(4,72,1),(4,73,1),(4,74,1),(4,75,1),(4,76,1),(4,77,1),(4,78,1),(4,79,1),(5,5,0),(5,80,1),(5,81,1),(5,82,1),(5,236,1),(6,6,0),(6,83,1),(6,84,1),(6,85,1),(6,86,1),(6,87,1),(6,88,1),(6,89,1),(6,90,1),(6,91,1),(6,92,1),(6,93,1),(6,94,1),(6,95,1),(6,96,1),(6,97,1),(6,98,1),(6,99,1),(6,100,1),(6,101,1),(6,102,1),(6,103,1),(6,104,1),(6,105,1),(6,106,1),(6,107,1),(6,108,1),(6,109,1),(6,110,1),(6,111,1),(6,112,1),(6,113,1),(6,114,1),(6,115,1),(6,116,1),(6,117,1),(6,118,1),(6,119,1),(6,120,1),(6,121,1),(6,122,1),(6,123,1),(6,124,1),(6,125,1),(6,126,1),(6,127,1),(6,128,1),(6,129,1),(6,130,1),(6,131,1),(6,132,1),(6,133,1),(6,134,1),(6,135,1),(6,136,1),(6,137,1),(7,7,0),(7,138,1),(7,139,1),(7,140,1),(7,141,1),(7,142,1),(7,143,1),(7,144,1),(7,145,1),(7,146,1),(8,8,0),(8,147,1),(8,148,1),(8,149,1),(8,150,1),(8,151,1),(8,152,1),(8,153,1),(8,154,1),(8,155,1),(8,156,1),(8,157,1),(8,158,1),(8,159,1),(8,162,1),(8,163,1),(8,164,1),(8,165,1),(8,167,1),(8,168,1),(8,169,1),(8,170,1),(8,171,1),(8,172,1),(8,173,1),(8,174,1),(8,175,1),(8,177,1),(8,178,1),(8,179,1),(8,180,1),(8,181,1),(9,9,0),(9,182,1),(9,183,1),(9,184,1),(9,185,1),(9,186,1),(9,187,1),(9,188,1),(9,189,1),(9,190,1),(9,191,1),(9,192,1),(9,193,1),(9,194,1),(9,195,1),(9,196,1),(9,197,1),(9,198,1),(9,199,1),(9,200,1),(9,201,1),(9,202,1),(9,203,1),(9,204,1),(9,205,1),(9,206,1),(9,207,1),(9,208,1),(9,209,1),(9,210,1),(9,211,1),(9,212,1),(9,213,1),(9,214,1),(9,215,1),(9,216,1),(9,217,1),(9,218,1),(9,219,1),(9,220,1),(10,10,0),(10,221,1),(10,222,1),(10,223,1),(10,224,1),(10,225,1),(10,226,1),(10,227,1),(10,228,1),(10,229,1),(10,230,1),(10,231,1),(10,232,1),(10,233,1),(10,234,1),(10,237,1),(12,12,0),(13,13,0),(14,14,0),(15,15,0),(16,16,0),(17,17,0),(18,18,0),(19,19,0),(20,20,0),(21,21,0),(22,22,0),(23,23,0),(24,24,0),(25,25,0),(26,26,0),(27,27,0),(28,28,0),(29,29,0),(30,30,0),(31,31,0),(32,32,0),(33,33,0),(34,34,0),(35,35,0),(36,36,0),(37,37,0),(38,38,0),(39,39,0),(40,40,0),(41,41,0),(42,42,0),(43,43,0),(44,44,0),(45,45,0),(46,46,0),(47,47,0),(48,48,0),(49,49,0),(50,50,0),(51,51,0),(52,52,0),(53,53,0),(54,54,0),(55,55,0),(56,56,0),(57,57,0),(58,58,0),(59,59,0),(60,60,0),(61,61,0),(62,62,0),(63,63,0),(64,64,0),(65,65,0),(66,66,0),(67,67,0),(68,68,0),(69,69,0),(70,70,0),(71,71,0),(72,72,0),(73,73,0),(74,74,0),(75,75,0),(76,76,0),(77,77,0),(78,78,0),(79,79,0),(80,80,0),(81,81,0),(82,82,0),(83,83,0),(84,84,0),(85,85,0),(86,86,0),(87,87,0),(88,88,0),(89,89,0),(90,90,0),(91,91,0),(92,92,0),(93,93,0),(94,94,0),(95,95,0),(96,96,0),(97,97,0),(98,98,0),(99,99,0),(100,100,0),(101,101,0),(102,102,0),(103,103,0),(104,104,0),(105,105,0),(106,106,0),(107,107,0),(108,108,0),(109,109,0),(110,110,0),(111,111,0),(112,112,0),(113,113,0),(114,114,0),(115,115,0),(116,116,0),(117,117,0),(118,118,0),(119,119,0),(120,120,0),(121,121,0),(122,122,0),(123,123,0),(124,124,0),(125,125,0),(126,126,0),(127,127,0),(128,128,0),(129,129,0),(130,130,0),(131,131,0),(132,132,0),(133,133,0),(134,134,0),(135,135,0),(136,136,0),(137,137,0),(138,138,0),(139,139,0),(140,140,0),(141,141,0),(142,142,0),(143,143,0),(144,144,0),(145,145,0),(146,146,0),(147,147,0),(148,148,0),(149,149,0),(150,150,0),(151,151,0),(152,152,0),(153,153,0),(154,154,0),(155,155,0),(156,156,0),(157,157,0),(158,158,0),(159,159,0),(160,160,0),(161,161,0),(162,162,0),(163,163,0),(164,164,0),(165,165,0),(166,166,0),(167,167,0),(168,168,0),(169,169,0),(170,170,0),(171,171,0),(172,172,0),(173,173,0),(174,174,0),(175,175,0),(176,176,0),(177,177,0),(178,178,0),(179,179,0),(180,180,0),(181,181,0),(182,182,0),(183,183,0),(184,184,0),(185,185,0),(186,186,0),(187,187,0),(188,188,0),(189,189,0),(190,190,0),(191,191,0),(192,192,0),(193,193,0),(194,194,0),(195,195,0),(196,196,0),(197,197,0),(198,198,0),(199,199,0),(200,200,0),(201,201,0),(202,202,0),(203,203,0),(204,204,0),(205,205,0),(206,206,0),(207,207,0),(208,208,0),(209,209,0),(210,210,0),(211,211,0),(212,212,0),(213,213,0),(214,214,0),(215,215,0),(216,216,0),(217,217,0),(218,218,0),(219,219,0),(220,220,0),(221,221,0),(222,222,0),(223,223,0),(224,224,0),(225,225,0),(226,226,0),(227,227,0),(228,228,0),(229,229,0),(230,230,0),(231,231,0),(232,232,0),(233,233,0),(235,235,0),(236,236,0),(237,237,0);
/*!40000 ALTER TABLE `category_hierarchies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `creator_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `privacy` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_events_on_creator_id` (`creator_id`),
  KEY `index_events_on_place_id` (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'event1',5,2,'2013-08-01 16:57:00',1,'ewrqwerqw\r\n\r\nsdfasda','2013-02-16 18:00:21','2013-02-23 07:38:25'),(2,'event2',5,2,'2013-02-20 17:57:00',1,'vdsfv;l,w','2013-02-16 18:02:19','2013-02-16 18:02:19'),(3,'weq2f',5,2,'2013-02-18 18:40:00',0,'effef','2013-02-16 18:43:10','2013-02-16 18:43:10'),(4,'eefsw',5,2,'2013-08-30 09:31:44',1,'frfewfw','2013-04-01 09:32:03','2013-04-01 09:32:08'),(5,'event3',5,1,'2013-12-14 12:14:00',0,'edfewdfwe','2013-06-14 11:15:32','2013-06-14 11:15:32');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorite_places`
--

DROP TABLE IF EXISTS `favorite_places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorite_places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorite_places`
--

LOCK TABLES `favorite_places` WRITE;
/*!40000 ALTER TABLE `favorite_places` DISABLE KEYS */;
INSERT INTO `favorite_places` VALUES (11,5,2,'2013-02-11 19:36:18','2013-02-11 19:36:18'),(12,6,3,'2013-02-23 18:18:43','2013-02-23 18:18:43'),(13,9,3,'2013-02-24 10:23:14','2013-02-24 10:23:14'),(14,10,3,'2013-03-12 10:47:15','2013-03-12 10:47:15'),(15,6,1,'2013-03-12 11:49:01','2013-03-12 11:49:06'),(16,10,1,'2013-03-12 11:49:36','2013-03-12 11:49:41');
/*!40000 ALTER TABLE `favorite_places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friendships`
--

DROP TABLE IF EXISTS `friendships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `friendships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `friend_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendships`
--

LOCK TABLES `friendships` WRITE;
/*!40000 ALTER TABLE `friendships` DISABLE KEYS */;
INSERT INTO `friendships` VALUES (3,5,6,'accepted','2013-02-17 13:18:00','2012-12-25 12:07:50','2013-02-17 13:18:00'),(4,6,5,'accepted','2013-02-17 13:18:00','2012-12-25 12:07:50','2013-02-17 13:18:00'),(5,9,5,'accepted','2013-02-24 10:24:04','2013-02-24 10:23:30','2013-02-24 10:24:04'),(6,5,9,'accepted','2013-02-24 10:24:04','2013-02-24 10:23:30','2013-02-24 10:24:04'),(7,10,5,'accepted','2013-03-12 10:46:11','2013-03-12 10:43:30','2013-03-12 10:46:11'),(8,5,10,'accepted','2013-03-12 10:46:11','2013-03-12 10:43:30','2013-03-12 10:46:11'),(15,11,5,'pending',NULL,'2013-06-23 18:01:01','2013-06-23 18:01:01'),(16,5,11,'requested',NULL,'2013-06-23 18:01:01','2013-06-23 18:01:01');
/*!40000 ALTER TABLE `friendships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_locations_on_user_id` (`user_id`),
  KEY `index_locations_on_place_id` (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,5,1,'2013-04-25 21:04:39','2013-04-25 19:18:26'),(2,6,2,'2013-04-25 21:04:58','2013-04-27 12:49:05'),(3,10,NULL,'2013-04-25 21:05:14','2013-04-25 21:05:17'),(4,11,NULL,'2013-04-25 21:05:26','2013-04-25 21:05:31'),(5,9,NULL,'2013-04-28 09:38:55','2013-04-28 09:38:59'),(6,16,NULL,'2013-05-20 10:30:29','2013-05-20 10:30:29');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photo_albums`
--

DROP TABLE IF EXISTS `photo_albums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photo_albums` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `privacy` tinyint(4) DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_photo_albums_on_creator_id` (`creator_id`),
  KEY `index_photo_albums_on_place_id` (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo_albums`
--

LOCK TABLES `photo_albums` WRITE;
/*!40000 ALTER TABLE `photo_albums` DISABLE KEYS */;
INSERT INTO `photo_albums` VALUES (1,5,NULL,'Profile Album','Profile Pictures.',0,'2012-09-30 10:03:41','2012-09-30 10:03:41'),(3,5,NULL,'album 1','fssada',1,'2012-10-01 10:17:57','2012-10-01 10:17:57'),(4,6,NULL,'Profile Album','Profile Pictures.',0,'2012-12-08 09:57:06','2012-12-08 09:57:06'),(5,5,NULL,'0bjb','',2,'2013-02-23 08:12:46','2013-05-06 19:19:55'),(6,5,NULL,'home','',0,'2012-12-23 11:39:34','2012-12-23 11:39:34'),(7,5,NULL,'home','',0,'2012-12-23 11:39:39','2012-12-23 11:39:39'),(8,5,NULL,'test','',0,'2012-12-23 11:51:18','2012-12-23 11:51:18'),(9,5,NULL,'test2','',0,'2012-12-23 11:55:21','2012-12-23 11:55:21'),(10,5,NULL,'test3','',0,'2012-12-23 11:57:32','2012-12-23 11:57:32'),(11,5,NULL,'test4','',0,'2012-12-23 12:03:26','2012-12-23 12:03:26'),(12,5,NULL,'test5','',0,'2012-12-23 12:05:21','2012-12-23 12:05:21'),(13,5,NULL,'test6','',0,'2012-12-23 12:06:55','2012-12-23 12:06:55'),(14,5,NULL,'test7','',2,'2012-12-23 12:27:37','2012-12-23 12:27:37'),(15,5,NULL,'test8','',0,'2012-12-23 12:34:06','2012-12-23 12:34:06'),(16,5,NULL,'test9','',0,'2012-12-23 12:40:04','2012-12-23 12:40:04'),(17,5,NULL,'test10','',0,'2012-12-23 12:42:17','2012-12-23 12:42:17'),(18,9,NULL,'Profile Album','Profile Pictures.',0,'2013-02-24 10:21:51','2013-02-24 10:21:51'),(19,10,NULL,'Profile Album','Profile Pictures.',0,'2013-03-12 10:41:10','2013-03-12 10:41:10'),(20,11,NULL,'Profile Album','Profile Pictures.',0,'2013-04-03 18:58:02','2013-04-03 18:58:02'),(21,16,NULL,'Profile Album','Profile Pictures',0,'2013-05-20 10:30:29','2013-05-20 10:30:29');
/*!40000 ALTER TABLE `photo_albums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) DEFAULT NULL,
  `photo_album_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_photos_on_creator_id` (`creator_id`),
  KEY `index_photos_on_album_id` (`photo_album_id`),
  KEY `index_photos_on_place_id` (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` VALUES (8,5,1,2,'adddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddccccccccccccccccccccccccdccdscldc\'\r\n\r\n\r\ndcsdcdsc\r\ndvdfsvdf\r\n\r\n\r\nf\r\n\r\n\r\n\r\n\r\ndfvdfvdvdf\r\n\r\n\r\n\r\n\r\n\r\n\r\ndfvdfvdfvfd\r\n\r\n\r\n\r\n\r\nd\r\n\r\n\r\n\r\n\r\n\r\n\r\nfvdfvdfvdfvdf\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\nfvdfvdfvdfv\r\n\r\n\r\n\r\n\r\n\r\nfvdfvfdv\r\n\r\n\r\nfvdfv\r\nfvfdvdf\r\n\r\n\r\n\r\n\r\na\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\ndfvdfvdf\r\ndfvdf\r\n\r\n\r\n\r\n\r\n\r\nd\r\n\r\n\r\n\r\n\r\n\r\ndfvdf','2012-10-05 21:23:00','2012-11-26 20:25:11','1369.jpg','image/jpeg',118517,'2012-10-05 21:22:56'),(9,5,1,1,'wow','2012-10-13 20:39:52','2012-10-13 20:39:52','At_Golden_Dawn__Topi_Antelope.jpg','image/jpeg',128279,'2012-10-13 20:39:47'),(10,5,1,2,'b','2012-10-24 17:45:38','2012-10-24 17:45:38','P1030472.JPG','image/jpeg',524943,'2012-10-24 17:45:27'),(12,5,3,NULL,'d','2012-10-24 18:02:10','2012-10-24 18:02:10','P1030482.JPG','image/jpeg',356434,'2012-10-24 18:02:03'),(13,5,1,NULL,'','2012-12-03 20:36:52','2012-12-03 20:36:52','P1030519.JPG','image/jpeg',266497,'2012-12-03 20:36:43'),(19,5,1,1,'','2012-12-03 20:55:56','2012-12-03 20:55:56','P1030483.JPG','image/jpeg',229673,'2012-12-03 20:55:50'),(20,5,5,1,'','2012-12-25 09:32:34','2012-12-25 09:32:34','148319_wallpaper_monsters_inc_03_1024.jpg','image/jpeg',227286,'2012-12-25 09:32:28'),(21,5,1,NULL,'','2013-03-17 16:16:46','2013-03-17 16:16:46','1024_-_Shrek.jpg','image/jpeg',152400,'2013-03-17 16:16:38'),(22,5,1,NULL,'','2013-03-17 16:19:08','2013-03-17 16:19:08','1024_-_Shrek.jpg','image/jpeg',152400,'2013-03-17 16:19:03'),(23,5,1,NULL,'','2013-03-17 16:21:10','2013-03-17 16:21:10','1024_-_Shrek.jpg','image/jpeg',152400,'2013-03-17 16:21:05'),(24,5,1,NULL,'','2013-03-17 16:22:44','2013-03-17 16:22:44','alvin_1280x960_wallpaper1.jpg','image/jpeg',335992,'2013-03-17 16:22:39'),(25,5,1,NULL,'','2013-03-17 16:25:42','2013-03-17 16:25:42','Apollo13.jpg','image/jpeg',103070,'2013-03-17 16:25:37'),(26,5,1,NULL,'','2013-03-17 16:25:47','2013-03-17 16:25:47','148319_wallpaper_monsters_inc_03_1024.jpg','image/jpeg',227286,'2013-03-17 16:25:43'),(27,5,5,NULL,'dfwdq','2013-03-29 20:49:24','2013-03-29 20:49:24','alvin_1280x960_wallpaper1.jpg','image/jpeg',335992,'2013-03-29 20:49:15'),(28,5,1,NULL,NULL,'2013-03-31 15:59:24','2013-03-31 15:59:24','wallpaper_03__1600x1200.jpg','image/jpeg',172579,'2013-03-31 15:59:15'),(29,5,1,NULL,NULL,'2013-03-31 15:59:31','2013-03-31 15:59:31','w-curtain_1280.jpg','image/jpeg',472181,'2013-03-31 15:59:26'),(30,5,1,NULL,NULL,'2013-03-31 15:59:38','2013-03-31 15:59:38','wallpaper_04__1600x1200.jpg','image/jpeg',400757,'2013-03-31 15:59:32'),(31,5,3,NULL,'---\n- iceage1\n','2013-04-01 06:32:44','2013-04-01 06:32:44','ice-age01.jpg','image/jpeg',30096,'2013-04-01 06:32:37'),(32,5,3,NULL,'---\n- iceage3\n','2013-04-01 06:32:50','2013-04-01 06:32:50','IceAge3_2009_01_1280x1024.jpg','image/jpeg',390710,'2013-04-01 06:32:45'),(33,5,6,NULL,'---\n- \'2354\'\n','2013-04-08 20:30:31','2013-04-08 20:30:31','5445_song01.jpg','image/jpeg',56677,'2013-04-08 20:30:23'),(34,5,6,NULL,'---\n- os\n','2013-04-08 20:32:40','2013-04-08 20:32:40','Olga_Scheps.jpg','image/jpeg',45152,'2013-04-08 20:32:36'),(35,5,7,0,'---\n- ab2\n','2013-05-04 11:18:24','2013-05-04 11:18:24','Abstract_Wallpapers_00010.jpg','image/jpeg',24491,'2013-05-04 11:18:13'),(36,5,7,0,'---\n- ab1\n','2013-05-04 11:18:30','2013-05-04 11:18:30','Abstract_Wallpapers_00001.jpg','image/jpeg',53073,'2013-05-04 11:18:25'),(37,5,7,0,'---\n- ab3\n','2013-05-04 11:21:06','2013-05-04 11:21:06','Abstract_Wallpapers_00088.jpg','image/jpeg',39051,'2013-05-04 11:21:01'),(38,5,7,0,'---\n- ab4\n','2013-05-04 11:21:12','2013-05-04 11:21:12','Abstract_Wallpapers_00092.jpg','image/jpeg',86618,'2013-05-04 11:21:08'),(39,5,7,0,'---\n- ab0\n','2013-05-04 11:34:07','2013-05-04 11:34:07','beer.jpg','image/jpeg',59869,'2013-05-04 11:34:02'),(40,5,7,0,'---\n- ab9\n','2013-05-04 11:34:18','2013-05-04 11:34:18','Fractal_Color_Waves.jpg','image/jpeg',121016,'2013-05-04 11:34:08'),(41,5,7,NULL,'---\n- ba1\n','2013-05-04 11:41:54','2013-05-04 11:41:54','uniquewallpaper053.jpg','image/jpeg',37983,'2013-05-04 11:41:48'),(42,5,7,NULL,'---\n- ba2\n','2013-05-04 11:42:04','2013-05-04 11:42:04','uniquewallpaper064.jpg','image/jpeg',46236,'2013-05-04 11:41:55'),(43,5,7,0,'---\n- ab3\n','2013-05-04 11:47:21','2013-05-04 11:47:21','Fractals123.jpg','image/jpeg',46476,'2013-05-04 11:47:15'),(44,5,7,0,'---\n- ab7\n','2013-05-04 11:47:26','2013-05-04 11:47:26','Fractals218.jpg','image/jpeg',27626,'2013-05-04 11:47:21'),(45,5,7,4,'---\n- bgt\n','2013-05-04 11:49:48','2013-05-04 11:49:48','Abstract_Wallpapers_00212.jpg','image/jpeg',38126,'2013-05-04 11:49:42'),(46,5,8,NULL,'---\n- hjiu\n','2013-05-11 14:05:04','2013-05-11 14:05:04','Computer_Generated_and_Games_00353.jpg','image/jpeg',97158,'2013-05-11 14:04:55'),(47,5,8,NULL,'---\n- loop\n','2013-05-11 14:07:19','2013-05-11 14:07:19','Computer_Generated_and_Games_00369.jpg','image/jpeg',29673,'2013-05-11 14:07:14'),(48,5,8,NULL,'---\n- fgt\n','2013-05-11 14:09:48','2013-05-11 14:09:48','Computer_Generated_and_Games_00350.jpg','image/jpeg',24458,'2013-05-11 14:09:43'),(49,5,8,NULL,'---\n- \'678\'\n','2013-05-11 14:30:08','2013-05-11 14:30:08','Computer_Generated_and_Games_00083.jpg','image/jpeg',46674,'2013-05-11 14:30:03'),(50,5,8,NULL,'---\n- \'\'\n','2013-05-11 14:31:57','2013-05-11 14:31:57','Computer_Generated_and_Games_00423.jpg','image/jpeg',46369,'2013-05-11 14:31:53'),(51,5,9,1,'---\n- dtr\n','2013-05-20 06:26:51','2013-05-20 06:26:51','Half-Life.jpg','image/jpeg',60655,'2013-05-20 06:26:43'),(52,5,9,NULL,'---\n- fe4\n','2013-05-20 06:29:28','2013-05-20 06:29:28','FEAR_2-303913.jpeg','image/jpeg',60695,'2013-05-20 06:29:24'),(53,5,9,NULL,'---\n- efr\n','2013-05-20 06:37:18','2013-05-20 06:37:18','suzy_by_milkyo-d4lps3i.jpg','image/jpeg',82367,'2013-05-20 06:37:13'),(54,5,9,NULL,'---\n- efe4\n','2013-05-20 06:38:46','2013-05-20 06:38:46','oyS9v.jpg','image/jpeg',51612,'2013-05-20 06:38:42'),(55,5,9,NULL,'---\n- iu\n','2013-05-20 06:39:46','2013-05-20 06:39:46','s2.jpg','image/jpeg',79856,'2013-05-20 06:39:41'),(56,5,9,NULL,'---\n- fr\n','2013-05-20 06:40:42','2013-05-20 06:40:42','14-Ferrari-550-Barchetta-890541.jpeg','image/jpeg',67356,'2013-05-20 06:40:37'),(57,5,9,NULL,'---\n- k\n','2013-05-20 07:39:53','2013-05-20 07:39:53','24hmansfond4.jpg','image/jpeg',102857,'2013-05-20 07:39:47'),(58,5,9,NULL,'---\n- \'876543\'\n','2013-05-20 07:53:18','2013-05-20 07:53:18','4344.jpg','image/jpeg',91141,'2013-05-20 07:53:14'),(59,5,9,NULL,'---\n- vhjh\n','2013-05-20 08:06:04','2013-05-20 08:06:04','cars_lamborghini_005.jpg','image/jpeg',28102,'2013-05-20 08:05:59'),(60,5,9,NULL,'---\n- fer\n','2013-05-20 08:12:33','2013-05-20 08:12:33','cars_ferrari_036.jpg','image/jpeg',23205,'2013-05-20 08:12:28'),(61,5,9,NULL,'---\n- d\n','2013-05-20 08:16:57','2013-05-20 08:16:57','Dodge_00002.jpg','image/jpeg',45482,'2013-05-20 08:16:52'),(62,5,9,NULL,'---\n- vw\n','2013-05-20 08:18:24','2013-05-20 08:18:24','Volkswagen_Passat_2006.jpg','image/jpeg',82953,'2013-05-20 08:18:20'),(63,5,9,NULL,'---\n- bw\n','2013-05-20 08:19:35','2013-05-20 08:19:35','037.jpg','image/jpeg',68601,'2013-05-20 08:19:30'),(64,5,9,NULL,'---\n- att\n','2013-05-20 08:42:04','2013-05-20 08:42:04','800_-_Audi_TT.JPG','image/jpeg',59573,'2013-05-20 08:41:59'),(65,5,9,NULL,'---\n- dss\n','2013-05-20 09:36:57','2013-05-20 09:36:57','Lamborghini_00015.jpg','image/jpeg',30016,'2013-05-20 09:36:52'),(66,5,9,NULL,'---\n- min\n','2013-05-20 09:38:12','2013-05-20 09:38:12','cars_mini_046.jpg','image/jpeg',19226,'2013-05-20 09:38:07'),(67,5,9,NULL,'---\n- \'\'\n','2013-05-20 09:39:21','2013-05-20 09:39:21','350Z-482223.jpeg','image/jpeg',81835,'2013-05-20 09:39:16'),(68,5,9,NULL,'---\n- \'\'\n','2013-05-20 09:40:27','2013-05-20 09:40:27','800_-_Audi_TT.JPG','image/jpeg',59573,'2013-05-20 09:40:23'),(69,5,10,NULL,'---\n- \'\'\n','2013-05-25 08:49:55','2013-05-25 08:49:55','287-1920.jpg','image/jpeg',23485,'2013-05-25 08:49:48'),(70,5,10,NULL,'---\n- \'\'\n','2013-05-25 08:51:12','2013-05-25 08:51:12','65-1920.jpg','image/jpeg',39247,'2013-05-25 08:51:07'),(71,5,10,NULL,'---\n- \'\'\n','2013-05-25 08:52:54','2013-05-25 08:52:54','frankV11280.jpg','image/jpeg',111118,'2013-05-25 08:52:49'),(72,5,10,NULL,'---\n- \'\'\n','2013-05-25 09:02:08','2013-05-25 09:02:08','282-1920.jpg','image/jpeg',23021,'2013-05-25 09:02:03'),(73,5,10,NULL,'---\n- \'\'\n','2013-05-25 09:02:53','2013-05-25 09:02:53','273-1920.jpg','image/jpeg',60773,'2013-05-25 09:02:48'),(74,5,10,NULL,'---\n- \'\'\n','2013-05-25 09:05:43','2013-05-25 09:05:43','ornate-orchids-1280-960-1017.jpg','image/jpeg',68495,'2013-05-25 09:05:39'),(75,5,11,1,'---\n- des1\n','2013-05-26 13:19:53','2013-05-26 13:19:53','momentariness-1280-800-1237.jpg','image/jpeg',76334,'2013-05-26 13:19:48'),(76,5,11,4,'desc2','2013-05-26 13:31:49','2013-05-26 13:31:49','287-1920.jpg','image/jpeg',23485,'2013-05-26 13:31:43'),(79,5,11,2,'des1','2013-05-26 14:11:32','2013-05-26 14:11:32','115026June-1112196744.jpg','image/jpeg',43945,'2013-05-26 14:11:27'),(80,5,11,NULL,'desc2','2013-05-26 14:11:38','2013-05-26 14:11:38','115104orange.jpg','image/jpeg',89870,'2013-05-26 14:11:34');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `places`
--

DROP TABLE IF EXISTS `places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `street` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `state` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postcode` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `reviews_count` int(11) DEFAULT '0',
  `favorite_places_count` int(11) DEFAULT '0',
  `visited_places_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index_places_on_category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `places`
--

LOCK TABLES `places` WRITE;
/*!40000 ALTER TABLE `places` DISABLE KEYS */;
INSERT INTO `places` VALUES (1,'home','Ravensburg, Baden-Württemberg, Federal Republic of Germany (land mass)','Ravensburg','Baden-Württemberg','88250','Federal Republic of Germany (land mass)',47.7818,9.61294,'2012-11-04 17:44:33','2013-06-01 08:45:40',174,41,2,1),(2,'Kaufland','Karlstrasse 21','Weingarten','','88250','Germany',47.7854,9.61029,'2012-11-10 10:15:24','2013-06-01 08:45:40',NULL,2,1,1),(3,'qwe','kdfjsd','ravensburg','sdas','112324','Germany',47.7809,9.61479,'2013-02-15 20:05:11','2013-06-01 08:45:40',174,1,3,0),(4,'hore','fgwfew','rave','bw','88250','Germany',47.785,9.61,'2013-03-04 18:52:52','2013-03-04 18:52:56',NULL,5,0,0);
/*!40000 ALTER TABLE `places` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profile_photos`
--

DROP TABLE IF EXISTS `profile_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profile_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `photo_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_profile_photos_on_user_id` (`user_id`),
  KEY `index_profile_photos_on_photo_id` (`photo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profile_photos`
--

LOCK TABLES `profile_photos` WRITE;
/*!40000 ALTER TABLE `profile_photos` DISABLE KEYS */;
INSERT INTO `profile_photos` VALUES (1,5,32,'2012-11-23 21:21:27','2013-05-09 12:55:49'),(2,6,NULL,'2012-12-08 09:57:06','2012-12-08 09:57:06'),(3,9,NULL,'2013-02-24 10:21:51','2013-02-24 10:21:51'),(4,10,NULL,'2013-03-12 10:41:10','2013-03-12 10:41:10'),(5,11,NULL,'2013-04-03 18:58:02','2013-04-03 18:58:02'),(6,16,NULL,'2013-05-20 10:30:29','2013-05-20 10:30:29');
/*!40000 ALTER TABLE `profile_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `profiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `first_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `about` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `time_zone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_profiles_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (3,5,'hendra','sasmito','2012-07-09','M','1','','','2012-09-30 10:03:41','2013-04-24 18:04:11','Berlin'),(4,6,'bambang','werty','2012-07-12','M',NULL,NULL,NULL,'2012-12-08 09:57:06','2012-12-08 09:57:06',NULL),(5,9,'myonlyhandbook','as','2013-01-02','M',NULL,NULL,NULL,'2013-02-24 10:21:51','2013-02-24 10:21:51','American Samoa'),(6,10,'sepeda','mini','2013-12-03','M',NULL,NULL,NULL,'2013-03-12 10:41:10','2013-03-12 10:41:10','American Samoa'),(7,11,'bambus','bam','1989-04-12','M',NULL,NULL,NULL,'2013-04-03 18:58:02','2013-04-03 18:58:02','American Samoa'),(8,16,'Sepatu','Sendal',NULL,NULL,NULL,NULL,NULL,'2013-05-20 10:30:29','2013-05-20 10:30:29',NULL);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_photos`
--

DROP TABLE IF EXISTS `review_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_photos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `place_id` int(11) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `image_file_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_content_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_photos`
--

LOCK TABLES `review_photos` WRITE;
/*!40000 ALTER TABLE `review_photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_votes`
--

DROP TABLE IF EXISTS `review_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `review_id` int(11) DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_review_votes_on_review_id` (`review_id`),
  KEY `index_review_votes_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_votes`
--

LOCK TABLES `review_votes` WRITE;
/*!40000 ALTER TABLE `review_votes` DISABLE KEYS */;
INSERT INTO `review_votes` VALUES (1,6,26,1,'2012-12-25 08:01:57','2012-12-25 08:01:57'),(2,6,25,1,'2012-12-25 09:17:44','2012-12-25 09:17:44'),(3,5,29,1,'2013-05-25 17:08:44','2013-05-25 17:08:44');
/*!40000 ALTER TABLE `review_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `content` text COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_reviews_on_creator_id` (`creator_id`),
  KEY `index_reviews_on_place_id` (`place_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,5,1,'test','2012-10-29 21:10:48','2012-11-21 21:10:56'),(2,5,1,'lagi','2012-11-21 21:17:44','2012-11-21 21:17:49'),(3,5,1,'aaa','2012-11-23 23:18:08','2012-11-23 23:18:08'),(4,5,1,'123','2012-11-23 23:59:13','2012-11-23 23:59:13'),(5,6,2,'345','2012-11-24 00:02:01','2012-11-24 00:02:01'),(6,5,1,'fff','2012-11-24 00:03:02','2012-11-24 00:03:02'),(7,5,1,'pol','2012-11-24 00:08:11','2012-11-24 00:08:11'),(8,5,1,'123\r\n\r\n\r\n\r\n\r\n','2012-11-24 08:12:12','2012-11-24 08:12:12'),(9,5,1,'123\r\n\r\n\r\n\r\n\r\n','2012-11-24 08:15:48','2012-11-24 08:15:48'),(10,5,1,'123\r\n\r\n\r\n\r\n\r\n','2012-11-24 08:16:48','2012-11-24 08:16:48'),(11,5,1,'123\r\n\r\n\r\n\r\n\r\n','2012-11-24 08:18:53','2012-11-24 08:18:53'),(12,5,1,'123\r\n\r\n\r\n\r\n\r\n','2012-11-24 08:19:29','2012-11-24 08:19:29'),(13,5,1,'3435\r\n\r\n\r\n\r\n','2012-11-24 08:22:05','2012-11-24 08:22:05'),(14,5,1,'nhas','2012-12-03 21:44:38','2012-12-03 21:44:38'),(15,5,1,'uiup','2012-12-04 20:02:24','2012-12-04 20:02:24'),(16,5,1,'bvvc','2012-12-04 20:04:14','2012-12-04 20:04:14'),(18,5,1,'mrt','2012-12-04 20:20:34','2012-12-04 20:20:34'),(19,5,2,'good','2012-12-04 20:41:35','2012-12-04 20:41:35'),(20,5,1,'cxvvxc','2012-12-04 21:07:13','2012-12-04 21:07:13'),(21,5,1,'mcvnklc','2012-12-04 21:09:00','2012-12-04 21:09:00'),(22,5,1,'dcvdsas','2012-12-04 21:10:56','2012-12-04 21:10:56'),(23,5,1,'dqs','2012-12-04 21:11:00','2012-12-04 21:11:00'),(24,5,1,'csas','2012-12-04 21:11:04','2012-12-04 21:11:04'),(25,5,1,'12d','2012-12-08 20:47:58','2012-12-08 20:47:58'),(26,5,1,'hjb','2012-12-08 20:53:36','2012-12-08 20:53:36'),(28,6,1,'bnm','2013-02-18 18:28:01','2013-02-18 18:28:01'),(29,6,1,'muiferferfrevvvvvvvvvvvvvvvvvvvvvvvvrv                         frrewrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr........................44444444444444444444fffffffffffffffffffff','2013-02-18 18:31:13','2013-02-18 18:31:13'),(30,5,1,'123','2013-03-09 11:50:22','2013-03-09 11:50:22'),(31,5,1,'23r3 ','2013-04-07 09:28:52','2013-04-07 09:28:52'),(32,5,1,'1232','2013-04-07 09:50:48','2013-04-07 09:50:48'),(33,5,1,'vgfhh','2013-04-07 14:07:15','2013-04-07 14:07:15'),(34,5,4,'wrwregtewew','2013-05-05 11:45:07','2013-05-05 11:45:07'),(35,5,4,'opkmrke','2013-05-05 11:46:09','2013-05-05 11:46:09'),(36,5,1,'jldgfe','2013-05-11 12:27:50','2013-05-11 12:27:50'),(37,5,1,'wdwdw','2013-05-11 12:30:13','2013-05-11 12:30:13'),(38,5,1,'kljkl','2013-05-11 12:47:42','2013-05-11 12:47:42'),(39,5,1,'iuhoidfewfeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeppppppppppppppppppppppppppprrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrkkkkkkkkkkkkkkkkkkkkkkkkkkvgvvvvvvvvvvvvvvvvvvvv','2013-05-11 12:47:55','2013-05-11 12:47:55'),(40,5,3,'dsdew','2013-06-01 09:16:29','2013-06-01 09:16:29'),(41,5,4,'wdqdqwderfreferrrrrrrrrrrrrrrrrbvvvvvvvvvvvvvvvvvvvvtrrrrrrrrrrrrrrrrrr              btrbbgrrrrrrrrrrrrrrrrrbtrttbbbbbbbbbbbbbbbbb','2013-06-01 09:17:50','2013-06-01 09:17:50'),(42,5,4,'fgdfgdfgfdfewfewfeferffffffffffffffreferfdfeferfrefdfrf                     fgrferferferfrfrefrefrfrfref                 rferferferfdcvrfrerrrrehjjjjjjjjjjjjjjjjjjjjjjjjjjjjerferferferfreferrrrrrrrrrrrrrrrrrrrrrrrrrvfrvrfvrrrrrrrrrrrrrrrrrrrrrrrrrrvfvgvrrrrrrrrrrrrrrrrrrrrrrrrrr','2013-06-01 09:17:53','2013-06-01 09:17:53'),(43,5,1,'ewdwd','2013-06-11 19:42:02','2013-06-11 19:42:02'),(44,5,1,'ewdwd','2013-06-11 19:43:38','2013-06-11 19:43:38'),(45,5,1,'dsfds','2013-06-11 19:52:49','2013-06-11 19:52:49'),(46,5,1,'dsfds','2013-06-11 20:02:49','2013-06-11 20:02:49'),(47,6,1,'cewq','2013-06-11 20:18:28','2013-06-11 20:18:28'),(48,6,1,'n nmkll','2013-06-11 20:20:13','2013-06-11 20:20:13'),(49,6,1,'bkjkj','2013-06-11 20:28:19','2013-06-11 20:28:19'),(50,6,1,'hjbvjh','2013-06-11 20:33:53','2013-06-11 20:33:53'),(51,5,4,'jkjüöjn','2013-06-22 14:57:50','2013-06-22 14:57:50');
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20120912172547'),('20120918191649'),('20120925191238'),('20120929074337'),('20120930091917'),('20121001102208'),('20121001110233'),('20121104173421'),('20121113182659'),('20121121204231'),('20121128195355'),('20121203200600'),('20121205200559'),('20121207200051'),('20121207200052'),('20121207200053'),('20121207200054'),('20121207200055'),('20121207200056'),('20121207200057'),('20121225073118'),('20130130203228'),('20130204190400'),('20130204191648'),('20130209193420'),('20130209194652'),('20130218194144'),('20130424183321'),('20130424191105'),('20130424192040'),('20130511162357'),('20130511162517'),('20130511162518'),('20130601081905'),('20130601082112'),('20130624192400'),('20130624192627');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmation_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `provider` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uid` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reviews_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_users_on_unlock_token` (`unlock_token`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,'hendra_sasmito@yahoo.com','$2a$10$Yl4GifyxFZK9dsrbIIvJKekOildM1j6iDZpWMh7gNmPS.aUBUQw3G',NULL,NULL,NULL,414,'2013-06-25 21:25:37','2013-06-25 19:13:16','127.0.0.1','127.0.0.1',NULL,'2012-09-30 10:07:15','2012-09-30 10:03:35',NULL,0,NULL,NULL,'2012-09-30 10:03:35','2013-06-25 21:25:37','facebook','775739922',42),(6,'bambang@yahoo.com','$2a$10$m8oZl78Htnw0zDu.VlucHe2KzDNxIGniZw3xZoefOQoyjthhdCL02',NULL,NULL,NULL,21,'2013-06-11 20:17:43','2013-04-27 12:46:15','127.0.0.1','127.0.0.1',NULL,'2012-12-08 09:58:30','2012-12-08 09:57:00',NULL,0,NULL,NULL,'2012-12-08 09:57:00','2013-06-11 20:17:43',NULL,NULL,7),(9,'handbook@yahoo.com','$2a$10$6Vmnv/N548y45vbry0u1JewnP32M8V7x6k8eeCLJEv7peWjTnNwn6',NULL,NULL,NULL,1,'2013-02-24 10:22:54','2013-02-24 10:22:54','127.0.0.1','127.0.0.1',NULL,'2013-02-24 10:22:54','2013-02-24 10:21:48',NULL,0,NULL,NULL,'2013-02-24 10:21:48','2013-02-24 10:22:54',NULL,NULL,0),(10,'sepeda_mini@yahoo.com','$2a$10$Ix4PVCDeGUCX4MxrTPvu.uomezfEZLdsufn0I17ImhJ8Kfy1BlZlO',NULL,NULL,NULL,1,'2013-03-12 10:41:53','2013-03-12 10:41:53','127.0.0.1','127.0.0.1',NULL,'2013-03-12 10:41:52','2013-03-12 10:41:01',NULL,0,NULL,NULL,'2013-03-12 10:41:01','2013-03-12 10:41:53',NULL,NULL,0),(11,'bambus@yahoo.com','$2a$10$Dq6qAmxmLm8X0QyIuWZvduhGz.rjCrWxmCbFEqcSs70xHuN7HIWse',NULL,NULL,NULL,5,'2013-06-23 17:58:32','2013-06-15 12:53:33','127.0.0.1','127.0.0.1',NULL,'2013-04-03 18:59:39','2013-04-03 18:57:55',NULL,0,NULL,NULL,'2013-04-03 18:57:55','2013-06-23 17:58:32',NULL,NULL,0),(16,'hendra.sasmito@gmail.com','$2a$10$ewG/tLZxqL/grLvkpnR5lOLA.c0B8scksTgkFhW5ywuKI2429XFai',NULL,NULL,NULL,7,'2013-05-31 10:22:13','2013-05-31 09:19:54','127.0.0.1','127.0.0.1',NULL,'2013-05-20 13:19:31','2013-05-20 10:30:26',NULL,0,NULL,NULL,'2013-05-20 10:30:26','2013-05-31 10:22:13','facebook','100000747325370',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visited_places`
--

DROP TABLE IF EXISTS `visited_places`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visited_places` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `place_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visited_places`
--

LOCK TABLES `visited_places` WRITE;
/*!40000 ALTER TABLE `visited_places` DISABLE KEYS */;
INSERT INTO `visited_places` VALUES (1,6,2,'2013-04-27 12:52:26','2013-04-27 12:52:26'),(2,5,1,'2013-05-09 11:50:00','2013-05-09 11:50:00');
/*!40000 ALTER TABLE `visited_places` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-06-28 18:29:13
