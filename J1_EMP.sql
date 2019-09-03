-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: J1_EMP
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.18.04.1

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
-- Table structure for table `EMPLOYEES`
--

DROP TABLE IF EXISTS `EMPLOYEES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EMPLOYEES` (
  `ecode` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `pass_hash` varchar(100) NOT NULL,
  `designation` varchar(100) NOT NULL,
  PRIMARY KEY (`ecode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEES`
--

LOCK TABLES `EMPLOYEES` WRITE;
/*!40000 ALTER TABLE `EMPLOYEES` DISABLE KEYS */;
INSERT INTO `EMPLOYEES` VALUES ('E00179','preeti.khanna@trantorinc.com','Preeti Khanna','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','TeamLead'),('E00213','sachin.dogra@trantorinc.com','Sachin Dogra','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','TeamLead'),('E00583','jaspreet.singh@trantorinc.com','Jaspreet Singh','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','TeamLead'),('E01114','aakash.gautam@trantorinc.com','Aakash Gautam','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','Developer'),('E01115','diksha.wadhwa@trantorinc.com','Diksha Wadhwa','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','Developer'),('E01116','mayank.sinha@trantorinc.com','Mayank Sinha','12r2s25827O+WjpghzuF8+yr8+Tc3VwjDDRRuBofNdY=\r\n$sAJ4A8rNE/db3IXklFodHuwnk8kiAHgbk7xO7rr6nU0=\r\n','Developer'),('E01188','kartik.raina@trantorinc.com','Kartik Raina','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','TeamLead'),('EXXXX0','admin.leaveApp@trantorinc.com','Admin','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','Admin'),('EXXXXX','superAdmin.leaveApp@trantorinc.com','Super Admin','Qi7A6dFrU9sqgd/eIlJwboJN5iKFZIwuW727TQ++7DY=\r\n$oO2hjR2H2m7HmnXH+pC2VlKukrgyRCQ9An65O2JREAI=\r\n','Super_Admin');
/*!40000 ALTER TABLE `EMPLOYEES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LEAVE_REQUEST`
--

DROP TABLE IF EXISTS `LEAVE_REQUEST`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LEAVE_REQUEST` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ecode` varchar(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `team_lead` varchar(100) NOT NULL,
  `project_manager` varchar(100) NOT NULL,
  `leave_start_date` date NOT NULL,
  `leave_end_date` date NOT NULL,
  `number_of_days` int(11) NOT NULL,
  `full_day_leave` int(11) DEFAULT '0',
  `half_day_leave` int(11) DEFAULT '0',
  `leave_type` varchar(100) NOT NULL,
  `leave_desc` varchar(400) NOT NULL,
  `leave_request_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LEAVE_REQUEST`
--

LOCK TABLES `LEAVE_REQUEST` WRITE;
/*!40000 ALTER TABLE `LEAVE_REQUEST` DISABLE KEYS */;
/*!40000 ALTER TABLE `LEAVE_REQUEST` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LEAVE_STATUS`
--

DROP TABLE IF EXISTS `LEAVE_STATUS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LEAVE_STATUS` (
  `id` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LEAVE_STATUS`
--

LOCK TABLES `LEAVE_STATUS` WRITE;
/*!40000 ALTER TABLE `LEAVE_STATUS` DISABLE KEYS */;
/*!40000 ALTER TABLE `LEAVE_STATUS` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-02 12:46:23
