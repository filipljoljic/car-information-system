/*
SQLyog Community v13.1.9 (64 bit)
MySQL - 8.0.28 : Database - freedb_carsharing
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`freedb_carsharing` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `freedb_carsharing`;

/*Table structure for table `accounts` */

DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `password` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `status` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'PENDING',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

/*Data for the table `accounts` */

insert  into `accounts`(`id`,`username`,`password`,`status`) values 
(15,'testo','test1','ACTIVE'),
(40,'ajla','123','ACTIVE'),
(50,'asisic1','password','ACTIVE'),
(57,'test','5f4dcc3b5aa765d61d8327deb882cf99','PENDING'),
(58,'ajlaaa','19cf8fc05187049569a7fc2991782bac','PENDING'),
(59,'ajla.sisic','12345','ACTIVE');

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `locationID` int unsigned NOT NULL AUTO_INCREMENT,
  `location_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `location_address` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`locationID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

/*Data for the table `locations` */

insert  into `locations`(`locationID`,`location_name`,`location_address`) values 
(1,'Grbavica','Kemala Kapetanovica 12'),
(2,'AP','TMP 7'),
(3,'Otoka','Gradacacka 32');

/*Table structure for table `payments` */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `rentalID` int unsigned NOT NULL,
  `total_amount` double NOT NULL,
  `payment_date` date NOT NULL,
  `payment_details` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rental` (`rentalID`),
  CONSTRAINT `fk_rental` FOREIGN KEY (`rentalID`) REFERENCES `rentaldetails` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

/*Data for the table `payments` */

/*Table structure for table `rentaldetails` */

DROP TABLE IF EXISTS `rentaldetails`;

CREATE TABLE `rentaldetails` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `date_of_rental` date NOT NULL,
  `pick_up_time` time NOT NULL,
  `drop_of_time` time NOT NULL,
  `vehicleID` int unsigned NOT NULL,
  `accountID` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_vehicleID` (`vehicleID`),
  KEY `fk_account` (`accountID`),
  CONSTRAINT `fk_account` FOREIGN KEY (`accountID`) REFERENCES `accounts` (`id`),
  CONSTRAINT `fk_vehicleID` FOREIGN KEY (`vehicleID`) REFERENCES `vehicles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

/*Data for the table `rentaldetails` */

insert  into `rentaldetails`(`id`,`date_of_rental`,`pick_up_time`,`drop_of_time`,`vehicleID`,`accountID`) values 
(1,'2021-04-07','08:45:00','09:50:00',2,50),
(2,'2021-05-05','19:38:29','22:22:00',3,40);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `DOB` date NOT NULL,
  `email` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `phone_number` int NOT NULL,
  `role` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'USER',
  `token` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `token_created_at` timestamp NULL DEFAULT NULL,
  `accountID` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_email` (`email`),
  KEY `fk_accountID` (`accountID`),
  CONSTRAINT `fk_accountID` FOREIGN KEY (`accountID`) REFERENCES `accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

/*Data for the table `users` */

insert  into `users`(`id`,`full_name`,`DOB`,`email`,`phone_number`,`role`,`token`,`token_created_at`,`accountID`) values 
(34,'blablabla','1911-10-05','test123@gmail.com',865874,'USER','2f33b8236dd59a66970669e7852c7cff',NULL,15),
(57,'Ajla Sisic','2000-07-19','ajlasisic00@gmail.com',532525,'USER','5dbf2c6f3c7ae12a675ec443e7078506',NULL,40),
(65,'Ajla Sisic','2000-02-10','ajla.sisic19@gmail.com',634634,'ADMIN','764424075bb30b9ba58010c95d6b2475','2021-09-13 11:53:42',50),
(68,'Name Surname','2000-01-01','blabla@gmail.com',123456,'USER','903dcfb5079ae72466c5d527c412758a',NULL,57),
(69,'Name Surname','2001-07-29','ajla.sisic@stu.ibu.edu.ba',123456,'ADMIN',NULL,'2021-09-13 18:26:31',59);

/*Table structure for table `vehicles` */

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `car_brand` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `car_model` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `mileage` int DEFAULT NULL,
  `availability` tinyint(1) DEFAULT NULL,
  `locationID` int unsigned DEFAULT NULL,
  `license_plate` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `price_per_hour` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_locationID` (`locationID`),
  CONSTRAINT `fk_locationID` FOREIGN KEY (`locationID`) REFERENCES `locations` (`locationID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;

/*Data for the table `vehicles` */

insert  into `vehicles`(`id`,`car_brand`,`car_model`,`mileage`,`availability`,`locationID`,`license_plate`,`price_per_hour`) values 
(2,'renault','clio',10231,1,1,'123A432B',5.44),
(3,'peugeot','308',4503,1,2,'276P432K',4.82),
(4,'vw','up',173,0,3,'840H946L',6.5),
(5,'renault','kadjar',1286,1,1,'347H215N',4.45),
(6,'audi','a3',NULL,NULL,NULL,'137A259M',5.5),
(7,'audi','a2',NULL,1,NULL,'912H828K',2.9),
(11,'peugeot','206',NULL,1,NULL,'1397H5M2',3.53),
(12,'renault','clio',NULL,1,NULL,'187G911V',1.99),
(15,'peugeot','508',NULL,NULL,NULL,'2EU34S13',2.1),
(17,'vw','up',NULL,NULL,NULL,'2AA34S13',2);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
