CREATE DATABASE  IF NOT EXISTS `footprint32_production` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;
USE `footprint32_production`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: footprint32_production
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

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
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(2) NOT NULL,
  `cities_count` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'Andorra','AD',10),(2,'United Arab Emirates','AE',13),(3,'Afghanistan','AF',312),(4,'Antigua and Barbuda','AG',9),(5,'Anguilla','AI',5),(6,'Albania','AL',355),(7,'Armenia','AM',310),(8,'Angola','AO',36),(9,'Argentina','AR',747),(10,'American Samoa','AS',14),(11,'Austria','AT',1651),(12,'Australia','AU',1086),(13,'Aruba','AW',4),(14,'Aland Islands','AX',16),(15,'Azerbaijan','AZ',171),(16,'Bosnia and Herzegovina','BA',224),(17,'Barbados','BB',10),(18,'Bangladesh','BD',98),(19,'Belgium','BE',543),(20,'Burkina Faso','BF',52),(21,'Bulgaria','BG',277),(22,'Bahrain','BH',9),(23,'Burundi','BI',17),(24,'Benin','BJ',34),(25,'Saint Bartelemey','BL',1),(26,'Bermuda','BM',2),(27,'Brunei Darussalam','BN',5),(28,'Bolivia','BO',143),(29,'Bonaire','BQ',7),(30,'Brazil','BR',1996),(31,'Bahamas','BS',26),(32,'Bhutan','BT',24),(33,'Bouvet Island','BV',0),(34,'Botswana','BW',86),(35,'Belarus','BY',247),(36,'Belize','BZ',12),(37,'Canada','CA',768),(38,'Cocos (Keeling) Islands','CC',1),(39,'Congo','CD',69),(40,'Central African Republic','CF',37),(41,'Congo','CG',18),(42,'Switzerland','CH',1370),(43,'Cote d\'Ivoire','CI',71),(44,'Cook Islands','CK',1),(45,'Chile','CL',136),(46,'Cameroon','CM',123),(47,'China','CN',14615),(48,'Colombia','CO',931),(49,'Costa Rica','CR',119),(50,'Cuba','CU',156),(51,'Cape Verde','CV',25),(52,'Curacao','CW',5),(53,'Christmas Island','CX',1),(54,'Cyprus','CY',80),(55,'Czech Republic','CZ',1287),(56,'Germany','DE',11020),(57,'Djibouti','DJ',13),(58,'Denmark','DK',331),(59,'Dominica','DM',17),(60,'Dominican Republic','DO',202),(61,'Algeria','DZ',254),(62,'Ecuador','EC',112),(63,'Estonia','EE',94),(64,'Egypt','EG',135),(65,'Western Sahara','EH',4),(66,'Eritrea','ER',11),(67,'Spain','ES',6769),(68,'Ethiopia','ET',107),(69,'Europe','EU',0),(70,'Finland','FI',454),(71,'Fiji','FJ',7),(72,'Falkland Islands (Malvinas)','FK',1),(73,'Micronesia','FM',52),(74,'Faroe Islands','FO',14),(75,'France','FR',8588),(76,'Gabon','GA',27),(77,'United Kingdom','GB',3560),(78,'Grenada','GD',7),(79,'Georgia','GE',93),(80,'French Guiana','GF',14),(81,'Guernsey','GG',1),(82,'Ghana','GH',70),(83,'Gibraltar','GI',1),(84,'Greenland','GL',13),(85,'Gambia','GM',70),(86,'Guinea','GN',41),(87,'Guadeloupe','GP',25),(88,'Equatorial Guinea','GQ',22),(89,'Greece','GR',1029),(90,'South Georgia and the South Sandwich Islands','GS',1),(91,'Guatemala','GT',317),(92,'Guam','GU',2),(93,'Guinea-Bissau','GW',14),(94,'Guyana','GY',14),(95,'Hong Kong','HK',14),(96,'Heard Island and McDonald Islands','HM',0),(97,'Honduras','HN',413),(98,'Croatia','HR',426),(99,'Haiti','HT',102),(100,'Hungary','HU',874),(101,'Indonesia','ID',8626),(102,'Ireland','IE',185),(103,'Israel','IL',157),(104,'Isle of Man','IM',5),(105,'India','IN',3418),(106,'British Indian Ocean Territory','IO',0),(107,'Iraq','IQ',72),(108,'Iran','IR',212),(109,'Iceland','IS',27),(110,'Italy','IT',8180),(111,'Jersey','JE',1),(112,'Jamaica','JM',86),(113,'Jordan','JO',78),(114,'Japan','JP',802),(115,'Kenya','KE',112),(116,'Kyrgyz Republic','KG',55),(117,'Cambodia','KH',27),(118,'Kiribati','KI',18),(119,'Comoros','KM',84),(120,'Saint Kitts and Nevis','KN',14),(121,'North Korea','KP',79),(122,'South Korea','KR',136),(123,'Kuwait','KW',23),(124,'Cayman Islands','KY',6),(125,'Kazakhstan','KZ',258),(126,'Lao People\'s Democratic Republic','LA',47),(127,'Lebanon','LB',31),(128,'Saint Lucia','LC',12),(129,'Liechtenstein','LI',11),(130,'Sri Lanka','LK',65),(131,'Liberia','LR',19),(132,'Lesotho','LS',12),(133,'Lithuania','LT',105),(134,'Luxembourg','LU',83),(135,'Latvia','LV',132),(136,'Libyan','LY',54),(137,'Morocco','MA',239),(138,'Monaco','MC',6),(139,'Moldova','MD',71),(140,'Montenegro','ME',35),(141,'Saint Martin','MF',1),(142,'Madagascar','MG',122),(143,'Marshall Islands','MH',25),(144,'Macedonia','MK',199),(145,'Mali','ML',39),(146,'Myanmar','MM',64),(147,'Mongolia','MN',328),(148,'Macao','MO',1),(149,'Northern Mariana Islands','MP',2),(150,'Martinique','MQ',20),(151,'Mauritania','MR',16),(152,'Montserrat','MS',3),(153,'Malta','MT',70),(154,'Mauritius','MU',95),(155,'Maldives','MV',22),(156,'Malawi','MW',36),(157,'Mexico','MX',2744),(158,'Malaysia','MY',154),(159,'Mozambique','MZ',25),(160,'Namibia','NA',42),(161,'New Caledonia','NC',28),(162,'Niger','NE',44),(163,'Norfolk Island','NF',1),(164,'Nigeria','NG',449),(165,'Nicaragua','NI',125),(166,'Netherlands','NL',675),(167,'Norway','NO',544),(168,'Nepal','NP',62),(169,'Nauru','NR',7),(170,'Niue','NU',1),(171,'New Zealand','NZ',137),(172,'Oman','OM',29),(173,'Panama','PA',198),(174,'Peru','PE',1288),(175,'French Polynesia','PF',35),(176,'Papua New Guinea','PG',41),(177,'Philippines','PH',4494),(178,'Pakistan','PK',434),(179,'Poland','PL',2825),(180,'Saint Pierre and Miquelon','PM',2),(181,'Pitcairn','PN',1),(182,'Puerto Rico','PR',220),(183,'Palestinian Territory','PS',321),(184,'Portugal','PT',485),(185,'Palau','PW',18),(186,'Paraguay','PY',139),(187,'Qatar','QA',17),(188,'Reunion','RE',23),(189,'Romania','RO',4488),(190,'Serbia','RS',397),(191,'Russian Federation','RU',4441),(192,'Rwanda','RW',14),(193,'Saudi Arabia','SA',91),(194,'Solomon Islands','SB',9),(195,'Seychelles','SC',8),(196,'Sudan','SD',70),(197,'Sweden','SE',733),(198,'Singapore','SG',1),(199,'Saint Helena','SH',3),(200,'Slovenia','SI',264),(201,'Svalbard and Jan Mayen','SJ',2),(202,'Slovakia','SK',139),(203,'Sierra Leone','SL',83),(204,'San Marino','SM',9),(205,'Senegal','SN',59),(206,'Somalia','SO',51),(207,'Suriname','SR',13),(208,'South Sudan','SS',19),(209,'Sao Tome and Principe','ST',2),(210,'El Salvador','SV',100),(211,'Sint Maarten','SX',2),(212,'Syrian Arab Republic','SY',281),(213,'Swaziland','SZ',21),(214,'Turks and Caicos Islands','TC',1),(215,'Chad','TD',46),(216,'French Southern Territories','TF',1),(217,'Togo','TG',21),(218,'Thailand','TH',997),(219,'Tajikistan','TJ',82),(220,'Tokelau','TK',3),(221,'Timor-Leste','TL',15),(222,'Turkmenistan','TM',30),(223,'Tunisia','TN',142),(224,'Tonga','TO',7),(225,'Turkey','TR',1866),(226,'Trinidad and Tobago','TT',23),(227,'Tuvalu','TV',8),(228,'Taiwan','TW',33),(229,'Tanzania','TZ',283),(230,'Ukraine','UA',1114),(231,'Uganda','UG',135),(232,'United States Minor Outlying Islands','UM',0),(233,'United States','US',16192),(234,'Uruguay','UY',123),(235,'Uzbekistan','UZ',156),(236,'Vatican City','VA',1),(237,'Saint Vincent and the Grenadines','VC',9),(238,'Venezuela','VE',367),(239,'Virgin Islands','VG',2),(240,'Virgin Islands','VI',3),(241,'Vietnam','VN',356),(242,'Vanuatu','VU',8),(243,'Wallis and Futuna','WF',3),(244,'Samoa','WS',23),(245,'Yemen','YE',297),(246,'Mayotte','YT',17),(247,'South Africa','ZA',318),(248,'Zambia','ZM',67),(249,'Zimbabwe','ZW',64),(250,'Kosovo','XK',58);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-19 11:28:48
