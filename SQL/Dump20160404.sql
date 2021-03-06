CREATE DATABASE  IF NOT EXISTS `e3erp_sit` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `e3erp_sit`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: e3erp_sit
-- ------------------------------------------------------
-- Server version	5.1.72-community

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
-- Table structure for table `assignment_status`
--

DROP TABLE IF EXISTS `assignment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assignment_status` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assignment_status`
--

LOCK TABLES `assignment_status` WRITE;
/*!40000 ALTER TABLE `assignment_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `assignment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank`
--

DROP TABLE IF EXISTS `bank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank`
--

LOCK TABLES `bank` WRITE;
/*!40000 ALTER TABLE `bank` DISABLE KEYS */;
INSERT INTO `bank` VALUES (1,'HDFC'),(2,'SBI'),(3,'ICICI');
/*!40000 ALTER TABLE `bank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `start_date` date NOT NULL,
  `status` char(1) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` date NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `course_fee_id` int(11) DEFAULT NULL,
  `center_course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_user1_idx` (`created_by`),
  KEY `fk_batch_user2_idx` (`updated_by`),
  KEY `fk_batch_course_fee1_idx` (`course_fee_id`),
  KEY `fk_batch_center_course1_idx` (`center_course_id`),
  CONSTRAINT `fk_batch_center_course1` FOREIGN KEY (`center_course_id`) REFERENCES `center_course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_course_fee1` FOREIGN KEY (`course_fee_id`) REFERENCES `course_fee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES (1,'DDR','2016-03-31','Y','Yes To All','2016-04-30',NULL,1,'2016-03-30 03:00:00',1,NULL,1),(2,'DDS','2016-04-30','Y','Yes To All','2016-04-30',NULL,1,'2016-03-30 03:00:00',NULL,NULL,2),(3,'MNO','2016-04-01','Y','Tes Data','2016-04-01',NULL,1,'0000-00-00 00:00:00',NULL,NULL,2);
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_groups`
--

DROP TABLE IF EXISTS `batch_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_groups_batch1_idx` (`batch_id`),
  KEY `fk_batch_groups_user1_idx` (`created_by`),
  KEY `fk_batch_groups_user2_idx` (`updated_by`),
  CONSTRAINT `fk_batch_groups_batch1` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_groups_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_groups_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_groups`
--

LOCK TABLES `batch_groups` WRITE;
/*!40000 ALTER TABLE `batch_groups` DISABLE KEYS */;
INSERT INTO `batch_groups` VALUES (1,'Batch1Group1',1,NULL,1,'2016-03-30 03:00:00',NULL),(2,'Batch1Group2',1,NULL,1,'2016-03-30 03:00:00',NULL),(3,'Batch2Group1',2,NULL,1,'2016-03-30 03:00:00',NULL);
/*!40000 ALTER TABLE `batch_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_user`
--

DROP TABLE IF EXISTS `batch_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `batch_groups_id` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_users_batch1_idx` (`batch_id`),
  KEY `fk_batch_users_user1_idx` (`user_id`),
  KEY `fk_batch_users_role1_idx` (`role_id`),
  KEY `fk_batch_users_batch_groups1_idx` (`batch_groups_id`),
  KEY `fk_batch_user_user2_idx` (`created_by`),
  KEY `fk_batch_user_user3_idx` (`updated_by`),
  CONSTRAINT `fk_batch_user_user2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user_user3` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_users_batch1` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_users_batch_groups1` FOREIGN KEY (`batch_groups_id`) REFERENCES `batch_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_users_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_users_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_user`
--

LOCK TABLES `batch_user` WRITE;
/*!40000 ALTER TABLE `batch_user` DISABLE KEYS */;
INSERT INTO `batch_user` VALUES (1,1,42,3,1,NULL,NULL,'2016-04-04 11:53:06',1),(2,1,44,3,2,NULL,NULL,'2016-04-04 04:31:23',1);
/*!40000 ALTER TABLE `batch_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch_user_fee_audit`
--

DROP TABLE IF EXISTS `batch_user_fee_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_user_fee_audit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `bank_account_number` varchar(255) DEFAULT NULL,
  `ifsc_code` varchar(45) DEFAULT NULL,
  `bank_branch` varchar(45) DEFAULT NULL,
  `cheque_number` varchar(45) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `batch_user_id` int(11) NOT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `payment_status_id` int(11) NOT NULL,
  `payment_mode_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_batch_user_fee_user1_idx` (`created_by`),
  KEY `fk_batch_user_fee_user2_idx` (`updated_by`),
  KEY `fk_batch_user_fee_audit_batch_user1_idx` (`batch_user_id`),
  KEY `fk_batch_user_fee_audit_bank1_idx` (`bank_id`),
  KEY `fk_batch_user_fee_audit_payment_status1_idx` (`payment_status_id`),
  KEY `fk_batch_user_fee_audit_payment_mode1_idx` (`payment_mode_id`),
  CONSTRAINT `fk_batch_user_fee_audit_bank1` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user_fee_audit_batch_user1` FOREIGN KEY (`batch_user_id`) REFERENCES `batch_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user_fee_audit_payment_mode1` FOREIGN KEY (`payment_mode_id`) REFERENCES `payment_mode` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user_fee_audit_payment_status1` FOREIGN KEY (`payment_status_id`) REFERENCES `payment_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user_fee_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_batch_user_fee_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch_user_fee_audit`
--

LOCK TABLES `batch_user_fee_audit` WRITE;
/*!40000 ALTER TABLE `batch_user_fee_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_user_fee_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `business_turnover`
--

DROP TABLE IF EXISTS `business_turnover`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `business_turnover` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `business_turnover`
--

LOCK TABLES `business_turnover` WRITE;
/*!40000 ALTER TABLE `business_turnover` DISABLE KEYS */;
INSERT INTO `business_turnover` VALUES (1,'< 2 Lakhs'),(2,'2 Lakhs To 5 Lakhs'),(3,'5 Lakhs To 10 Lakhs'),(4,'10 Lakhs To 50 Lakhs'),(5,'50 Lakhs To 1 Crore'),(6,'1 Crore To 2 Crore');
/*!40000 ALTER TABLE `business_turnover` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `center`
--

DROP TABLE IF EXISTS `center`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `center` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `city_taluka_id` int(11) NOT NULL,
  `contact_details_name` varchar(255) NOT NULL,
  `contact_details_mobile` varchar(255) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `pincode` varchar(45) NOT NULL,
  `address_line_1` varchar(255) DEFAULT NULL,
  `address_line_2` varchar(255) DEFAULT NULL,
  `street_landmark` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `whtsup_no` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_center_user1_idx` (`created_by`),
  KEY `fk_center_user2_idx` (`updated_by`),
  KEY `fk_center_country1_idx` (`country_id`),
  KEY `fk_center_state1_idx` (`state_id`),
  KEY `fk_center_district1_idx` (`district_id`),
  KEY `fk_center_city_taluka1_idx` (`city_taluka_id`),
  CONSTRAINT `fk_center_city_taluka1` FOREIGN KEY (`city_taluka_id`) REFERENCES `city_taluka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_country1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_district1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_state1` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `center`
--

LOCK TABLES `center` WRITE;
/*!40000 ALTER TABLE `center` DISABLE KEYS */;
INSERT INTO `center` VALUES (1,'Dadar',NULL,NULL,'2016-03-31 03:00:00',1,1,1,1,1,'Darshan','9773937434','45','400086','Thane',NULL,'Near Wagle Estate','darshan@gmail.com','7777777777'),(2,'Thane',NULL,NULL,'2016-04-01 03:00:00',1,1,1,1,1,'Aniket','9773611703',NULL,'',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `center` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `center_course`
--

DROP TABLE IF EXISTS `center_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `center_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `active` char(1) NOT NULL,
  `course_id` int(11) NOT NULL,
  `center_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_center_course_course1_idx` (`course_id`),
  KEY `fk_center_course_center1_idx` (`center_id`),
  CONSTRAINT `fk_center_course_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_course_course1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `center_course`
--

LOCK TABLES `center_course` WRITE;
/*!40000 ALTER TABLE `center_course` DISABLE KEYS */;
INSERT INTO `center_course` VALUES (1,'Y',1,1),(2,'Y',2,2);
/*!40000 ALTER TABLE `center_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `center_user`
--

DROP TABLE IF EXISTS `center_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `center_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `center_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_center_user_user1_idx` (`user_id`),
  KEY `fk_center_user_center1_idx` (`center_id`),
  KEY `fk_center_user_role1_idx` (`role_id`),
  CONSTRAINT `fk_center_user_center1` FOREIGN KEY (`center_id`) REFERENCES `center` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_user_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_center_user_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `center_user`
--

LOCK TABLES `center_user` WRITE;
/*!40000 ALTER TABLE `center_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `center_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city_taluka`
--

DROP TABLE IF EXISTS `city_taluka`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city_taluka` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `district_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_city_taluka_district1_idx` (`district_id`),
  CONSTRAINT `fk_city_taluka_district1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_taluka`
--

LOCK TABLES `city_taluka` WRITE;
/*!40000 ALTER TABLE `city_taluka` DISABLE KEYS */;
INSERT INTO `city_taluka` VALUES (1,' JAMMU & KASHMIR',1),(2,' Kupwara',2),(3,' Kupwara',2),(4,' Handwara',2),(5,' Karnah',2),(6,' Baramula',3),(7,' Gurez',3),(8,' Bandipore',3),(9,' Sonawari',3),(10,' Sopore',3),(11,' Pattan',3),(12,' Baramula',3),(13,' Uri',3),(14,' Gulmarg',3),(15,' Srinagar',4),(16,' Kangan',4),(17,' Ganderbal',4),(18,' Srinagar',4),(19,' Badgam',5),(20,' Beerwah',5),(21,' Badgam',5),(22,' Chadura',5),(23,' Pulwama',6),(24,' Pampore',6),(25,' Tral',6),(26,' Pulwama',6),(27,' Shupiyan',6),(28,' Anantnag',7),(29,' Pahalgam',7),(30,' Bijbehara',7),(31,' Anantnag',7),(32,' Kulgam',7),(33,' Duru',7),(34,' Leh (Ladakh)',8),(35,' Leh',8),(36,' Kargil',9),(37,' Kargil',9),(38,' Zanskar',9),(39,' Doda',10),(40,' Banihal',10),(41,' Ramban',10),(42,' Doda',10),(43,' Kishtwar',10),(44,' Thathri',10),(45,' Bhalessa (Gandoh)',10),(46,' Bhaderwah',10),(47,' Udhampur',11),(48,' Gool Gulab Garh',11),(49,' Reasi',11),(50,' Udhampur',11),(51,' Chenani',11),(52,' Ramnagar',11),(53,' Punch',12),(54,' Haveli',12),(55,' Mendhar',12),(56,' Surankote',12),(57,' Rajauri',13),(58,' Thanamandi',13),(59,' Rajauri',13),(60,' Budhal',13),(61,' Kalakote',13),(62,' Nowshehra ',13),(63,' Sunderbani  ',13),(64,' Jammu',14),(65,' Akhnoor',14),(66,' Jammu',14),(67,' Ranbirsinghpora',14),(68,' Bishna',14),(69,' Samba',14),(70,' Kathua',15),(71,' Billawar',15),(72,' Bashohli',15),(73,' Kathua',15),(74,' Hiranagar',15),(75,' HIMACHAL PRADESH',16),(76,' Chamba',17),(77,' Pangi(T)',17),(78,' Chaurah(T)',17),(79,' Saluni(T)',17),(80,' Bhalai(S.T)',17),(81,' Dalhousie(T)',17),(82,' Bhattiyat(T)',17),(83,' Sihunta(S.T)',17),(84,' Chamba(T)',17),(85,' Holi(S.T)',17),(86,' Brahmaur(T)',17),(87,' Kangra',18),(88,' Nurpur(T)',18),(89,' Indora(T)',18),(90,' Fatehpur(T)',18),(91,' Jawali(T)',18),(92,' Harchakian(S.T)',18),(93,' Shahpur(T)',18),(94,' Dharmsala(T)',18),(95,' Kangra(T)',18),(96,' Baroh(T)',18),(97,' Dera Gopipur(T)',18),(98,' Jaswan(T)',18),(99,' Rakkar(S.T)',18),(100,' Khundian(T)',18),(101,' Thural(S.T)',18),(102,' Dhira(S.T)',18),(103,' Jai Singhpur(T)',18),(104,' Palampur(T)',18),(105,' Baijnath(T)',18),(106,' Multhan(S.T)',18),(107,' Lahul & Spiti',19),(108,' Udaipur (S.T)',19),(109,' Lahul     (T)',19),(110,' Spiti       (T)',19),(111,' Kullu',20),(112,' Manali(T)',20),(113,' Kullu(T)',20),(114,' Sainj(S.T)',20),(115,' Banjar(T)',20),(116,' Ani(S.T)',20),(117,' Nermand(T)',20),(118,' Mandi',21),(119,' Padhar(T)',21),(120,' Jogindarnagar(T)',21),(121,' Lad Bharol(T)',21),(122,' Sandhol(S.T)',21),(123,' Dharmpur(S.T)',21),(124,' Kotli(S.T)',21),(125,' Sarkaghat(T)',21),(126,' Baldwara(S.T)',21),(127,' Sundarnagar(T)',21),(128,' Mandi(T)',21),(129,' Aut(S.T)',21),(130,' Bali Chowki(S.T)',21),(131,' Thunag(T)',21),(132,' Chachyot(T)',21),(133,' Nihri(S.T)',21),(134,' Karsog(T)',21),(135,' Hamirpur',22),(136,' Tira Sujanpur(T)',22),(137,' Nadaun(T)',22),(138,' Hamirpur(T)',22),(139,' Barsar(T)',22),(140,' Dhatwal(ST)',22),(141,' Bhoranj(T)',22),(142,' Una',23),(143,' Bharwain(S.T)',23),(144,' Amb(T)',23),(145,' Bangana(T)',23),(146,' Una(T)',23),(147,' Haroli(S.T)',23),(148,' Bilaspur',24),(149,' Ghumarwin(T)',24),(150,' Jhanduta(T)',24),(151,' Naina Devi(S.T)',24),(152,' Bilaspur Sadar(T)',24),(153,' Solan',25),(154,' Arki(T)',25),(155,' Ramshahr(S.T)',25),(156,' Nalagarh(T)',25),(157,' Krishangarh(S.T)',25),(158,' Kasauli(T)',25),(159,' Solan(T)',25),(160,' Kandaghat(T)',25),(161,' Sirmaur',26),(162,' Rajgarh(T)',26),(163,' Nohra(S.T)',26),(164,' Pachhad(T)',26),(165,' Renuka(T)',26),(166,' Dadahu(S.T)',26),(167,' Nahan(T)',26),(168,' Paonta Sahib(T)',26),(169,' Kamrau(S.T)',26),(170,' Shalai(T)',26),(171,' Ronhat(S.T)',26),(172,' Shimla',27),(173,' Rampur(T)',27),(174,' Nankhari(S.T)',27),(175,' Kumharsain(T)',27),(176,' Seoni(T)',27),(177,' Shimla Rural(T)',27),(178,' Shimla Urban(T)',27),(179,' Junga(S.T)',27),(180,' Theog(T)',27),(181,' Chaupal(T)',27),(182,' Cheta(S.T)',27),(183,' Nerua(S.T)',27),(184,' Jubbal(T)',27),(185,' Kotkhai(T)',27),(186,' Tikar(S.T)',27),(187,' Rohru(T)',27),(188,' Chirgaon(T)',27),(189,' Dodra Kwar(T)',27),(190,' Kinnaur',28),(191,' Hangrang(S.T)',28),(192,' Poo(T)',28),(193,' Morang(T)',28),(194,' Kalpa(T)',28),(195,' Nichar(T)',28),(196,' Sangla(T)',28),(197,' PUNJAB',29),(198,' Gurdaspur',30),(199,' Dhar Kalan',30),(200,' Pathankot',30),(201,' Gurdaspur',30),(202,' Batala',30),(203,' Dera Baba Nanak',30),(204,' Amritsar',31),(205,' Ajnala',31),(206,' Amritsar -I',31),(207,' Amritsar- II',31),(208,' Tarn-Taran',31),(209,' Patti',31),(210,' Khadur Sahib',31),(211,' Baba Bakala',31),(212,' Kapurthala',32),(213,' Bhulath',32),(214,' Kapurthala',32),(215,' Sultanpur Lodhi',32),(216,' Phagwara',32),(217,' Jalandhar',33),(218,' Shahkot',33),(219,' Nakodar',33),(220,' Phillaur',33),(221,' Jalandhar - I',33),(222,' Jalandhar -II',33),(223,' Hoshiarpur',34),(224,' Dasua',34),(225,' Mukerian',34),(226,' Hoshiarpur',34),(227,' Garhshankar',34),(228,' Nawanshahr *',35),(229,' Nawanshahr',35),(230,' Balachaur',35),(231,' Rupnagar',36),(232,' Anandpur Sahib',36),(233,' Rupnagar',36),(234,' Kharar',36),(235,' S.A.S.Nagar (Mohali)',36),(236,' Fatehgarh Sahib *',37),(237,' Bassi Pathana',37),(238,' Fatehgarh Sahib',37),(239,' Amloh',37),(240,' Khamanon',37),(241,' Ludhiana',38),(242,' Samrala',38),(243,' Khanna',38),(244,' Payal',38),(245,' Ludhiana (East)',38),(246,' Ludhiana (West)',38),(247,' Raikot',38),(248,' Jagraon',38),(249,' Moga *',39),(250,' Nihal Singhwala',39),(251,' Bagha Purana',39),(252,' Moga',39),(253,' Firozpur',40),(254,' Zira',40),(255,' Firozepur',40),(256,' Jalalabad',40),(257,' Fazilka',40),(258,' Abohar',40),(259,' Muktsar *',41),(260,' Malout',41),(261,' Giddarbaha',41),(262,' Muktsar',41),(263,' Faridkot',42),(264,' Faridkot',42),(265,' Jaitu',42),(266,' Bathinda',43),(267,' Rampura Phul',43),(268,' Bathinda',43),(269,' Talwandi Sabo',43),(270,' Mansa *',44),(271,' Sardulgarh',44),(272,' Budhlada',44),(273,' Mansa',44),(274,' Sangrur',45),(275,' Barnala',45),(276,' Malerkotla',45),(277,' Dhuri',45),(278,' Sangrur',45),(279,' Sunam',45),(280,' Moonak',45),(281,' Patiala',46),(282,' Samana',46),(283,' Nabha',46),(284,' Patiala',46),(285,' Rajpura',46),(286,' Dera Bassi',46),(287,' CHANDIGARH',47),(288,' Chandigarh',48),(289,' Chandigarh',48),(290,' UTTARANCHAL',49),(291,' Uttarkashi',50),(292,' Puraula',50),(293,' Rajgarhi',50),(294,' Dunda',50),(295,' Bhatwari',50),(296,' Chamoli',51),(297,' Joshimath ',51),(298,' Chamoli',51),(299,' Pokhari **',51),(300,' Karnaprayag ',51),(301,' Tharali',51),(302,' Gair Sain **',51),(303,' Rudraprayag *',52),(304,' Ukhimath',52),(305,' Rudraprayag ',52),(306,' Tehri Garhwal',53),(307,' Ghansali **',53),(308,' Devprayag',53),(309,' Pratapnagar',53),(310,' Tehri',53),(311,' Narendranagar',53),(312,' Dehradun',54),(313,' Chakrata',54),(314,' Vikasnagar **',54),(315,' Dehradun',54),(316,' Rishikesh **',54),(317,' Garhwal',55),(318,' Srinagar **',55),(319,' Pauri',55),(320,' Thali Sain',55),(321,' Dhoomakot',55),(322,' Lansdowne ',55),(323,' Kotdwara',55),(324,' Pithoragarh',56),(325,' Munsiari',56),(326,' Dharchula',56),(327,' Didihat',56),(328,' Gangolihat',56),(329,' Pithoragarh',56),(330,' Bageshwar',57),(331,' Kapkot **',57),(332,' Bageshwar ',57),(333,' Almora',58),(334,' Bhikia Sain',58),(335,' Ranikhet',58),(336,' Almora',58),(337,' Champawat',59),(338,' Champawat',59),(339,' Nainital',60),(340,' Kosya Kutauli',60),(341,' Nainital',60),(342,' Dhari',60),(343,' Haldwani',60),(344,' Udham Singh Nagar *',61),(345,' Kashipur',61),(346,' Kichha',61),(347,' Sitarganj',61),(348,' Khatima',61),(349,' Hardwar',62),(350,' Roorkee',62),(351,' Hardwar',62),(352,' Laksar',62),(353,' HARYANA',63),(354,' Panchkula *',64),(355,' Kalka',64),(356,' Panchkula',64),(357,' Ambala',65),(358,' Naraingarh',65),(359,' Ambala',65),(360,' Barara',65),(361,' Yamunanagar',66),(362,' Jagadhri',66),(363,' Chhachhrauli',66),(364,' Kurukshetra',67),(365,' Shahbad',67),(366,' Pehowa',67),(367,' Thanesar',67),(368,' Kaithal',68),(369,' Guhla',68),(370,' Kaithal',68),(371,' Karnal',69),(372,' Nilokheri',69),(373,' Indri',69),(374,' Karnal',69),(375,' Assandh',69),(376,' Gharaunda',69),(377,' Panipat',70),(378,' Panipat',70),(379,' Israna',70),(380,' Samalkha',70),(381,' Sonipat',71),(382,' Gohana',71),(383,' Ganaur',71),(384,' Sonipat',71),(385,' Kharkhoda',71),(386,' Jind',72),(387,' Narwana',72),(388,' Jind',72),(389,' Julana',72),(390,' Safidon',72),(391,' Fatehabad *',73),(392,' Ratia',73),(393,' Tohana',73),(394,' Fatehabad',73),(395,' Sirsa',74),(396,' Dabwali',74),(397,' Sirsa',74),(398,' Rania',74),(399,' Ellenabad',74),(400,' Hisar',75),(401,' Adampur',75),(402,' Hisar',75),(403,' Narnaund',75),(404,' Hansi',75),(405,' Bhiwani',76),(406,' Bawani Khera',76),(407,' Bhiwani',76),(408,' Tosham',76),(409,' Siwani',76),(410,' Loharu ',76),(411,' Dadri',76),(412,' Rohtak',77),(413,' Maham',77),(414,' Rohtak',77),(415,' Jhajjar *',78),(416,' Beri',78),(417,' Bahadurgarh',78),(418,' Jhajjar',78),(419,' Mahendragarh',79),(420,' Mahendragarh',79),(421,' Narnaul',79),(422,' Rewari',80),(423,' Kosli',80),(424,' Rewari',80),(425,' Bawal',80),(426,' Gurgaon',81),(427,' Pataudi',81),(428,' Gurgaon',81),(429,' Sohna',81),(430,' Taoru',81),(431,' Nuh',81),(432,' Ferozepur Jhirka',81),(433,' Punahana',81),(434,' Faridabad',82),(435,' Faridabad',82),(436,' Ballabgarh',82),(437,' Palwal',82),(438,' Hathin',82),(439,' Hodal',82),(440,' DELHI',83),(441,' North West   *',84),(442,' Narela',84),(443,' Saraswati Vihar',84),(444,' Model Town',84),(445,' North   *',85),(446,' Civil Lines',85),(447,' Sadar Bazar',85),(448,' Kotwali',85),(449,' North East   *',86),(450,' Seelam Pur',86),(451,' Shahdara',86),(452,' Seema Puri',86),(453,' East   *',87),(454,' Gandhi Nagar',87),(455,' Vivek Vihar',87),(456,' Preet Vihar',87),(457,' New Delhi',88),(458,' Parliament Street',88),(459,' Connaught Place',88),(460,' Chanakya Puri',88),(461,' Central  *',89),(462,' Karol Bagh',89),(463,' Pahar Ganj',89),(464,' Darya Ganj',89),(465,' West   *',90),(466,' Punjabi Bagh',90),(467,' Patel Nagar',90),(468,' Rajouri Garden',90),(469,' South West   *',91),(470,' Najafgarh',91),(471,' Delhi Cantonment.',91),(472,' Vasant Vihar',91),(473,' South  *',92),(474,' Defence Colony',92),(475,' Hauz Khas',92),(476,' Kalkaji',92),(477,' RAJASTHAN',93),(478,' Ganganagar',94),(479,' Karanpur',94),(480,' Ganganagar',94),(481,' Sadulshahar',94),(482,' Padampur',94),(483,' Raisinghnagar',94),(484,' Anupgarh',94),(485,' Gharsana',94),(486,' Vijainagar',94),(487,' Suratgarh',94),(488,' Hanumangarh *',95),(489,' Sangaria',95),(490,' Tibi',95),(491,' Hanumangarh',95),(492,' Pilibanga',95),(493,' Rawatsar',95),(494,' Nohar',95),(495,' Bhadra',95),(496,' Bikaner',96),(497,' Bikaner',96),(498,' Poogal',96),(499,' Lunkaransar',96),(500,' Kolayat',96),(501,' Nokha',96),(502,' Khajuwala',96),(503,' Chhatargarh',96),(504,' Churu',97),(505,' Taranagar',97),(506,' Rajgarh',97),(507,' Sardarshahar',97),(508,' Churu',97),(509,' Dungargarh',97),(510,' Ratangarh',97),(511,' Sujangarh',97),(512,' Jhunjhunun',98),(513,' Jhunjhunun',98),(514,' Chirawa',98),(515,' Buhana',98),(516,' Khetri',98),(517,' Nawalgarh',98),(518,' Udaipurwati',98),(519,' Alwar',99),(520,' Behror',99),(521,' Mandawar',99),(522,' Kotkasim',99),(523,' Tijara',99),(524,' Kishangarh Bas',99),(525,' Ramgarh',99),(526,' Alwar',99),(527,' Bansur',99),(528,' Thanagazi',99),(529,' Rajgarh',99),(530,' Lachhmangarh',99),(531,' Kathumar',99),(532,' Bharatpur',100),(533,' Pahari',100),(534,' Kaman',100),(535,' Nagar',100),(536,' Deeg',100),(537,' Nadbai',100),(538,' Kumher',100),(539,' Bharatpur',100),(540,' Weir',100),(541,' Bayana',100),(542,' Rupbas',100),(543,' Dhaulpur',101),(544,' Baseri',101),(545,' Bari',101),(546,' Sepau',101),(547,' Dhaulpur',101),(548,' Rajakhera',101),(549,' Karauli *',102),(550,' Todabhim',102),(551,' Nadoti',102),(552,' Hindaun',102),(553,' Karauli',102),(554,' Mandrail',102),(555,' Sapotra',102),(556,' Sawai Madhopur',103),(557,' Gangapur',103),(558,' Bamanwas',103),(559,' Malarna Doongar',103),(560,' Bonli',103),(561,' Chauth Ka Barwara',103),(562,' Sawai Madhopur',103),(563,' Khandar',103),(564,' Dausa *',104),(565,' Baswa',104),(566,' Mahwa',104),(567,' Sikrai',104),(568,' Dausa',104),(569,' Lalsot',104),(570,' Jaipur',105),(571,' Kotputli',105),(572,' Viratnagar',105),(573,' Shahpura',105),(574,' Chomu',105),(575,' Phulera (HQ.Sambhar)',105),(576,' Dudu (HQ. Mauzamabad)',105),(577,' Phagi',105),(578,' Sanganer',105),(579,' Jaipur',105),(580,' Amber',105),(581,' Jamwa Ramgarh',105),(582,' Bassi',105),(583,' Chaksu',105),(584,' Sikar',106),(585,' Fatehpur',106),(586,' Lachhmangarh',106),(587,' Sikar',106),(588,' Danta Ramgarh',106),(589,' Sri Madhopur',106),(590,' Neem Ka Thana',106),(591,' Nagaur',107),(592,' Ladnu',107),(593,' Didwana',107),(594,' Jayal',107),(595,' Nagaur',107),(596,' Kheenvsar',107),(597,' Merta',107),(598,' Degana',107),(599,' Parbatsar',107),(600,' Makrana',107),(601,' Nawa',107),(602,' Jodhpur',108),(603,' Phalodi',108),(604,' Osian',108),(605,' Bhopalgarh',108),(606,' Jodhpur',108),(607,' Shergarh',108),(608,' Luni',108),(609,' Bilara',108),(610,' Jaisalmer',109),(611,' Jaisalmer',109),(612,' Pokaran',109),(613,' Fatehgarh',109),(614,' Barmer',110),(615,' Sheo',110),(616,' Baytoo',110),(617,' Pachpadra',110),(618,' Siwana',110),(619,' Gudha Malani',110),(620,' Barmer',110),(621,' Ramsar',110),(622,' Chohtan',110),(623,' Jalor',111),(624,' Sayla',111),(625,' Ahore',111),(626,' Jalor',111),(627,' Bhinmal',111),(628,' Bagora',111),(629,' Sanchore',111),(630,' Raniwara',111),(631,' Sirohi',112),(632,' Sheoganj',112),(633,' Sirohi',112),(634,' Pindwara',112),(635,' Abu Road',112),(636,' Reodar',112),(637,' Pali',113),(638,' Jaitaran',113),(639,' Raipur',113),(640,' Sojat',113),(641,' Rohat',113),(642,' Pali',113),(643,' Marwar Junction',113),(644,' Desuri',113),(645,' Sumerpur',113),(646,' Bali',113),(647,' Ajmer',114),(648,' Kishangarh',114),(649,' Ajmer',114),(650,' Peesangan',114),(651,' Beawar',114),(652,' Masuda',114),(653,' Nasirabad',114),(654,' Bhinay',114),(655,' Sarwar',114),(656,' Kekri',114),(657,' Tonk',115),(658,' Malpura',115),(659,' Peeplu',115),(660,' Niwai',115),(661,' Tonk',115),(662,' Todaraisingh',115),(663,' Deoli',115),(664,' Uniara',115),(665,' Bundi',116),(666,' Hindoli',116),(667,' Nainwa',116),(668,' Indragarh',116),(669,' Keshoraipatan',116),(670,' Bundi',116),(671,' Bhilwara',117),(672,' Asind',117),(673,' Hurda',117),(674,' Shahpura',117),(675,' Banera',117),(676,' Mandal',117),(677,' Raipur',117),(678,' Sahara',117),(679,' Bhilwara',117),(680,' Kotri',117),(681,' Jahazpur',117),(682,' Mandalgarh',117),(683,' Beejoliya',117),(684,' Rajsamand *',118),(685,' Bhim',118),(686,' Deogarh',118),(687,' Amet',118),(688,' Kumbhalgarh',118),(689,' Rajsamand',118),(690,' Railmagra',118),(691,' Nathdwara',118),(692,' Udaipur',119),(693,' Mavli',119),(694,' Gogunda',119),(695,' Kotra',119),(696,' Jhadol',119),(697,' Girwa',119),(698,' Vallabhnagar',119),(699,' Dhariawad',119),(700,' Salumbar',119),(701,' Sarada',119),(702,' Kherwara',119),(703,' Dungarpur',120),(704,' Dungarpur',120),(705,' Aspur',120),(706,' Sagwara',120),(707,' Simalwara',120),(708,' Banswara',121),(709,' Ghatol',121),(710,' Garhi',121),(711,' Banswara',121),(712,' Bagidora',121),(713,' Kushalgarh',121),(714,' Chittaurgarh',122),(715,' Rashmi',122),(716,' Gangrar',122),(717,' Begun',122),(718,' Rawatbhata',122),(719,' Chittaurgarh',122),(720,' Kapasan',122),(721,' Dungla',122),(722,' Bhadesar',122),(723,' Nimbahera',122),(724,' Chhoti Sadri',122),(725,' Bari Sadri',122),(726,' Pratapgarh',122),(727,' Arnod',122),(728,' Kota',123),(729,' Pipalda',123),(730,' Digod',123),(731,' Ladpura',123),(732,' Ramganj Mandi',123),(733,' Sangod',123),(734,' Baran *',124),(735,' Mangrol',124),(736,' Antah',124),(737,' Baran',124),(738,' Atru',124),(739,' Kishanganj',124),(740,' Shahbad',124),(741,' Chhabra',124),(742,' Chhipabarod',124),(743,' Jhalawar',125),(744,' Khanpur',125),(745,' Jhalrapatan',125),(746,' Aklera',125),(747,' Manohar Thana',125),(748,' Pachpahar',125),(749,' Pirawa',125),(750,' Gangdhar',125),(751,' UTTAR PRADESH',126),(752,' Saharanpur',127),(753,' Behat',127),(754,' Saharanpur',127),(755,' Nakur',127),(756,' Deoband',127),(757,' Muzaffarnagar',128),(758,' Kairana',128),(759,' Shamli **',128),(760,' Muzaffarnagar',128),(761,' Budhana',128),(762,' Jansath',128),(763,' Bijnor',129),(764,' Najibabad',129),(765,' Bijnor',129),(766,' Nagina',129),(767,' Dhampur',129),(768,' Chandpur',129),(769,' Moradabad',130),(770,' Thakurdwara',130),(771,' Moradabad',130),(772,' Bilari',130),(773,' Sambhal',130),(774,' Chandausi',130),(775,' Rampur',131),(776,' Suar',131),(777,' Bilaspur',131),(778,' Rampur',131),(779,' Shahabad ',131),(780,' Milak ',131),(781,' Jyotiba Phule Nagar *',132),(782,' Dhanaura',132),(783,' Amroha',132),(784,' Hasanpur',132),(785,' Meerut',133),(786,' Sardhana',133),(787,' Mawana',133),(788,' Meerut',133),(789,' Baghpat *',134),(790,' Baraut **',134),(791,' Baghpat',134),(792,' Khekada **',134),(793,' Ghaziabad',135),(794,' Modinagar',135),(795,' Ghaziabad',135),(796,' Hapur',135),(797,' Garhmukteshwar',135),(798,' Gautam Buddha Nagar *',136),(799,' Dadri',136),(800,' Gautam Buddha Nagar **',136),(801,' Jewar **',136),(802,' Bulandshahr',137),(803,' Sikandrabad',137),(804,' Bulandshahr',137),(805,' Siana',137),(806,' Anupshahr',137),(807,' Debai **',137),(808,' Shikarpur **',137),(809,' Khurja ',137),(810,' Aligarh',138),(811,' Khair',138),(812,' Gabhana **',138),(813,' Atrauli',138),(814,' Koil ',138),(815,' Iglas',138),(816,' Hathras *',139),(817,' Sasni **',139),(818,' Sikandra Rao ',139),(819,' Hathras',139),(820,' Sadabad',139),(821,' Mathura',140),(822,' Chhata',140),(823,' Mat',140),(824,' Mathura',140),(825,' Agra',141),(826,' Etmadpur',141),(827,' Agra',141),(828,' Kiraoli',141),(829,' Kheragarh',141),(830,' Fatehabad',141),(831,' Bah',141),(832,' Firozabad',142),(833,' Tundla **',142),(834,' Firozabad',142),(835,' Jasrana ',142),(836,' Shikohabad ',142),(837,' Etah',143),(838,' Kasganj',143),(839,' Patiyali',143),(840,' Aliganj ',143),(841,' Etah',143),(842,' Jalesar ',143),(843,' Mainpuri',144),(844,' Mainpuri',144),(845,' Karhal',144),(846,' Bhogaon ',144),(847,' Budaun',145),(848,' Gunnaur ',145),(849,' Bisauli ',145),(850,' Bilsi **',145),(851,' Sahaswan',145),(852,' Budaun',145),(853,' Dataganj',145),(854,' Bareilly',146),(855,' Baheri',146),(856,' Meerganj ',146),(857,' Aonla ',146),(858,' Bareilly ',146),(859,' Nawabganj ',146),(860,' Faridpur ',146),(861,' Pilibhit',147),(862,' Pilibhit ',147),(863,' Bisalpur',147),(864,' Puranpur',147),(865,' Shahjahanpur',148),(866,' Powayan',148),(867,' Tilhar',148),(868,' Shahjahanpur',148),(869,' Jalalabad',148),(870,' Kheri',149),(871,' Nighasan',149),(872,' Gola Gokaran Nath',149),(873,' Mohammdi',149),(874,' Lakhimpur',149),(875,' Dhaurahara',149),(876,' Sitapur',150),(877,' Misrikh',150),(878,' Sitapur',150),(879,' Laharpur ',150),(880,' Biswan',150),(881,' Mahmudabad',150),(882,' Sidhauli',150),(883,' Hardoi',151),(884,' Shahabad',151),(885,' Sawayajpur **',151),(886,' Hardoi ',151),(887,' Bilgram',151),(888,' Sandila ',151),(889,' Unnao',152),(890,' Safipur',152),(891,' Hasanganj ',152),(892,' Unnao',152),(893,' Purwa ',152),(894,' Bighapur **',152),(895,' Lucknow',153),(896,' Malihabad',153),(897,' Bakshi Ka Talab**',153),(898,' Lucknow',153),(899,' Mohanlalganj ',153),(900,' Rae Bareli',154),(901,' Maharajganj',154),(902,' Tiloi',154),(903,' Rae Bareli ',154),(904,' Lalganj ',154),(905,' Dalmau ',154),(906,' Unchahar **',154),(907,' Salon',154),(908,' Farrukhabad',155),(909,' Kaimganj',155),(910,' Amritpur **',155),(911,' Farrukhabad ',155),(912,' Kannauj *',156),(913,' Chhibramau',156),(914,' Kannauj',156),(915,' Tirwa **',156),(916,' Etawah',157),(917,' Jaswantnagar **',157),(918,' Saifai **',157),(919,' Etawah',157),(920,' Bharthana',157),(921,' Chakarnagar **',157),(922,' Auraiya *',158),(923,' Bidhuna',158),(924,' Auraiya ',158),(925,' Kanpur Dehat',159),(926,' Rasulabad ',159),(927,' Derapur',159),(928,' Akbarpur ',159),(929,' Bhognipur',159),(930,' Sikandra **',159),(931,' Kanpur Nagar',160),(932,' Bilhaur ',160),(933,' Kanpur ',160),(934,' Ghatampur ',160),(935,' Jalaun ',161),(936,' Madhogarh ** ',161),(937,' Jalaun',161),(938,' Kalpi ',161),(939,' Orai',161),(940,' Konch',161),(941,' Jhansi',162),(942,' Moth',162),(943,' Garautha',162),(944,' Tahrauli **',162),(945,' Mauranipur',162),(946,' Jhansi',162),(947,' Lalitpur',163),(948,' Talbehat',163),(949,' Lalitpur ',163),(950,' Mahroni',163),(951,' Hamirpur',164),(952,' Hamirpur',164),(953,' Rath',164),(954,' Maudaha',164),(955,' Mahoba *',165),(956,' Kulpahar',165),(957,' Charkhari',165),(958,' Mahoba ',165),(959,' Banda',166),(960,' Banda',166),(961,' Baberu',166),(962,' Atarra ',166),(963,' Naraini',166),(964,' Chitrakoot *',167),(965,' Karwi',167),(966,' Mau',167),(967,' Fatehpur',168),(968,' Bindki',168),(969,' Fatehpur',168),(970,' Khaga ',168),(971,' Pratapgarh',169),(972,' Lalganj Ajhara ',169),(973,' Kunda',169),(974,' Pratapgarh',169),(975,' Patti',169),(976,' Kaushambi *',170),(977,' Sirathu',170),(978,' Manjhanpur ',170),(979,' Chail',170),(980,' Allahabad ',171),(981,' Soraon',171),(982,' Phulpur ',171),(983,' Allahabad **',171),(984,' Bara  ',171),(985,' Karchhana ',171),(986,' Handia',171),(987,' Meja',171),(988,' Koraon **',171),(989,' Barabanki',172),(990,' Fatehpur',172),(991,' Ramnagar ',172),(992,' Nawabganj ',172),(993,' Sirauli Gauspur**',172),(994,' Ramsanehighat',172),(995,' Haidergarh',172),(996,' Faizabad',173),(997,' Rudauli',173),(998,' Milkipur **',173),(999,' Sohawal **',173),(1000,' Faizabad',173),(1001,' Bikapur',173),(1002,' Ambedkar Nagar *',174),(1003,' Tanda',174),(1004,' Allapur **',174),(1005,' Jalalpur ',174),(1006,' Akbarpur',174),(1007,' Sultanpur',175),(1008,' Musafirkhana ',175),(1009,' Gauriganj',175),(1010,' Amethi ',175),(1011,' Sultanpur',175),(1012,' Lambhuwa **',175),(1013,' Kadipur ',175),(1014,' Bahraich',176),(1015,' Nanpara ',176),(1016,' Mahasi **',176),(1017,' Bahraich',176),(1018,' Kaiserganj',176),(1019,' Shrawasti *',177),(1020,' Bhinga',177),(1021,' Ikauna **',177),(1022,' Payagpur **',177),(1023,' Balrampur *',178),(1024,' Balrampur',178),(1025,' Tulsipur',178),(1026,' Utraula',178),(1027,' Gonda',179),(1028,' Gonda ',179),(1029,' Colonelganj ',179),(1030,' Tarabganj',179),(1031,' Mankapur ',179),(1032,' Siddharthnagar',180),(1033,' Shohratgarh **',180),(1034,' Naugarh',180),(1035,' Bansi',180),(1036,' Itwa',180),(1037,' Domariyaganj',180),(1038,' Basti',181),(1039,' Bhanpur',181),(1040,' Harraiya',181),(1041,' Basti',181),(1042,' Sant Kabir Nagar *',182),(1043,' Mehdawal **',182),(1044,' Khalilabad',182),(1045,' Ghanghata **',182),(1046,' Maharajganj',183),(1047,' Nautanwa',183),(1048,' Nichlaul',183),(1049,' Pharenda',183),(1050,' Maharajganj',183),(1051,' Gorakhpur',184),(1052,' Campierganj **',184),(1053,' Sahjanwa',184),(1054,' Gorakhpur',184),(1055,' Chauri Chaura',184),(1056,' Bansgaon',184),(1057,' Khajani',184),(1058,' Gola ',184),(1059,' Kushinagar *',185),(1060,' Padrauna',185),(1061,' Hata',185),(1062,' Kasya **',185),(1063,' Tamkuhi Raj',185),(1064,' Deoria',186),(1065,' Deoria',186),(1066,' Rudrapur',186),(1067,' Barhaj **',186),(1068,' Salempur',186),(1069,' Bhatpar Rani **',186),(1070,' Azamgarh',187),(1071,' Burhanpur',187),(1072,' Sagri',187),(1073,' Azamgarh ',187),(1074,' Nizamabad **',187),(1075,' Phulpur ',187),(1076,' Lalganj',187),(1077,' Mehnagar **',187),(1078,' Mau',188),(1079,' Ghosi',188),(1080,' Madhuban **',188),(1081,' Maunath Bhanjan',188),(1082,' Muhammadabad Gohna',188),(1083,' Ballia',189),(1084,' Belthara Road **',189),(1085,' Sikanderpur **',189),(1086,' Rasra',189),(1087,' Ballia',189),(1088,' Bansdih',189),(1089,' Bairia',189),(1090,' Jaunpur',190),(1091,' Shahganj',190),(1092,' Badlapur',190),(1093,' Machhlishahr',190),(1094,' Jaunpur ',190),(1095,' Mariahu ',190),(1096,' Kerakat',190),(1097,' Ghazipur',191),(1098,' Jakhanian **',191),(1099,' Saidpur',191),(1100,' Ghazipur',191),(1101,' Mohammadabad ',191),(1102,' Zamania',191),(1103,' Chandauli *',192),(1104,' Sakaldiha',192),(1105,' Chandauli',192),(1106,' Chakia',192),(1107,' Varanasi',193),(1108,' Pindra **',193),(1109,' Varanasi',193),(1110,' Sant Ravidas Nagar *',194),(1111,' Bhadohi',194),(1112,' Gyanpur',194),(1113,' Mirzapur',195),(1114,' Mirzapur',195),(1115,' Lalganj',195),(1116,' Marihan',195),(1117,' Chunar',195),(1118,' Sonbhadra',196),(1119,' Ghorawal **',196),(1120,' Robertsganj',196),(1121,' Dudhi',196),(1122,' BIHAR',197),(1123,' Pashchim Champaran',198),(1124,' Sidhaw',198),(1125,' Ramnagar',198),(1126,' Gaunaha',198),(1127,' Mainatanr',198),(1128,' Narkatiaganj',198),(1129,' Lauria',198),(1130,' Bagaha',198),(1131,' Piprasi',198),(1132,' Madhubani',198),(1133,' Bhitaha',198),(1134,' Thakrahan',198),(1135,' Jogapatti',198),(1136,' Chanpatia',198),(1137,' Sikta',198),(1138,' Majhaulia',198),(1139,' Bettiah',198),(1140,' Bairia',198),(1141,' Nautan',198),(1142,' Purba Champaran',199),(1143,' Raxaul',199),(1144,' Adapur',199),(1145,' Ramgarhwa',199),(1146,' Sugauli',199),(1147,' Banjaria',199),(1148,' Narkatia',199),(1149,' Bankatwa',199),(1150,' Ghorasahan',199),(1151,' Dhaka',199),(1152,' Chiraia',199),(1153,' Motihari',199),(1154,' Turkaulia',199),(1155,' Harsidhi',199),(1156,' Paharpur',199),(1157,' Areraj',199),(1158,' Sangrampur',199),(1159,' Kesaria',199),(1160,' Kalyanpur',199),(1161,' Kotwa',199),(1162,' Piprakothi',199),(1163,' Chakia(Pipra)',199),(1164,' Pakri Dayal',199),(1165,' Patahi',199),(1166,' Phenhara',199),(1167,' Madhuban',199),(1168,' Tetaria',199),(1169,' Mehsi',199),(1170,' Sheohar *',200),(1171,' Purnahiya',200),(1172,' Piprarhi',200),(1173,' Sheohar',200),(1174,' Dumri Katsari',200),(1175,' Tariani Chowk',200),(1176,' Sitamarhi',201),(1177,' Bairgania',201),(1178,' Suppi',201),(1179,' Majorganj',201),(1180,' Sonbarsa',201),(1181,' Parihar',201),(1182,' Sursand',201),(1183,' Bathnaha',201),(1184,' Riga',201),(1185,' Parsauni',201),(1186,' Belsand',201),(1187,' Runisaidpur',201),(1188,' Dumra',201),(1189,' Bajpatti',201),(1190,' Charaut',201),(1191,' Pupri',201),(1192,' Nanpur',201),(1193,' Bokhara',201),(1194,' Madhubani',202),(1195,' Madhwapur',202),(1196,' Harlakhi',202),(1197,' Basopatti',202),(1198,' Jainagar',202),(1199,' Ladania',202),(1200,' Laukaha',202),(1201,' Laukahi',202),(1202,' Phulparas',202),(1203,' Babubarhi',202),(1204,' Khajauli',202),(1205,' Kaluahi',202),(1206,' Benipatti',202),(1207,' Bisfi',202),(1208,' Madhubani',202),(1209,' Pandaul',202),(1210,' Rajnagar',202),(1211,' Andhratharhi',202),(1212,' Jhanjharpur',202),(1213,' Ghoghardiha',202),(1214,' Lakhnaur',202),(1215,' Madhepur',202),(1216,' Supaul *',203),(1217,' Nirmali',203),(1218,' Basantpur',203),(1219,' Chhatapur',203),(1220,' Pratapganj',203),(1221,' Raghopur',203),(1222,' Saraigarh Bhaptiyahi',203),(1223,' Kishanpur',203),(1224,' Marauna',203),(1225,' Supaul',203),(1226,' Pipra',203),(1227,' Tribeniganj',203),(1228,' Araria',204),(1229,' Narpatganj',204),(1230,' Forbesganj',204),(1231,' Bhargama',204),(1232,' Raniganj',204),(1233,' Araria',204),(1234,' Kursakatta',204),(1235,' Sikti',204),(1236,' Palasi',204),(1237,' Jokihat',204),(1238,' Kishanganj',205),(1239,' Terhagachh',205),(1240,' Dighalbank',205),(1241,' Thakurganj',205),(1242,' Pothia',205),(1243,' Bahadurganj',205),(1244,' Kochadhamin',205),(1245,' Kishanganj',205),(1246,' Purnia',206),(1247,' Banmankhi',206),(1248,' Barhara',206),(1249,' Bhawanipur',206),(1250,' Rupauli',206),(1251,' Dhamdaha',206),(1252,' Krityanand Nagar',206),(1253,' Purnia East',206),(1254,' Kasba',206),(1255,' Srinagar',206),(1256,' Jalalgarh',206),(1257,' Amour',206),(1258,' Baisa',206),(1259,' Baisi',206),(1260,' Dagarua',206),(1261,' Katihar',207),(1262,' Falka',207),(1263,' Korha',207),(1264,' Hasanganj',207),(1265,' Kadwa',207),(1266,' Balrampur',207),(1267,' Barsoi',207),(1268,' Azamnagar',207),(1269,' Pranpur',207),(1270,' Dandkhora',207),(1271,' katihar',207),(1272,' Mansahi',207),(1273,' Barari',207),(1274,' Sameli',207),(1275,' Kursela',207),(1276,' Manihari',207),(1277,' Amdabad',207),(1278,' Madhepura',208),(1279,' Gamharia',208),(1280,' Singheshwar',208),(1281,' Ghailarh',208),(1282,' Madhepura',208),(1283,' Shankarpur',208),(1284,' Kumarkhand',208),(1285,' Murliganj',208),(1286,' Gwalpara',208),(1287,' Bihariganj',208),(1288,' Kishanganj',208),(1289,' Puraini',208),(1290,' Alamnagar',208),(1291,' Chausa',208),(1292,' Saharsa',209),(1293,' Nauhatta',209),(1294,' Satar Kataiya',209),(1295,' Mahishi',209),(1296,' Kahara',209),(1297,' Saur Bazar',209),(1298,' Patarghat',209),(1299,' Sonbarsa',209),(1300,' Simri Bakhtiarpur',209),(1301,' Salkhua',209),(1302,' Banma Itarhi',209),(1303,' Darbhanga',210),(1304,' Jale',210),(1305,' Singhwara',210),(1306,' Keotiranway',210),(1307,' Darbhanga',210),(1308,' Manigachhi',210),(1309,' Tardih',210),(1310,' Alinagar',210),(1311,' Benipur',210),(1312,' Bahadurpur',210),(1313,' Hanumannagar',210),(1314,' Hayaghat',210),(1315,' Baheri',210),(1316,' Biraul',210),(1317,' Ghanshyampur',210),(1318,' Kiratpur',210),(1319,' Gora Bauram',210),(1320,' Kusheshwar Asthan',210),(1321,' Kusheshwar Asthan Purbi',210),(1322,' Muzaffarpur',211),(1323,' Sahebganj',211),(1324,' Baruraj (Motipur)',211),(1325,' Paroo',211),(1326,' Saraiya',211),(1327,' Marwan',211),(1328,' Kanti',211),(1329,' Minapur',211),(1330,' Bochaha',211),(1331,' Aurai',211),(1332,' Katra',211),(1333,' Gaighat',211),(1334,' Bandra',211),(1335,' Dholi (Moraul)',211),(1336,' Musahari',211),(1337,' Kurhani',211),(1338,' Sakra',211),(1339,' Gopalganj',212),(1340,' Kataiya',212),(1341,' Bijaipur',212),(1342,' Bhorey',212),(1343,' Pachdeori',212),(1344,' Kuchaikote',212),(1345,' phulwaria',212),(1346,' Hathua',212),(1347,' Uchkagaon',212),(1348,' Thawe',212),(1349,' Gopalganj',212),(1350,' Manjha',212),(1351,' Barauli',212),(1352,' Sidhwalia',212),(1353,' Baikunthpur',212),(1354,' Siwan',213),(1355,' Nautan',213),(1356,' Siwan',213),(1357,' Barharia',213),(1358,' Goriakothi',213),(1359,' Lakri Nabiganj',213),(1360,' Basantpur',213),(1361,' Bhagwanpur Hat',213),(1362,' Maharajganj',213),(1363,' Pachrukhi',213),(1364,' Hussainganj',213),(1365,' Ziradei',213),(1366,' Mairwa',213),(1367,' Guthani',213),(1368,' Darauli',213),(1369,' Andar',213),(1370,' Raghunathpur',213),(1371,' Hasanpura',213),(1372,' Daraundha',213),(1373,' Siswan',213),(1374,' Saran',214),(1375,' Mashrakh',214),(1376,' Panapur',214),(1377,' Taraiya',214),(1378,' Ishupur',214),(1379,' Baniapur',214),(1380,' Lahladpur',214),(1381,' Ekma',214),(1382,' Manjhi',214),(1383,' Jalalpur',214),(1384,' Revelganj',214),(1385,' Chapra',214),(1386,' Nagra',214),(1387,' Marhaura',214),(1388,' Amnour',214),(1389,' Maker',214),(1390,' Parsa',214),(1391,' Dariapur',214),(1392,' Garkha',214),(1393,' Dighwara',214),(1394,' Sonepur',214),(1395,' Vaishali',215),(1396,' Vaishali',215),(1397,' Paterhi Belsar',215),(1398,' Lalganj',215),(1399,' Bhagwanpur',215),(1400,' Goraul',215),(1401,' Chehra Kalan',215),(1402,' Patepur',215),(1403,' Mahua',215),(1404,' Jandaha',215),(1405,' Raja Pakar',215),(1406,' Hajipur',215),(1407,' Raghopur',215),(1408,' Bidupur',215),(1409,' Desri',215),(1410,' Sahdai Buzurg',215),(1411,' Mahnar',215),(1412,' Samastipur',216),(1413,' Kalyanpur',216),(1414,' Warisnagar',216),(1415,' Shivaji Nagar',216),(1416,' Khanpur',216),(1417,' Samastipur',216),(1418,' Pusa',216),(1419,' Tajpur',216),(1420,' Morwa',216),(1421,' Patori',216),(1422,' Mohanpur',216),(1423,' Mohiuddinagar',216),(1424,' Sarairanjan',216),(1425,' Vidyapati Nagar',216),(1426,' Dalsinghsarai',216),(1427,' Ujiarpur',216),(1428,' Bibhutpur',216),(1429,' Rosera',216),(1430,' Singhia',216),(1431,' Hasanpur',216),(1432,' Bithan',216),(1433,' Begusarai',217),(1434,' Khudabandpur',217),(1435,' Chorahi',217),(1436,' Garhpura',217),(1437,' Cheria Bariarpur',217),(1438,' Bhagwanpur',217),(1439,' Mansurchak',217),(1440,' Bachhwara',217),(1441,' Teghra',217),(1442,' Barauni',217),(1443,' Birpur',217),(1444,' Begusarai',217),(1445,' Naokothi',217),(1446,' Bakhri',217),(1447,' Dandari',217),(1448,' Sahebpur Kamal',217),(1449,' Balia',217),(1450,' Matihani',217),(1451,' Shamho Akha Kurha',217),(1452,' Khagaria',218),(1453,' Alauli',218),(1454,' Khagaria',218),(1455,' Mansi',218),(1456,' Chautham',218),(1457,' Beldaur',218),(1458,' Gogari',218),(1459,' Parbatta',218),(1460,' Bhagalpur',219),(1461,' Narayanpur',219),(1462,' Bihpur',219),(1463,' Kharik',219),(1464,' Naugachhia',219),(1465,' Rangra Chowk',219),(1466,' Gopalpur',219),(1467,' Pirpainti',219),(1468,' Colgong',219),(1469,' Ismailpur',219),(1470,' Sabour',219),(1471,' Nathnagar',219),(1472,' Sultanganj',219),(1473,' Shahkund',219),(1474,' Goradih',219),(1475,' Jagdishpur',219),(1476,' Sonhaula',219),(1477,' Banka *',220),(1478,' Shambhuganj',220),(1479,' Amarpur',220),(1480,' Rajaun',220),(1481,' Dhuraiya',220),(1482,' Barahat',220),(1483,' Banka',220),(1484,' Phulidumar',220),(1485,' Belhar',220),(1486,' Chanan',220),(1487,' Katoria',220),(1488,' Bausi',220),(1489,' Munger',221),(1490,' Munger',221),(1491,' Bariyarpur',221),(1492,' Jamalpur',221),(1493,' Dharhara',221),(1494,' Kharagpur',221),(1495,' Asarganj',221),(1496,' Tarapur',221),(1497,' Tetiha Bambor',221),(1498,' Sangrampur',221),(1499,' Lakhisarai *',222),(1500,' Barahiya',222),(1501,' Pipariya',222),(1502,' Surajgarha',222),(1503,' Lakhisarai',222),(1504,' Ramgarh Chowk',222),(1505,' Halsi',222),(1506,' Sheikhpura *',223),(1507,' Barbigha',223),(1508,' Shekhopur Sarai',223),(1509,' Sheikhpura',223),(1510,' Ghat Kusmha',223),(1511,' Chewara',223),(1512,' Ariari',223),(1513,' Nalanda',224),(1514,' Karai Parsurai',224),(1515,' Nagar Nausa',224),(1516,' Harnaut',224),(1517,' Chandi',224),(1518,' Rahui',224),(1519,' Bind',224),(1520,' Sarmera',224),(1521,' Asthawan ',224),(1522,' Bihar',224),(1523,' Noorsarai',224),(1524,' Tharthari ',224),(1525,' Parbalpur',224),(1526,' Hilsa',224),(1527,' Ekangarsarai',224),(1528,' Islampur',224),(1529,' Ben',224),(1530,' Rajgir',224),(1531,' Silao',224),(1532,' Giriak',224),(1533,' Katrisarai',224),(1534,' Patna',225),(1535,' Maner',225),(1536,' Dinapur-Cum-Khagaul',225),(1537,' Patna Rural (a) Patna Rural (b)',225),(1538,' Sampatchak',225),(1539,' Phulwari',225),(1540,' Bihta',225),(1541,' Naubatpur',225),(1542,' Bikram',225),(1543,' Dulhin Bazar',225),(1544,' Paliganj',225),(1545,' Masaurhi ',225),(1546,' Dhanarua',225),(1547,' Punpun',225),(1548,' Fatwah',225),(1549,' Daniawan ',225),(1550,' Khusrupur',225),(1551,' Bakhtiarpur',225),(1552,' Athmalgola',225),(1553,' Belchhi',225),(1554,' Barh',225),(1555,' Pandarak',225),(1556,' Ghoswari',225),(1557,' Mokameh',225),(1558,' Bhojpur',226),(1559,' Shahpur',226),(1560,' Arrah',226),(1561,' Barhara',226),(1562,' Koilwar',226),(1563,' Sandesh',226),(1564,' Udwant Nagar',226),(1565,' Behea',226),(1566,' Jagdishpur',226),(1567,' Piro',226),(1568,' Charpokhri',226),(1569,' Garhani',226),(1570,' Agiaon',226),(1571,' Tarari',226),(1572,' Sahar',226),(1573,' Buxar *',227),(1574,' Simri',227),(1575,' Chakki',227),(1576,' Barhampur',227),(1577,' Chaugain',227),(1578,' Kesath ',227),(1579,' Dumraon ',227),(1580,' Buxar',227),(1581,' Chausa',227),(1582,' Rajpur',227),(1583,' Itarhi',227),(1584,' Nawanagar',227),(1585,' Kaimur (Bhabua) *',228),(1586,' Ramgarh',228),(1587,' Noawan',228),(1588,' Kudra',228),(1589,' Mohania',228),(1590,' Durgawati',228),(1591,' Chand',228),(1592,' Chainpur',228),(1593,' Bhabua',228),(1594,' Rampur',228),(1595,' Bhagwanpur',228),(1596,' Adhaura',228),(1597,' Rohtas',229),(1598,' Kochas',229),(1599,' Dinara',229),(1600,' Dawath',229),(1601,' Suryapura',229),(1602,' Bikramganj',229),(1603,' Karakat',229),(1604,' Nasriganj',229),(1605,' Rajpur',229),(1606,' Sanjhauli',229),(1607,' Nokha',229),(1608,' Kargahar',229),(1609,' Chenari',229),(1610,' Nauhatta',229),(1611,' Sheosagar',229),(1612,' Sasaram',229),(1613,' Akorhi Gola',229),(1614,' Dehri',229),(1615,' Tilouthu',229),(1616,' Rohtas',229),(1617,' Jehanabad ',230),(1618,' Arwal',230),(1619,' Kaler',230),(1620,' Karpi',230),(1621,' Sonbhadra Banshi',230),(1622,' Suryapur Kurtha',230),(1623,' Ratni Faridpur',230),(1624,' Jehanabad',230),(1625,' Kako',230),(1626,' Modanganj',230),(1627,' Ghoshi',230),(1628,' Makhdumpur',230),(1629,' Hulasganj',230),(1630,' Aurangabad',231),(1631,' Daudnagar',231),(1632,' Haspura',231),(1633,' Goh',231),(1634,' Rafiganj',231),(1635,' Obra',231),(1636,' Aurangabad',231),(1637,' Barun',231),(1638,' Nabinagar',231),(1639,' Kutumba',231),(1640,' Deo',231),(1641,' Madanpur',231),(1642,' Gaya',232),(1643,' Konch',232),(1644,' Tikari ',232),(1645,' Belaganj',232),(1646,' Khizirsarai',232),(1647,' Neem Chak Bathani',232),(1648,' Muhra',232),(1649,' Atri',232),(1650,' Manpur',232),(1651,' Gaya',232),(1652,' Paraiya',232),(1653,' Guraru',232),(1654,' Gurua',232),(1655,' Amas',232),(1656,' Banke Bazar',232),(1657,' Imamganj',232),(1658,' Dumaria',232),(1659,' Sherghati',232),(1660,' Dobhi',232),(1661,' Bodh Gaya',232),(1662,' Tan Kuppa',232),(1663,' Wazirganj',232),(1664,' Fatehpur',232),(1665,' Mohanpur',232),(1666,' Barachatti',232),(1667,' Nawada',233),(1668,' Nardiganj',233),(1669,' Nawada',233),(1670,' Warisaliganj',233),(1671,' Kashi Chak',233),(1672,' Pakribarawan',233),(1673,' Kawakol',233),(1674,' Roh',233),(1675,' Govindpur',233),(1676,' Akbarpur',233),(1677,' Hisua',233),(1678,' Narhat',233),(1679,' Meskaur',233),(1680,' Sirdala',233),(1681,' Rajauli',233),(1682,' Jamui *',234),(1683,' Islamnagar Aliganj',234),(1684,' Sikandra',234),(1685,' Jamui',234),(1686,' Barhat',234),(1687,' Lakshmipur',234),(1688,' Jhajha',234),(1689,' Gidhaur',234),(1690,' Khaira',234),(1691,' Sono',234),(1692,' Chakai',234),(1693,' SIKKIM',235),(1694,' North ',236),(1695,' Chungthang',236),(1696,' Mangan',236),(1697,' West',237),(1698,' Gyalshing',237),(1699,' Soreng',237),(1700,' South',238),(1701,' Namchi',238),(1702,' Ravong',238),(1703,' East',239),(1704,' Gangtok',239),(1705,' Pakyong',239),(1706,' Rongli',239),(1707,' ARUNACHAL PRADESH',240),(1708,' Tawang',241),(1709,' Zemithang Circle',241),(1710,' Lumla Circle',241),(1711,' Dudunghar Circle',241),(1712,' Tawang Circle',241),(1713,' Jang Circle',241),(1714,' Mukto Circle',241),(1715,' Thingbu Circle',241),(1716,' West Kameng',242),(1717,' Dirang Circle',242),(1718,' Nafra Circle',242),(1719,' Bomdila Circle',242),(1720,' Kalaktang Circle',242),(1721,' Rupa Circle',242),(1722,' Singchung Circle',242),(1723,' Jamiri Circle',242),(1724,' Thrizino Circle',242),(1725,' Bhalukpong Circle',242),(1726,' Balemu Circle',242),(1727,' East Kameng',243),(1728,' Seijosa Circle',243),(1729,' Pakke Kessang Circle',243),(1730,' Richukrong Circle',243),(1731,' Seppa Circle',243),(1732,' Lada Circle',243),(1733,' Bameng Circle',243),(1734,' Pipu Circle',243),(1735,' Khenewa Circle',243),(1736,' Chayangtajo Circle',243),(1737,' Sawa Circle',243),(1738,' Papum Pare *',244),(1739,' Balijan Circle',244),(1740,' Itanagar Circle',244),(1741,' Naharlagun Circle',244),(1742,' Doimukh Circle',244),(1743,' Toru Circle',244),(1744,' Sagalee Circle',244),(1745,' Leporiang Circle',244),(1746,' Mengio Circle',244),(1747,' Kimin Circle',244),(1748,' Lower Subansiri',245),(1749,' Ziro Circle',245),(1750,' Yachuli Circle',245),(1751,' Pistana Circle',245),(1752,' Palin Circle',245),(1753,' Yangte Circle',245),(1754,' Sangram Circle',245),(1755,' Nyapin Circle',245),(1756,' Koloriang Circle',245),(1757,' Chambang Circle',245),(1758,' Sarli Circle',245),(1759,' Parsi-Parlo Circle',245),(1760,' Damin Circle',245),(1761,' Longding Koling Circle',245),(1762,' Tali Circle',245),(1763,' Kamporijo Circle',245),(1764,' Dollungmukh Circle',245),(1765,' Raga Circle',245),(1766,' Upper Subansiri',246),(1767,' Taksing Circle',246),(1768,' Limeking Circle',246),(1769,' Nacho Circle',246),(1770,' Siyum Circle',246),(1771,' Taliha Circle',246),(1772,' Payeng Circle',246),(1773,' Giba Circle',246),(1774,' Daporijo Circle',246),(1775,' Puchi Geko Circle',246),(1776,' Dumporijo Circle',246),(1777,' Baririjo Circle',246),(1778,' West Siang',247),(1779,' Mechuka Circle',247),(1780,' Monigong Circle',247),(1781,' Pidi Circle',247),(1782,' Payum Circle',247),(1783,' Tato Circle',247),(1784,' Kaying Circle',247),(1785,' Darak Circle',247),(1786,' Kamba Circle',247),(1787,' Rumgong Circle',247),(1788,' Jomlo Mobuk Circle',247),(1789,' Liromoba Circle',247),(1790,' Yomcha Circle',247),(1791,' Along Circle',247),(1792,' Tirbin Circle',247),(1793,' Basar Circle',247),(1794,' Daring Circle',247),(1795,' Gensi Circle',247),(1796,' Likabali Circle',247),(1797,' Kangku Circle',247),(1798,' Bagra Circle',247),(1799,' East Siang',248),(1800,' Boleng Circle',248),(1801,' Riga Circle',248),(1802,' Pangin Circle',248),(1803,' Rebo-Perging Circle',248),(1804,' Koyu Circle',248),(1805,' Nari Circle',248),(1806,' New Seren Circle',248),(1807,' Bilat Circle',248),(1808,' Ruksin Circle',248),(1809,' Sille-Oyan Circle',248),(1810,' Pasighat Circle',248),(1811,' Mebo Circle',248),(1812,' Upper Siang *',249),(1813,' Tuting Circle',249),(1814,' Migging Circle',249),(1815,' Palling Circle',249),(1816,' Gelling Circle',249),(1817,' Singa Circle',249),(1818,' Yingwong Circle',249),(1819,' Jengging Circle',249),(1820,' Geku Circle',249),(1821,' Mariyang Circle',249),(1822,' Katan Circle ',249),(1823,' Dibang Valley',250),(1824,' Mipi Circle',250),(1825,' Anini Circle ',250),(1826,' Etalin Circle',250),(1827,' Anelih Circle',250),(1828,' Koronli Circle',250),(1829,' Hunli Circle',250),(1830,' Desali Circle',250),(1831,' Roing Circle',250),(1832,' Dambuk Circle',250),(1833,' Koronu Circle',250),(1834,' Lohit',251),(1835,' Sunpura Circle',251),(1836,' Tezu Circle',251),(1837,' Hayuliang Circle',251),(1838,' Manchal Circle',251),(1839,' Goiliang Circle',251),(1840,' Chaglagam Circle',251),(1841,' Kibithoo Circle',251),(1842,' Walong Circle',251),(1843,' Hawai Circle',251),(1844,' Wakro Circle',251),(1845,' Chowkham Circle',251),(1846,' Namsai Circle',251),(1847,' Piyong Circle',251),(1848,' Mahadevpur Circle',251),(1849,' Changlang',252),(1850,' Khimiyong Circle',252),(1851,' Changlang Circle',252),(1852,' Namtok Circle',252),(1853,' Manmao Circle',252),(1854,' Nampong Circle',252),(1855,' Jairampur Circle',252),(1856,' Vijoynagar Circle',252),(1857,' Miao Circle',252),(1858,' Kharsang Circle',252),(1859,' Diyun Circle',252),(1860,' Bordumsa Circle',252),(1861,' Tirap',253),(1862,' Namsang Circle',253),(1863,' Khonsa Circle',253),(1864,' Kanubari Circle',253),(1865,' Longding Circle',253),(1866,' Pumao Circle',253),(1867,' Pangchao Circle',253),(1868,' Wakka Circle',253),(1869,' Laju Circle',253),(1870,' NAGALAND',254),(1871,' Mon',255),(1872,' Naginimora',255),(1873,' Tizit',255),(1874,' Hunta',255),(1875,' Shangyu',255),(1876,' Mon Sadar',255),(1877,' Wakching',255),(1878,' Aboi',255),(1879,' Longshen',255),(1880,' Phomching',255),(1881,' Chen',255),(1882,' Longching',255),(1883,' Mopong',255),(1884,' Tobu',255),(1885,' Monyakshu',255),(1886,' Tuensang',256),(1887,' Tamlu',256),(1888,' Yongya',256),(1889,' Longleng',256),(1890,' Noksen',256),(1891,' Chare',256),(1892,' Longkhim',256),(1893,' Tuensang Sadar',256),(1894,' Noklak',256),(1895,' Panso',256),(1896,' Shamator',256),(1897,' Tsurungtho',256),(1898,' Chessore',256),(1899,' Seyochung',256),(1900,' Amahator',256),(1901,' Kiphire Sadar',256),(1902,' Thonoknyu',256),(1903,' Kiusam',256),(1904,' Sitimi',256),(1905,' Longmatra',256),(1906,' Pungro',256),(1907,' Mokokchung',257),(1908,' Longchem',257),(1909,' Alongkima',257),(1910,' Tuli',257),(1911,' Changtongya',257),(1912,' Chuchuyimlang',257),(1913,' Kubolong',257),(1914,' Mangkolemba',257),(1915,' Ongpangkong',257),(1916,' Zunheboto',258),(1917,' V.K.',258),(1918,' Akuluto',258),(1919,' Suruhoto',258),(1920,' Asuto',258),(1921,' Aghunato',258),(1922,' Zunheboto Sadar',258),(1923,' Atoizu',258),(1924,' Pughoboto',258),(1925,' Ghatashi',258),(1926,' Satakha',258),(1927,' Satoi',258),(1928,' Wokha',259),(1929,' Changpang',259),(1930,' Aitepyong',259),(1931,' Bhandari',259),(1932,' Baghty',259),(1933,' Sungro',259),(1934,' Sanis',259),(1935,' Lotsu',259),(1936,' Ralan',259),(1937,' Wozhuro',259),(1938,' Wokha Sadar',259),(1939,' Chukitong',259),(1940,' Dimapur *',260),(1941,' Niuland',260),(1942,' Kuhoboto',260),(1943,' Nihokhu',260),(1944,' Dimapur Sadar',260),(1945,' Chumukedima',260),(1946,' Dhansiripar',260),(1947,' Medziphema',260),(1948,' Kohima',261),(1949,' Tseminyu',261),(1950,' Chiephobozou',261),(1951,' Kezocha',261),(1952,' Jakhama',261),(1953,' Kohima Sadar',261),(1954,' Sechu',261),(1955,' Ngwalwa',261),(1956,' Jalukie',261),(1957,' Athibung',261),(1958,' Nsong',261),(1959,' Tening',261),(1960,' Peren',261),(1961,' Phek',262),(1962,' Sekruzu',262),(1963,' Phek Sadar',262),(1964,' Meluri',262),(1965,' Phokhungri',262),(1966,' Chazouba',262),(1967,' Chetheba',262),(1968,' Sakraba',262),(1969,' Pfutsero',262),(1970,' Khezhakeno',262),(1971,' Chizami',262),(1972,' MANIPUR',263),(1973,' Senapati',264),(1974,' Mao-Maram Sub-Division',264),(1975,' Paomata Sub-Division',264),(1976,' Purul Sub-Division',264),(1977,' Sadar Hills West Sub-Division',264),(1978,' Saitu Gamphazol Sub-Division ',264),(1979,' Sadar Hills East Sub-Division',264),(1980,' Tamenglong',265),(1981,' Tamenglong West Sub-Division',265),(1982,' Tamenglong North Sub-Division',265),(1983,' Tamenglong Sub-Division ',265),(1984,' Nungba Sub-Division',265),(1985,' Churachandpur',266),(1986,' Tipaimukh Sub-Division',266),(1987,' Thanlon Sub-Division',266),(1988,' Churachandpur North Sub-Div.',266),(1989,' Churachandpur  Sub-Division',266),(1990,' Singngat Sub-Division ',266),(1991,' Bishnupur',267),(1992,' Nambol Sub-Division',267),(1993,' Bishnupur Sub-Division',267),(1994,' Moirang Sub-Division ',267),(1995,' Thoubal',268),(1996,' Lilong Sub-Division',268),(1997,' Thoubal Sub-Division',268),(1998,' Kakching Sub-Div.',268),(1999,' Imphal West',269),(2000,' Lamshang Sub-Division ',269),(2001,' Patsoi Sub-Division',269),(2002,' Lamphelpat Sub-Division',269),(2003,' Wangoi Sub-Division',269),(2004,' Imphal East *',270),(2005,' Jiribam  Sub-Division',270),(2006,' Sawombung Sub-Division',270),(2007,' Porompat Sub-Division',270),(2008,' Keirao Bitra Sub-Division',270),(2009,' Ukhrul',271),(2010,' Ukhrul North  Sub-Division',271),(2011,' Ukhrul Central Sub-Division',271),(2012,' Kamjong Chassad Sub-Div.',271),(2013,' Phungyar Phaisat Sub-Division',271),(2014,' Ukhrul South Sub-Division',271),(2015,' Chandel',272),(2016,' Machi  Sub-Division',272),(2017,' Tengnoupal Sub-Division',272),(2018,' Chandel Sub-Div.',272),(2019,' Chakpikarong Sub-Division',272),(2020,' MIZORAM',273),(2021,' Mamit *',274),(2022,' Zawlnuam',274),(2023,' West Phaileng',274),(2024,' Reiek',274),(2025,' Kolasib *',275),(2026,' North Thingdawl',275),(2027,' Aizawl',276),(2028,' Darlawn',276),(2029,' Phullen',276),(2030,' Thingsulthliah',276),(2031,' Tlangnuam',276),(2032,' Aibawk',276),(2033,' Champhai *',277),(2034,' Ngopa',277),(2035,' Khawzawl',277),(2036,' Khawbung',277),(2037,' Serchhip *',278),(2038,' Serchhip',278),(2039,' East Lungdar',278),(2040,' Lunglei',279),(2041,' West Bunghmun',279),(2042,' Lungsen',279),(2043,' Lunglei',279),(2044,' Hnahthial',279),(2045,' Lawngtlai',280),(2046,' Chawngte',280),(2047,' Lawngtlai',280),(2048,' Saiha *',281),(2049,' Sangau',281),(2050,' Tuipang',281),(2051,' TRIPURA',282),(2052,' West Tripura ',283),(2053,' Mohanpur',283),(2054,' Hezamara',283),(2055,' Pabmabil',283),(2056,' Khowai',283),(2057,' Tulashikhar',283),(2058,' Kalyanpur',283),(2059,' Teliamura',283),(2060,' Mandai',283),(2061,' Jirania',283),(2062,' Dukli',283),(2063,' Jampuijala',283),(2064,' Bishalgarh',283),(2065,' Boxanagar',283),(2066,' Melaghar',283),(2067,' Kathalia',283),(2068,' South Tripura ',284),(2069,' Killa',284),(2070,' Amarpur',284),(2071,' Matarbari',284),(2072,' Kakraban',284),(2073,' Rajnagar',284),(2074,' Hrishyamukh',284),(2075,' Bagafa',284),(2076,' Karbuk',284),(2077,' Rupaichhari',284),(2078,' Satchand',284),(2079,' Dhalai  *',285),(2080,' Salema',285),(2081,' Manu',285),(2082,' Ambassa',285),(2083,' Chhamanu',285),(2084,' Dumburnagar',285),(2085,' North Tripura ',286),(2086,' Gournagar',286),(2087,' Kadamtala',286),(2088,' Panisagar',286),(2089,' Damchhara',286),(2090,' Pencharthal',286),(2091,' Kumarghat',286),(2092,' Dasda',286),(2093,' Jampuii hills',286),(2094,' MEGHALAYA',287),(2095,' West Garo Hills',288),(2096,' Selsella',288),(2097,' Dadenggiri',288),(2098,' Tikrikilla',288),(2099,' Rongram',288),(2100,' Betasing',288),(2101,' Zikzak',288),(2102,' Dalu',288),(2103,' East Garo Hills',289),(2104,' Resubelpara',289),(2105,' Dambo Rongjeng',289),(2106,' Songsak',289),(2107,' Samanda',289),(2108,' South Garo Hills *',290),(2109,' Chokpot',290),(2110,' Baghmara',290),(2111,' Rongara',290),(2112,' West Khasi Hills',291),(2113,' Mawshynrut',291),(2114,' Nongstoin',291),(2115,' Mairang',291),(2116,' Ranikor',291),(2117,' Mawkyrwat',291),(2118,' Ri Bhoi  *',292),(2119,' Umling',292),(2120,' Umsning',292),(2121,' East Khasi Hills',293),(2122,' Mawphlang',293),(2123,' Mylliem',293),(2124,' Mawryngkneng',293),(2125,' Mawkynrew',293),(2126,' Mawsynram',293),(2127,' Shella Bholaganj',293),(2128,' Pynursla',293),(2129,' Jaintia Hills',294),(2130,' Thadlaskein',294),(2131,' Laskein',294),(2132,' Amlarem',294),(2133,' Khliehriat',294),(2134,' ASSAM',295),(2135,' Kokrajhar',296),(2136,' Gossaigaon',296),(2137,' Bhowraguri',296),(2138,' Dotoma',296),(2139,' Kokrajhar',296),(2140,' Sidli (PT-I)',296),(2141,' Dhubri',297),(2142,' Agamoni',297),(2143,' Golokganj',297),(2144,' Dhubri',297),(2145,' BagribariI',297),(2146,' Bilasipara',297),(2147,' Chapar',297),(2148,' South Salmara',297),(2149,' Mankachar',297),(2150,' Goalpara',298),(2151,' Lakhipur',298),(2152,' Balijana',298),(2153,' Matia',298),(2154,' Dudhnai',298),(2155,' Rangjuli',298),(2156,' Bongaigaon',299),(2157,' Sidli (PT-II)',299),(2158,' Bongaigaon',299),(2159,' Boitamari',299),(2160,' Srijangram',299),(2161,' Bijni',299),(2162,' Barpeta',300),(2163,' Barnagar',300),(2164,' Kalgachia',300),(2165,' Baghbor',300),(2166,' Barpeta',300),(2167,' Sarthebari',300),(2168,' Bajali',300),(2169,' Sarupeta',300),(2170,' Jalah',300),(2171,' Kamrup',301),(2172,' Goreswar',301),(2173,' Rangia',301),(2174,' Kamalpur ',301),(2175,' Kamalpur ',301),(2176,' Hajo',301),(2177,' Chhaygaon',301),(2178,' Chamaria',301),(2179,' Nagarbera',301),(2180,' Boko',301),(2181,' Palasbari',301),(2182,' Guwahati',301),(2183,' North Guwahati',301),(2184,' Dispur',301),(2185,' Sonapur',301),(2186,' Chandrapur',301),(2187,' Nalbari',302),(2188,' Baska',302),(2189,' Barama',302),(2190,' Tihu',302),(2191,' Pachim Nalbari',302),(2192,' Barkhetri',302),(2193,' Barbhag',302),(2194,' Nalbari',302),(2195,' Ghograpar',302),(2196,' Tamulpur',302),(2197,' Darrang',303),(2198,' Harisinga',303),(2199,' Khoirabari',303),(2200,' Pathorighat',303),(2201,' Sipajhar',303),(2202,' Mangaldoi',303),(2203,' Kalajgaon',303),(2204,' Dalgaon',303),(2205,' Dalgaon ',303),(2206,' Udalguri',303),(2207,' Majbat',303),(2208,' Marigaon',304),(2209,' Mayong',304),(2210,' Bhuragaon',304),(2211,' Laharighat',304),(2212,' Marigaon',304),(2213,' Mikirbheta',304),(2214,' Nagaon',305),(2215,' Koliabor',305),(2216,' Samaguri ',305),(2217,' Samaguri',305),(2218,' Rupahi ',305),(2219,' Rupahi ',305),(2220,' Dhing',305),(2221,' Nagaon',305),(2222,' Raha',305),(2223,' Kampur',305),(2224,' Hojai',305),(2225,' Lanka',305),(2226,' Sonitpur',306),(2227,' Dhekiajuli',306),(2228,' Chariduar',306),(2229,' Tezpur',306),(2230,' Na-Duar',306),(2231,' Biswanath',306),(2232,' Helem',306),(2233,' Gohpur',306),(2234,' Lakhimpur',307),(2235,' Narayanpur',307),(2236,' Bihpuraia',307),(2237,' Naobaicha',307),(2238,' Kadam',307),(2239,' North Lakhimpur',307),(2240,' Dhakuakhana (PT-I)',307),(2241,' Subansiri (PT-I)',307),(2242,' Dhemaji',308),(2243,' Subansiri (PT-II)',308),(2244,' Dhemaji',308),(2245,' Dhakuakhana (PT-II)',308),(2246,' Sissibargaon',308),(2247,'  Jonai ',308),(2248,' Tinsukia',309),(2249,' Sadiya',309),(2250,' Doom Dooma',309),(2251,' Tinsukia',309),(2252,' Margherita',309),(2253,' Dibrugarh',310),(2254,' Dibrugarh West',310),(2255,' Dibrugarh East',310),(2256,' Chabua',310),(2257,' Tengakhat',310),(2258,' Moran',310),(2259,' Tingkhong',310),(2260,' Naharkathiya',310),(2261,' Sibsagar',311),(2262,' Dimow',311),(2263,' Sibsagar',311),(2264,' Amguri ',311),(2265,' Amguri ',311),(2266,' Nazira ',311),(2267,' Nazira ',311),(2268,' Sonari ',311),(2269,' Sonari ',311),(2270,' Mahmora',311),(2271,' Jorhat',312),(2272,' Majuli',312),(2273,' Jorhat West',312),(2274,' Jorhat East',312),(2275,' Teok',312),(2276,' Titabar',312),(2277,' Golaghat',313),(2278,' Bokakhat',313),(2279,' Khumtai',313),(2280,' Dergaon',313),(2281,' Golaghat',313),(2282,' Sarupathar',313),(2283,' Karbi Anglong',314),(2284,' Donka',314),(2285,' Diphu ',314),(2286,' Diphu ',314),(2287,' Phuloni ',314),(2288,' Phuloni ',314),(2289,' Silonijan',314),(2290,' North Cachar Hills',315),(2291,' Umrangso',315),(2292,' Haflong',315),(2293,' Mahur',315),(2294,' Maibong',315),(2295,' Cachar',316),(2296,' Katigora',316),(2297,' Silchar',316),(2298,' Udarbond',316),(2299,' Sonai ',316),(2300,' Sonai ',316),(2301,' Lakhipur',316),(2302,' Karimganj',317),(2303,' Karimganj',317),(2304,' Badarpur',317),(2305,' Nilambazar',317),(2306,' Patharkandi',317),(2307,' Ramkrishna Nagar',317),(2308,' Hailakandi',318),(2309,' Algapur',318),(2310,' Hailakandi',318),(2311,' Lala',318),(2312,' Katlichara',318),(2313,' WEST BENGAL',319),(2314,' Darjiling ',320),(2315,' Darjeeling Pulbazar',320),(2316,' Rangli Rangliot',320),(2317,' Kalimpong -I',320),(2318,' Kalimpong - II',320),(2319,' Gorubathan',320),(2320,' Jorebunglow Sukiapokhri',320),(2321,' Mirik',320),(2322,' Kurseong',320),(2323,' Matigara ',320),(2324,' Naxalbari',320),(2325,' Phansidewa',320),(2326,' Kharibari',320),(2327,' Jalpaiguri ',321),(2328,' Rajganj',321),(2329,' Mal',321),(2330,' Matiali',321),(2331,' Nagrakata',321),(2332,' Madarihat',321),(2333,' Kalchini',321),(2334,' Kumargram',321),(2335,' Alipurduar - I',321),(2336,' Alipurduar - II',321),(2337,' Falakata',321),(2338,' Dhupguri',321),(2339,' Maynaguri',321),(2340,' Jalpaiguri',321),(2341,' Koch Bihar ',322),(2342,' Haldibari',322),(2343,' Mekliganj',322),(2344,' Mathabhanga - I',322),(2345,' Mathabhanga - II',322),(2346,' Cooch Behar - I',322),(2347,' Cooch Behar - II',322),(2348,' Tufanganj - I',322),(2349,' Tufanganj - II',322),(2350,' Dinhata - I',322),(2351,' Dinhata - II',322),(2352,' Sitai',322),(2353,' Sitalkuchi',322),(2354,' Uttar Dinajpur',323),(2355,' Chopra',323),(2356,' Islampur',323),(2357,' Goalpokhar - I',323),(2358,' Goalpokhar - II',323),(2359,' Karandighi',323),(2360,' Raiganj',323),(2361,' Hemtabad',323),(2362,' Kaliaganj',323),(2363,' Itahar',323),(2364,' Dakshin Dinajpur *',324),(2365,' Kushmundi',324),(2366,' Gangarampur',324),(2367,' Kumarganj',324),(2368,' Hilli',324),(2369,' Balurghat',324),(2370,' Tapan',324),(2371,' Bansihari',324),(2372,' Harirampur',324),(2373,' Maldah ',325),(2374,' Harishchandrapur - I',325),(2375,' Harishchandrapur - II',325),(2376,' Chanchal - I',325),(2377,' Chanchal - II',325),(2378,' Ratua - I',325),(2379,' Ratua - II',325),(2380,' Gazole',325),(2381,' Bamangola',325),(2382,' Habibpur',325),(2383,' Maldah (old)',325),(2384,' English Bazar',325),(2385,' Manikchak',325),(2386,' Kaliachak - I',325),(2387,' Kaliachak - II',325),(2388,' Kaliachak - III',325),(2389,' Murshidabad ',326),(2390,' Farakka',326),(2391,' Samserganj',326),(2392,' Suti - I',326),(2393,' Suti - II',326),(2394,' Raghunathganj - I',326),(2395,' Raghunathganj - II',326),(2396,' Lalgola',326),(2397,' Sagardighi',326),(2398,' Bhagawangola - I',326),(2399,' Bhagawangola - II',326),(2400,' Raninagar - II',326),(2401,' Jalangi',326),(2402,' Domkal',326),(2403,' Raninagar - I',326),(2404,' Murshidabad Jiaganj',326),(2405,' Nabagram',326),(2406,' Khargram',326),(2407,' Kandi',326),(2408,' Berhampore',326),(2409,' Hariharpara',326),(2410,' Nawda',326),(2411,' Beldanga - I',326),(2412,' Beldanga - II',326),(2413,' Bharatpur - II',326),(2414,' Bharatpur - I',326),(2415,' Burwan',326),(2416,' Birbhum',327),(2417,' Murarai - I',327),(2418,' Murarai - II',327),(2419,' Nalhati - I',327),(2420,' Nalhati - II',327),(2421,' Rampurhat - I',327),(2422,' Rampurhat - II',327),(2423,' Mayureswar - I',327),(2424,' Mayureswar - II',327),(2425,' Mohammad Bazar',327),(2426,' Rajnagar',327),(2427,' Suri - I',327),(2428,' Suri - II',327),(2429,' Sainthia',327),(2430,' Labpur',327),(2431,' Nanoor',327),(2432,' Bolpur Sriniketan',327),(2433,' Illambazar',327),(2434,' Dubrajpur',327),(2435,' Khoyrasol',327),(2436,' Barddhaman ',328),(2437,' Salanpur',328),(2438,' Barabani',328),(2439,' Jamuria',328),(2440,' Raniganj',328),(2441,' Ondal',328),(2442,' Pandabeswar',328),(2443,' Faridpur Durgapur',328),(2444,' Kanksa',328),(2445,' Ausgram - II',328),(2446,' Ausgram - I',328),(2447,' Mangolkote',328),(2448,' Ketugram - I',328),(2449,' Ketugram - II',328),(2450,' Katwa - I',328),(2451,' Katwa - II',328),(2452,' Purbasthali - I',328),(2453,' Purbasthali - II',328),(2454,' Manteswar',328),(2455,' Bhatar',328),(2456,' Galsi - I',328),(2457,' Galsi - II',328),(2458,' Burdwan - I',328),(2459,' Burdwan - II',328),(2460,' Memari - I',328),(2461,' Memari - II',328),(2462,' Kalna - I',328),(2463,' Kalna - II',328),(2464,' Jamalpur',328),(2465,' Raina - I',328),(2466,' Khandaghosh',328),(2467,' Raina - II',328),(2468,' Nadia ',329),(2469,' Karimpur - I',329),(2470,' Karimpur - II',329),(2471,' Tehatta - I',329),(2472,' Tehatta - II',329),(2473,' Kaliganj',329),(2474,' Nakashipara',329),(2475,' Chapra',329),(2476,' Krishnagar - II',329),(2477,'  Nabadwip',329),(2478,' Krishnagar - I',329),(2479,' Krishnaganj',329),(2480,' Hanskhali',329),(2481,' Santipur',329),(2482,' Ranaghat - I',329),(2483,' Ranaghat - II',329),(2484,' Chakdah',329),(2485,' Haringhata',329),(2486,' North Twenty Four Parganas',330),(2487,' Bagda',330),(2488,' Bongaon',330),(2489,' Gaighata',330),(2490,' Swarupnagar',330),(2491,' Habra - I',330),(2492,' Habra - II',330),(2493,' Amdanga',330),(2494,' Barrackpur - I',330),(2495,' Barrackpur - II',330),(2496,' Barasat - I',330),(2497,' Barasat - II',330),(2498,' Deganga',330),(2499,' Baduria',330),(2500,' Basirhat - I',330),(2501,' Basirhat - II',330),(2502,' Haroa',330),(2503,' Rajarhat',330),(2504,' Minakhan',330),(2505,' Sandeskhali - I',330),(2506,' Sandeskhali - II',330),(2507,' Hasnabad',330),(2508,' Hingalganj',330),(2509,' Hugli ',331),(2510,' Goghat - I',331),(2511,' Goghat - II',331),(2512,' Arambag',331),(2513,' Pursura',331),(2514,' Tarakeswar',331),(2515,' Dhaniakhali',331),(2516,' Pandua',331),(2517,' Balagarh',331),(2518,' Chinsurah - Magra',331),(2519,' Polba - Dadpur',331),(2520,' Haripal',331),(2521,' Singur',331),(2522,' Serampur Uttarpara',331),(2523,' Chanditala - I',331),(2524,' Chanditala - II',331),(2525,' Jangipara',331),(2526,' Khanakul - I',331),(2527,' Khanakul - II',331),(2528,' Bankura ',332),(2529,' Saltora',332),(2530,' Mejhia',332),(2531,' Gangajalghati',332),(2532,' Chhatna',332),(2533,' Indpur',332),(2534,' Bankura - I',332),(2535,' Bankura - II',332),(2536,' Barjora',332),(2537,' Sonamukhi',332),(2538,' Patrasayer',332),(2539,' Indus',332),(2540,' Kotulpur',332),(2541,' Jaypur',332),(2542,' Vishnupur',332),(2543,' Onda',332),(2544,' Taldangra',332),(2545,' Simlapal',332),(2546,' Khatra',332),(2547,' Hirbandh',332),(2548,' Ranibundh',332),(2549,' Raipur',332),(2550,' Sarenga',332),(2551,' Puruliya',333),(2552,' Jaipur',333),(2553,' Purulia - II',333),(2554,' Para',333),(2555,' Raghunathpur - II',333),(2556,' Raghunathpur - I',333),(2557,' Neturia',333),(2558,' Santuri',333),(2559,' Kashipur',333),(2560,' Hura',333),(2561,' Purulia - I',333),(2562,' Puncha',333),(2563,' Arsha',333),(2564,' Jhalda - I',333),(2565,' Jhalda - II',333),(2566,' Bagmundi',333),(2567,' Balarampur',333),(2568,' Barabazar',333),(2569,' Manbazar - I',333),(2570,' Manbazar - II',333),(2571,' Bundwan',333),(2572,' Medinipur ',334),(2573,' Binpur - II',334),(2574,' Binpur - I',334),(2575,' Garbeta - II',334),(2576,' Garbeta - I',334),(2577,' Garbeta - III',334),(2578,' Chandrakona - I',334),(2579,' Chandrakona - II',334),(2580,' Ghatal',334),(2581,' Daspur - I',334),(2582,' Daspur - II',334),(2583,' Keshpur',334),(2584,' Salbani',334),(2585,' Midnapore',334),(2586,' Jhargram',334),(2587,' Jamboni',334),(2588,' Gopiballavpur - II',334),(2589,' Gopiballavpur - I',334),(2590,' Nayagram',334),(2591,' Sankrail',334),(2592,' Kharagpur - I',334),(2593,' Kharagpur - II',334),(2594,' Debra',334),(2595,' Panskura - I',334),(2596,' Panskura - II',334),(2597,' Tamluk',334),(2598,' Sahid Matangini',334),(2599,' Nanda Kumar',334),(2600,' Mahisadal',334),(2601,' Moyna',334),(2602,' Pingla',334),(2603,' Sabang',334),(2604,' Narayangarh',334),(2605,' Keshiary',334),(2606,' Dantan - I',334),(2607,' Dantan - II',334),(2608,' Potashpur - I',334),(2609,' Potashpur - II',334),(2610,' Bhagawanpur - II',334),(2611,' Bhagawanpur - I',334),(2612,' Nandigram - III',334),(2613,' Sutahata - I',334),(2614,' Sutahata - II',334),(2615,' Nandigram - I',334),(2616,' Nandigram - II',334),(2617,' Khejuri - I',334),(2618,' Khejuri - II',334),(2619,' Contai - I',334),(2620,' Contai - II',334),(2621,' Contai - III',334),(2622,' Egra - I',334),(2623,' Egra - II',334),(2624,' Mohanpur',334),(2625,' Ramnagar - I',334),(2626,' Ramnagar - II',334),(2627,' Haora ',335),(2628,' Udaynarayanpur',335),(2629,' Amta - II',335),(2630,' Amta - I',335),(2631,' Jagatballavpur',335),(2632,' Domjur',335),(2633,' Bally Jagachha',335),(2634,' Sankrail',335),(2635,' Panchla',335),(2636,' Uluberia - II',335),(2637,' Uluberia - I',335),(2638,' Bagnan - I',335),(2639,' Bagnan - II',335),(2640,' Shyampur - I',335),(2641,' Shyampur - II',335),(2642,' Kolkata',336),(2643,' South  Twenty Four Parganas',337),(2644,' Thakurpukur Mahestola',337),(2645,' Budge Budge - I',337),(2646,' Budge Budge - II',337),(2647,' Bishnupur - I',337),(2648,' Bishnupur - II',337),(2649,' Sonarpur',337),(2650,' Bhangar - I',337),(2651,' Bhangar - II',337),(2652,' Canning - I',337),(2653,' Canning - II',337),(2654,' Baruipur',337),(2655,' Magrahat - II',337),(2656,' Magrahat - I',337),(2657,' Falta',337),(2658,' Diamond Harbour - I',337),(2659,' Diamond Harbour - II',337),(2660,' Kulpi',337),(2661,' Mandirbazar',337),(2662,' Mathurapur - I',337),(2663,' Jaynagar - I',337),(2664,' Jaynagar - II',337),(2665,' Kultali',337),(2666,' Basanti',337),(2667,' Gosaba',337),(2668,' Mathurapur - II',337),(2669,' Kakdwip',337),(2670,' Sagar',337),(2671,' Namkhana',337),(2672,' Patharpratima',337),(2673,' JHARKHAND',338),(2674,' Garhwa *',339),(2675,' Kharaundhi',339),(2676,' Bhawnathpur',339),(2677,' Kandi',339),(2678,' Majhiaon',339),(2679,' Ramna',339),(2680,' Nagaruntari',339),(2681,' Dhurki',339),(2682,' Dandai',339),(2683,' Chinia',339),(2684,' Meral (Pipra Kalan)',339),(2685,' Garhwa',339),(2686,' Ranka',339),(2687,' Ramkanda',339),(2688,' Bhandaria',339),(2689,' Palamu',340),(2690,' Hussainabad',340),(2691,' Hariharganj',340),(2692,' Chhatarpur',340),(2693,' Pandu',340),(2694,' Bishrampur',340),(2695,' Patan',340),(2696,' Manatu',340),(2697,' Panki',340),(2698,' Manika',340),(2699,' Satbarwa',340),(2700,' Leslieganj',340),(2701,' Daltonganj',340),(2702,' Chainpur',340),(2703,' Barwadih',340),(2704,' Mahuadanr',340),(2705,' Garu',340),(2706,' Latehar',340),(2707,' Balumath',340),(2708,' Chandwa',340),(2709,' Chatra *',341),(2710,' Hunterganj',341),(2711,' Pratappur',341),(2712,' Kunda',341),(2713,' Lawalaung',341),(2714,' Chatra',341),(2715,' Itkhori',341),(2716,' Gidhaur',341),(2717,' Pathalgora',341),(2718,' Simaria',341),(2719,' Tandwa',341),(2720,' Hazaribag',342),(2721,' Chauparan',342),(2722,' Barhi',342),(2723,' Padma',342),(2724,' Ichak',342),(2725,' Barkatha',342),(2726,' Bishungarh',342),(2727,' Hazaribag',342),(2728,' Katkamsandi',342),(2729,' Keredari',342),(2730,' Barkagaon',342),(2731,' Patratu',342),(2732,' Churchu',342),(2733,' Mandu',342),(2734,' Ramgarh',342),(2735,' Gola',342),(2736,' Kodarma *',343),(2737,' Satgawan',343),(2738,' Kodarma',343),(2739,' Jainagar',343),(2740,' Markacho',343),(2741,' Giridih',344),(2742,' Gawan',344),(2743,' Tisri',344),(2744,' Deori',344),(2745,' Dhanwar',344),(2746,' Jamua',344),(2747,' Bengabad',344),(2748,' Gande',344),(2749,' Giridih',344),(2750,' Birni',344),(2751,' Bagodar',344),(2752,' Dumri',344),(2753,' Pirtanr',344),(2754,' Deoghar',345),(2755,' Deoghar',345),(2756,' Mohanpur',345),(2757,' Sarwan',345),(2758,' Devipur',345),(2759,' Madhupur',345),(2760,' Karon',345),(2761,' Sarath',345),(2762,' Palojori',345),(2763,' Godda',346),(2764,' Meherma',346),(2765,' Thakur Gangti',346),(2766,' Boarijor',346),(2767,' Mahagama',346),(2768,' Pathargama',346),(2769,' Godda',346),(2770,' Poreyahat',346),(2771,' Sundar Pahari',346),(2772,' Sahibganj',347),(2773,' Sahibganj',347),(2774,' Mandro',347),(2775,' Borio',347),(2776,' Barhait',347),(2777,' Taljhari',347),(2778,' Rajmahal',347),(2779,' Udhwa',347),(2780,' Pathna',347),(2781,' Barharwa',347),(2782,' Pakaur *',348),(2783,' Litipara',348),(2784,' Amrapara',348),(2785,' Hiranpur',348),(2786,' Pakaur',348),(2787,' Maheshpur',348),(2788,' Pakuria',348),(2789,' Dumka',349),(2790,' Saraiyahat',349),(2791,' Jarmundi',349),(2792,' Ramgarh',349),(2793,' Gopikandar',349),(2794,' Kathikund',349),(2795,' Shikaripara',349),(2796,' Ranishwar',349),(2797,' Dumka',349),(2798,' Jama',349),(2799,' Masalia',349),(2800,' Narayanpur',349),(2801,' Jamtara',349),(2802,' Nala',349),(2803,' Kundhit',349),(2804,' Dhanbad',350),(2805,' Tundi',350),(2806,' Topchanchi',350),(2807,' Baghmara-Cum-Katras',350),(2808,' Gobindpur',350),(2809,' Dhanbad-Cum-Ken-duadih-Cum-Jagta',350),(2810,' Jharia-Cum-Jorap-okhar-Cum-Sindri',350),(2811,' Baliapur',350),(2812,' Nirsa-Cum-Chirkunda',350),(2813,' Bokaro *',351),(2814,' Nawadih',351),(2815,' Bermo',351),(2816,' Gumia',351),(2817,' Peterwar',351),(2818,' Kasmar',351),(2819,' Jaridih',351),(2820,' Chas',351),(2821,' Chandankiyari',351),(2822,' Ranchi',352),(2823,' Burmu',352),(2824,' Kanke',352),(2825,' Ormanjhi',352),(2826,' Angara',352),(2827,' Silli',352),(2828,' Sonahatu',352),(2829,' Namkum',352),(2830,' Ratu',352),(2831,' Mandar',352),(2832,' Chanho',352),(2833,' Bero',352),(2834,' Lapung',352),(2835,' Karra',352),(2836,' Torpa',352),(2837,' Rania',352),(2838,' Murhu',352),(2839,' Khunti',352),(2840,' Bundu',352),(2841,' Erki (Tamar II)',352),(2842,' Tamar I',352),(2843,' Lohardaga',353),(2844,' Kisko',353),(2845,' Kuru',353),(2846,' Lohardaga',353),(2847,' Senha',353),(2848,' Bhandra',353),(2849,' Gumla',354),(2850,' Bishunpur',354),(2851,' Ghaghra',354),(2852,' Sisai',354),(2853,' Verno',354),(2854,' Kamdara',354),(2855,' Basia',354),(2856,' Gumla',354),(2857,' Chainpur',354),(2858,' Dumri',354),(2859,' Raidih',354),(2860,' Palkot',354),(2861,' simdega',354),(2862,' Kurdeg',354),(2863,' Bolba',354),(2864,' Thethaitangar',354),(2865,' Kolebira',354),(2866,' Jaldega',354),(2867,' Bano',354),(2868,' Pashchimi Singhbhum',355),(2869,' Sonua',355),(2870,' Bandgaon',355),(2871,' Chakradharpur',355),(2872,' Kuchai',355),(2873,' Kharsawan',355),(2874,' Chandil',355),(2875,' Ichagarh',355),(2876,' Nimdih',355),(2877,' Adityapur',355),(2878,' Seraikela',355),(2879,' Gobindpur',355),(2880,' Khuntpani',355),(2881,' Goilkera',355),(2882,' Manoharpur',355),(2883,' Noamundi',355),(2884,' Tonto',355),(2885,' Chaibasa',355),(2886,' Tantnagar',355),(2887,' Manjhari',355),(2888,' Jhinkpani',355),(2889,' Jagannathpur',355),(2890,' Kumardungi',355),(2891,' Majhgaon',355),(2892,' Purbi Singhbhum',356),(2893,' Patamda',356),(2894,' Golmuri-Cum-Jugsalai',356),(2895,' Ghatshila',356),(2896,' Potka',356),(2897,' Musabani',356),(2898,' Dumaria',356),(2899,' Dhalbhumgarh',356),(2900,' Chakulia',356),(2901,' Baharagora',356),(2902,' ORISSA',357),(2903,' Bargarh  *',358),(2904,' Paikamal',358),(2905,' Jharabandha',358),(2906,' Jharabandha',358),(2907,' Padmapur',358),(2908,' Burden',358),(2909,' Gaisilet',358),(2910,' Melchhamunda',358),(2911,' Sohela',358),(2912,' Bijepur',358),(2913,' Barapali',358),(2914,' Bheden',358),(2915,' Bargarh',358),(2916,' Bhatli',358),(2917,' Ambabhona',358),(2918,' Attabira',358),(2919,' Jharsuguda  *',359),(2920,' Rengali',359),(2921,' Lakhanpur',359),(2922,' Belpahar',359),(2923,' Banaharapali',359),(2924,' Orient',359),(2925,' Brajarajnagar',359),(2926,' Jharsuguda',359),(2927,' Laikera',359),(2928,' Kolabira',359),(2929,' Sambalpur',360),(2930,' Govindpur',360),(2931,' Mahulpalli',360),(2932,' Kochinda',360),(2933,' Jamankira',360),(2934,' Kisinda',360),(2935,' Naktideul',360),(2936,' Rairakhol',360),(2937,' Charamal',360),(2938,' Jujomura',360),(2939,' Dhama',360),(2940,' Burla',360),(2941,' Hirakud',360),(2942,' Ainthapali',360),(2943,' Dhanupali',360),(2944,' Sadar',360),(2945,' Sasan',360),(2946,' Katarbaga',360),(2947,' Debagarh  *',361),(2948,' Debagarh',361),(2949,' Barkot',361),(2950,' Kundheigola',361),(2951,' Reamal',361),(2952,' Sundargarh',362),(2953,' Hemgir',362),(2954,' Lephripara',362),(2955,' Bhasma',362),(2956,' Bhasma',362),(2957,' Sundargarh Town',362),(2958,' Sundargarh    ',362),(2959,' Kinjirkela',362),(2960,' Kinjirkela ',362),(2961,' Kinjirkela ',362),(2962,' Talasara',362),(2963,' Talasara',362),(2964,' Baragaon',362),(2965,' Kutra',362),(2966,' Rajagangapur',362),(2967,' Rajagangapur',362),(2968,' Raiboga',362),(2969,' Biramitrapur',362),(2970,' Biramitrapur',362),(2971,' Hatibari',362),(2972,' Bisra',362),(2973,' Bisra',362),(2974,' Bondamunda',362),(2975,' Bondamunda',362),(2976,' Brahmani Tarang',362),(2977,' Raghunathapali',362),(2978,' Tangarapali',362),(2979,' Lathikata',362),(2980,' Banki',362),(2981,' Kamarposh Balang',362),(2982,' Koida',362),(2983,' Lahunipara',362),(2984,' Gurundia',362),(2985,' Tikaetpali',362),(2986,' Banei',362),(2987,' Mahulpada',362),(2988,' Kendujhar',363),(2989,' Telkoi',363),(2990,' Kanjipani',363),(2991,' Nayakote',363),(2992,' Barbil',363),(2993,' Joda',363),(2994,' Champua',363),(2995,' Champua',363),(2996,' Baria',363),(2997,' Turumunga',363),(2998,' Turumunga',363),(2999,' Patana',363),(3000,' Patana',363),(3001,' Ghatgaon',363),(3002,' Ghatgaon',363),(3003,' Kendujhar Sadar',363),(3004,' Kendujhar Town',363),(3005,' Pandapara',363),(3006,' Harichandanpur',363),(3007,' Daitari',363),(3008,' Ghasipura',363),(3009,' Sainkul',363),(3010,' Nandipada',363),(3011,' Anandapur',363),(3012,' Anandapur',363),(3013,' Soso',363),(3014,' Mayurbhanj',364),(3015,' Tiringi',364),(3016,' Bahalda',364),(3017,' Gorumahisani',364),(3018,' Rairangpur',364),(3019,' Rairangpur Town',364),(3020,' Badampahar',364),(3021,' Bisoi',364),(3022,' Bangiriposi',364),(3023,' Jharpokharia',364),(3024,' Chandua',364),(3025,' Koliana',364),(3026,' Baripada Sadar',364),(3027,' Baripada Town',364),(3028,' Suliapada',364),(3029,' Muruda ',364),(3030,' Muruda ',364),(3031,' Muruda ',364),(3032,' Betanati',364),(3033,' Betanati',364),(3034,' Rasagobindapur',364),(3035,' Baisinga',364),(3036,' Barsahi',364),(3037,' Khunta',364),(3038,' Udala',364),(3039,' Kaptipada',364),(3040,' Sharata',364),(3041,' Mahuldiha',364),(3042,' Thakurmunda',364),(3043,' Karanjia',364),(3044,' Jashipur',364),(3045,' Jashipur',364),(3046,' Raruan',364),(3047,' Raruan',364),(3048,' Baleshwar',365),(3049,' Raibania',365),(3050,' Jaleswar',365),(3051,' Bhograi',365),(3052,' Baliapal',365),(3053,' Singla',365),(3054,' Singla',365),(3055,' Basta',365),(3056,' Rupsa',365),(3057,' Baleshwar Sadar',365),(3058,' Chandipur',365),(3059,' Remuna',365),(3060,' Bampada',365),(3061,' Nilagiri',365),(3062,' Berhampur',365),(3063,' Oupada',365),(3064,' Soro',365),(3065,' Khaira',365),(3066,' Similia',365),(3067,' Bhadrak  *',366),(3068,' Agarpada',366),(3069,' Bant',366),(3070,' Bant',366),(3071,' Bhadrak Rural',366),(3072,' Bhadrak Rural',366),(3073,' Bhandari Pokhari',366),(3074,' Dhamanagar',366),(3075,' Dhusuri',366),(3076,' Dhusuri',366),(3077,' Tihidi',366),(3078,' Tihidi',366),(3079,' Chandabali',366),(3080,' Bansada',366),(3081,' Naikanidihi',366),(3082,' Basudebpur',366),(3083,' Kendrapara *',367),(3084,' Rajkanika',367),(3085,' Aali',367),(3086,' Pattamundai',367),(3087,' Kendrapara',367),(3088,' Patkura',367),(3089,' Patkura',367),(3090,' Mahakalapada',367),(3091,' Rajnagar',367),(3092,' Jagatsinghapur  *',368),(3093,' Paradip',368),(3094,' Kujang',368),(3095,' Ersama',368),(3096,' Tirtol',368),(3097,' Balikuda',368),(3098,' Naugaon',368),(3099,' Jagatsinghapur',368),(3100,' Cuttack',369),(3101,' Mahanga',369),(3102,' Salepur',369),(3103,' Jagatpur',369),(3104,' Kishannagar',369),(3105,' Niali',369),(3106,' Gobindpur',369),(3107,' Cuttack Sadar',369),(3108,' Tangi',369),(3109,' Choudwar',369),(3110,' Choudwar',369),(3111,' Gurudijhatia',369),(3112,' Barang',369),(3113,' Athagad',369),(3114,' Tigiria',369),(3115,' Banki',369),(3116,' Baidyeswar',369),(3117,' Badamba',369),(3118,' Kanpur',369),(3119,' Narasinghpur',369),(3120,' Jajapur  *',370),(3121,' Sukinda',370),(3122,' Duburi',370),(3123,' Jajapur Road',370),(3124,' Korai',370),(3125,' Jajapur   ',370),(3126,' Mangalpur',370),(3127,' Binjharpur',370),(3128,' Binjharpur',370),(3129,' Balichandrapur',370),(3130,' Balichandrapur',370),(3131,' Badachana',370),(3132,' Badachana',370),(3133,' Dharmasala',370),(3134,' Dhenkanal',371),(3135,' Bhuban',371),(3136,' Kamakshyanagar',371),(3137,' Kamakshyanagar',371),(3138,' Parajang',371),(3139,' Parajang',371),(3140,' Tumusingha',371),(3141,' Motunga',371),(3142,' Balimi',371),(3143,' Hindol',371),(3144,' Rasol',371),(3145,' Dhenkanal Sadar',371),(3146,' Gandia',371),(3147,' Gandia',371),(3148,' Gandia',371),(3149,' Anugul  *',372),(3150,' Palalahada',372),(3151,' Khamar',372),(3152,' Rengali Damsite',372),(3153,' Kaniha',372),(3154,' NTPC',372),(3155,' Samal Barrage',372),(3156,' Talcher Sadar',372),(3157,' Colliery',372),(3158,' Bikrampur',372),(3159,' NALCO',372),(3160,' Banarpal',372),(3161,' Anugul',372),(3162,' Bantala',372),(3163,' Purunakot',372),(3164,' Jarapada',372),(3165,' Jarapada',372),(3166,' Chhendipada',372),(3167,' Handapa',372),(3168,' Kishorenagar',372),(3169,' Thakurgarh',372),(3170,' Athmallik',372),(3171,' Nayagarh  *',373),(3172,' Dasapalla',373),(3173,' Gania',373),(3174,' Khandapada',373),(3175,' Fategarh',373),(3176,' Nayagarh',373),(3177,' Nuagaon',373),(3178,' Odagaon',373),(3179,' Sarankul',373),(3180,' Ranapur',373),(3181,' Khordha  *',374),(3182,' Bolagad',374),(3183,' Begunia',374),(3184,' Begunia',374),(3185,' Khordha',374),(3186,' Khordha',374),(3187,' Chandaka',374),(3188,' Chandaka',374),(3189,' Khandagiri',374),(3190,' Saheednagar',374),(3191,' Balianta',374),(3192,' Balipatana',374),(3193,' Lingaraj',374),(3194,' Lingaraj',374),(3195,' Jatani',374),(3196,' Jankia',374),(3197,' Jankia',374),(3198,' Jankia',374),(3199,' Tangi',374),(3200,' Tangi',374),(3201,' Balugaon',374),(3202,' Banapur',374),(3203,' Puri',375),(3204,' Delanga',375),(3205,' Pipili',375),(3206,' Nimapada',375),(3207,' Nimapada',375),(3208,' Gop',375),(3209,' Gop',375),(3210,' Kakatpur',375),(3211,' Konark',375),(3212,' Konark',375),(3213,' Satyabadi',375),(3214,' Satyabadi',375),(3215,' Chandanpur',375),(3216,' Sadar',375),(3217,' Sadar',375),(3218,' Brahmagiri',375),(3219,' Brahmagiri',375),(3220,' Krushna Prasad',375),(3221,' Ganjam',376),(3222,' Tarasingi',376),(3223,' Buguda',376),(3224,' Bhanjanagar',376),(3225,' Bhanjanagar',376),(3226,' Gangapur',376),(3227,' Gangapur',376),(3228,' Gangapur',376),(3229,' Gangapur',376),(3230,' Surada',376),(3231,' Badagada',376),(3232,' Badagada',376),(3233,' Asika',376),(3234,' Purusottampur',376),(3235,' Purusottampur',376),(3236,' Purusottampur',376),(3237,' Kabisuryanagar',376),(3238,' Kabisuryanagar',376),(3239,' Kodala',376),(3240,' Kodala',376),(3241,' Khalikote',376),(3242,' Khalikote',376),(3243,' Rambha',376),(3244,' Rambha',376),(3245,' Rambha',376),(3246,' Chhatrapur',376),(3247,' Chhatrapur',376),(3248,' Gopalpur',376),(3249,' Gopalpur',376),(3250,' Brahmapur Sadar',376),(3251,' Brahmapur Sadar',376),(3252,' Brahmapur Sadar',376),(3253,' Golanthara',376),(3254,' Golanthara',376),(3255,' Nuagaon',376),(3256,' Nuagaon',376),(3257,' Nuagaon',376),(3258,' Digapahandi',376),(3259,' Digapahandi',376),(3260,' Digapahandi',376),(3261,' Jarada',376),(3262,' Patapur',376),(3263,' Patapur',376),(3264,' Patapur',376),(3265,' Hinjili',376),(3266,' Hinjili',376),(3267,' Hinjili',376),(3268,' Hinjili',376),(3269,' Hinjili',376),(3270,' Ramagiri',376),(3271,' Gajapati  *',377),(3272,' Ramagiri',377),(3273,' Ramagiri',377),(3274,' Adva',377),(3275,' Mohana',377),(3276,' R.Udaygiri',377),(3277,' Garabandha',377),(3278,' Parlakhemundi',377),(3279,' Kashinagara',377),(3280,' Serango',377),(3281,' Serango',377),(3282,' Rayagada',377),(3283,' Kandhamal',378),(3284,' Gochhapada',378),(3285,' Phulabani',378),(3286,' Phulabani Town ',378),(3287,' Khajuripada',378),(3288,' G.Udayagiri',378),(3289,' Tikabali',378),(3290,' Sarangagarh',378),(3291,' Sarangagarh',378),(3292,' Phiringia',378),(3293,' Baliguda',378),(3294,' Tumudibandha',378),(3295,' Belaghar',378),(3296,' Kotagarh',378),(3297,' Brahmanigaon',378),(3298,' Daringbadi',378),(3299,' Raikia',378),(3300,' Baudh  *',379),(3301,' Kantamal',379),(3302,' Manamunda',379),(3303,' Manamunda',379),(3304,' Baunsuni',379),(3305,' Baudh Sadar',379),(3306,' Puruna Katak',379),(3307,' Harbhanga',379),(3308,' Sonapur  *',380),(3309,' Dunguripali',380),(3310,' Dunguripali',380),(3311,' Dunguripali',380),(3312,' Tarbha',380),(3313,' Sonapur',380),(3314,' Biramaharajpur',380),(3315,' Ulunda',380),(3316,' Binika',380),(3317,' Binika',380),(3318,' Rampur',380),(3319,' Rampur',380),(3320,' Balangir',381),(3321,' Khaprakhol',381),(3322,' Turekela',381),(3323,' Belpara',381),(3324,' Kantabanji',381),(3325,' Bangomunda',381),(3326,' Sindhekela',381),(3327,' Sindhekela',381),(3328,' Titlagarh',381),(3329,' Saintala',381),(3330,' Tushura',381),(3331,' Patnagarh',381),(3332,' Balangir',381),(3333,' Balangir',381),(3334,' Loisinga',381),(3335,' Loisinga',381),(3336,' Nuapada  *',382),(3337,' Jonk',382),(3338,' Nuapada',382),(3339,' Komana',382),(3340,' Khariar',382),(3341,' Boden',382),(3342,' Sinapali',382),(3343,' Kalahandi',383),(3344,' Kokasara',383),(3345,' Kokasara',383),(3346,' Dharamgarh',383),(3347,' Kegaon',383),(3348,' Kegaon',383),(3349,' Sadar',383),(3350,' Sadar',383),(3351,' Kesinga',383),(3352,' Kesinga',383),(3353,' Narala',383),(3354,' Narala',383),(3355,' Madanpur Rampur',383),(3356,' Lanjigarh',383),(3357,' Lanjigarh',383),(3358,' Thuamul Rampur',383),(3359,' Junagarh',383),(3360,' Junagarh',383),(3361,' Jayapatna',383),(3362,' Rayagada  *',384),(3363,' Ambadala',384),(3364,' Muniguda',384),(3365,' Muniguda',384),(3366,' Bishamakatak',384),(3367,' Gudari',384),(3368,' Padmapur',384),(3369,' Puttasing',384),(3370,' Gunupur',384),(3371,' Rayagada',384),(3372,' Kalyanasingpur',384),(3373,' Kashipur',384),(3374,' Tikiri',384),(3375,' Nabarangapur  *',385),(3376,' Raighar',385),(3377,' Umarkote',385),(3378,' Chandahandi',385),(3379,' Jharigan',385),(3380,' Jharigan',385),(3381,' Dabugan',385),(3382,' Dabugan',385),(3383,' Paparahandi',385),(3384,' Tentulikhunti',385),(3385,' Khatiguda',385),(3386,' Nabarangapur',385),(3387,' Kodinga',385),(3388,' Koraput',386),(3389,' Kotpad',386),(3390,' Boriguma',386),(3391,' Bhairabsingipur',386),(3392,' Dasamantapur',386),(3393,' Lakshmipur',386),(3394,' Narayanpatana',386),(3395,' Kakiriguma',386),(3396,' Koraput',386),(3397,' Koraput Town',386),(3398,' Nandapur',386),(3399,' Nandapur',386),(3400,' Similiguda',386),(3401,' Damanjodi',386),(3402,' Pottangi',386),(3403,' Padua',386),(3404,' Sunabeda',386),(3405,' Machh kund',386),(3406,' Boipariguda',386),(3407,' Jeypur',386),(3408,' Kundura',386),(3409,' Malkangiri  *',387),(3410,' Malkangiri',387),(3411,' Mathili',387),(3412,' Mudulipada',387),(3413,' Chitrakonda',387),(3414,' Orkel',387),(3415,' Kalimela',387),(3416,' M.V. 79',387),(3417,' Motu',387),(3418,' CHHATTISGARH',388),(3419,' Koriya *',389),(3420,' Bharatpur',389),(3421,' Baikunthpur',389),(3422,' Sonhat',389),(3423,' Manendragarh',389),(3424,' Surguja',390),(3425,' Pal',390),(3426,' Wadrafnagar',390),(3427,' Pratappur',390),(3428,' Samari',390),(3429,' Surajpur',390),(3430,' Ambikapur',390),(3431,' Rajpur',390),(3432,' Lundra',390),(3433,' Sitapur',390),(3434,' Jashpur *',391),(3435,' Bagicha',391),(3436,' Jashpur',391),(3437,' Kunkuri',391),(3438,' Pathalgaon',391),(3439,' Raigarh',392),(3440,' Udaipur (Dharamjaigarh)',392),(3441,' Lailunga',392),(3442,' Gharghoda',392),(3443,' Raigarh',392),(3444,' Kharsia',392),(3445,' Sarangarh',392),(3446,' Korba *',393),(3447,' Katghora',393),(3448,' Pali',393),(3449,' Korba',393),(3450,' Kartala',393),(3451,' Janjgir - Champa*',394),(3452,' Janjgir',394),(3453,' Nawagarh',394),(3454,' Champa',394),(3455,' Sakti',394),(3456,' Pamgarh',394),(3457,' Dabhara',394),(3458,' Malkharoda',394),(3459,' Jaijaipur',394),(3460,' Bilaspur',395),(3461,' Pendraroad',395),(3462,' Lormi',395),(3463,' Kota',395),(3464,' Mungeli',395),(3465,' Takhatpur',395),(3466,' Bilaspur',395),(3467,' Masturi',395),(3468,' Bilha',395),(3469,' Kawardha *',396),(3470,' Kawardha',396),(3471,' Pandariya',396),(3472,' Rajnandgaon',397),(3473,' Chhuikhadan',397),(3474,' Khairagarh',397),(3475,' Dongargarh',397),(3476,' Rajnandgaon',397),(3477,' Dongargaon',397),(3478,' Mohla',397),(3479,' Manpur',397),(3480,' Ambagarh',397),(3481,' Durg',398),(3482,' Nawagarh',398),(3483,' Bemetra',398),(3484,' Saja',398),(3485,' Berla',398),(3486,' Dhamdha',398),(3487,' Durg',398),(3488,' Patan',398),(3489,' Gunderdehi',398),(3490,' Dondiluhara',398),(3491,' Sanjari Balod',398),(3492,' Gurur',398),(3493,' Raipur',399),(3494,' Simga',399),(3495,' Bhatapara',399),(3496,' Baloda Bazar',399),(3497,' Palari',399),(3498,' Kasdol',399),(3499,' Bilaigarh',399),(3500,' Arang',399),(3501,' Abhanpur',399),(3502,' Raipur',399),(3503,' Rajim',399),(3504,' Tilda ',399),(3505,' Bindranawagarh',399),(3506,' Deobhog',399),(3507,' Mahasamund *',400),(3508,' Basna',400),(3509,' Saraipali',400),(3510,' Mahasamund',400),(3511,' Dhamtari *',401),(3512,' Kurud',401),(3513,' Dhamtari',401),(3514,' Nagri',401),(3515,' Kanker *',402),(3516,' Charama',402),(3517,' Bhanupratappur',402),(3518,' Kanker',402),(3519,' Narharpur',402),(3520,' Antagarh',402),(3521,' Pakhanjur',402),(3522,' Bastar',403),(3523,' Keshkal',403),(3524,' Narayanpur',403),(3525,' Kondagaon',403),(3526,' Jagdalpur',403),(3527,' Dantewada*',404),(3528,' Bhopalpattanam (Matdand)',404),(3529,' Bijapur',404),(3530,' Dantewada',404),(3531,' Konta',404),(3532,' MADHYA PRADESH',405),(3533,' Sheopur *',406),(3534,' Vijaypur',406),(3535,' Sheopur',406),(3536,' Karahal',406),(3537,' Morena',407),(3538,' Ambah',407),(3539,' Porsa',407),(3540,' Morena',407),(3541,' Joura',407),(3542,' Kailaras',407),(3543,' Sabalgarh',407),(3544,' Bhind',408),(3545,' Ater',408),(3546,' Bhind',408),(3547,' Mehgaon',408),(3548,' Gohad',408),(3549,' Ron',408),(3550,' Mihona',408),(3551,' Lahar',408),(3552,' Gwalior',409),(3553,' Gird',409),(3554,' Pichhore',409),(3555,' Bhitarwar',409),(3556,' Datia',410),(3557,' Seondha',410),(3558,' Datia',410),(3559,' Bhander',410),(3560,' Shivpuri',411),(3561,' Pohari',411),(3562,' Shivpuri',411),(3563,' Narwar',411),(3564,' Karera',411),(3565,' Kolaras',411),(3566,' Pichhore',411),(3567,' Khaniyadhana',411),(3568,' Guna',412),(3569,' Isagarh',412),(3570,' Chanderi',412),(3571,' Guna',412),(3572,' Ashoknagar',412),(3573,' Raghogarh',412),(3574,' Mungaoli',412),(3575,' Kumbhraj',412),(3576,' Aron',412),(3577,' Chachaura',412),(3578,' Tikamgarh',413),(3579,' Niwari',413),(3580,' Prithvipur',413),(3581,' Jatara',413),(3582,' Palera',413),(3583,' Baldeogarh',413),(3584,' Tikamgarh',413),(3585,' Chhatarpur',414),(3586,' Gaurihar',414),(3587,' Laundi',414),(3588,' Nowgaon',414),(3589,' Chhatarpur',414),(3590,' Rajnagar',414),(3591,' Bada-Malhera',414),(3592,' Bijawar',414),(3593,' Panna',415),(3594,' Ajaigarh',415),(3595,' Panna',415),(3596,' Gunnor',415),(3597,' Pawai',415),(3598,' Shahnagar',415),(3599,' Sagar',416),(3600,' Bina',416),(3601,' Khurai',416),(3602,' Banda',416),(3603,' Rahatgarh',416),(3604,' Sagar',416),(3605,' Garhakota',416),(3606,' Rehli',416),(3607,' Kesli',416),(3608,' Deori',416),(3609,' Damoh',417),(3610,' Hatta',417),(3611,' Patera',417),(3612,' Batiyagarh',417),(3613,' Patharia',417),(3614,' Damoh',417),(3615,' Jabera',417),(3616,' Tendukheda',417),(3617,' Satna',418),(3618,' Raghurajnagar',418),(3619,' Nagod',418),(3620,' Unchehara',418),(3621,' Rampur-Baghelan',418),(3622,' Amarpatan',418),(3623,' Ramnagar',418),(3624,' Maihar',418),(3625,' Rewa',419),(3626,' Teonthar',419),(3627,' Sirmour',419),(3628,' Hanumana',419),(3629,' Mauganj',419),(3630,' Huzur',419),(3631,' Raipur - Karchuliyan',419),(3632,' Gurh',419),(3633,' Umaria *',420),(3634,' Bandhogarh',420),(3635,' Shahdol',421),(3636,' Beohari',421),(3637,' Jaisinghnagar',421),(3638,' Sohagpur',421),(3639,' Jaitpur',421),(3640,' Kotma',421),(3641,' Anuppur',421),(3642,' Jaithari',421),(3643,' Pushprajgarh',421),(3644,' Sidhi',422),(3645,' Rampur Naikin',422),(3646,' Churhat',422),(3647,' Gopadbanas',422),(3648,' Sihawal',422),(3649,' Chitrangi',422),(3650,' Deosar',422),(3651,' Majhauli',422),(3652,' Kusmi',422),(3653,' Singrauli',422),(3654,' Neemuch *',423),(3655,' Jawad',423),(3656,' Neemuch',423),(3657,' Manasa',423),(3658,' Mandsaur',424),(3659,' Bhanpura',424),(3660,' Malhargarh',424),(3661,' Garoth',424),(3662,' Mandsaur',424),(3663,' Sitamau',424),(3664,' Ratlam',425),(3665,' Piploda',425),(3666,' Jaora',425),(3667,' Alot',425),(3668,' Sailana',425),(3669,' Bajna',425),(3670,' Ratlam',425),(3671,' Ujjain',426),(3672,' Khacharod',426),(3673,' Nagda',426),(3674,' Mahidpur',426),(3675,' Ghatiya',426),(3676,' Tarana',426),(3677,' Ujjain',426),(3678,' Badnagar',426),(3679,' Shajapur',427),(3680,' Susner',427),(3681,' Nalkheda',427),(3682,' Badod',427),(3683,' Agar',427),(3684,' Shajapur',427),(3685,' Moman Badodiya',427),(3686,' Shujalpur',427),(3687,' Kalapipal',427),(3688,' Dewas',428),(3689,' Tonk Khurd',428),(3690,' Sonkatch',428),(3691,' Dewas',428),(3692,' Kannod',428),(3693,' Bagli',428),(3694,' Khategaon',428),(3695,' Jhabua',429),(3696,' Thandla',429),(3697,' Petlawad',429),(3698,' Meghnagar',429),(3699,' Jhabua',429),(3700,' Bhavra',429),(3701,' Jobat',429),(3702,' Alirajpur',429),(3703,' Ranapur',429),(3704,' Dhar',430),(3705,' Badnawar',430),(3706,' Sardarpur',430),(3707,' Dhar',430),(3708,' Gandhwani',430),(3709,' Kukshi',430),(3710,' Manawar',430),(3711,' Dharampuri',430),(3712,' Indore',431),(3713,' Depalpur',431),(3714,' Sawer',431),(3715,' Indore',431),(3716,' Mhow ',431),(3717,' West Nimar',432),(3718,' Barwaha',432),(3719,' Maheshwar',432),(3720,' Kasrawad',432),(3721,' Segaon',432),(3722,' Bhikangaon',432),(3723,' Khargone',432),(3724,' Bhagwanpura',432),(3725,' Jhiranya',432),(3726,' Barwani *',433),(3727,' Barwani',433),(3728,' Thikri',433),(3729,' Rajpur',433),(3730,' Pansemal',433),(3731,' Niwali',433),(3732,' Sendhwa',433),(3733,' East Nimar',434),(3734,' Harsud',434),(3735,' Khandwa',434),(3736,' Pandhana',434),(3737,' Burhanpur',434),(3738,' Nepanagar',434),(3739,' Rajgarh',435),(3740,' Jirapur',435),(3741,' Khilchipur',435),(3742,' Rajgarh',435),(3743,' Biaora',435),(3744,' Sarangpur',435),(3745,' Narsinghgarh',435),(3746,' Vidisha',436),(3747,' Lateri',436),(3748,' Sironj',436),(3749,' Kurwai',436),(3750,' Basoda',436),(3751,' Nateran',436),(3752,' Gyaraspur',436),(3753,' Vidisha',436),(3754,' Bhopal',437),(3755,' Berasia',437),(3756,' Huzur',437),(3757,' Sehore',438),(3758,' Sehore',438),(3759,' Ashta',438),(3760,' Ichhawar',438),(3761,' Nasrullaganj',438),(3762,' Budni',438),(3763,' Raisen',439),(3764,' Raisen',439),(3765,' Gairatganj',439),(3766,' Begamganj',439),(3767,' Goharganj',439),(3768,' Baraily',439),(3769,' Silwani',439),(3770,' Udaipura',439),(3771,' Betul',440),(3772,' Bhainsdehi',440),(3773,' Betul ',440),(3774,' Shahpur',440),(3775,' Multai',440),(3776,' Amla',440),(3777,' Harda *',441),(3778,' Khirkiya',441),(3779,' Harda',441),(3780,' Timarni',441),(3781,' Hoshangabad',442),(3782,' Seoni-Malwa',442),(3783,' Itarsi',442),(3784,' Hoshangabad',442),(3785,' Babai',442),(3786,' Sohagpur',442),(3787,' Pipariya',442),(3788,' Bankhedi',442),(3789,' Katni *',443),(3790,' Murwara',443),(3791,' Vijayraghavgarh',443),(3792,' Bahoriband',443),(3793,' Dhimar Kheda',443),(3794,' Jabalpur',444),(3795,' Sihora',444),(3796,' Patan',444),(3797,' Jabalpur',444),(3798,' Kundam',444),(3799,' Narsimhapur',445),(3800,' Gotegaon',445),(3801,' Gadarwara',445),(3802,' Narsimhapur',445),(3803,' Kareli',445),(3804,' Tendukheda',445),(3805,' Dindori *',446),(3806,' Shahpura',446),(3807,' Dindori ',446),(3808,' Mandla',447),(3809,' Niwas',447),(3810,' Mandla',447),(3811,' Bichhiya',447),(3812,' Nainpur',447),(3813,' Chhindwara',448),(3814,' Tamia',448),(3815,' Amarwara',448),(3816,' Chaurai',448),(3817,' Jamai',448),(3818,' Parasia',448),(3819,' Chhindwara',448),(3820,' Sausar',448),(3821,' Bichhua',448),(3822,' Pandhurna',448),(3823,' Seoni',449),(3824,' Lakhnadon',449),(3825,' Ghansor',449),(3826,' Keolari',449),(3827,' Seoni',449),(3828,' Barghat',449),(3829,' Kurai',449),(3830,' Balaghat',450),(3831,' Katangi',450),(3832,' Waraseoni',450),(3833,' Balaghat',450),(3834,' Kirnapur',450),(3835,' Baihar',450),(3836,' Lanji',450),(3837,' GUJARAT',451),(3838,' Kachchh',452),(3839,' Lakhpat',452),(3840,' Rapar',452),(3841,' Bhachau',452),(3842,' Anjar',452),(3843,' Bhuj',452),(3844,' Nakhatrana',452),(3845,' Abdasa',452),(3846,' Mandvi',452),(3847,' Mundra',452),(3848,' Gandhidham',452),(3849,' Banas Kantha',453),(3850,' Vav',453),(3851,' Tharad',453),(3852,' Dhanera',453),(3853,' Dantiwada',453),(3854,' Amirgadh',453),(3855,' Danta',453),(3856,' Vadgam',453),(3857,' Palanpur',453),(3858,' Deesa',453),(3859,' Deodar',453),(3860,' Bhabhar',453),(3861,' Kankrej',453),(3862,' Patan  *',454),(3863,' Santalpur',454),(3864,' Radhanpur',454),(3865,' Vagdod',454),(3866,' Sidhpur',454),(3867,' Patan',454),(3868,' Harij',454),(3869,' Sami',454),(3870,' Chanasma',454),(3871,' Mahesana',455),(3872,' Satlasana',455),(3873,' Kheralu',455),(3874,' Unjha',455),(3875,' Visnagar',455),(3876,' Vadnagar',455),(3877,' Vijapur',455),(3878,' Mahesana',455),(3879,' Becharaji',455),(3880,' Kadi',455),(3881,' Sabar Kantha',456),(3882,' Khedbrahma',456),(3883,' Vijaynagar',456),(3884,' Vadali',456),(3885,' Idar',456),(3886,' Bhiloda',456),(3887,' Meghraj',456),(3888,' Himatnagar',456),(3889,' Prantij',456),(3890,' Talod',456),(3891,' Modasa',456),(3892,' Dhansura',456),(3893,' Malpur',456),(3894,' Bayad',456),(3895,' Gandhinagar',457),(3896,' Kalol',457),(3897,' Mansa',457),(3898,' Gandhinagar',457),(3899,' Dehgam',457),(3900,' Ahmadabad',458),(3901,' Mandal',458),(3902,' Detroj-Rampura',458),(3903,' Viramgam',458),(3904,' Sanand',458),(3905,' Ahmadabad City',458),(3906,' Daskroi',458),(3907,' Dholka',458),(3908,' Bavla',458),(3909,' Ranpur',458),(3910,' Barwala',458),(3911,' Dhandhuka',458),(3912,' Surendranagar',459),(3913,' Halvad',459),(3914,' Dhrangadhra',459),(3915,' Dasada',459),(3916,' Lakhtar',459),(3917,' Wadhwan',459),(3918,' Muli',459),(3919,' Chotila',459),(3920,' Sayla',459),(3921,' Chuda',459),(3922,' Limbdi',459),(3923,' Rajkot',460),(3924,' Maliya',460),(3925,' Morvi',460),(3926,' Tankara',460),(3927,' Wankaner',460),(3928,' Paddhari',460),(3929,' Rajkot',460),(3930,' Lodhika',460),(3931,' Kotda Sangani',460),(3932,' Jasdan',460),(3933,' Gondal',460),(3934,' Jamkandorna',460),(3935,' Upleta',460),(3936,' Dhoraji',460),(3937,' Jetpur',460),(3938,' Jamnagar',461),(3939,' Okhamandal',461),(3940,' Khambhalia',461),(3941,' Jamnagar',461),(3942,' Jodiya',461),(3943,' Dhrol',461),(3944,' Kalavad',461),(3945,' Lalpur',461),(3946,' Kalyanpur',461),(3947,' Bhanvad',461),(3948,' Jamjodhpur',461),(3949,' Porbandar  *',462),(3950,' Porbandar',462),(3951,' Ranavav',462),(3952,' Kutiyana',462),(3953,' Junagadh',463),(3954,' Manavadar',463),(3955,' Vanthali',463),(3956,' Junagadh',463),(3957,' Bhesan',463),(3958,' Visavadar',463),(3959,' Mendarda',463),(3960,' Keshod',463),(3961,' Mangrol',463),(3962,' Malia',463),(3963,' Talala',463),(3964,' Patan-Veraval',463),(3965,' Sutrapada',463),(3966,' Kodinar',463),(3967,' Una',463),(3968,' Amreli',464),(3969,' Kunkavav Vadia',464),(3970,' Babra',464),(3971,' Lathi',464),(3972,' Lilia',464),(3973,' Amreli',464),(3974,' Bagasara',464),(3975,' Dhari',464),(3976,' Savar Kundla',464),(3977,' Khambha',464),(3978,' Jafrabad',464),(3979,' Rajula',464),(3980,' Bhavnagar',465),(3981,' Botad',465),(3982,' Vallabhipur',465),(3983,' Gadhada',465),(3984,' Umrala',465),(3985,' Bhavnagar',465),(3986,' Ghogha',465),(3987,' Sihor',465),(3988,' Gariadhar',465),(3989,' Palitana',465),(3990,' Talaja',465),(3991,' Mahuva',465),(3992,' Anand  *',466),(3993,' Tarapur',466),(3994,' Sojitra',466),(3995,' Umreth',466),(3996,' Anand',466),(3997,' Petlad',466),(3998,' Khambhat',466),(3999,' Borsad',466),(4000,' Anklav',466),(4001,' Kheda',467),(4002,' Kapadvanj',467),(4003,' Virpur',467),(4004,' Balasinor',467),(4005,' Kathlal',467),(4006,' Mehmedabad',467),(4007,' Kheda',467),(4008,' Matar',467),(4009,' Nadiad',467),(4010,' Mahudha',467),(4011,' Thasra',467),(4012,' Panch Mahals',468),(4013,' Khanpur',468),(4014,' Kadana',468),(4015,' Santrampur',468),(4016,' Lunawada',468),(4017,' Shehera',468),(4018,' Morwa (Hadaf)',468),(4019,' Godhra',468),(4020,' Kalol',468),(4021,' Ghoghamba',468),(4022,' Halol',468),(4023,' Jambughoda',468),(4024,' Dohad  *',469),(4025,' Fatepura',469),(4026,' Jhalod',469),(4027,' Limkheda',469),(4028,' Dohad',469),(4029,' Garbada',469),(4030,' Devgadbaria',469),(4031,' Dhanpur',469),(4032,' Vadodara',470),(4033,' Savli',470),(4034,' Vadodara',470),(4035,' Vaghodia',470),(4036,' Jetpur Pavi',470),(4037,' Chhota Udaipur',470),(4038,' Kavant',470),(4039,' Nasvadi',470),(4040,' Sankheda',470),(4041,' Dabhoi',470),(4042,' Padra',470),(4043,' Karjan',470),(4044,' Sinor',470),(4045,' Narmada  *',471),(4046,' Tilakwada',471),(4047,' Nandod',471),(4048,' Dediapada',471),(4049,' Sagbara',471),(4050,' Bharuch',472),(4051,' Jambusar',472),(4052,' Amod',472),(4053,' Vagra',472),(4054,' Bharuch',472),(4055,' Jhagadia',472),(4056,' Anklesvar',472),(4057,' Hansot',472),(4058,' Valia',472),(4059,' Surat',473),(4060,' Olpad',473),(4061,' Mangrol',473),(4062,' Umarpada',473),(4063,' Nizar',473),(4064,' Uchchhal',473),(4065,' Songadh',473),(4066,' Mandvi',473),(4067,' Kamrej',473),(4068,' Surat City',473),(4069,' Chorasi',473),(4070,' Palsana',473),(4071,' Bardoli',473),(4072,' Vyara',473),(4073,' Valod',473),(4074,' Mahuva',473),(4075,' The Dangs',474),(4076,' The Dangs',474),(4077,' Navsari  *',475),(4078,' Navsari',475),(4079,' Jalalpore',475),(4080,' Gandevi',475),(4081,' Chikhli',475),(4082,' Bansda',475),(4083,' Valsad',476),(4084,' Valsad',476),(4085,' Dharampur',476),(4086,' Pardi',476),(4087,' Kaprada',476),(4088,' Umbergaon',476),(4089,' DAMAN & DIU',477),(4090,' Diu',478),(4091,' Diu',478),(4092,' Daman',479),(4093,' Daman',479),(4094,' DADRA & NAGAR HAVELI',480),(4095,' Dadra & Nagar Haveli',481),(4096,' Dadra & Nagar Haveli',481),(4097,' MAHARASHTRA',482),(4098,' Nandurbar *',483),(4099,' Akkalkuwa',483),(4100,' Akrani',483),(4101,' Talode',483),(4102,' Shahade',483),(4103,' Nandurbar',483),(4104,' Nawapur',483),(4105,' Dhule',484),(4106,' Shirpur',484),(4107,' Sindkhede',484),(4108,' Sakri',484),(4109,' Dhule',484),(4110,' Jalgaon',485),(4111,' Chopda',485),(4112,' Yawal',485),(4113,' Raver',485),(4114,' Edlabad (Muktainagar)',485),(4115,' Bodvad',485),(4116,' Bhusawal',485),(4117,' Jalgaon',485),(4118,' Erandol',485),(4119,' Dharangaon',485),(4120,' Amalner',485),(4121,' Parola',485),(4122,' Bhadgaon',485),(4123,' Chalisgaon',485),(4124,' Pachora',485),(4125,' Jamner',485),(4126,' Buldana',486),(4127,' Jalgaon (Jamod)',486),(4128,' Sangrampur',486),(4129,' Shegaon',486),(4130,' Nandura',486),(4131,' Malkapur',486),(4132,' Motala',486),(4133,' Khamgaon',486),(4134,' Mehkar',486),(4135,' Chikhli',486),(4136,' Buldana',486),(4137,' Deolgaon Raja',486),(4138,' Sindkhed Raja',486),(4139,' Lonar',486),(4140,' Akola',487),(4141,' Telhara',487),(4142,' Akot',487),(4143,' Balapur',487),(4144,' Akola',487),(4145,' Murtijapur',487),(4146,' Patur',487),(4147,' Barshitakli',487),(4148,' Washim *',488),(4149,' Malegaon',488),(4150,' Mangrulpir',488),(4151,' Karanja',488),(4152,' Manora',488),(4153,' Washim',488),(4154,' Risod',488),(4155,' Amravati',489),(4156,' Dharni',489),(4157,' Chikhaldara',489),(4158,' Anjangaon Surji',489),(4159,' Achalpur',489),(4160,' Chandurbazar',489),(4161,' Morshi',489),(4162,' Warud',489),(4163,' Teosa',489),(4164,' Amravati',489),(4165,' Bhatkuli',489),(4166,' Daryapur',489),(4167,' Nandgaon-Khandeshwar',489),(4168,' Chandur Railway',489),(4169,' Dhamangaon Railway',489),(4170,' Wardha',490),(4171,' Ashti',490),(4172,' Karanja',490),(4173,' Arvi',490),(4174,' Seloo',490),(4175,' Wardha',490),(4176,' Deoli',490),(4177,' Hinganghat',490),(4178,' Samudrapur',490),(4179,' Nagpur',491),(4180,' Narkhed',491),(4181,' Katol',491),(4182,' Kalameshwar',491),(4183,' Savner',491),(4184,' Parseoni',491),(4185,' Ramtek',491),(4186,' Mauda',491),(4187,' Kamptee',491),(4188,' Nagpur (Rural)',491),(4189,' Nagpur (Urban)',491),(4190,' Hingna',491),(4191,' Umred',491),(4192,' Kuhi',491),(4193,' Bhiwapur',491),(4194,' Bhandara',492),(4195,' Tumsar',492),(4196,' Mohadi',492),(4197,' Bhandara',492),(4198,' Sakoli',492),(4199,' Lakhani',492),(4200,' Pauni',492),(4201,' Lakhandur',492),(4202,' Gondiya *',493),(4203,' Tirora',493),(4204,' Goregaon',493),(4205,' Gondiya',493),(4206,' Amgaon',493),(4207,' Salekasa',493),(4208,' Sadak-Arjuni',493),(4209,' Arjuni Morgaon',493),(4210,' Deori',493),(4211,' Gadchiroli',494),(4212,' Desaiganj (Vadasa)',494),(4213,' Armori',494),(4214,' Kurkheda',494),(4215,' Korchi',494),(4216,' Dhanora',494),(4217,' Gadchiroli',494),(4218,' Chamorshi',494),(4219,' Mulchera',494),(4220,' Etapalli',494),(4221,' Bhamragad',494),(4222,' Aheri',494),(4223,' Sironcha',494),(4224,' Chandrapur',495),(4225,' Warora',495),(4226,' Chimur',495),(4227,' Nagbhir',495),(4228,' Brahmapuri',495),(4229,' Sawali',495),(4230,' Sindewahi',495),(4231,' Bhadravati',495),(4232,' Chandrapur',495),(4233,' Mul',495),(4234,' Pombhurna',495),(4235,' Ballarpur',495),(4236,' Korpana',495),(4237,' Rajura',495),(4238,' Gondpipri',495),(4239,' Yavatmal',496),(4240,' Ner',496),(4241,' Babulgaon',496),(4242,' Kalamb',496),(4243,' Yavatmal',496),(4244,' Darwha',496),(4245,' Digras',496),(4246,' Pusad',496),(4247,' Umarkhed',496),(4248,' Mahagaon',496),(4249,' Arni',496),(4250,' Ghatanji',496),(4251,' Kelapur',496),(4252,' Ralegaon',496),(4253,' Maregaon',496),(4254,' Zari-Jamani',496),(4255,' Wani',496),(4256,' Nanded',497),(4257,' Mahoor',497),(4258,' Kinwat',497),(4259,' Himayatnagar',497),(4260,' Hadgaon',497),(4261,' Ardhapur',497),(4262,' Nanded',497),(4263,' Mudkhed',497),(4264,' Bhokar',497),(4265,' Umri',497),(4266,' Dharmabad',497),(4267,' Biloli',497),(4268,' Naigaon (Khairgaon)',497),(4269,' Loha',497),(4270,' Kandhar',497),(4271,' Mukhed',497),(4272,' Deglur',497),(4273,' Hingoli *',498),(4274,' Sengaon',498),(4275,' Hingoli',498),(4276,' Aundha (Nagnath)',498),(4277,' Kalamnuri',498),(4278,' Basmath',498),(4279,' Parbhani',499),(4280,' Sailu',499),(4281,' Jintur',499),(4282,' Parbhani',499),(4283,' Manwath',499),(4284,' Pathri',499),(4285,' Sonpeth',499),(4286,' Gangakhed',499),(4287,' Palam',499),(4288,' Purna',499),(4289,' Jalna',500),(4290,' Bhokardan',500),(4291,' Jafferabad',500),(4292,' Jalna',500),(4293,' Badnapur',500),(4294,' Ambad',500),(4295,' Ghansawangi',500),(4296,' Partur',500),(4297,' Mantha',500),(4298,' Aurangabad',501),(4299,' Kannad',501),(4300,' Soegaon',501),(4301,' Sillod',501),(4302,' Phulambri',501),(4303,' Aurangabad',501),(4304,' Khuldabad',501),(4305,' Vaijapur',501),(4306,' Gangapur',501),(4307,' Paithan',501),(4308,' Nashik',502),(4309,' Surgana',502),(4310,' Kalwan',502),(4311,' Deola',502),(4312,' Baglan',502),(4313,' Malegaon',502),(4314,' Nandgaon',502),(4315,' Chandvad',502),(4316,' Dindori',502),(4317,' Peint',502),(4318,' Trimbakeshwar',502),(4319,' Nashik',502),(4320,' Igatpuri',502),(4321,' Sinnar',502),(4322,' Niphad',502),(4323,' Yevla',502),(4324,' Thane',503),(4325,' Talasari',503),(4326,' Dahanu',503),(4327,' Vikramgad',503),(4328,' Jawhar',503),(4329,' Mokhada',503),(4330,' Vada',503),(4331,' Palghar',503),(4332,' Vasai',503),(4333,' Thane',503),(4334,' Bhiwandi',503),(4335,' Shahapur',503),(4336,' Kalyan',503),(4337,' Ulhasnagar',503),(4338,' Ambarnath',503),(4339,' Murbad',503),(4340,' Mumbai (Suburban) *',504),(4341,' Mumbai',505),(4342,' Raigarh',506),(4343,' Uran',506),(4344,' Panvel',506),(4345,' Karjat',506),(4346,' Khalapur',506),(4347,' Pen',506),(4348,' Alibag',506),(4349,' Murud',506),(4350,' Roha',506),(4351,' Sudhagad',506),(4352,' Mangaon',506),(4353,' Tala',506),(4354,' Shrivardhan',506),(4355,' Mhasla',506),(4356,' Mahad',506),(4357,' Poladpur',506),(4358,' Pune',507),(4359,' Junnar',507),(4360,' Ambegaon',507),(4361,' Shirur',507),(4362,' Khed',507),(4363,' Mawal',507),(4364,' Mulshi',507),(4365,' Haveli',507),(4366,' Pune City',507),(4367,' Daund',507),(4368,' Purandhar',507),(4369,' Velhe',507),(4370,' Bhor',507),(4371,' Baramati',507),(4372,' Indapur',507),(4373,' Ahmadnagar',508),(4374,' Akola',508),(4375,' Sangamner',508),(4376,' Kopargaon',508),(4377,' Rahta',508),(4378,' Shrirampur',508),(4379,' Nevasa',508),(4380,' Shevgaon',508),(4381,' Pathardi',508),(4382,' Nagar',508),(4383,' Rahuri',508),(4384,' Parner',508),(4385,' Shrigonda',508),(4386,' Karjat',508),(4387,' Jamkhed',508),(4388,' Bid',509),(4389,' Ashti',509),(4390,' Patoda',509),(4391,' Shirur (Kasar)',509),(4392,' Georai',509),(4393,' Manjalegaon',509),(4394,' Wadwani',509),(4395,' Bid',509),(4396,' Kaij',509),(4397,' Dharur',509),(4398,' Parli',509),(4399,' Ambejogai',509),(4400,' Latur',510),(4401,' Latur',510),(4402,' Renapur',510),(4403,' Ahmadpur',510),(4404,' Jalkot',510),(4405,' Chakur',510),(4406,' Shirur-Anantpal',510),(4407,' Ausa',510),(4408,' Nilanga',510),(4409,' Deoni',510),(4410,' Udgir',510),(4411,' Osmanabad',511),(4412,' Paranda',511),(4413,' Bhum',511),(4414,' Washi',511),(4415,' Kalamb',511),(4416,' Osmanabad',511),(4417,' Tuljapur',511),(4418,' Lohara',511),(4419,' Umarga',511),(4420,' Solapur',512),(4421,' Karmala',512),(4422,' Madha',512),(4423,' Barshi',512),(4424,' Solapur North',512),(4425,' Mohol',512),(4426,' Pandharpur',512),(4427,' Malshiras',512),(4428,' Sangole',512),(4429,' Mangalvedhe',512),(4430,' Solapur South',512),(4431,' Akkalkot',512),(4432,' Satara',513),(4433,' Mahabaleshwar',513),(4434,' Wai',513),(4435,' Khandala',513),(4436,' Phaltan',513),(4437,' Man',513),(4438,' Khatav',513),(4439,' Koregaon',513),(4440,' Satara',513),(4441,' Jaoli',513),(4442,' Patan',513),(4443,' Karad',513),(4444,' Ratnagiri',514),(4445,' Mandangad',514),(4446,' Dapoli',514),(4447,' Khed',514),(4448,' Chiplun',514),(4449,' Guhagar',514),(4450,' Ratnagiri',514),(4451,' Sangameshwar',514),(4452,' Lanja',514),(4453,' Rajapur',514),(4454,' Sindhudurg',515),(4455,' Devgad',515),(4456,' Vaibhavvadi',515),(4457,' Kankavli',515),(4458,' Malwan',515),(4459,' Vengurla',515),(4460,' Kudal',515),(4461,' Sawantwadi',515),(4462,' Dodamarg',515),(4463,' Kolhapur',516),(4464,' Shahuwadi',516),(4465,' Panhala',516),(4466,' Hatkanangle',516),(4467,' Shirol',516),(4468,' Karvir',516),(4469,' Bavda',516),(4470,' Radhanagari',516),(4471,' Kagal',516),(4472,' Bhudargad',516),(4473,' Ajra',516),(4474,' Gadhinglaj',516),(4475,' Chandgad',516),(4476,' Sangli',517),(4477,' Shirala',517),(4478,' Walwa',517),(4479,' Palus',517),(4480,' Khanapur',517),(4481,' Atpadi',517),(4482,' Tasgaon',517),(4483,' Miraj',517),(4484,' Kavathe-Mahankal',517),(4485,' Jat',517),(4486,' ANDHRA PRADESH',518),(4487,' Adilabad',519),(4488,' Tamsi',519),(4489,' Adilabad',519),(4490,' Jainad',519),(4491,' Bela',519),(4492,' Talamadugu',519),(4493,' Gudihatnoor',519),(4494,' Indervelly',519),(4495,' Narnoor',519),(4496,' Kerameri ',519),(4497,' Wankidi',519),(4498,' Sirpur (T)',519),(4499,' Koutala',519),(4500,' Bejjur',519),(4501,' Kaghaznagar ',519),(4502,' Asifabad ',519),(4503,' Jainoor',519),(4504,' Utnoor',519),(4505,' Ichoda',519),(4506,' Bazarhatnoor',519),(4507,' Boath',519),(4508,' Neeradigonda',519),(4509,' Sirpur',519),(4510,' Rebbena',519),(4511,' Bhimini',519),(4512,' Dahegaon',519),(4513,' Vemanpalle',519),(4514,' Nennel',519),(4515,' Tandur',519),(4516,' Tiryani',519),(4517,' Jannaram',519),(4518,' Kaddam (Peddur)',519),(4519,' Sarangapur',519),(4520,' Kuntala',519),(4521,' Kubeer',519),(4522,' Bhainsa',519),(4523,' Thanoor',519),(4524,' Mudhole',519),(4525,' Lokeshwaram',519),(4526,' Dilawarpur',519),(4527,' Nirmal',519),(4528,' Laxmanchanda',519),(4529,' Mamda',519),(4530,' Khanapur',519),(4531,' Dandepalle',519),(4532,' Kasipet',519),(4533,' Bellampalle',519),(4534,' Kotapalle',519),(4535,' Mandamarri',519),(4536,' Luxettipet',519),(4537,' Mancherial',519),(4538,' Jaipur',519),(4539,' Chennur',519),(4540,' Nizamabad',520),(4541,' Ranjal',520),(4542,' Navipet',520),(4543,' Nandipet',520),(4544,' Armur',520),(4545,' Balkonda',520),(4546,' Mortad',520),(4547,' Kammar palle',520),(4548,' Bheemgal',520),(4549,' Velpur',520),(4550,' Jakranpalle',520),(4551,' Makloor',520),(4552,' Nizamabad',520),(4553,' Yedpalle',520),(4554,' Bodhan',520),(4555,' Kotgiri',520),(4556,' Madnoor',520),(4557,' Jukkal',520),(4558,' Bichkunda',520),(4559,' Birkoor',520),(4560,' Varni',520),(4561,' Dichpalle',520),(4562,' Dharpalle',520),(4563,' Sirkonda',520),(4564,' Machareddy',520),(4565,' Sadasivanagar',520),(4566,' Gandhari',520),(4567,' Banswada',520),(4568,' Pitlam',520),(4569,' Nizamsagar',520),(4570,' Yellareddy',520),(4571,' Nagareddypet',520),(4572,' Lingampet',520),(4573,' Tadwai',520),(4574,' Kamareddy',520),(4575,' Bhiknur',520),(4576,' Domakonda',520),(4577,' Karimnagar',521),(4578,' Ibrahimpatnam',521),(4579,' Mallapur',521),(4580,' Raikal',521),(4581,' Sarangapur',521),(4582,' Dharmapuri',521),(4583,' Velgatoor',521),(4584,' Ramagundam',521),(4585,' Kamanpur',521),(4586,' Manthani',521),(4587,' Kataram',521),(4588,' Mahadevpur',521),(4589,' Mutharam (N)',521),(4590,' Malharrao mandal',521),(4591,' Mutharam (A)',521),(4592,' Srirampur',521),(4593,' Peddapalle',521),(4594,' Julapalle',521),(4595,' Bommareddypalle (H/o.Dharmaram)',521),(4596,' Gollapalle',521),(4597,' Mallial',521),(4598,' Jagtial',521),(4599,' Medipalle',521),(4600,' Koratla',521),(4601,' Metpalle',521),(4602,' Kathlapur',521),(4603,' Chandurthi',521),(4604,' Kodimial',521),(4605,' Pegadapalle',521),(4606,' Gangadhara',521),(4607,' Ramadugu',521),(4608,' Choppadandi',521),(4609,' Sulthanabad',521),(4610,' Odela',521),(4611,' Manakondur',521),(4612,' Karimnagar',521),(4613,' Boinpalle',521),(4614,' Vemulawada',521),(4615,' Konaraopeta',521),(4616,' Yellareddipet',521),(4617,' Gambhiraopet',521),(4618,' Mustabad',521),(4619,' Sirsilla',521),(4620,' Ellanthakunta',521),(4621,' Bejjanki',521),(4622,' Thimmapur (LMD)',521),(4623,' Veenavanka',521),(4624,' Jammikunta',521),(4625,' Shankarapeta kesavapatnam',521),(4626,' Chigurumamidi',521),(4627,' Koheda',521),(4628,' Husnabad',521),(4629,' Saidapur',521),(4630,' Huzurabad',521),(4631,' Kamalapur',521),(4632,' Bheemadevarpalle',521),(4633,' Elkathurthy',521),(4634,' Medak',522),(4635,' Kangti',522),(4636,' Manoor',522),(4637,' Narayankhed',522),(4638,' Kalher',522),(4639,' Shankarampet (A)',522),(4640,' Papannapet',522),(4641,' Medak',522),(4642,' Ramayampet',522),(4643,' Dubbak',522),(4644,' Siddipet',522),(4645,' Chinnakodur',522),(4646,' Nangnoor',522),(4647,' Kondapak',522),(4648,' Mirdoddi',522),(4649,' Doulthabad',522),(4650,' Chegunta',522),(4651,' Shankarampet (R)',522),(4652,' Kulcharam',522),(4653,' Tekmal',522),(4654,' Alladurg',522),(4655,' Regode',522),(4656,' Raikode',522),(4657,' Nyalkal',522),(4658,' Zahirabad',522),(4659,' Kohir',522),(4660,' Jharasangam',522),(4661,' Munipalle',522),(4662,' Pulkal',522),(4663,' Andole',522),(4664,' Kowdipalle',522),(4665,' Veldurthy',522),(4666,' Tupran',522),(4667,' Gajwel',522),(4668,' Jagdevpur',522),(4669,' Wargal',522),(4670,' Mulugu',522),(4671,' Shivampet',522),(4672,' Narsapur',522),(4673,' Hathnoora',522),(4674,' Sadasivpet',522),(4675,' Kondapoor',522),(4676,' Sangareddy',522),(4677,' Jinnaram',522),(4678,' Patancheru',522),(4679,' Ramchandrapuram',522),(4680,' Hyderabad',523),(4681,' Shaikpet',523),(4682,' Ameerpet',523),(4683,' Secunderabad',523),(4684,' Tirumalagiri',523),(4685,' Maredpalle',523),(4686,' Musheerabad',523),(4687,' Amberpet',523),(4688,' Himayathnagar',523),(4689,' Nampally',523),(4690,' Khairatabad',523),(4691,' Asifnagar',523),(4692,' Golconda',523),(4693,' Bahadurpura',523),(4694,' Bandlaguda',523),(4695,' Charminar',523),(4696,' Saidabad',523),(4697,' Rangareddi',524),(4698,' Marpalle',524),(4699,' Mominpet',524),(4700,' Nawabpet',524),(4701,' Shankarpalle',524),(4702,' Serilingampalle',524),(4703,' Balanagar',524),(4704,' Quthbullapur',524),(4705,' Medchal',524),(4706,' Shamirpet',524),(4707,' Malkajgiri',524),(4708,' Keesara',524),(4709,' Ghatkesar',524),(4710,' Uppal kalan ',524),(4711,' Hayathnagar',524),(4712,' Saroornagar',524),(4713,' Rajendranagar',524),(4714,' Moinabad',524),(4715,' Chevella',524),(4716,' Vicarabad',524),(4717,' Dharur',524),(4718,' Bantwaram',524),(4719,' Peddemul',524),(4720,' Tandur',524),(4721,' Basheerabad',524),(4722,' Yalal',524),(4723,' Doma',524),(4724,' Gandeed',524),(4725,' Kulkacharla',524),(4726,' Pargi',524),(4727,' Pudur',524),(4728,' Shabad',524),(4729,' Shamshabad',524),(4730,' Maheswaram',524),(4731,' Kandukur',524),(4732,' Ibrahimpatnam',524),(4733,' Manchal',524),(4734,' Yacharam',524),(4735,' Mahbubnagar',525),(4736,' Kodangal',525),(4737,' Bomraspet',525),(4738,' Kosgi',525),(4739,' Doulathabad',525),(4740,' Damaragidda',525),(4741,' Maddur',525),(4742,' Hanwada',525),(4743,' Nawabpet',525),(4744,' Balanagar',525),(4745,' Kondurg',525),(4746,' Farooqnagar',525),(4747,' Kothur',525),(4748,' Keshampet',525),(4749,' Talakondapalle',525),(4750,' Amangal',525),(4751,' Madgul',525),(4752,' Veldanda',525),(4753,' Midjil',525),(4754,' Jadcharla',525),(4755,' Mahabubnagar',525),(4756,' Koilkonda',525),(4757,' Narayanpet',525),(4758,' Utkoor',525),(4759,' Dhanwada',525),(4760,' Devarkadra',525),(4761,' Bhoothpur',525),(4762,' Thimmajipet',525),(4763,' Kalwakurthy',525),(4764,' Vangoor',525),(4765,' Amrabad',525),(4766,' Achampet',525),(4767,' Uppununthala',525),(4768,' Telkapalle',525),(4769,' Tadoor',525),(4770,' Nagarkurnool',525),(4771,' Bijinapalle',525),(4772,' Ghanpur',525),(4773,' Addakal',525),(4774,' Chinnachintakunta',525),(4775,' Narwa',525),(4776,' Makthal',525),(4777,' Maganoor',525),(4778,' Dharur',525),(4779,' Atmakur',525),(4780,' Kothakota',525),(4781,' Peddamandadi',525),(4782,' Wanaparthy',525),(4783,' Gopalpeta',525),(4784,' Balmoor',525),(4785,' Lingal',525),(4786,' Peddakothapalle',525),(4787,' Kodair',525),(4788,' Pangal',525),(4789,' Pebbair',525),(4790,' Gadwal',525),(4791,' Maldakal',525),(4792,' Ghattu',525),(4793,' Aiza',525),(4794,' Itikyal',525),(4795,' Weepangandla',525),(4796,' Kollapur',525),(4797,' Waddepalle',525),(4798,' Manopad',525),(4799,' Alampur',525),(4800,' Nalgonda',526),(4801,' Bommalaramaram',526),(4802,' M.Turkapalle',526),(4803,' Rajapet',526),(4804,' Yadagirigutta',526),(4805,' Alair',526),(4806,' Gundala',526),(4807,' Thirumalgiri',526),(4808,' Thungathurthi',526),(4809,' Nuthankal',526),(4810,' Atmakur (S)',526),(4811,' Jaji reddi gudem',526),(4812,' Sali gouraram',526),(4813,' Mothkur',526),(4814,' Atmakur (M)',526),(4815,' Valigonda',526),(4816,' Bhuvanagiri',526),(4817,' Bibinagar',526),(4818,' Pochampalle',526),(4819,' Choutuppal',526),(4820,' Ramannapeta',526),(4821,' Chityala',526),(4822,' Narketpalle',526),(4823,' Kattangoor',526),(4824,' Nakrekal',526),(4825,' Kethe palle',526),(4826,' Suryapet',526),(4827,' Chivvemla',526),(4828,' Mothey',526),(4829,' Nadigudem',526),(4830,' Munagala',526),(4831,' Penpahad',526),(4832,' Vemulapalle',526),(4833,' Thipparthi',526),(4834,' Nalgonda',526),(4835,' Munugode',526),(4836,' Narayanpur',526),(4837,' Marriguda',526),(4838,' Chintha palle',526),(4839,' Gundla palle',526),(4840,' Chandam pet',526),(4841,' Devarkonda',526),(4842,' Nampalle',526),(4843,' Chandur',526),(4844,' Kangal',526),(4845,' Gurrampode',526),(4846,' Pedda adiserla palle',526),(4847,' Peddavoora',526),(4848,' Anumula',526),(4849,' Nidamanur',526),(4850,' Thripuraram',526),(4851,' Damaracherla',526),(4852,' Miryalaguda',526),(4853,' Nereducherla',526),(4854,' Garide palle',526),(4855,' Chilkur',526),(4856,' Kodad',526),(4857,' Huzurnagar',526),(4858,' Mattam palle',526),(4859,' Mella cheruvu',526),(4860,' Warangal',527),(4861,' Cherial',527),(4862,' Maddur',527),(4863,' Bachannapet',527),(4864,' Narmetta',527),(4865,' Ghanpur (Station)',527),(4866,' Dharamsagar',527),(4867,' Hasanparthy',527),(4868,' Parakal',527),(4869,' Mogullapalle',527),(4870,' Chityal',527),(4871,' Bhupalpalle',527),(4872,' Ghanpur (Mulug)',527),(4873,' Venkatapur',527),(4874,' Eturnagaram',527),(4875,' Mangapet',527),(4876,' Tadvai',527),(4877,' Govindaraopet',527),(4878,' Mulug',527),(4879,' Regonda',527),(4880,' Shyampet',527),(4881,' Nallabelly',527),(4882,' Duggondi',527),(4883,' Atmakur',527),(4884,' Hanamkonda',527),(4885,' Zaffergadh',527),(4886,' Palakurthi',527),(4887,' Raghunathpalle',527),(4888,' Jangaon',527),(4889,' Lingalaghanpur',527),(4890,' Devaruppula',527),(4891,' Kodakandla',527),(4892,' Raiparthy',527),(4893,' Wardhanna pet',527),(4894,' Sangam',527),(4895,' Warangal',527),(4896,' Geesugonda',527),(4897,' Narsampet',527),(4898,' Khanapur',527),(4899,' Kothagudem',527),(4900,' Gudur',527),(4901,' Chennaraopet',527),(4902,' Nekkonda',527),(4903,' Parvathagiri',527),(4904,' Thorrur',527),(4905,' Nellikudur',527),(4906,' Kesamudram',527),(4907,' Mahabubabad',527),(4908,' Narsimhulapet',527),(4909,' Maripeda',527),(4910,' Kuravi',527),(4911,' Dornakal',527),(4912,' Khammam',528),(4913,' Wazeed',528),(4914,' Venkatapuram',528),(4915,' Pinapaka',528),(4916,' Cherla',528),(4917,' Manugur',528),(4918,' Aswapuram',528),(4919,' Dummugudem',528),(4920,' Bhadrachalam',528),(4921,' Kunavaram',528),(4922,' Chintur',528),(4923,' Vararamachandrapuram',528),(4924,' Velairpad',528),(4925,' Kukunoor',528),(4926,' Burgumpahad',528),(4927,' Palwancha',528),(4928,' Kothagudem',528),(4929,' Tekulapalle',528),(4930,' Yellandu',528),(4931,' Gundala',528),(4932,' Bayyaram',528),(4933,' Garla',528),(4934,' Singareni',528),(4935,' Kamepalle',528),(4936,' Julurpadu',528),(4937,' Chandrugonda',528),(4938,' Mulkalapalle',528),(4939,' Aswaraopet',528),(4940,' Dammapet',528),(4941,' Sathupalle',528),(4942,' Penuballe',528),(4943,' Enkuru',528),(4944,' Tirumalayapalem',528),(4945,' Kusumanchi',528),(4946,' Khammam (Rural)',528),(4947,' Khammam (Urban)',528),(4948,' Mudigonda',528),(4949,' Nelakondapalle',528),(4950,' Chinthakani',528),(4951,' Konijerla',528),(4952,' Tallada',528),(4953,' Kallur',528),(4954,' Wyra',528),(4955,' Bonakal',528),(4956,' Madhira',528),(4957,' Yerrupalem',528),(4958,' Vemsoor',528),(4959,' Srikakulam',529),(4960,' Veeraghattam',529),(4961,' Seethampeta',529),(4962,' Bhamini',529),(4963,' Kothuru',529),(4964,' Pathapatnam',529),(4965,' Meliaputtu',529),(4966,' Palasa',529),(4967,' Mandasa',529),(4968,' Kanchili',529),(4969,' Ichchapuram',529),(4970,' Kaviti',529),(4971,' Sompeta',529),(4972,' Vajrapukothuru',529),(4973,' Nandigam',529),(4974,' Hiramandalam',529),(4975,' Palakonda',529),(4976,' Vangara',529),(4977,' Regidi Amadalavalasa',529),(4978,' Laxminarasupeta',529),(4979,' Saravakota',529),(4980,' Tekkali',529),(4981,' Santhabommali',529),(4982,' Kotabommili',529),(4983,' Jalumuru',529),(4984,' Sarubujjili',529),(4985,' Burja',529),(4986,' Santhakaviti',529),(4987,' Rajam',529),(4988,' Ganguvarisigadam',529),(4989,' Amadalavalasa',529),(4990,' Narasannapeta',529),(4991,' Polaki',529),(4992,' Gara',529),(4993,' Srikakulam',529),(4994,' Ponduru',529),(4995,' Laveru',529),(4996,' Ranasthalam',529),(4997,' Etcherla',529),(4998,' Vizianagaram',530),(4999,' Komarada',530),(5000,' Gummalakshmipuram',530),(5001,' Kurupam',530),(5002,' Jiyyammavalasa',530),(5003,' Garugubilli',530),(5004,' Parvathipuram',530),(5005,' Makkuva',530),(5006,' Seethanagaram',530),(5007,' Balijipeta',530),(5008,' Bobbili',530),(5009,' Salur',530),(5010,' Pachipenta',530),(5011,' Ramabhadrapuram',530),(5012,' Badangi',530),(5013,' Therlam',530),(5014,' Merakamudidam',530),(5015,' Dathirajeru',530),(5016,' Mentada',530),(5017,' Gajapathinagaram',530),(5018,' Garividi',530),(5019,' Cheepurupalle',530),(5020,' Gurla',530),(5021,' Bondapalle',530),(5022,' Gantyada',530),(5023,' Srungavarapukota',530),(5024,' Vepada',530),(5025,' Lakkavarapukota',530),(5026,' Kothavalasa',530),(5027,' Jami',530),(5028,' Vizianagaram',530),(5029,' Nellimarla',530),(5030,' Pusapatirega',530),(5031,' Denkada',530),(5032,' Bhogapuram',530),(5033,' Visakhapatnam',531),(5034,' Munchingi puttu',531),(5035,' Peda bayalu',531),(5036,' Dumbriguda',531),(5037,' Araku valley',531),(5038,' Ananthagiri',531),(5039,' Hukumpeta',531),(5040,' Paderu',531),(5041,' G.madugula',531),(5042,' Chintapalle',531),(5043,' Gudem kotha veedhi',531),(5044,' Koyyuru',531),(5045,' Nathavaram',531),(5046,' Golugonda',531),(5047,' Narsipatnam',531),(5048,' Rolugunta',531),(5049,' Ravikamatham',531),(5050,' Madugula',531),(5051,' Cheedikada',531),(5052,' Devarapalle',531),(5053,' K.Kotapadu',531),(5054,' Sabbavaram',531),(5055,' Pendurthi',531),(5056,' Anandapuram',531),(5057,' Padmanabham',531),(5058,' Bheemunipatnam',531),(5059,' Visakhapatnam (Rural)',531),(5060,' Visakhapatnam (Urban)',531),(5061,' Pedagantyada',531),(5062,' Gajuwaka',531),(5063,' Paravada',531),(5064,' Anakapalle',531),(5065,' Chodavaram',531),(5066,' Butchayyapeta',531),(5067,' Kotauratla',531),(5068,' Makavarapalem',531),(5069,' Kasimkota',531),(5070,' Munagapaka',531),(5071,' Atchutapuram',531),(5072,' Yelamanchili',531),(5073,' Nakkapalle',531),(5074,' Payakaraopeta',531),(5075,' S.Rayavaram',531),(5076,' Rambilli',531),(5077,' East Godavari',532),(5078,' Maredumilli',532),(5079,' Devipatnam',532),(5080,' Y. Ramavaram',532),(5081,' Addateegala',532),(5082,' Rajavommangi',532),(5083,' Kotananduru',532),(5084,' Tuni',532),(5085,' Sankhavaram',532),(5086,' Yeleswaram',532),(5087,' Gangavaram',532),(5088,' Rampachodavaram',532),(5089,' Seethanagaram',532),(5090,' Gokavaram',532),(5091,' Jaggampeta',532),(5092,' Kirlampudi',532),(5093,' Prathipadu',532),(5094,' Thondangi',532),(5095,' Gollaprolu',532),(5096,' Peddapuram',532),(5097,' Gandepalle',532),(5098,' Korukonda',532),(5099,' Rajahmundry (U)',532),(5100,' Rajahmundry Rural',532),(5101,' Rajanagaram',532),(5102,' Rangampeta',532),(5103,' Samalkota',532),(5104,' Pithapuram',532),(5105,' Kothapalle',532),(5106,' Kakinada Rural',532),(5107,' Kakinada (U)',532),(5108,' Pedapudi',532),(5109,' Biccavolu',532),(5110,' Anaparthy',532),(5111,' Kadiam',532),(5112,' Atreyapuram',532),(5113,' Mandapeta',532),(5114,' Rayavaram',532),(5115,' Karapa',532),(5116,' Kajuluru',532),(5117,' Ramachandrapuram',532),(5118,' Alamuru',532),(5119,' Ravulapalem',532),(5120,' Kothapeta',532),(5121,' Kapileswarapuram',532),(5122,' Pamarru',532),(5123,' Thallarevu',532),(5124,' I. Polavaram',532),(5125,' Mummidivaram',532),(5126,' Ainavilli',532),(5127,' P.Gannavaram',532),(5128,' Ambajipeta',532),(5129,' Mamidikuduru',532),(5130,' Razole',532),(5131,' Malikipuram',532),(5132,' Sakhinetipalle',532),(5133,' Allavaram',532),(5134,' Amalapuram',532),(5135,' Uppalaguptam',532),(5136,' Katrenikona',532),(5137,' West Godavari',533),(5138,' Chintalapudi',533),(5139,' Lingapalem',533),(5140,' T.Narasapuram',533),(5141,' Jeelugu milli',533),(5142,' Buttayagudem',533),(5143,' Polavaram',533),(5144,' Tallapudi',533),(5145,' Gopalapuram',533),(5146,' Koyyalagudem',533),(5147,' Jangareddigudem',533),(5148,' Kamavarapukota',533),(5149,' Dwarakatirumala',533),(5150,' Nallajerla',533),(5151,' Devarapalle',533),(5152,' Kovvur',533),(5153,' Chagallu',533),(5154,' Nidadavole',533),(5155,' Tadepalligudem',533),(5156,' Unguturu',533),(5157,' Bhimadole',533),(5158,' Pedavegi',533),(5159,' Pedapadu',533),(5160,' Eluru',533),(5161,' Denduluru',533),(5162,' Nidamarru',533),(5163,' Pentapadu',533),(5164,' Undrajavaram',533),(5165,' Peravali',533),(5166,' Tanuku',533),(5167,' Attili',533),(5168,' Ganapavaram',533),(5169,' Akividu',533),(5170,' Undi',533),(5171,' Palacoderu',533),(5172,' Penumantra',533),(5173,' Iragavaram',533),(5174,' Penugonda',533),(5175,' Achanta',533),(5176,' Poduru',533),(5177,' Veeravasaram',533),(5178,' Bhimavaram',533),(5179,' Kalla',533),(5180,' Mogaltur',533),(5181,' Narsapur',533),(5182,' Palacole',533),(5183,' Elamanchili',533),(5184,' Krishna',534),(5185,' Vatsavai',534),(5186,' Jaggayyapeta',534),(5187,' Penuganchiprolu',534),(5188,' Nandigama',534),(5189,' Veerullapadu',534),(5190,' Mylavaram',534),(5191,' Gampalagudem',534),(5192,' Tiruvuru',534),(5193,' A.Konduru',534),(5194,' Reddigudem',534),(5195,' Vissannapeta',534),(5196,' Chatrai',534),(5197,' Musunuru',534),(5198,' Nuzvid',534),(5199,' Bapulapadu',534),(5200,' Agiripalle',534),(5201,' G.Konduru',534),(5202,' Kanchikacherla',534),(5203,' Chandarlapadu',534),(5204,' Ibrahimpatnam',534),(5205,' Vijayawada (Urban)',534),(5206,' Vijayawada (Rural)',534),(5207,' Gannavaram',534),(5208,' Unguturu',534),(5209,' Nandivada',534),(5210,' Mandavalli',534),(5211,' Kaikalur',534),(5212,' Kalidindi',534),(5213,' Kruthivennu',534),(5214,' Bantumilli',534),(5215,' Mudinepalle',534),(5216,' Gudivada',534),(5217,' Pedaparupudi',534),(5218,' Kankipadu',534),(5219,' Penamaluru',534),(5220,' Thotlavalluru',534),(5221,' Pamidimukkala',534),(5222,' Vuyyuru',534),(5223,' Pamarru',534),(5224,' Gudlavalleru',534),(5225,' Pedana',534),(5226,' Guduru',534),(5227,' Movva',534),(5228,' Ghantasala',534),(5229,' Machilipatnam',534),(5230,' Challapalle',534),(5231,' Mopidevi',534),(5232,' Avanigadda',534),(5233,' Nagayalanka',534),(5234,' Koduru',534),(5235,' Guntur',535),(5236,' Macherla',535),(5237,' Veldurthy',535),(5238,' Durgi',535),(5239,' Rentachintala',535),(5240,' Gurazala',535),(5241,' Dachepalle',535),(5242,' Karempudi',535),(5243,' Piduguralla',535),(5244,' Machavaram',535),(5245,' Bellamkonda',535),(5246,' Atchampet',535),(5247,' Krosuru',535),(5248,' Amaravathi',535),(5249,' Thullur',535),(5250,' Tadepalle',535),(5251,' Mangalagiri',535),(5252,' Tadikonda',535),(5253,' Pedakurapadu',535),(5254,' Sattenapalle',535),(5255,' Rajupalem',535),(5256,' Nekarikallu',535),(5257,' Bollapalle',535),(5258,' Vinukonda',535),(5259,' Nuzendla',535),(5260,' Savalyapuram Kanumarlapudi',535),(5261,' Ipur',535),(5262,' Rompicherla',535),(5263,' Narasaraopeta',535),(5264,' Muppalla',535),(5265,' Nadendla',535),(5266,' Chilakaluripet H/o.Purushotha Patnam',535),(5267,' Edlapadu',535),(5268,' Phirangipuram',535),(5269,' Medikonduru',535),(5270,' Guntur',535),(5271,' Pedakakani',535),(5272,' Duggirala',535),(5273,' Kollipara',535),(5274,' Tenali',535),(5275,' Chebrolu',535),(5276,' Vatticherukuru',535),(5277,' Prathipadu',535),(5278,' Pedanandipadu',535),(5279,' Kakumanu',535),(5280,' Ponnur',535),(5281,' Tsundur',535),(5282,' Amruthalur',535),(5283,' Vemuru',535),(5284,' Kollur',535),(5285,' Bhattiprolu',535),(5286,' Cherukupalle H/o Arumbaka',535),(5287,' Pittalavanipalem',535),(5288,' Karlapalem',535),(5289,' Bapatla',535),(5290,' Nizampatnam',535),(5291,' Nagaram',535),(5292,' Repalle',535),(5293,' Prakasam',536),(5294,' Yerragondapalem',536),(5295,' Pullalacheruvu',536),(5296,' Tripuranthakam',536),(5297,' Dornala',536),(5298,' Pedda Raveedu',536),(5299,' Donakonda',536),(5300,' Kurichedu',536),(5301,' Santhamaguluru',536),(5302,' Ballikurava',536),(5303,' Martur',536),(5304,' Yeddana pudi',536),(5305,' Parchur',536),(5306,' Karamchedu',536),(5307,' Inkollu',536),(5308,' Janakavarampanguluru',536),(5309,' Addanki',536),(5310,' Mundlamuru',536),(5311,' Darsi',536),(5312,' Markapur',536),(5313,' Ardhaveedu',536),(5314,' Cumbum',536),(5315,' Tarlupadu',536),(5316,' Konakanamitla',536),(5317,' Podili',536),(5318,' Thallur',536),(5319,' Korisapadu',536),(5320,' Chirala',536),(5321,' Vetapalem',536),(5322,' Chinaganjam',536),(5323,' Naguluppala padu',536),(5324,' Maddipadu',536),(5325,' Chimakurthy',536),(5326,' Marripudi',536),(5327,' Hanumanthuni padu',536),(5328,' Bestavaripeta',536),(5329,' Racherla',536),(5330,' Giddaluru',536),(5331,' Komarolu',536),(5332,' Veligandla',536),(5333,' Kanigiri',536),(5334,' Kondapi',536),(5335,' Santhanuthala padu',536),(5336,' Ongole',536),(5337,' Kotha patnam',536),(5338,' Tangutur',536),(5339,' Zarugumilli',536),(5340,' Ponnaluru',536),(5341,' Pedacherlo palle',536),(5342,' Chandra sekhara puram',536),(5343,' Pamur',536),(5344,' Voletivaripalem',536),(5345,' Kandukur',536),(5346,' Singarayakonda',536),(5347,' Lingasamudram',536),(5348,' Gudlur',536),(5349,' Ulavapadu',536),(5350,' Nellore',537),(5351,' Seetharamapuram',537),(5352,' Udayagiri',537),(5353,' Varikuntapadu',537),(5354,' Kondapuram',537),(5355,' Jaladanki',537),(5356,' Kavali',537),(5357,' Bogole',537),(5358,' Kaligiri',537),(5359,' Vinjamur',537),(5360,' Duttalur',537),(5361,' Marripadu',537),(5362,' Atmakur',537),(5363,' Anumasamudrampeta',537),(5364,' Dagadarthi',537),(5365,' Allur',537),(5366,' Vidavalur',537),(5367,' Kodavalur',537),(5368,' Buchireddipalem ',537),(5369,' Sangam',537),(5370,' Chejerla',537),(5371,' Ananthasagaram',537),(5372,' Kaluvoya',537),(5373,' Rapur',537),(5374,' Podalakur',537),(5375,' Nellore',537),(5376,' Kovur',537),(5377,' Indukurpet',537),(5378,' Thotapalligudur',537),(5379,' Muthukur',537),(5380,' Venkatachalam',537),(5381,' Manubolu',537),(5382,' Gudur',537),(5383,' Sydapuram',537),(5384,' Dakkili',537),(5385,' Venkatagiri',537),(5386,' Balayapalle',537),(5387,' Ozili',537),(5388,' Chillakur',537),(5389,' Kota',537),(5390,' Vakadu',537),(5391,' Chittamur',537),(5392,' Naidupet',537),(5393,' Pellakur',537),(5394,' Doravarisatram',537),(5395,' Sullurpeta',537),(5396,' Tada',537),(5397,' Cuddapah',538),(5398,' Kondapuram',538),(5399,' Mylavaram',538),(5400,' Peddamudium',538),(5401,' Rajupalem',538),(5402,' Duvvur',538),(5403,' S.Mydukur',538),(5404,' Brahmamgarimattam',538),(5405,' Sri Avadhuth kasinayana',538),(5406,' Kalasapadu',538),(5407,' Porumamilla',538),(5408,' B.Kodur',538),(5409,' Badvel',538),(5410,' Gopavaram',538),(5411,' Khajipet',538),(5412,' Chapadu',538),(5413,' Proddatur',538),(5414,' Jammalamadugu',538),(5415,' Muddanur',538),(5416,' Simhadripuram',538),(5417,' Lingala',538),(5418,' Pulivendla',538),(5419,' Vemula',538),(5420,' Thondur',538),(5421,' Veerapunayunipalle',538),(5422,' Yerraguntla',538),(5423,' Kamalapuram',538),(5424,' Vallur',538),(5425,' Chennur',538),(5426,' Atlur',538),(5427,' Vontimitta',538),(5428,' Sidhout',538),(5429,' Cuddapah',538),(5430,' Chinthakommadinne',538),(5431,' Pendlimarry',538),(5432,' Vempalle',538),(5433,' Chakarayapet',538),(5434,' Galiveedu',538),(5435,' Chinnamudiam',538),(5436,' Sambepalle',538),(5437,' T.Sundupalle',538),(5438,' Rayachoti',538),(5439,' Lakkireddipalle',538),(5440,' Ramapuram',538),(5441,' Veeraballe',538),(5442,' Nandalur',538),(5443,' Penagalur',538),(5444,' Chitvel',538),(5445,' Rajampet',538),(5446,' Pullampet',538),(5447,' Obulavaripalle',538),(5448,' Rly.kodur',538),(5449,' Kurnool',539),(5450,' Mantralayam',539),(5451,' Kosigi',539),(5452,' Kowthalam',539),(5453,' Pedda kadabur',539),(5454,' Yemmiganur',539),(5455,' Nandavaram',539),(5456,' C.Belagal',539),(5457,' Gudur',539),(5458,' Kallur',539),(5459,' Kurnool',539),(5460,' Nandikotkur',539),(5461,' Pagidyala',539),(5462,' Jupadu bungalow',539),(5463,' Kothapalle',539),(5464,' Srisailam',539),(5465,' Atmakur',539),(5466,' Pamulapadu',539),(5467,' Midthur',539),(5468,' Orvakal',539),(5469,' Kodumur',539),(5470,' Gonegandla',539),(5471,' Adoni',539),(5472,' Holagunda',539),(5473,' Halaharvi',539),(5474,' Alur',539),(5475,' Aspari',539),(5476,' Devanakonda',539),(5477,' Krishnagiri',539),(5478,' Veldurthi',539),(5479,' Bethamcherla',539),(5480,' Panyam',539),(5481,' Gadivemula',539),(5482,' Velgode',539),(5483,' Bandi Atmakur',539),(5484,' Nandyal',539),(5485,' Mahanandi',539),(5486,' Sirvel',539),(5487,' Gospadu',539),(5488,' Banaganapalle',539),(5489,' Dhone',539),(5490,' Pathikonda',539),(5491,' Chippagiri',539),(5492,' Maddikera (East)',539),(5493,' Tuggali',539),(5494,' Peapally',539),(5495,' Owk',539),(5496,' Koilkuntla',539),(5497,' Rudravaram',539),(5498,' Allagadda',539),(5499,' Dornipadu',539),(5500,' Sanjamala',539),(5501,' Kolimigundla',539),(5502,' Uyyalawada',539),(5503,' Chagalamarri',539),(5504,' Anantapur',540),(5505,' D.Hirehal',540),(5506,' Rayadurg',540),(5507,' Kanekal',540),(5508,' Bommanahal',540),(5509,' Vidapanakal',540),(5510,' Guntakal',540),(5511,' Gooty',540),(5512,' Peddavadugur',540),(5513,' Yadiki',540),(5514,' Tadpatri',540),(5515,' Peddapappur',540),(5516,' Pamidi',540),(5517,' Vijrakarur',540),(5518,' Uravakonda',540),(5519,' Beluguppa',540),(5520,' Gummagatta',540),(5521,' Brahmasamudram',540),(5522,' Kalyandurg',540),(5523,' Atmakur',540),(5524,' Kudair',540),(5525,' Garladinne',540),(5526,' Singanamala',540),(5527,' Putlur',540),(5528,' Yellanur',540),(5529,' Narpala',540),(5530,' Bukkarayasamudram',540),(5531,' Anantapur',540),(5532,' Raptadu',540),(5533,' Settur',540),(5534,' Kundurpi',540),(5535,' Kambadur',540),(5536,' Kanaganapalle',540),(5537,' Dharmavaram',540),(5538,' Bathalapalle',540),(5539,' Tadimarri',540),(5540,' Mudigubba',540),(5541,' Talupula',540),(5542,' Nambulapulakunta',540),(5543,' Gandlapenta',540),(5544,' Kadiri',540),(5545,' Nallamada',540),(5546,' Bukkapatnam',540),(5547,' Kothacheruvu',540),(5548,' Chennekothapalle',540),(5549,' Ramagiri',540),(5550,' Roddam',540),(5551,' Madakasira',540),(5552,' Amarapuram',540),(5553,' Gudibanda',540),(5554,' Rolla',540),(5555,' Agali',540),(5556,' Parigi',540),(5557,' Penukonda',540),(5558,' Puttaparthi',540),(5559,' Obuladevarecheruvu',540),(5560,' Nallacheruvu',540),(5561,' Tanakallu',540),(5562,' Amadagur',540),(5563,' Gorantla',540),(5564,' Somandepalle',540),(5565,' Hindupur',540),(5566,' Lepakshi',540),(5567,' Chilamathur',540),(5568,' Chittoor',541),(5569,' Mulakalacheruvu',541),(5570,' Thamballapalle',541),(5571,' Peddamandyam',541),(5572,' Gurramkonda',541),(5573,' Kalakada',541),(5574,' Kambhamvaripalle',541),(5575,' Rompicherla',541),(5576,' Yerravaripalem',541),(5577,' Tirupathi (Rural)',541),(5578,' Renigunta',541),(5579,' Yerpedu',541),(5580,' Srikalahasti',541),(5581,' Thottambedu',541),(5582,' Buchinaidu Khandriga',541),(5583,' Varadaiahpalem',541),(5584,' K.V.B.Puram',541),(5585,' Tirupati (Urban)',541),(5586,' Chandragiri',541),(5587,' Chinnagottigallu',541),(5588,' Piler',541),(5589,' Kalikiri',541),(5590,' Vayalpad',541),(5591,' Kurabalakota',541),(5592,' Peddathippa samudram',541),(5593,' B.Kothakota',541),(5594,' Madanapalle',541),(5595,' Nimmanapalle',541),(5596,' Sodum',541),(5597,' Pulicherla',541),(5598,' Pakala',541),(5599,' Vedurukuppam',541),(5600,' Ramachandra puram',541),(5601,' Vadamalapeta',541),(5602,' Narayanavanam',541),(5603,' Pitchatur',541),(5604,' Satyavedu',541),(5605,' Nagalapuram',541),(5606,' Nindra',541),(5607,' Vijayapuram',541),(5608,' Nagari',541),(5609,' Puttur',541),(5610,' Karvetinagar',541),(5611,' Penumur',541),(5612,' Puthalapattu',541),(5613,' Irala',541),(5614,' Somala',541),(5615,' Chowdepalle',541),(5616,' Ramasamudram',541),(5617,' Punganur',541),(5618,' Peddapanjani',541),(5619,' Gangavaram',541),(5620,' Thavanampalle',541),(5621,' Srirangarajapuram',541),(5622,' Gangadhara Nellore',541),(5623,' Chittoor',541),(5624,' Palamaner',541),(5625,' Baireddipalle',541),(5626,' Venkatagirikota',541),(5627,' Santhipuram ',541),(5628,' Gudupalle',541),(5629,' Kuppam',541),(5630,' Ramakuppam',541),(5631,' Bangarupalyam',541),(5632,' Yadamari',541),(5633,' Gudipala',541),(5634,' Palasamudram',541),(5635,' KARNATAKA',542),(5636,' Belgaum',543),(5637,' Chikodi',543),(5638,' Athni',543),(5639,' Raybag',543),(5640,' Gokak',543),(5641,' Hukeri',543),(5642,' Belgaum',543),(5643,' Khanapur',543),(5644,' Sampgaon',543),(5645,' Parasgad',543),(5646,' Ramdurg',543),(5647,' Bagalkot *',544),(5648,' Jamkhandi',544),(5649,' Bilgi',544),(5650,' Mudhol',544),(5651,' Badami',544),(5652,' Bagalkot',544),(5653,' Hungund',544),(5654,' Bijapur',545),(5655,' Bijapur',545),(5656,' Indi',545),(5657,' Sindgi',545),(5658,' Basavana Bagevadi',545),(5659,' Muddebihal',545),(5660,' Gulbarga',546),(5661,' Aland',546),(5662,' Afzalpur',546),(5663,' Gulbarga',546),(5664,' Chincholi',546),(5665,' Sedam',546),(5666,' Chitapur',546),(5667,' Jevargi',546),(5668,' Shahpur',546),(5669,' Shorapur',546),(5670,' Yadgir',546),(5671,' Bidar',547),(5672,' Basavakalyan',547),(5673,' Aurad',547),(5674,' Bhalki',547),(5675,' Bidar',547),(5676,' Homnabad',547),(5677,' Raichur',548),(5678,' Lingsugur',548),(5679,' Devadurga',548),(5680,' Raichur',548),(5681,' Manvi',548),(5682,' Sindhnur',548),(5683,' Koppal *',549),(5684,' Yelbarga',549),(5685,' Kushtagi',549),(5686,' Gangawati',549),(5687,' Koppal',549),(5688,' Gadag *',550),(5689,' Nargund',550),(5690,' Ron',550),(5691,' Gadag',550),(5692,' Shirhatti',550),(5693,' Mundargi',550),(5694,' Dharwad',551),(5695,' Dharwad',551),(5696,' Navalgund',551),(5697,' Hubli',551),(5698,' Kalghatgi',551),(5699,' Kundgol',551),(5700,' Uttara Kannada',552),(5701,' Karwar',552),(5702,' Supa',552),(5703,' Haliyal',552),(5704,' Yellapur',552),(5705,' Mundgod',552),(5706,' Sirsi',552),(5707,' Ankola',552),(5708,' Kumta',552),(5709,' Siddapur',552),(5710,' Honavar',552),(5711,' Bhatkal',552),(5712,' Haveri *',553),(5713,' Shiggaon',553),(5714,' Savanur',553),(5715,' Hangal',553),(5716,' Haveri',553),(5717,' Byadgi',553),(5718,' Hirekerur',553),(5719,' Ranibennur',553),(5720,' Bellary',554),(5721,' Hadagalli',554),(5722,' Hagaribommanahalli',554),(5723,' Hospet',554),(5724,' Siruguppa',554),(5725,' Bellary',554),(5726,' Sandur',554),(5727,' Kudligi',554),(5728,' Chitradurga',555),(5729,' Molakalmuru',555),(5730,' Challakere',555),(5731,' Chitradurga',555),(5732,' Holalkere',555),(5733,' Hosdurga',555),(5734,' Hiriyur',555),(5735,' Davanagere*',556),(5736,' Harihar',556),(5737,' Harapanahalli',556),(5738,' Jagalur',556),(5739,' Davanagere',556),(5740,' Honnali',556),(5741,' Channagiri',556),(5742,' Shimoga',557),(5743,' Sagar',557),(5744,' Sorab',557),(5745,' Shikarpur',557),(5746,' Hosanagara',557),(5747,' Tirthahalli',557),(5748,' Shimoga',557),(5749,' Bhadravati',557),(5750,' Udupi *',558),(5751,' Kundapura',558),(5752,' Udupi',558),(5753,' Karkal',558),(5754,' Chikmagalur',559),(5755,' Sringeri',559),(5756,' Koppa',559),(5757,' Narasimharajapura',559),(5758,' Tarikere',559),(5759,' Kadur',559),(5760,' Chikmagalur',559),(5761,' Mudigere',559),(5762,' Tumkur',560),(5763,' Chiknayakanhalli',560),(5764,' Sira',560),(5765,' Pavagada',560),(5766,' Madhugiri',560),(5767,' Koratagere',560),(5768,' Tumkur',560),(5769,' Gubbi',560),(5770,' Tiptur',560),(5771,' Turuvekere',560),(5772,' Kunigal',560),(5773,' Kolar',561),(5774,' Gauribidanur',561),(5775,' Chik Ballapur',561),(5776,' Gudibanda',561),(5777,' Bagepalli',561),(5778,' Sidlaghatta',561),(5779,' Chintamani',561),(5780,' Srinivaspur',561),(5781,' Kolar',561),(5782,' Malur',561),(5783,' Bangarapet',561),(5784,' Mulbagal',561),(5785,' Bangalore',562),(5786,' Bangalore North',562),(5787,' Bangalore South',562),(5788,' Anekal',562),(5789,' Bangalore Rural',563),(5790,' Nelamangala',563),(5791,' Dod Ballapur',563),(5792,' Devanhalli',563),(5793,' Hoskote',563),(5794,' Magadi',563),(5795,' Ramanagaram',563),(5796,' Channapatna',563),(5797,' Kanakapura',563),(5798,' Mandya',564),(5799,' Krishnarajpet',564),(5800,' Nagamangala',564),(5801,' Pandavapura',564),(5802,' Shrirangapattana',564),(5803,' Mandya',564),(5804,' Maddur',564),(5805,' Malavalli',564),(5806,' Hassan',565),(5807,' Sakleshpur',565),(5808,' Belur',565),(5809,' Arsikere',565),(5810,' Hassan',565),(5811,' Alur',565),(5812,' Arkalgud',565),(5813,' Hole Narsipur',565),(5814,' Channarayapatna',565),(5815,' Dakshina Kannada',566),(5816,' Mangalore',566),(5817,' Bantval',566),(5818,' Beltangadi',566),(5819,' Puttur',566),(5820,' Sulya',566),(5821,' Kodagu',567),(5822,' Madikeri',567),(5823,' Somvarpet',567),(5824,' Virajpet',567),(5825,' Mysore',568),(5826,' Piriyapatna',568),(5827,' Hunsur',568),(5828,' Krishnarajanagara',568),(5829,' Mysore',568),(5830,' Heggadadevankote',568),(5831,' Nanjangud',568),(5832,' Tirumakudal Narsipur',568),(5833,' Chamarajanagar*',569),(5834,' Gundlupet',569),(5835,' Chamarajanagar',569),(5836,' Yelandur',569),(5837,' Kollegal',569),(5838,' GOA',570),(5839,' North Goa ',571),(5840,' Pernem',571),(5841,' Bardez',571),(5842,' Tiswadi',571),(5843,' Bicholim ',571),(5844,' Satari',571),(5845,' Ponda',571),(5846,' South Goa',572),(5847,' Mormugao ',572),(5848,' Salcete',572),(5849,' Quepem ',572),(5850,' Sanguem ',572),(5851,' Canacona',572),(5852,' LAKSHADWEEP',573),(5853,' Lakshadweep',574),(5854,' Amini',574),(5855,' Kavaratti',574),(5856,' Andrott',574),(5857,' Minicoy',574),(5858,' KERALA',575),(5859,' Kasaragod',576),(5860,' Kasaragod',576),(5861,' Hosdurg',576),(5862,' Kannur',577),(5863,' Taliparamba',577),(5864,' Kannur',577),(5865,' Thalassery',577),(5866,' Wayanad',578),(5867,' Mananthavady',578),(5868,' Sulthanbathery',578),(5869,' Vythiri',578),(5870,' Kozhikode',579),(5871,' Vadakara',579),(5872,' Quilandy',579),(5873,' Kozhikode',579),(5874,' Malappuram',580),(5875,' Ernad',580),(5876,' Nilambur',580),(5877,' Perinthalmanna',580),(5878,' Tirur',580),(5879,' Tirurangadi',580),(5880,' Ponnani',580),(5881,' Palakkad',581),(5882,' Ottappalam',581),(5883,' Mannarkad',581),(5884,' Palakkad',581),(5885,' Chittur',581),(5886,' Alathur',581),(5887,' Thrissur',582),(5888,' Talappilly',582),(5889,' Chavakkad',582),(5890,' Thrissur',582),(5891,' Kodungallur',582),(5892,' Mukundapuram',582),(5893,' Ernakulam',583),(5894,' Kunnathunad',583),(5895,' Aluva',583),(5896,' Paravur',583),(5897,' Kochi',583),(5898,' Kanayannur',583),(5899,' Muvattupuzha',583),(5900,' Kothamangalam',583),(5901,' Idukki',584),(5902,' Devikulam',584),(5903,' Udumbanchola',584),(5904,' Thodupuzha',584),(5905,' Peerumade',584),(5906,' Kottayam',585),(5907,' Meenachil',585),(5908,' Vaikom',585),(5909,' Kottayam',585),(5910,' Changanassery',585),(5911,' Kanjirappally',585),(5912,' Alappuzha',586),(5913,' Cherthala',586),(5914,' Ambalappuzha',586),(5915,' Kuttanad',586),(5916,' Karthikappally',586),(5917,' Chengannur',586),(5918,' Mavelikkara',586),(5919,' Pathanamthitta',587),(5920,' Thiruvalla',587),(5921,' Mallappally',587),(5922,' Ranni',587),(5923,' Kozhenchery',587),(5924,' Adoor',587),(5925,' Kollam',588),(5926,' Karunagappally',588),(5927,' Kunnathur',588),(5928,' Pathanapuram',588),(5929,' Kottarakkara',588),(5930,' Kollam',588),(5931,' Thiruvananthapuram',589),(5932,' Chirayinkeezhu',589),(5933,' Nedumangad',589),(5934,' Thiruvananthapuram',589),(5935,' Neyyattinkara',589),(5936,' TAMIL NADU',590),(5937,' Thiruvallur',591),(5938,' Gummidipoondi',591),(5939,' Ponneri',591),(5940,' Uthukkottai',591),(5941,' Tiruttani',591),(5942,' Pallipattu',591),(5943,' Thiruvallur',591),(5944,' Poonamallee',591),(5945,' Ambattur',591),(5946,' Chennai',592),(5947,' Kancheepuram',593),(5948,' Sriperumbudur',593),(5949,' Tambaram',593),(5950,' Chengalpattu',593),(5951,' Kancheepuram',593),(5952,' Uthiramerur',593),(5953,' Tirukalukundram',593),(5954,' Maduranthakam',593),(5955,' Cheyyur',593),(5956,' Vellore',594),(5957,' Gudiyatham',594),(5958,' Katpadi',594),(5959,' Wallajah',594),(5960,' Arakonam',594),(5961,' Arcot',594),(5962,' Vellore',594),(5963,' Vaniyambadi',594),(5964,' Tirupathur',594),(5965,' Dharmapuri',595),(5966,' Hosur',595),(5967,' Krishnagiri',595),(5968,' Denkanikottai',595),(5969,' Palakkodu',595),(5970,' Pochampalli',595),(5971,' Uthangarai',595),(5972,' Harur',595),(5973,' Pappireddipatti',595),(5974,' Dharmapuri',595),(5975,' Pennagaram',595),(5976,' Tiruvannamalai',596),(5977,' Arani',596),(5978,' Cheyyar',596),(5979,' Vandavasi',596),(5980,' Polur',596),(5981,' Chengam',596),(5982,' Tiruvannamalai',596),(5983,' Viluppuram',597),(5984,' Gingee',597),(5985,' Tindivanam',597),(5986,' Vanur',597),(5987,' Viluppuram',597),(5988,' Tirukkoyilur',597),(5989,' Sankarapuram',597),(5990,' Kallakkurichi',597),(5991,' Ulundurpettai',597),(5992,' Salem',598),(5993,' Mettur',598),(5994,' Omalur',598),(5995,' Edappadi',598),(5996,' Sankari',598),(5997,' Salem',598),(5998,' Yercaud',598),(5999,' Vazhapadi',598),(6000,' Attur',598),(6001,' Gangavalli',598),(6002,' Namakkal   *',599),(6003,' Tiruchengode',599),(6004,' Rasipuram',599),(6005,' Namakkal',599),(6006,' Paramathi-Velur',599),(6007,' Erode',600),(6008,' Sathyamangalam',600),(6009,' Bhavani',600),(6010,' Gobichetti - Palayam',600),(6011,' Perundurai',600),(6012,' Erode',600),(6013,' Kangeyam',600),(6014,' Dharapuram',600),(6015,' The Nilgiris',601),(6016,' Panthalur',601),(6017,' Gudalur',601),(6018,' Udhagamandalam',601),(6019,' Kotagiri',601),(6020,' Coonoor',601),(6021,' Kundah',601),(6022,' Coimbatore',602),(6023,' Mettupalayam',602),(6024,' Avanashi',602),(6025,' Tiruppur',602),(6026,' Palladam',602),(6027,' Coimbatore North',602),(6028,' Coimbatore South',602),(6029,' Pollachi',602),(6030,' Udumalaipettai',602),(6031,' Valparai',602),(6032,' Dindigul',603),(6033,' Palani',603),(6034,' Oddanchatram',603),(6035,' Vedasandur',603),(6036,' Natham',603),(6037,' Dindigul',603),(6038,' Kodaikanal',603),(6039,' Nilakkottai',603),(6040,' Karur  *',604),(6041,' Aravakurichi',604),(6042,' Karur',604),(6043,' Krishnarayapuram',604),(6044,' Kulithalai',604),(6045,' Tiruchirappalli',605),(6046,' Thottiyam',605),(6047,' Musiri',605),(6048,' Thuraiyur',605),(6049,' Manachanallur',605),(6050,' Lalgudi',605),(6051,' Srirangam',605),(6052,' Tiruchirappalli',605),(6053,' Manapparai',605),(6054,' Perambalur  *',606),(6055,' Veppanthattai',606),(6056,' Perambalur',606),(6057,' Kunnam',606),(6058,' Ariyalur  *',607),(6059,' Sendurai',607),(6060,' Udayarpalayam',607),(6061,' Ariyalur',607),(6062,' Cuddalore',608),(6063,' Panruti',608),(6064,' Cuddalore',608),(6065,' Chidambaram',608),(6066,' Kattumannarkoil',608),(6067,' Virudhachalam',608),(6068,' Tittakudi',608),(6069,' Nagapattinam  *',609),(6070,' Sirkali',609),(6071,' Mayiladuthurai',609),(6072,' Tharangambadi',609),(6073,' Nagapattinam',609),(6074,' Kilvelur',609),(6075,' Thirukkuvalai',609),(6076,' Vedaranyam',609),(6077,' Thiruvarur',610),(6078,' Valangaiman',610),(6079,' Kodavasal',610),(6080,' Nannilam',610),(6081,' Thiruvarur',610),(6082,' Needamangalam',610),(6083,' Mannargudi',610),(6084,' Thiruthuraipoondi',610),(6085,' Thanjavur',611),(6086,' Thiruvidaimarudur',611),(6087,' Kumbakonam',611),(6088,' Papanasam',611),(6089,' Thiruvaiyaru',611),(6090,' Thanjavur',611),(6091,' Orathanadu',611),(6092,' Pattukkottai',611),(6093,' Peravurani',611),(6094,' Pudukkottai',612),(6095,' Iluppur',612),(6096,' Kulathur',612),(6097,' Gandarvakkottai',612),(6098,' Pudukkottai',612),(6099,' Thirumayam',612),(6100,' Alangudi',612),(6101,' Aranthangi',612),(6102,' Manamelkudi',612),(6103,' Avudayarkoil',612),(6104,' Sivaganga',613),(6105,' Tirupathur',613),(6106,' Karaikkudi',613),(6107,' Devakottai',613),(6108,' Sivaganga',613),(6109,' Manamadurai',613),(6110,' Ilayangudi',613),(6111,' Madurai',614),(6112,' Melur',614),(6113,' Madurai North',614),(6114,' Vadipatti',614),(6115,' Usilampatti',614),(6116,' Peraiyur',614),(6117,' Thirumangalam',614),(6118,' Madurai South',614),(6119,' Theni  *',615),(6120,' Bodinayakanur',615),(6121,' Periyakulam',615),(6122,' Theni ',615),(6123,' Uthamapalayam',615),(6124,' Andipatti',615),(6125,' Virudhunagar',616),(6126,' Rajapalayam',616),(6127,' Srivilliputhur',616),(6128,' Sivakasi',616),(6129,' Virudhunagar',616),(6130,' Kariapatti',616),(6131,' Tiruchuli',616),(6132,' Aruppukkottai',616),(6133,' Sattur',616),(6134,' Ramanathapuram',617),(6135,' Tiruvadanai',617),(6136,' Paramakudi',617),(6137,' Mudukulathur',617),(6138,' Kamuthi',617),(6139,' Kadaladi',617),(6140,' Ramanathapuram',617),(6141,' Rameswaram',617),(6142,' Thoothukkudi',618),(6143,' Kovilpatti',618),(6144,' Ettayapuram',618),(6145,' Vilathikulam',618),(6146,' Ottapidaram',618),(6147,' Thoothukkudi',618),(6148,' Srivaikuntam',618),(6149,' Tiruchendur',618),(6150,' Sathankulam',618),(6151,' Tirunelveli ',619),(6152,' Sivagiri',619),(6153,' Sankarankoil',619),(6154,' Veerakeralamputhur',619),(6155,' Tenkasi',619),(6156,' Shenkottai',619),(6157,' Alangulam',619),(6158,' Tirunelveli',619),(6159,' Palayamkottai',619),(6160,' Ambasamudram',619),(6161,' Nanguneri',619),(6162,' Radhapuram',619),(6163,' Kanniyakumari',620),(6164,' Vilavancode',620),(6165,' Kalkulam',620),(6166,' Thovala',620),(6167,' Agastheeswaram',620),(6168,' PONDICHERRY',621),(6169,' Yanam',622),(6170,' Pondicherry',623),(6171,' Mannadipet Commune Panchayat',623),(6172,' Villianur Commune Panchayat',623),(6173,' Ariankuppam Commune Panchayat',623),(6174,' Nettapakkam Commune Panchayat',623),(6175,' Bahour Commune Panchayat',623),(6176,' Mahe',624),(6177,' Karaikal',625),(6178,' Nedungadu Commune Panchayat',625),(6179,' Kottucherry Commune Panchayat',625),(6180,' Thirunallar Commune Panchayat',625),(6181,' Neravy Commune Panchayat',625),(6182,' Thirumalairayan Pattinam Commune Panchayat',625),(6183,' ANDAMAN & NICOBAR ISLANDS',626),(6184,' Andamans',627),(6185,' Diglipur',627),(6186,' Mayabunder',627),(6187,' Rangat',627),(6188,' Ferrargunj',627),(6189,' Port Blair',627),(6190,' Nicobars',628),(6191,' Car Nicobar',628),(6192,' Nancowry',628);
/*!40000 ALTER TABLE `city_taluka` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'India','91');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_user_idx` (`created_by`),
  KEY `fk_course_user3_idx` (`updated_by`),
  CONSTRAINT `fk_course_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_user3` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (1,'CA ','Enterance Exam For CA ',NULL,NULL,'2016-03-29 03:00:00',1),(2,'MBA','Masters Of Computer Application',NULL,NULL,'2016-03-31 10:24:33',1);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_fee`
--

DROP TABLE IF EXISTS `course_fee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `course_fee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `center_course_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_course_fee_user1_idx` (`created_by`),
  KEY `fk_course_fee_user2_idx` (`updated_by`),
  KEY `fk_course_fee_center_course1_idx` (`center_course_id`),
  CONSTRAINT `fk_course_fee_center_course1` FOREIGN KEY (`center_course_id`) REFERENCES `center_course` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_fee_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_fee_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_fee`
--

LOCK TABLES `course_fee` WRITE;
/*!40000 ALTER TABLE `course_fee` DISABLE KEYS */;
/*!40000 ALTER TABLE `course_fee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `district`
--

DROP TABLE IF EXISTS `district`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `district` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `state_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_district_state1_idx` (`state_id`),
  CONSTRAINT `fk_district_state1` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=629 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `district`
--

LOCK TABLES `district` WRITE;
/*!40000 ALTER TABLE `district` DISABLE KEYS */;
INSERT INTO `district` VALUES (1,' JAMMU & KASHMIR','1',1),(2,' Kupwara','2',1),(3,' Baramula','3',1),(4,' Srinagar','4',1),(5,' Badgam','5',1),(6,' Pulwama','6',1),(7,' Anantnag','7',1),(8,' Leh (Ladakh)','8',1),(9,' Kargil','9',1),(10,' Doda','10',1),(11,' Udhampur','11',1),(12,' Punch','12',1),(13,' Rajauri','13',1),(14,' Jammu','14',1),(15,' Kathua','15',1),(16,' HIMACHAL PRADESH','16',2),(17,' Chamba','17',2),(18,' Kangra','18',2),(19,' Lahul & Spiti','19',2),(20,' Kullu','20',2),(21,' Mandi','21',2),(22,' Hamirpur','22',2),(23,' Una','23',2),(24,' Bilaspur','24',2),(25,' Solan','25',2),(26,' Sirmaur','26',2),(27,' Shimla','27',2),(28,' Kinnaur','28',2),(29,' PUNJAB','29',3),(30,' Gurdaspur','30',3),(31,' Amritsar','31',3),(32,' Kapurthala','32',3),(33,' Jalandhar','33',3),(34,' Hoshiarpur','34',3),(35,' Nawanshahr *','35',3),(36,' Rupnagar','36',3),(37,' Fatehgarh Sahib *','37',3),(38,' Ludhiana','38',3),(39,' Moga *','39',3),(40,' Firozpur','40',3),(41,' Muktsar *','41',3),(42,' Faridkot','42',3),(43,' Bathinda','43',3),(44,' Mansa *','44',3),(45,' Sangrur','45',3),(46,' Patiala','46',3),(47,' CHANDIGARH','47',4),(48,' Chandigarh','48',4),(49,' UTTARANCHAL','49',5),(50,' Uttarkashi','50',5),(51,' Chamoli','51',5),(52,' Rudraprayag *','52',5),(53,' Tehri Garhwal','53',5),(54,' Dehradun','54',5),(55,' Garhwal','55',5),(56,' Pithoragarh','56',5),(57,' Bageshwar','57',5),(58,' Almora','58',5),(59,' Champawat','59',5),(60,' Nainital','60',5),(61,' Udham Singh Nagar *','61',5),(62,' Hardwar','62',5),(63,' HARYANA','63',6),(64,' Panchkula *','64',6),(65,' Ambala','65',6),(66,' Yamunanagar','66',6),(67,' Kurukshetra','67',6),(68,' Kaithal','68',6),(69,' Karnal','69',6),(70,' Panipat','70',6),(71,' Sonipat','71',6),(72,' Jind','72',6),(73,' Fatehabad *','73',6),(74,' Sirsa','74',6),(75,' Hisar','75',6),(76,' Bhiwani','76',6),(77,' Rohtak','77',6),(78,' Jhajjar *','78',6),(79,' Mahendragarh','79',6),(80,' Rewari','80',6),(81,' Gurgaon','81',6),(82,' Faridabad','82',6),(83,' DELHI','83',7),(84,' North West   *','84',7),(85,' North   *','85',7),(86,' North East   *','86',7),(87,' East   *','87',7),(88,' New Delhi','88',7),(89,' Central  *','89',7),(90,' West   *','90',7),(91,' South West   *','91',7),(92,' South  *','92',7),(93,' RAJASTHAN','93',8),(94,' Ganganagar','94',8),(95,' Hanumangarh *','95',8),(96,' Bikaner','96',8),(97,' Churu','97',8),(98,' Jhunjhunun','98',8),(99,' Alwar','99',8),(100,' Bharatpur','100',8),(101,' Dhaulpur','101',8),(102,' Karauli *','102',8),(103,' Sawai Madhopur','103',8),(104,' Dausa *','104',8),(105,' Jaipur','105',8),(106,' Sikar','106',8),(107,' Nagaur','107',8),(108,' Jodhpur','108',8),(109,' Jaisalmer','109',8),(110,' Barmer','110',8),(111,' Jalor','111',8),(112,' Sirohi','112',8),(113,' Pali','113',8),(114,' Ajmer','114',8),(115,' Tonk','115',8),(116,' Bundi','116',8),(117,' Bhilwara','117',8),(118,' Rajsamand *','118',8),(119,' Udaipur','119',8),(120,' Dungarpur','120',8),(121,' Banswara','121',8),(122,' Chittaurgarh','122',8),(123,' Kota','123',8),(124,' Baran *','124',8),(125,' Jhalawar','125',8),(126,' UTTAR PRADESH','126',9),(127,' Saharanpur','127',9),(128,' Muzaffarnagar','128',9),(129,' Bijnor','129',9),(130,' Moradabad','130',9),(131,' Rampur','131',9),(132,' Jyotiba Phule Nagar *','132',9),(133,' Meerut','133',9),(134,' Baghpat *','134',9),(135,' Ghaziabad','135',9),(136,' Gautam Buddha Nagar *','136',9),(137,' Bulandshahr','137',9),(138,' Aligarh','138',9),(139,' Hathras *','139',9),(140,' Mathura','140',9),(141,' Agra','141',9),(142,' Firozabad','142',9),(143,' Etah','143',9),(144,' Mainpuri','144',9),(145,' Budaun','145',9),(146,' Bareilly','146',9),(147,' Pilibhit','147',9),(148,' Shahjahanpur','148',9),(149,' Kheri','149',9),(150,' Sitapur','150',9),(151,' Hardoi','151',9),(152,' Unnao','152',9),(153,' Lucknow','153',9),(154,' Rae Bareli','154',9),(155,' Farrukhabad','155',9),(156,' Kannauj *','156',9),(157,' Etawah','157',9),(158,' Auraiya *','158',9),(159,' Kanpur Dehat','159',9),(160,' Kanpur Nagar','160',9),(161,' Jalaun','161',9),(162,' Jhansi','162',9),(163,' Lalitpur','163',9),(164,' Hamirpur','164',9),(165,' Mahoba *','165',9),(166,' Banda','166',9),(167,' Chitrakoot *','167',9),(168,' Fatehpur','168',9),(169,' Pratapgarh','169',9),(170,' Kaushambi *','170',9),(171,' Allahabad','171',9),(172,' Barabanki','172',9),(173,' Faizabad','173',9),(174,' Ambedkar Nagar *','174',9),(175,' Sultanpur','175',9),(176,' Bahraich','176',9),(177,' Shrawasti *','177',9),(178,' Balrampur *','178',9),(179,' Gonda','179',9),(180,' Siddharthnagar','180',9),(181,' Basti','181',9),(182,' Sant Kabir Nagar *','182',9),(183,' Maharajganj','183',9),(184,' Gorakhpur','184',9),(185,' Kushinagar *','185',9),(186,' Deoria','186',9),(187,' Azamgarh','187',9),(188,' Mau','188',9),(189,' Ballia','189',9),(190,' Jaunpur','190',9),(191,' Ghazipur','191',9),(192,' Chandauli *','192',9),(193,' Varanasi','193',9),(194,' Sant Ravidas Nagar *','194',9),(195,' Mirzapur','195',9),(196,' Sonbhadra','196',9),(197,' BIHAR','197',10),(198,' Pashchim Champaran','198',10),(199,' Purba Champaran','199',10),(200,' Sheohar *','200',10),(201,' Sitamarhi','201',10),(202,' Madhubani','202',10),(203,' Supaul *','203',10),(204,' Araria','204',10),(205,' Kishanganj','205',10),(206,' Purnia','206',10),(207,' Katihar','207',10),(208,' Madhepura','208',10),(209,' Saharsa','209',10),(210,' Darbhanga','210',10),(211,' Muzaffarpur','211',10),(212,' Gopalganj','212',10),(213,' Siwan','213',10),(214,' Saran','214',10),(215,' Vaishali','215',10),(216,' Samastipur','216',10),(217,' Begusarai','217',10),(218,' Khagaria','218',10),(219,' Bhagalpur','219',10),(220,' Banka *','220',10),(221,' Munger','221',10),(222,' Lakhisarai *','222',10),(223,' Sheikhpura *','223',10),(224,' Nalanda','224',10),(225,' Patna','225',10),(226,' Bhojpur','226',10),(227,' Buxar *','227',10),(228,' Kaimur (Bhabua) *','228',10),(229,' Rohtas','229',10),(230,' Jehanabad','230',10),(231,' Aurangabad','231',10),(232,' Gaya','232',10),(233,' Nawada','233',10),(234,' Jamui *','234',10),(235,' SIKKIM','235',11),(236,' North','236',11),(237,' West','237',11),(238,' South','238',11),(239,' East','239',11),(240,' ARUNACHAL PRADESH','240',12),(241,' Tawang','241',12),(242,' West Kameng','242',12),(243,' East Kameng','243',12),(244,' Papum Pare *','244',12),(245,' Lower Subansiri','245',12),(246,' Upper Subansiri','246',12),(247,' West Siang','247',12),(248,' East Siang','248',12),(249,' Upper Siang *','249',12),(250,' Dibang Valley','250',12),(251,' Lohit','251',12),(252,' Changlang','252',12),(253,' Tirap','253',12),(254,' NAGALAND','254',13),(255,' Mon','255',13),(256,' Tuensang','256',13),(257,' Mokokchung','257',13),(258,' Zunheboto','258',13),(259,' Wokha','259',13),(260,' Dimapur *','260',13),(261,' Kohima','261',13),(262,' Phek','262',13),(263,' MANIPUR','263',14),(264,' Senapati','264',14),(265,' Tamenglong','265',14),(266,' Churachandpur','266',14),(267,' Bishnupur','267',14),(268,' Thoubal','268',14),(269,' Imphal West','269',14),(270,' Imphal East *','270',14),(271,' Ukhrul','271',14),(272,' Chandel','272',14),(273,' MIZORAM','273',15),(274,' Mamit *','274',15),(275,' Kolasib *','275',15),(276,' Aizawl','276',15),(277,' Champhai *','277',15),(278,' Serchhip *','278',15),(279,' Lunglei','279',15),(280,' Lawngtlai','280',15),(281,' Saiha *','281',15),(282,' TRIPURA','282',16),(283,' West Tripura','283',16),(284,' South Tripura','284',16),(285,' Dhalai  *','285',16),(286,' North Tripura','286',16),(287,' MEGHALAYA','287',17),(288,' West Garo Hills','288',17),(289,' East Garo Hills','289',17),(290,' South Garo Hills *','290',17),(291,' West Khasi Hills','291',17),(292,' Ri Bhoi  *','292',17),(293,' East Khasi Hills','293',17),(294,' Jaintia Hills','294',17),(295,' ASSAM','295',18),(296,' Kokrajhar','296',18),(297,' Dhubri','297',18),(298,' Goalpara','298',18),(299,' Bongaigaon','299',18),(300,' Barpeta','300',18),(301,' Kamrup','301',18),(302,' Nalbari','302',18),(303,' Darrang','303',18),(304,' Marigaon','304',18),(305,' Nagaon','305',18),(306,' Sonitpur','306',18),(307,' Lakhimpur','307',18),(308,' Dhemaji','308',18),(309,' Tinsukia','309',18),(310,' Dibrugarh','310',18),(311,' Sibsagar','311',18),(312,' Jorhat','312',18),(313,' Golaghat','313',18),(314,' Karbi Anglong','314',18),(315,' North Cachar Hills','315',18),(316,' Cachar','316',18),(317,' Karimganj','317',18),(318,' Hailakandi','318',18),(319,' WEST BENGAL','319',19),(320,' Darjiling','320',19),(321,' Jalpaiguri','321',19),(322,' Koch Bihar','322',19),(323,' Uttar Dinajpur','323',19),(324,' Dakshin Dinajpur *','324',19),(325,' Maldah','325',19),(326,' Murshidabad','326',19),(327,' Birbhum','327',19),(328,' Barddhaman','328',19),(329,' Nadia','329',19),(330,' North Twenty Four Parganas','330',19),(331,' Hugli','331',19),(332,' Bankura','332',19),(333,' Puruliya','333',19),(334,' Medinipur','334',19),(335,' Haora','335',19),(336,' Kolkata','336',19),(337,' South  Twenty Four Parganas','337',19),(338,' JHARKHAND','338',20),(339,' Garhwa *','339',20),(340,' Palamu','340',20),(341,' Chatra *','341',20),(342,' Hazaribag','342',20),(343,' Kodarma *','343',20),(344,' Giridih','344',20),(345,' Deoghar','345',20),(346,' Godda','346',20),(347,' Sahibganj','347',20),(348,' Pakaur *','348',20),(349,' Dumka','349',20),(350,' Dhanbad','350',20),(351,' Bokaro *','351',20),(352,' Ranchi','352',20),(353,' Lohardaga','353',20),(354,' Gumla','354',20),(355,' Pashchimi Singhbhum','355',20),(356,' Purbi Singhbhum','356',20),(357,' ORISSA','357',21),(358,' Bargarh  *','358',21),(359,' Jharsuguda  *','359',21),(360,' Sambalpur','360',21),(361,' Debagarh  *','361',21),(362,' Sundargarh','362',21),(363,' Kendujhar','363',21),(364,' Mayurbhanj','364',21),(365,' Baleshwar','365',21),(366,' Bhadrak  *','366',21),(367,' Kendrapara *','367',21),(368,' Jagatsinghapur  *','368',21),(369,' Cuttack','369',21),(370,' Jajapur  *','370',21),(371,' Dhenkanal','371',21),(372,' Anugul  *','372',21),(373,' Nayagarh  *','373',21),(374,' Khordha  *','374',21),(375,' Puri','375',21),(376,' Ganjam','376',21),(377,' Gajapati  *','377',21),(378,' Kandhamal','378',21),(379,' Baudh  *','379',21),(380,' Sonapur  *','380',21),(381,' Balangir','381',21),(382,' Nuapada  *','382',21),(383,' Kalahandi','383',21),(384,' Rayagada  *','384',21),(385,' Nabarangapur  *','385',21),(386,' Koraput','386',21),(387,' Malkangiri  *','387',21),(388,' CHHATTISGARH','388',22),(389,' Koriya *','389',22),(390,' Surguja','390',22),(391,' Jashpur *','391',22),(392,' Raigarh','392',22),(393,' Korba *','393',22),(394,' Janjgir - Champa*','394',22),(395,' Bilaspur','395',22),(396,' Kawardha *','396',22),(397,' Rajnandgaon','397',22),(398,' Durg','398',22),(399,' Raipur','399',22),(400,' Mahasamund *','400',22),(401,' Dhamtari *','401',22),(402,' Kanker *','402',22),(403,' Baster','403',22),(404,' Dantewada*','404',22),(405,' MADHYA PRADESH','405',23),(406,' Sheopur *','406',23),(407,' Morena','407',23),(408,' Bhind','408',23),(409,' Gwalior','409',23),(410,' Datia','410',23),(411,' Shivpuri','411',23),(412,' Guna','412',23),(413,' Tikamgarh','413',23),(414,' Chhatarpur','414',23),(415,' Panna','415',23),(416,' Sagar','416',23),(417,' Damoh','417',23),(418,' Satna','418',23),(419,' Rewa','419',23),(420,' Umaria *','420',23),(421,' Shahdol','421',23),(422,' Sidhi','422',23),(423,' Neemuch *','423',23),(424,' Mandsaur','424',23),(425,' Ratlam','425',23),(426,' Ujjain','426',23),(427,' Shajapur','427',23),(428,' Dewas','428',23),(429,' Jhabua','429',23),(430,' Dhar','430',23),(431,' Indore','431',23),(432,' West Nimar','432',23),(433,' Barwani *','433',23),(434,' East Nimar','434',23),(435,' Rajgarh','435',23),(436,' Vidisha','436',23),(437,' Bhopal','437',23),(438,' Sehore','438',23),(439,' Raisen','439',23),(440,' Betul','440',23),(441,' Harda *','441',23),(442,' Hoshangabad','442',23),(443,' Katni *','443',23),(444,' Jabalpur','444',23),(445,' Narsimhapur','445',23),(446,' Dindori *','446',23),(447,' Mandla','447',23),(448,' Chhindwara','448',23),(449,' Seoni','449',23),(450,' Balaghat','450',23),(451,' GUJARAT','451',24),(452,' Kachchh','452',24),(453,' Banas Kantha','453',24),(454,' Patan  *','454',24),(455,' Mahesana','455',24),(456,' Sabar Kantha','456',24),(457,' Gandhinagar','457',24),(458,' Ahmadabad','458',24),(459,' Surendranagar','459',24),(460,' Rajkot','460',24),(461,' Jamnagar','461',24),(462,' Porbandar  *','462',24),(463,' Junagadh','463',24),(464,' Amreli','464',24),(465,' Bhavnagar','465',24),(466,' Anand  *','466',24),(467,' Kheda','467',24),(468,' Panch Mahals','468',24),(469,' Dohad  *','469',24),(470,' Vadodara','470',24),(471,' Narmada  *','471',24),(472,' Bharuch','472',24),(473,' Surat','473',24),(474,' The Dangs','474',24),(475,' Navsari  *','475',24),(476,' Valsad','476',24),(477,' DAMAN & DIU','477',25),(478,' Diu','478',25),(479,' Daman','479',25),(480,' DADRA & NAGAR HAVELI','480',26),(481,' Dadra & Nagar Haveli','481',26),(482,' MAHARASHTRA','482',27),(483,' Nandurbar *','483',27),(484,' Dhule','484',27),(485,' Jalgaon','485',27),(486,' Buldana','486',27),(487,' Akola','487',27),(488,' Washim *','488',27),(489,' Amravati','489',27),(490,' Wardha','490',27),(491,' Nagpur','491',27),(492,' Bhandara','492',27),(493,' Gondiya *','493',27),(494,' Gadchiroli','494',27),(495,' Chandrapur','495',27),(496,' Yavatmal','496',27),(497,' Nanded','497',27),(498,' Hingoli *','498',27),(499,' Parbhani','499',27),(500,' Jalna','500',27),(501,' Aurangabad','501',27),(502,' Nashik','502',27),(503,' Thane','503',27),(504,' Mumbai (Suburban) *','504',27),(505,' Mumbai','505',27),(506,' Raigarh','506',27),(507,' Pune','507',27),(508,' Ahmadnagar','508',27),(509,' Bid','509',27),(510,' Latur','510',27),(511,' Osmanabad','511',27),(512,' Solapur','512',27),(513,' Satara','513',27),(514,' Ratnagiri','514',27),(515,' Sindhudurg','515',27),(516,' Kolhapur','516',27),(517,' Sangli','517',27),(518,' ANDHRA PRADESH','518',28),(519,' Adilabad','519',28),(520,' Nizamabad','520',28),(521,' Karimnagar','521',28),(522,' Medak','522',28),(523,' Hyderabad','523',28),(524,' Rangareddi','524',28),(525,' Mahbubnagar','525',28),(526,' Nalgonda','526',28),(527,' Warangal','527',28),(528,' Khammam','528',28),(529,' Srikakulam','529',28),(530,' Vizianagaram','530',28),(531,' Visakhapatnam','531',28),(532,' East Godavari','532',28),(533,' West Godavari','533',28),(534,' Krishna','534',28),(535,' Guntur','535',28),(536,' Prakasam','536',28),(537,' Nellore','537',28),(538,' Cuddapah','538',28),(539,' Kurnool','539',28),(540,' Anantapur','540',28),(541,' Chittoor','541',28),(542,' KARNATAKA','542',29),(543,' Belgaum','543',29),(544,' Bagalkot *','544',29),(545,' Bijapur','545',29),(546,' Gulbarga','546',29),(547,' Bidar','547',29),(548,' Raichur','548',29),(549,' Koppal *','549',29),(550,' Gadag *','550',29),(551,' Dharwad','551',29),(552,' Uttara Kannada','552',29),(553,' Haveri *','553',29),(554,' Bellary','554',29),(555,' Chitradurga','555',29),(556,' Davangere*','556',29),(557,' Shimoga','557',29),(558,' Udupi *','558',29),(559,' Chikmagalur','559',29),(560,' Tumkur','560',29),(561,' Kolar','561',29),(562,' Bangalore','562',29),(563,' Bangalore Rural','563',29),(564,' Mandya','564',29),(565,' Hassan','565',29),(566,' Dakshina Kannada','566',29),(567,' Kodagu','567',29),(568,' Mysore','568',29),(569,' Chamrajnagar*','569',29),(570,' GOA','570',30),(571,' North Goa','571',30),(572,' South Goa','572',30),(573,' LAKSHADWEEP','573',31),(574,' Lakshadweep','574',31),(575,' KERALA','575',32),(576,' Kasaragod','576',32),(577,' Kannur','577',32),(578,' Wayanad','578',32),(579,' Kozhikode','579',32),(580,' Malappuram','580',32),(581,' Palakkad','581',32),(582,' Thrissur','582',32),(583,' Ernakulam','583',32),(584,' Idukki','584',32),(585,' Kottayam','585',32),(586,' Alappuzha','586',32),(587,' Pathanamthitta','587',32),(588,' Kollam','588',32),(589,' Thiruvananthapuram','589',32),(590,' TAMIL NADU','590',33),(591,' Thiruvallur','591',33),(592,' Chennai','592',33),(593,' Kancheepuram','593',33),(594,' Vellore','594',33),(595,' Dharmapuri','595',33),(596,' Tiruvannamalai','596',33),(597,' Viluppuram','597',33),(598,' Salem','598',33),(599,' Namakkal   *','599',33),(600,' Erode','600',33),(601,' The Nilgiris','601',33),(602,' Coimbatore','602',33),(603,' Dindigul','603',33),(604,' Karur  *','604',33),(605,' Tiruchirappalli','605',33),(606,' Perambalur  *','606',33),(607,' Ariyalur  *','607',33),(608,' Cuddalore','608',33),(609,' Nagapattinam  *','609',33),(610,' Thiruvarur','610',33),(611,' Thanjavur','611',33),(612,' Pudukkottai','612',33),(613,' Sivaganga','613',33),(614,' Madurai','614',33),(615,' Theni  *','615',33),(616,' Virudhunagar','616',33),(617,' Ramanathapuram','617',33),(618,' Thoothukkudi','618',33),(619,' Tirunelveli','619',33),(620,' Kanniyakumari','620',33),(621,' PONDICHERRY','621',34),(622,' Yanam','622',34),(623,' Pondicherry','623',34),(624,' Mahe','624',34),(625,' Karaikal','625',34),(626,' ANDAMAN & NICOBAR ISLANDS','626',35),(627,' Andamans','627',35),(628,' Nicobars','628',35);
/*!40000 ALTER TABLE `district` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forgot_password_otp`
--

DROP TABLE IF EXISTS `forgot_password_otp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forgot_password_otp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `otp` varchar(10) NOT NULL,
  `created_datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expire_on` datetime NOT NULL,
  `active` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forgot_password_otp`
--

LOCK TABLES `forgot_password_otp` WRITE;
/*!40000 ALTER TABLE `forgot_password_otp` DISABLE KEYS */;
/*!40000 ALTER TABLE `forgot_password_otp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `industry`
--

DROP TABLE IF EXISTS `industry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `industry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `industry`
--

LOCK TABLES `industry` WRITE;
/*!40000 ALTER TABLE `industry` DISABLE KEYS */;
INSERT INTO `industry` VALUES (1,'Accommodations'),(2,'Accounting'),(3,'Advertising'),(4,'Aerospace'),(5,'Agriculture & Agribusiness'),(6,'Air Transportation'),(7,'Apparel & Accessories'),(8,'Auto'),(9,'Banking'),(10,'Beauty & Cosmetics'),(11,'Biotechnology'),(12,'Chemical'),(13,'Communications'),(14,'Computer'),(15,'Construction'),(16,'Consulting'),(17,'Consumer Products'),(18,'Education'),(19,'Electronics'),(20,'Employment'),(21,'Energy'),(22,'Entertainment & Recreation '),(23,'Fashion '),(24,'Financial Services'),(25,'Food & Beverage'),(26,'Health'),(27,'Information '),(28,'Information Technology '),(29,'Insurance '),(30,'Journalism & News '),(31,'Legal Services'),(32,'Manufacturing'),(33,'Media & Broadcasting '),(34,'Medical Devices & Supplies'),(35,'Motion Pictures & Video '),(36,'Music'),(37,'Pharmaceutical'),(38,'Public Administration'),(39,'Public Relations'),(40,'Publishing'),(41,'Real Estate'),(42,'Retail'),(43,'Service'),(44,'Sports'),(45,'Technology '),(46,'Telecommunications '),(47,'Tourism '),(48,'Transportation'),(49,'Travel'),(50,'Utilities'),(51,'Video Game'),(52,'Web Services ');
/*!40000 ALTER TABLE `industry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `agenda` varchar(255) DEFAULT NULL,
  `venue` varchar(45) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `batch_groups_id` int(11) DEFAULT NULL,
  `is_jumbo_call` char(1) DEFAULT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `conference_number` varchar(45) DEFAULT NULL,
  `conference_other_details` varchar(45) DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meeting_batch1_idx` (`batch_id`),
  KEY `fk_meeting_batch_groups1_idx` (`batch_groups_id`),
  KEY `fk_meeting_user1_idx` (`created_by`),
  KEY `fk_meeting_user2_idx` (`updated_by`),
  CONSTRAINT `fk_meeting_batch1` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_meeting_batch_groups1` FOREIGN KEY (`batch_groups_id`) REFERENCES `batch_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_meeting_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_meeting_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` VALUES (1,'Meeting1','Agenda1','Venue1',1,1,NULL,'2016-03-31','10:00:00','18:00:00',NULL,NULL,1,NULL,'2016-03-30 03:00:00',NULL),(2,'Meeting2','Agenda2','Venue2',1,2,NULL,'2016-04-14','10:00:00','18:00:00',NULL,NULL,1,NULL,'2016-03-30 03:00:00',NULL);
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meeting_attendance`
--

DROP TABLE IF EXISTS `meeting_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meeting_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `batch_user_id` int(11) NOT NULL,
  `meeting_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_meeting_attendance_batch_user1_idx` (`batch_user_id`),
  KEY `fk_meeting_attendance_meeting1_idx` (`meeting_id`),
  CONSTRAINT `fk_meeting_attendance_batch_user1` FOREIGN KEY (`batch_user_id`) REFERENCES `batch_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_meeting_attendance_meeting1` FOREIGN KEY (`meeting_id`) REFERENCES `meeting` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting_attendance`
--

LOCK TABLES `meeting_attendance` WRITE;
/*!40000 ALTER TABLE `meeting_attendance` DISABLE KEYS */;
/*!40000 ALTER TABLE `meeting_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occupation`
--

DROP TABLE IF EXISTS `occupation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `occupation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=704 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occupation`
--

LOCK TABLES `occupation` WRITE;
/*!40000 ALTER TABLE `occupation` DISABLE KEYS */;
INSERT INTO `occupation` VALUES (1,'actor, puppeteer/marionetteer (actor/actress)'),(2,'actuary'),(3,'administrative worker'),(4,'advertising manager'),(5,'aerial rigger'),(6,'agricultural adviser (farming adviser)'),(7,'agricultural machinery mechanic (agricultural mechanic)'),(8,'agronomist'),(9,'air traffic controller'),(10,'air traffic safety technician'),(11,'aircraft instrument technician'),(12,'aircraft mechanic'),(13,'airline clerk (airline ticket agent)'),(14,'ammunition and explosives operative (munitions worker)'),(15,'animal technician'),(16,'animator'),(17,'anthropologist'),(18,'applications manager (computer applications manager)'),(19,'apprentice training officer/trainer (instructor)'),(20,'archeologist'),(21,'architect'),(22,'architectural conservation officer'),(23,'art critic and historian'),(24,'art glazier and window-pane maker (craft glazier)'),(25,'art metalworker (craft smith and locksmith)'),(26,'art photographer'),(27,'art restorer'),(28,'articled clerk - legal assistant'),(29,'artificial flower maker'),(30,'artistic promotions manager'),(31,'assessor (insurance assessor)'),(32,'assistant housekeeper (domestic help)'),(33,'assistant printing worker'),(34,'astrologer'),(35,'astronomer'),(36,'athlete (sportsman/woman)'),(37,'auctioneer'),(38,'audio graphic designer'),(39,'auditor'),(40,'auto-electrician'),(41,'auxiliary shop assistant (shop worker/shelf filler)'),(42,'auxiliary worker in geological survey (geological survey worker)'),(43,'auxiliary worker in textile and clothing industry (worker in textile and clothing)'),(44,'auxiliary worker in the timber industry (worker in woodcutting)'),(45,'auxiliary worker in water management (worker in water supply and distribution)'),(46,'auxiliaryworker in pharmaceutical and medical production'),(47,'baker'),(48,'bank clerk (client service)'),(49,'bank clerk for commercial credit'),(50,'banking expert'),(51,'barber and hairdresser (hairdresser)'),(52,'barman/barmaid (bartender)'),(53,'basket-maker and weaver'),(54,'beautician (beautician/beauty therapist)'),(55,'beekeeper'),(56,'bibliographer'),(57,'biochemist'),(58,'biologist'),(59,'biotechnologist'),(60,'biscuit maker'),(61,'blacksmith (farrier)'),(62,'blasters foreman/woman (explosives expert)'),(63,'blast-furnaceman/woman'),(64,'blasting works engineer'),(65,'boatman/woman (bargee, )'),(66,'boiler operator (boiler attendant)'),(67,'boilermaker/fitter'),(68,'bookbinder'),(69,'bookkeeper'),(70,'bookmaker'),(71,'botanist'),(72,'brewer and maltster'),(73,'bricklayer'),(74,'broadcaster/announcer (radio broadcaster, telecaster)'),(75,'brush-maker (brush maker)'),(76,'builders\' labourer (worker in the construction industry)'),(77,'building and road machinery mechanic'),(78,'building electrician'),(79,'building fitter (building locksmith)'),(80,'building inspector'),(81,'building machine operator'),(82,'building materials production operative'),(83,'building tinsmith'),(84,'building/civil engineering/ architectural technician/technologist'),(85,'butcher and sausage-maker'),(86,'butler'),(87,'button maker'),(88,'cab/taxi dispatcher'),(89,'cabinet maker'),(90,'cable car driver'),(91,'cable manufacture labourer (cable maker)'),(92,'camera mechanic'),(93,'camera operator (camera operator/camera crew)'),(94,'canning worker (cannery operator)'),(95,'capital markets clerk/officer'),(96,'captain of an aircraft'),(97,'car mechanic'),(98,'car service worker (service station worker )'),(99,'care assistant, home care assistant, home care organiser'),(100,'career diplomat/ diplomat'),(101,'career guidance counsellor (careers adviser)'),(102,'caretaker'),(103,'carpenter'),(104,'cartographer'),(105,'cellulose operator'),(106,'ceramic model maker'),(107,'ceramic painter (painter of ceramics )'),(108,'ceramicist (potter)'),(109,'ceramics/pottery maker'),(110,'charter agent /ship broker'),(111,'cheese maker'),(112,'chemical industries operative (chemical operator)'),(113,'chemical industry production manager'),(114,'chemical laboratory technician (laboratory assistant)'),(115,'chemical plant machine operator in non-ferrous metal production'),(116,'chemical plant machine operator(fat and cosmetic industries)'),(117,'chemical researcher'),(118,'chemical technologist'),(119,'chief/senior guard (railways)'),(120,'children\'s nurse (child\'s nurse )'),(121,'chimney sweep'),(122,'chipboard/fibreboard production operative'),(123,'choir master/mistress'),(124,'choreographer'),(125,'circus artiste (circus performer)'),(126,'cleaner'),(127,'clerk for cash or credit card systems'),(128,'cloakroom attendant'),(129,'coffee roaster'),(130,'coffeehouse keeper (caf� owner)'),(131,'commentator, reporter, journalist (commentator, reporter)'),(132,'commercial lawyer'),(133,'company lawyer'),(134,'composer'),(135,'computer engineer (information technology engineer)'),(136,'computer equipment operator (information technology operator)'),(137,'computer network manager'),(138,'computer programmer (systems programmer/ applications programmer)'),(139,'concrete worker (concreter)'),(140,'conductor (orchestral)'),(141,'conductor (tram/bus)'),(142,'confectioner (pastry and cake maker)'),(143,'conservator (museum/art gallery)'),(144,'construction carpenter/joiner'),(145,'construction/building site manager (site manager)'),(146,'cook'),(147,'corrosion control fitter'),(148,'court executive officer (bailiff)'),(149,'craft ceramicist'),(150,'craft gilder'),(151,'craft glass etcher'),(152,'craft glassmaker'),(153,'craft metal founder and chaser'),(154,'craft metalworker and brazier'),(155,'craft mosaic maker'),(156,'craft plasterer'),(157,'craft stonemason'),(158,'craft upholsterer'),(159,'crane driver (crane operator)'),(160,'crate maker/cooper'),(161,'criminal investigator'),(162,'crop treatment operative'),(163,'croupier'),(164,'customs officer (customs inspector)'),(165,'cutler'),(166,'dairy worker (dairy operator)'),(167,'dance teacher/trainer'),(168,'dancer'),(169,'data transfer appliance technician'),(170,'debt collector'),(171,'decorator-paperhanger (painter and decorator)'),(172,'dental surgery assistant (dental nurse)'),(173,'dental technician'),(174,'dentist / dental surgeon'),(175,'developing and printing technician (photographic laboratory assistant)'),(176,'dietician'),(177,'digger'),(178,'director (theatre/films)'),(179,'disc jockey'),(180,'dish washer'),(181,'dispatch clerk'),(182,'dispatcher (mines and quarries)'),(183,'dispatcher, electric power'),(184,'diver'),(185,'dog trainer'),(186,'doorkeeper, porter (doorkeeper)'),(187,'draughtsperson (draughtsman/woman)'),(188,'dresser'),(189,'driller'),(190,'drilling rig operator (driller)'),(191,'driver of motor vehicles (motor vehicle driver)'),(192,'driver\'s mate (driver\'s assistant)'),(193,'driving instructor'),(194,'dust control technician'),(195,'ecologist (environmentalist)'),(196,'economist (company accountant)'),(197,'editor (technical, language)/specialist editor'),(198,'educational methods specialist'),(199,'electrical and power systems design engineer'),(200,'electrical equipment design engineer (designer of electrotechnical appliances)'),(201,'electrical equipment inspector'),(202,'electrical fitter (electrical mechanic)'),(203,'electrician'),(204,'electroceramic production operative'),(205,'electronic equipment mechanic (electronic engineering technician)'),(206,'electroplating operator (galvaniser)'),(207,'employment agent (employment officer)'),(208,'enamel worker'),(209,'engineering fitter (machine fitter)'),(210,'engineering maintenance technician (plant technologist)'),(211,'entertainment officer'),(212,'environmental protection inspector (environmental inspector)'),(213,'ergonomist'),(214,'ethnographer'),(215,'exhibitions production manager'),(216,'faith healer'),(217,'farm worker/farm labourer'),(218,'farmer'),(219,'fashion designer'),(220,'feed production operator'),(221,'film critic'),(222,'film designer (film set designer)'),(223,'film or videotape editor'),(224,'film projectionist'),(225,'financial analyst'),(226,'financial officer'),(227,'fine artist'),(228,'fire officer'),(229,'fire officer (firefighter)'),(230,'fire prevention officer, fire inspector'),(231,'fish farmer'),(232,'fish warden (water keeper/bailiff)'),(233,'fisherman'),(234,'fitter (mechanic/fitter)'),(235,'fitter of (scientific and industrial) glass instruments'),(236,'fitter of gas pipelines (gas mains fitter)'),(237,'fitter of steel structures'),(238,'flight attendant (steward/ess, cabin staff)'),(239,'flight engineer'),(240,'floor fitter (floor layer)'),(241,'flower, shrub or plant grower'),(242,'flying instructor'),(243,'food industry production manager'),(244,'food industry technologist'),(245,'foreign exchange clerk'),(246,'foreign exchange clerk/teller (foreign exchange office clerk)'),(247,'forester (forestry manager)'),(248,'forester/forest manager'),(249,'forestry machine operator'),(250,'forestry worker'),(251,'fortune teller'),(252,'foster parent'),(253,'foundry worker/foundry process operator / coremaker /patternmaker'),(254,'fringe/trimmings maker'),(255,'fruit farmer (fruit grower)'),(256,'funeral service assistant (funeral service worker)'),(257,'fur coat seamstress (fur coat sewer)'),(258,'furnace operator'),(259,'furrier'),(260,'gardener (market gardener)'),(261,'gas industry inspector'),(262,'general labourer - chemical industry (worker in the chemical industry)'),(263,'general labourer - rubber and plastic manufacture (worker in rubber and plastic production)'),(264,'general labourer in petroleum refineries (worker in oil processing)'),(265,'geneticist'),(266,'geographer'),(267,'geological surveying equipment mechanic'),(268,'geologist'),(269,'geomechanic technician (mining)'),(270,'geophysicist'),(271,'glass decorator (glass engraver)'),(272,'glass jewellery maker'),(273,'glass making machine operator'),(274,'glass melter'),(275,'glass painter'),(276,'glass production worker (worker in the glass industry)'),(277,'glasscutter (glass grinder)'),(278,'glassworker (glass worker)'),(279,'glazier'),(280,'goldsmith'),(281,'government licensing officials (government licensing official)'),(282,'graphic designer (graphic designer /audiovisual graphic designer)'),(283,'gravedigger'),(284,'guide'),(285,'gunsmith'),(286,'hand embroiderer'),(287,'hand lacemaker'),(288,'harbour guard'),(289,'hardener'),(290,'harpooner'),(291,'hatter (hat maker)'),(292,'heating and ventilating fitter (air-conditioning fitter)'),(293,'heating engineer (heating and ventilating engineer)'),(294,'herbalist'),(295,'high-rise work specialist (steeplejack)'),(296,'historian'),(297,'historical monuments administrator /custodian (warden of a historic building)'),(298,'horse breeder (horse breeder and trainer)'),(299,'host (hostess)'),(300,'hotel porter'),(301,'hotel receptionist (receptionist)'),(302,'hydrologist'),(303,'ice-cream maker'),(304,'image consultant'),(305,'industrial designer (wood and furniture industry)'),(306,'information assistant/officer in rail transport'),(307,'information assistant/receptionist'),(308,'inspector of telecommunications equipment (inspector of telecommunications)'),(309,'insulation worker (insulator)'),(310,'insurance clerk'),(311,'insurance sales person, collector, and insurance underwriter'),(312,'interior designer interior designer'),(313,'interpreter and translator'),(314,'investment clerk'),(315,'invoice clerk'),(316,'jeweller (manufacturing or retail)/goldsmith and silversmith/jewellery designer'),(317,'jewellery maker'),(318,'joiner and cabinetmaker (joiner)'),(319,'judge'),(320,'keeper of records (archivist)'),(321,'keeper of service animals'),(322,'knitter'),(323,'land surveyor'),(324,'landscape architect'),(325,'laundry worker & dry-cleaner (laundry and dry cleaning operative )'),(326,'laundry worker (dry cleaning worker)'),(327,'lecturer (higher education)'),(328,'lecturer in vocational courses'),(329,'lecturer/researcher in linguistics'),(330,'librarian (librarian/information scientist )'),(331,'lifeguard (swimming instructor)'),(332,'lift attendant'),(333,'lift fitter'),(334,'lighting technician'),(335,'lightning conductor fitter (fitter of lightning conductors)'),(336,'lithographer'),(337,'livestock farmer'),(338,'lottery ticket street vendor'),(339,'machine shop worker (worker in a metal works)'),(340,'machinery inspector'),(341,'maker of non-woven textiles'),(342,'make-up artist and wigmaker'),(343,'management accountant'),(344,'management consultant'),(345,'manager'),(346,'manager/supervisor for shopping, accommodation or food-service units (catering manager)'),(347,'marine engineer (ship\'s engineer and machine operator)'),(348,'marine hotel manager'),(349,'marketing manager'),(350,'masseur/masseuse'),(351,'master of ceremonies'),(352,'materials handler'),(353,'mathematician'),(354,'medical laboratory assistant (medical laboratory technician)'),(355,'mechanic - measuring, controlling and automated systems (measurement and control technician )'),(356,'mechanic (service mechanic)'),(357,'mechanical engineering designer'),(358,'mechanical engineering production manager'),(359,'mechanical engineering technologist'),(360,'mechatronic engineer'),(361,'metal engraver'),(362,'metal grinder'),(363,'metal refiner'),(364,'metal turner'),(365,'metal worker / Steelworker (Foundry Worker )'),(366,'metallurgist (materials technician)'),(367,'metallurgist of nonferrous metals'),(368,'meteorologist'),(369,'metrologist'),(370,'microbiologist'),(371,'midwife'),(372,'miller'),(373,'milling-machine operator'),(374,'mine rescue service mechanic'),(375,'mine ventilation technician (mine ventilation engineer)'),(376,'miner'),(377,'mining air control technician'),(378,'mining electrician - heavy-current equipment (mining electrician of heavy-current equipment)'),(379,'mining finisher (mining dresser)'),(380,'mining machine operator'),(381,'mining mechanic (mining fitter)'),(382,'mining rescue worker (mining rescuer)'),(383,'mining/minerals surveyor'),(384,'model/ fashion model, photographic model'),(385,'modeller (model maker)'),(386,'motor vehicle bodybuilder/repairer'),(387,'mountain guide'),(388,'multimedia designer'),(389,'multimedia programmer (web site designer)'),(390,'municipal police officer (policeman/woman)'),(391,'municipal services worker (communal service worker)'),(392,'municipal street cleaner (communal cleaning worker)'),(393,'museum/art gallery curator'),(394,'music director'),(395,'musical instrument mechanic (musical instrument technician)'),(396,'musician'),(397,'musicologist'),(398,'nanny /nursery nurse'),(399,'naturalist/nature guide (reserve warden)'),(400,'newspaper editor/ sub-editor (journalist)'),(401,'nuclear power station operator'),(402,'nurse (general medicine, paediatric, obstetric)'),(403,'nursery school teacher (nursery teacher)'),(404,'nutritionist'),(405,'office junior'),(406,'on-line customer services operator'),(407,'operational analyst/researcher'),(408,'operations electrician for heavy-current equipment (heavy-current appliance electrician)'),(409,'operations mechanic (plant fitter)'),(410,'operative - food processing (food processing operator)'),(411,'operative in chemical and synthetic fibre manufacture'),(412,'operator in the tobacco industry'),(413,'operator of gas plant equipment (gasworks equipment operator)'),(414,'operator of numerically controlled machine tools'),(415,'operator of plastic material processing machines (plastics process operative)'),(416,'optical component maker / lens grinder'),(417,'optical instrument mechanic'),(418,'ore crusher (smelting and refinery)'),(419,'orthopaedic shoemaker (orthopaedic bootmaker)'),(420,'orthotic/prosthetic technician'),(421,'orthotist/prosthetist'),(422,'out-of-school educator'),(423,'overhead telecommunications cable fitter'),(424,'packer'),(425,'paediatrician'),(426,'palmists'),(427,'paper worker'),(428,'paramedic (ambulance worker)'),(429,'patent agent'),(430,'paver - asphalt layer (road worker)'),(431,'pawnbroker'),(432,'pedicurist, manicurist (pedicurist-manicurist)'),(433,'personnel officer'),(434,'pest control officer'),(435,'petroleum and petrochemical process operators'),(436,'pharmaceutical industry operative (pharmaceutical operator)'),(437,'pharmaceutical laboratory technician (pharmaceutical laboratory assistant)'),(438,'pharmacist'),(439,'philosopher'),(440,'photographer'),(441,'photographic reporter (press photographer)'),(442,'physicist'),(443,'physiotherapist'),(444,'piano tuner'),(445,'pilot (harbours and ports)'),(446,'pilot[aircraft]'),(447,'pipe fitter'),(448,'pipe fitter'),(449,'pizza maker'),(450,'plumber'),(451,'plywood maker'),(452,'police assistant (police clerk)'),(453,'police investigator (detective)'),(454,'police officer/inspector'),(455,'political scientist'),(456,'pollster'),(457,'post office counter clerk'),(458,'postal service worker'),(459,'postal transport worker'),(460,'postal worker (postman/woman)'),(461,'postmaster/postmistress'),(462,'poultry breeder (poultry farmer)'),(463,'poultry butcher (poulterer)'),(464,'powder metallurgist'),(465,'power engineering specialist'),(466,'power station supervisor'),(467,'power station/systems operator (energy s equipment operator)'),(468,'power system worker (worker in the electrical energy industry)'),(469,'power truck driver'),(470,'prefab construction worker'),(471,'press officer/public relations officer'),(472,'pricing officer'),(473,'priest/minister of religion (clergyman/woman)'),(474,'primary school teacher'),(475,'printer'),(476,'printing machine mechanic'),(477,'printing technician'),(478,'prison guard / prison officer'),(479,'private detective'),(480,'producer'),(481,'producer of leather goods/ leather goods worker'),(482,'product designer (industrial designer)'),(483,'production manager (electronic appliances)'),(484,'production manager in glass and ceramics'),(485,'production manager in textile industry'),(486,'production manager in wood industry'),(487,'production technologist (electronic appliances)/electronic appliance production technologist'),(488,'professional soldier'),(489,'prompter'),(490,'property manager'),(491,'props master (properties staff member)'),(492,'psychiatrist'),(493,'psychologist'),(494,'psychotherapist'),(495,'public administration officer'),(496,'public notary'),(497,'public relations manager'),(498,'publican (landlord/landlady)'),(499,'publisher'),(500,'purchasing officer/buyer/merchandiser'),(501,'quality control technician (technologist)/non-destructive testing (ndt) technician'),(502,'quality inspector'),(503,'radio and tv technician'),(504,'radio and tv transmission engineering technician'),(505,'radio officer/operator (merchant navy)'),(506,'radiographer/radiotherapist'),(507,'rail transport worker'),(508,'rail vehicle mechanic'),(509,'railway carriage and wagon inspector'),(510,'railway electrician (rail transport electrician)'),(511,'railway engine mechanic'),(512,'railway freight handler'),(513,'railway guard (guard)'),(514,'railway operative (railway administrative worker )'),(515,'railway ticket/booking office clerk (booking office clerk/ticket office clerk)'),(516,'railway track construction fitter'),(517,'railway yard worker'),(518,'real estate agent (estate agent)'),(519,'referee (umpire)'),(520,'refrigeration engineer (refrigeration mechanic )'),(521,'refuse collector'),(522,'registrar'),(523,'removal worker /furniture removal worker'),(524,'reproduction technician/photographer'),(525,'restorer of applied arts and crafts'),(526,'retoucher'),(527,'river basin keeper (river manager)'),(528,'road sign assistant (road sign keeper)'),(529,'road transport technician'),(530,'rolling-mill operator (rolling-mill worker)'),(531,'roofer (roof tiler or slater)'),(532,'room maid (chambermaid/cleaning staff)'),(533,'rope maker'),(534,'rotating machine fitter'),(535,'rubber operator (rubber process operative)'),(536,'rubber processing machine operator/ tyrefitter'),(537,'safety and communication electrician'),(538,'safety engineer'),(539,'safety, health and quality inspectors, health and safety inspectors'),(540,'sales assistant (salesperson)'),(541,'sales manager'),(542,'sales representative (commercial traveller)'),(543,'scaffolder'),(544,'scene painter'),(545,'scene-shifter'),(546,'script editor'),(547,'script writer (scriptwriter)'),(548,'sculptor'),(549,'seaman/woman (merchant navy) rating'),(550,'secondary school teacher'),(551,'secretary (secretary, personal assistant)'),(552,'section supervisor (mines and quarries)'),(553,'security guard'),(554,'service mechanic/ repairer'),(555,'sewerage system cleaning operator (sewerage cleaner)'),(556,'sewing machinist'),(557,'shepherd, goatherd'),(558,'shift engineer'),(559,'ship fitter /shipwright'),(560,'ship\'s captain'),(561,'ship\'s officer'),(562,'shoemaker (cobbler)'),(563,'shop cashier (shop cashier/checkout operator)'),(564,'shunter'),(565,'shunting team manager'),(566,'school caretaker'),(567,'school inspector'),(568,'silkworm breeder, sericulturist'),(569,'singer'),(570,'smith'),(571,'social worker'),(572,'sociologist'),(573,'solicitor'),(574,'songwriter'),(575,'sound effects technician'),(576,'sound engineer'),(577,'spa resort attendant (baths assistant)'),(578,'special educational needs teacher'),(579,'special effects engineer (special effects engineer)'),(580,'special needs teacher (learning/behavioural difficulties)'),(581,'specialist in animal husbandry (livestock specialist)'),(582,'spectacle frame maker'),(583,'speech therapist'),(584,'spinner'),(585,'stable hand, groom'),(586,'stage costume maker'),(587,'stage designer / theatre designer'),(588,'stage manager'),(589,'standards engineer'),(590,'state attorney (public prosecutor)'),(591,'station manager'),(592,'statistician'),(593,'stockbroker'),(594,'stonemason, stonecutter (stonemason)'),(595,'storekeeper (warehouse keeper)'),(596,'stove fitter'),(597,'stuntman (stuntwoman)'),(598,'sugar-maker (sugar maker)'),(599,'surgical toolmaker (surgery toolmaker)'),(600,'surveyor\'s assistant/helper'),(601,'sweet factory worker (sweet maker)'),(602,'systems designer (systems analyst)'),(603,'systems engineer (manufacturing)'),(604,'tailor, dressmaker (tailor and dressmaker)'),(605,'tamer (lion tamer)'),(606,'tanner'),(607,'tannery worker'),(608,'tax specialist, tax adviser/consultant'),(609,'technical editor'),(610,'technologist in glass and ceramics'),(611,'telecommunications cable fitter'),(612,'telecommunications dispatcher (controller of telecommunications operation)'),(613,'telecommunications engineer'),(614,'telecommunications installation and repair technician'),(615,'telecommunications mechanic (telecommunications technician)'),(616,'telecommunications technician'),(617,'telecommunications worker'),(618,'telephone/switchboard operator'),(619,'teller'),(620,'textile printer'),(621,'textile refiner'),(622,'textile technologist'),(623,'textiles dyer'),(624,'the doctor (doctor)'),(625,'the hygiene service assistant (hygiene service assistant)'),(626,'the medical orderly (nursing auxiliary/health care assistant)'),(627,'the optician (optometrist)'),(628,'ticket collector/inspector'),(629,'tinsmith'),(630,'tobacco technologist'),(631,'tool setter (machine-tool setter)'),(632,'tool-maker (toolmaker)'),(633,'town planner'),(634,'track engineer'),(635,'tracklayer'),(636,'tractor-driver'),(637,'trading standards officer/weights and measures inspector'),(638,'traffic police officer (motor patrolman/woman)'),(639,'train dispatcher'),(640,'train driver (engine driver)'),(641,'trainee/apprentice chef'),(642,'trainer (sports)/coach'),(643,'trainman/woman'),(644,'tram driver'),(645,'transport supervisor (transportation supervisor)'),(646,'travel agency clerk'),(647,'travel courier (tourist guide)'),(648,'tunneller (tunnel builder)'),(649,'tutor/ governess (home tutor)'),(650,'typesetter'),(651,'underground mine safety engineer (deep-mining safety engineer)'),(652,'upholsterer and decorator (upholsterer)'),(653,'usher/usherette'),(654,'valuer'),(655,'varnisher (painter-varnisher)'),(656,'veterinary surgeon'),(657,'veterinary technician (animal nurse)/veterinary assistant'),(658,'viniculturist (wine-grower)'),(659,'wages clerk'),(660,'waiter (waitress)'),(661,'wardrobe master/mistress'),(662,'warehouse clerk'),(663,'waste incineration plant worker'),(664,'water management controller (water supply and distribution manager)'),(665,'water supply and distribution equipment operator'),(666,'water treatment plant operator / water meter reader'),(667,'watercourse manager (river administrator)'),(668,'watch-maker (watchmaker)'),(669,'watchman (watchwoman)/security guard'),(670,'weaver'),(671,'weaver (hand weaver)'),(672,'weigher'),(673,'weir and dam operator'),(674,'welding operator (welder)'),(675,'well digger'),(676,'whaler'),(677,'window cleaner'),(678,'window-dresser'),(679,'winery worker/wine maker'),(680,'wire-drawer'),(681,'wood carver'),(682,'wood industry technologist'),(683,'woodcutting manager'),(684,'woodworking operator (wood machinist)'),(685,'work study engineer/organisation and methods officer (electronic appliances)'),(686,'work study/organisation and methods officer (glass and ceramics)'),(687,'work study/organisation and methods officer (mechanical engineering)'),(688,'work study/organisation and methods officer (textile industry)'),(689,'work study/organisation and methods officer (wood and furniture industry)'),(690,'worker in electrical engineering production'),(691,'worker in gas distribution'),(692,'worker in pressing and stamping shops'),(693,'worker in recycling services (worker at household waste recycling site)'),(694,'worker in shoe production (worker in footwear production)'),(695,'worker in the food industry (worker in food industry)'),(696,'worker in the paper industry'),(697,'worker in the production of building materials'),(698,'worker the in fur processing industry'),(699,'worker, metal industry (foundry worker)'),(700,'zookeeper'),(701,'Businessman'),(702,'Salaried'),(703,'Retired');
/*!40000 ALTER TABLE `occupation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_mode`
--

DROP TABLE IF EXISTS `payment_mode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_mode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_mode`
--

LOCK TABLES `payment_mode` WRITE;
/*!40000 ALTER TABLE `payment_mode` DISABLE KEYS */;
INSERT INTO `payment_mode` VALUES (1,'NEFT'),(2,'CASH'),(3,'CHEQUE');
/*!40000 ALTER TABLE `payment_mode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_status`
--

DROP TABLE IF EXISTS `payment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_status`
--

LOCK TABLES `payment_status` WRITE;
/*!40000 ALTER TABLE `payment_status` DISABLE KEYS */;
INSERT INTO `payment_status` VALUES (1,'Partial'),(2,'Completed');
/*!40000 ALTER TABLE `payment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `birth_date` date NOT NULL,
  `gender` char(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobile` varchar(45) NOT NULL,
  `optional_mobile` varchar(45) DEFAULT NULL,
  `life_goals` varchar(255) DEFAULT NULL,
  `e3_goals` varchar(45) DEFAULT NULL,
  `office_reg_no` varchar(45) DEFAULT NULL,
  `company_name` varchar(45) DEFAULT NULL,
  `designation` varchar(45) DEFAULT NULL,
  `qualification` varchar(45) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `job_profile` varchar(45) DEFAULT NULL,
  `is_married` char(1) NOT NULL,
  `reffered_by_type` varchar(45) DEFAULT NULL,
  `reffered_by_mobile` varchar(45) DEFAULT NULL,
  `reffered_by_name` varchar(45) DEFAULT NULL,
  `number_of_siblings` int(11) DEFAULT NULL,
  `whtsup_mobile` varchar(45) DEFAULT NULL,
  `other_education_details` varchar(45) DEFAULT NULL,
  `industry_id` int(11) DEFAULT NULL,
  `occupation_id` int(11) DEFAULT NULL,
  `business_size` int(11) DEFAULT NULL,
  `business_turnover_id` int(11) DEFAULT NULL,
  `optional_email` varchar(255) DEFAULT NULL,
  `reffered_by_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_user2_idx` (`user_id`),
  KEY `fk_person_industry1_idx` (`industry_id`),
  KEY `fk_person_occupation1_idx` (`occupation_id`),
  KEY `fk_person_business_turnover1_idx` (`business_turnover_id`),
  KEY `fk_person_user3_idx` (`reffered_by_user_id`),
  CONSTRAINT `fk_person_business_turnover1` FOREIGN KEY (`business_turnover_id`) REFERENCES `business_turnover` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_industry1` FOREIGN KEY (`industry_id`) REFERENCES `industry` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_occupation1` FOREIGN KEY (`occupation_id`) REFERENCES `occupation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_user2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_person_user3` FOREIGN KEY (`reffered_by_user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (7,'Devendra','Khamkar','2016-03-27','M','deva@gmail.com','9773611703','8888888888',NULL,NULL,NULL,NULL,NULL,'MCA ',40,NULL,'Y',NULL,NULL,NULL,NULL,'7777777777','HSC',NULL,NULL,NULL,NULL,'darshan@gmail.com',NULL),(8,'Vishal ','Kesarkar','2016-04-02','M','vishal@gmail.com','9773611703','9773937434',NULL,NULL,NULL,NULL,NULL,'MCA',41,NULL,'Y',NULL,NULL,NULL,NULL,'7777777777','HSC',NULL,NULL,NULL,NULL,'darshan@gmail.com',NULL),(9,'Mayur','Bande','2016-04-04','M','mayur@gmail.com','9773611703','9773937434','Yes To All','Yes To All','45454','TATA','Employee','MCA',42,'Developer','M','existing','','',1,'7777777777','HSC',NULL,701,3,1,'darshan@gmail.com',40),(10,'Avadhut','Hande','2016-03-29','M','avadhut@gmail.com','9773611703','8888888888',NULL,NULL,NULL,NULL,NULL,'',43,NULL,'Y',NULL,NULL,NULL,NULL,'7777777777','',NULL,NULL,NULL,NULL,'darshan@gmail.com',NULL),(11,'Dilip','Shahu','2016-03-28','M','dilip@gmail.com','9777777777','8888888888','Yes To All','Yes To All','45456','TATA','Emoloyee','MCA',44,'Developer','M','existing','','',1,'7777777777','HSC',NULL,4,NULL,NULL,'darshan@gmail.com',41),(12,'Prachi','Desai','2016-03-28','F','prachi@gmail.com','9773611703','8888888888',NULL,NULL,NULL,NULL,NULL,'MCA',45,NULL,'Y',NULL,NULL,NULL,NULL,'7777777777','HSC',NULL,NULL,NULL,NULL,'darshan@gmail.com',NULL);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Admin'),(2,'Coach'),(3,'Student');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `venue` varchar(255) NOT NULL,
  `batch_id` int(11) NOT NULL,
  `isactive` char(1) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `food_contribution` int(11) NOT NULL,
  `collected_food_contribution` int(11) DEFAULT NULL,
  `jumbo_call_date` date DEFAULT NULL,
  `jumbo_call_start_time` time DEFAULT NULL,
  `jumbo_call_end_time` time DEFAULT NULL,
  `jumbo_call_conf_number` varchar(45) DEFAULT NULL,
  `jumbo_call_conf_details` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_session_batch1_idx` (`batch_id`),
  KEY `fk_session_user1_idx` (`updated_by`),
  KEY `fk_session_user2_idx` (`created_by`),
  CONSTRAINT `fk_session_batch1` FOREIGN KEY (`batch_id`) REFERENCES `batch` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_user1` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_user2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (1,'CA Work Shop','2016-03-31','03:00:00','06:00:00','Dadar',1,'Y',NULL,NULL,'2016-03-31 03:00:00',1,500,NULL,NULL,NULL,NULL,NULL,NULL),(2,'MBA Workshop','2016-04-01','03:00:00','06:00:00','Thane',2,'Y',NULL,NULL,'2016-04-01 03:00:00',1,0,NULL,NULL,NULL,NULL,NULL,NULL),(3,'MBA Work Shop 2','2016-04-01','03:00:00','06:00:00','Thane',3,'Y',NULL,NULL,'2016-04-01 03:00:00',1,0,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_assignment`
--

DROP TABLE IF EXISTS `session_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_assignment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `session_id` int(11) NOT NULL,
  `isactive` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assignment_session1_idx` (`session_id`),
  CONSTRAINT `fk_assignment_session1` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_assignment`
--

LOCK TABLES `session_assignment` WRITE;
/*!40000 ALTER TABLE `session_assignment` DISABLE KEYS */;
INSERT INTO `session_assignment` VALUES (1,'Assignment1',NULL,1,'Y'),(2,'Assignment2',NULL,1,'Y'),(3,'Assignment3',NULL,2,'Y'),(4,'Assignment4',NULL,2,'N');
/*!40000 ALTER TABLE `session_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_attendance`
--

DROP TABLE IF EXISTS `session_attendance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_attendance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `batch_user_id` int(11) NOT NULL,
  `in_time` time DEFAULT NULL,
  `out_time` time DEFAULT NULL,
  `is_session_payment_complete` char(1) DEFAULT NULL,
  `is_present` char(1) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_session_registration_session1_idx` (`session_id`),
  KEY `fk_session_registration_batch_user1_idx` (`batch_user_id`),
  KEY `fk_session_attendance_user1_idx` (`created_by`),
  KEY `fk_session_attendance_user2_idx` (`updated_by`),
  CONSTRAINT `fk_session_attendance_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_attendance_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_registration_batch_user1` FOREIGN KEY (`batch_user_id`) REFERENCES `batch_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_registration_session1` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_attendance`
--

LOCK TABLES `session_attendance` WRITE;
/*!40000 ALTER TABLE `session_attendance` DISABLE KEYS */;
INSERT INTO `session_attendance` VALUES (1,1,1,'12:00:00','13:00:00','Y','Y',NULL,1,'2016-04-04 11:53:06',NULL),(2,1,2,'12:10:00','13:20:00','N','Y',NULL,1,'2016-04-04 11:53:06',NULL);
/*!40000 ALTER TABLE `session_attendance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_distinction`
--

DROP TABLE IF EXISTS `session_distinction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_distinction` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `session_id` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_distiction_session1_idx` (`session_id`),
  KEY `fk_distiction_user1_idx` (`updated_by`),
  KEY `fk_distiction_user2_idx` (`created_by`),
  CONSTRAINT `fk_distiction_session1` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_distiction_user1` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_distiction_user2` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_distinction`
--

LOCK TABLES `session_distinction` WRITE;
/*!40000 ALTER TABLE `session_distinction` DISABLE KEYS */;
INSERT INTO `session_distinction` VALUES (1,'Distinction1','Distin Desc1',1,NULL,NULL,'2016-04-04 11:53:06',1),(2,'Distinction1','Distin Desc1',1,NULL,NULL,'2016-04-04 11:53:06',1);
/*!40000 ALTER TABLE `session_distinction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_media`
--

DROP TABLE IF EXISTS `session_media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_media` (
  `id` int(11) NOT NULL,
  `url` varchar(255) NOT NULL,
  `type` varchar(25) NOT NULL,
  `session_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `open_to_all` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_session_media_session1_idx` (`session_id`),
  KEY `fk_session_media_user1_idx` (`created_by`),
  KEY `fk_session_media_user2_idx` (`updated_by`),
  CONSTRAINT `fk_session_media_session1` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_media_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_media_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_media`
--

LOCK TABLES `session_media` WRITE;
/*!40000 ALTER TABLE `session_media` DISABLE KEYS */;
INSERT INTO `session_media` VALUES (1,'https://www.youtube.com/watch?v=G1Uw-58wivI','VIDEO',1,1,NULL,'2016-04-04 11:53:06',NULL,'Y'),(2,'http://www.eandginnovativeeducation.in/wordpress/wp-content/uploads/2015/12/IMG_5802-1-1030x687.jpg','IMAGE',1,1,NULL,'2016-04-04 11:53:06',NULL,'N');
/*!40000 ALTER TABLE `session_media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_sharing`
--

DROP TABLE IF EXISTS `session_sharing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_sharing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sharing_details` varchar(255) DEFAULT NULL,
  `session_id` int(11) NOT NULL,
  `batch_user_id` int(11) NOT NULL,
  `sharing_time` time NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_session_sharing_session1_idx` (`session_id`),
  KEY `fk_session_sharing_batch_user1_idx` (`batch_user_id`),
  KEY `fk_session_sharing_user1_idx` (`created_by`),
  KEY `fk_session_sharing_user2_idx` (`updated_by`),
  CONSTRAINT `fk_session_sharing_batch_user1` FOREIGN KEY (`batch_user_id`) REFERENCES `batch_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_sharing_session1` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_sharing_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_session_sharing_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_sharing`
--

LOCK TABLES `session_sharing` WRITE;
/*!40000 ALTER TABLE `session_sharing` DISABLE KEYS */;
INSERT INTO `session_sharing` VALUES (1,'Sharing1',1,1,'12:00:00',NULL,1,'2016-04-04 11:53:06',NULL),(2,'Sharing2',1,2,'13:00:00',NULL,1,'2016-04-04 11:53:06',NULL);
/*!40000 ALTER TABLE `session_sharing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `state`
--

DROP TABLE IF EXISTS `state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(45) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_state_country1_idx` (`country_id`),
  CONSTRAINT `fk_state_country1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `state`
--

LOCK TABLES `state` WRITE;
/*!40000 ALTER TABLE `state` DISABLE KEYS */;
INSERT INTO `state` VALUES (1,'JAMMU & KASHMIR','1',1),(2,'HIMACHAL PRADESH','2',1),(3,'PUNJAB','3',1),(4,'CHANDIGARH','4',1),(5,'UTTARANCHAL','5',1),(6,'HARYANA','6',1),(7,'DELHI','7',1),(8,'RAJASTHAN','8',1),(9,'UTTAR PRADESH','9',1),(10,'BIHAR','10',1),(11,'SIKKIM','11',1),(12,'ARUNACHAL PRADESH','12',1),(13,'NAGALAND','13',1),(14,'MANIPUR','14',1),(15,'MIZORAM','15',1),(16,'TRIPURA','16',1),(17,'MEGHALAYA','17',1),(18,'ASSAM','18',1),(19,'WEST BENGAL','19',1),(20,'JHARKHAND','20',1),(21,'ORISSA','21',1),(22,'CHHATTISGARH','22',1),(23,'MADHYA PRADESH','23',1),(24,'GUJARAT','24',1),(25,'DAMAN & DIU','25',1),(26,'DADRA & NAGAR HAVELI','26',1),(27,'MAHARASHTRA','27',1),(28,'ANDHRA PRADESH','28',1),(29,'KARNATAKA','29',1),(30,'GOA','30',1),(31,'LAKSHADWEEP','31',1),(32,'KERALA','32',1),(33,'TAMIL NADU','33',1),(34,'PONDICHERRY','34',1),(35,'ANDAMAN & NICOBAR ISLANDS','35',1);
/*!40000 ALTER TABLE `state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `token`
--

DROP TABLE IF EXISTS `token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `token` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(45) NOT NULL,
  `expired_by` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `refresh_by` datetime NOT NULL,
  `isactive` char(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_token_user1_idx` (`user_id`),
  KEY `fk_token_role1_idx` (`role_id`),
  CONSTRAINT `fk_token_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_token_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `token`
--

LOCK TABLES `token` WRITE;
/*!40000 ALTER TABLE `token` DISABLE KEYS */;
/*!40000 ALTER TABLE `token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `isactive` char(1) NOT NULL,
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_datetime` datetime NOT NULL,
  `updated_datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_user1_idx` (`created_by`),
  KEY `fk_user_user2_idx` (`updated_by`),
  CONSTRAINT `fk_user_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_user2` FOREIGN KEY (`updated_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','admin','Y',1,NULL,'2016-03-29 03:00:00',NULL),(11,'rahul','Rahul@1234','Y',1,1,'2016-03-30 12:00:35','2016-03-30 04:41:26'),(12,'aniket','Aniket@123','Y',1,1,'2016-03-30 12:25:59','2016-03-30 05:10:54'),(13,'hkfgdsajfkjsdbsdjc','Aniket@1234','Y',1,NULL,'2016-03-30 03:30:26',NULL),(20,'','','Y',1,NULL,'2016-03-30 03:46:24',NULL),(23,'dili','Dilip@123','Y',1,1,'2016-03-30 05:04:09','2016-03-30 05:11:50'),(24,'sandy','Sandy@123','Y',1,1,'2016-03-30 05:16:12','2016-03-30 05:18:12'),(25,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:36:07',NULL),(26,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:37:14',NULL),(27,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:38:12',NULL),(28,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:38:30',NULL),(29,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:45:29',NULL),(30,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:45:52',NULL),(31,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:48:06',NULL),(32,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:50:22',NULL),(33,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:51:09',NULL),(34,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:51:39',NULL),(36,'aniket','Aniket@1223','Y',1,NULL,'2016-04-01 04:57:04',NULL),(40,'deva','Deva212345','Y',1,NULL,'2016-04-01 06:12:09',NULL),(41,'vishal','Vishal@1234','Y',1,NULL,'2016-04-04 11:05:35',NULL),(42,'mayur','Mayur@1234','Y',1,NULL,'2016-04-04 11:53:06',NULL),(43,'avadhut','Avadhut@1234','Y',1,1,'2016-04-04 12:14:11','2016-04-04 03:35:27'),(44,'dilip','Dilip@1234','Y',1,NULL,'2016-04-04 04:31:23',NULL),(45,'prachi','Prachi@1234','Y',1,NULL,'2016-04-04 04:34:40',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_address_details`
--

DROP TABLE IF EXISTS `user_address_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_address_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address_line_1` varchar(45) NOT NULL,
  `address_line_2` varchar(45) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `pincode` varchar(45) NOT NULL,
  `street_landmark` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `district_id` int(11) NOT NULL,
  `city_taluka_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_address_details_user1_idx` (`user_id`),
  KEY `fk_user_address_details_country1_idx` (`country_id`),
  KEY `fk_user_address_details_state1_idx` (`state_id`),
  KEY `fk_user_address_details_district1_idx` (`district_id`),
  KEY `fk_user_address_details_city_taluka1_idx` (`city_taluka_id`),
  CONSTRAINT `fk_user_address_details_city_taluka1` FOREIGN KEY (`city_taluka_id`) REFERENCES `city_taluka` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_address_details_country1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_address_details_district1` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_address_details_state1` FOREIGN KEY (`state_id`) REFERENCES `state` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_address_details_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_address_details`
--

LOCK TABLES `user_address_details` WRITE;
/*!40000 ALTER TABLE `user_address_details` DISABLE KEYS */;
INSERT INTO `user_address_details` VALUES (5,'Near Hanuman Mandir','',40,'400086','Kirol Road',1,27,504,4340),(6,'Thane','',41,'400086','Near Thane station',1,27,504,4340),(7,'Thane','',42,'400086','Near Wagle Estate',1,27,504,4340),(8,'Ghatkopar ','',43,'400086','Near Asalpha Metro Station',1,27,505,4341),(9,'Vidyavihr','',44,'400086','Near Hanuman Mandir',1,27,504,4340),(10,'Thane','',45,'400072','Near Ghodbandar Road',1,27,504,4340);
/*!40000 ALTER TABLE `user_address_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_assignment_status`
--

DROP TABLE IF EXISTS `user_assignment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_assignment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assignment_id` int(11) NOT NULL,
  `batch_user_id` int(11) NOT NULL,
  `approved_by_user_id` int(11) NOT NULL,
  `assignment_status_id` int(11) NOT NULL,
  `user_comment` varchar(1024) DEFAULT NULL,
  `approver_comment` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_assignment_status_assignment1_idx` (`assignment_id`),
  KEY `fk_user_assignment_status_batch_user1_idx` (`batch_user_id`),
  KEY `fk_user_assignment_status_batch_user2_idx` (`approved_by_user_id`),
  KEY `fk_user_assignment_status_assignment_status1_idx` (`assignment_status_id`),
  CONSTRAINT `fk_user_assignment_status_assignment1` FOREIGN KEY (`assignment_id`) REFERENCES `session_assignment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_assignment_status_assignment_status1` FOREIGN KEY (`assignment_status_id`) REFERENCES `assignment_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_assignment_status_batch_user1` FOREIGN KEY (`batch_user_id`) REFERENCES `batch_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_assignment_status_batch_user2` FOREIGN KEY (`approved_by_user_id`) REFERENCES `batch_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_assignment_status`
--

LOCK TABLES `user_assignment_status` WRITE;
/*!40000 ALTER TABLE `user_assignment_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_assignment_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_books`
--

DROP TABLE IF EXISTS `user_books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_books_user1_idx` (`user_id`),
  CONSTRAINT `fk_user_books_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_books`
--

LOCK TABLES `user_books` WRITE;
/*!40000 ALTER TABLE `user_books` DISABLE KEYS */;
INSERT INTO `user_books` VALUES (1,'Balguruswami',42),(2,'Balguruswami',44);
/*!40000 ALTER TABLE `user_books` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_family_details`
--

DROP TABLE IF EXISTS `user_family_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_family_details` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `relation` varchar(20) DEFAULT NULL,
  `educational_qualification` varchar(45) DEFAULT NULL,
  `professional_designation` varchar(45) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `optional_email` varchar(425) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT NULL,
  `job_profile` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_person_user1_idx` (`user_id`),
  CONSTRAINT `fk_person_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_family_details`
--

LOCK TABLES `user_family_details` WRITE;
/*!40000 ALTER TABLE `user_family_details` DISABLE KEYS */;
INSERT INTO `user_family_details` VALUES (1,42,'Pooja','Bande','2016-04-04','F','spouse','MCA','Employee','pooja@gmail.com','mayur@gmail.com','9773937434','Developer','TATA'),(2,44,'Pramila','Sahu','2016-04-04','F','spouse','MCA','Employee','pramila@gmail.com','darshan@gmail.com','9773937434','Developer','TATA');
/*!40000 ALTER TABLE `user_family_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'e3erp_sit'
--

--
-- Dumping routines for database 'e3erp_sit'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-04 18:21:18
