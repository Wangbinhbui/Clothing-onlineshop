-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: SWP391_FASHION_SHOP
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Order_Status`
--

DROP TABLE IF EXISTS `Order_Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Status`
--

LOCK TABLES `Order_Status` WRITE;
/*!40000 ALTER TABLE `Order_Status` DISABLE KEYS */;
INSERT INTO `Order_Status` VALUES (1,'Pending'),(2,'Prepared Order'),(3,'Package Order'),(4,'Delivering'),(5,'Successfully'),(6,'Cancelled');
/*!40000 ALTER TABLE `Order_Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'admin'),(2,'sale'),(3,'makerting'),(4,'user'),(5,'sale manager'),(6,'staff');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `AddressID` int NOT NULL AUTO_INCREMENT,
  `addressline` varchar(500) DEFAULT NULL,
  `city` varchar(500) DEFAULT NULL,
  `postalcode` varchar(100) DEFAULT NULL,
  `CountryID` int DEFAULT NULL,
  PRIMARY KEY (`AddressID`),
  KEY `fk_address_country` (`CountryID`),
  CONSTRAINT `fk_address_country` FOREIGN KEY (`CountryID`) REFERENCES `country` (`CountryID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'Thanh Cong','Ha Noi','100000',1),(2,'Thanh Cong','Ha Noi','100000',1),(3,'Thanh Cong','Ha Noi','100000',1),(4,'Thanh Cong','Ha Noi','100000',1),(5,'Thanh Cong','Ha Noi','100000',1),(6,'Thanh Cong','Ha Noi','100000',1),(7,'Thanh Cong','Ha Noi','100000',1),(8,'Thanh Cong','Ha Noi','100000',1),(9,'Thanh Cong','Ha Noi','100000',1),(10,'Thanh Cong','Ha Noi','100000',1),(11,'UIH ADI','Hanoi','2333',2),(12,'anao','asdaf','12312',3),(13,'afsgasg','afasda','132123',1),(14,'wewdasd','sdasdasd','13213123',1),(15,'asdasdad','adsadas','123123',1),(16,'4444','Hanoi','23123',1),(17,'S48','Tokyo','12314',2),(18,'S48','Tokyo','13412',2),(19,'S554','Tokyo','1234',2),(20,'S34','Tokyo','3213',2),(21,'S48','Tokyo','1234',2),(22,'Hai Ba Trung','Ha Noi','3416',1),(23,'Hai Ba Trung','Ha Noi','3241',1),(24,'S54','Tokyo','3210',2),(25,'S45','Tokyo','314',2),(26,'S52','TOkyo','2131',2),(27,'DIa chi Da Nang','Thanh Pho Da Nang','9999',2),(28,'S47','Tokyo','4488',2),(29,'S34','Tokyo','655',2);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `brief_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` int DEFAULT NULL,
  `author` int NOT NULL,
  `updated_date` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('Active','Inactive') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Active',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `blog_author_idx` (`author`),
  CONSTRAINT `blog_author_fk` FOREIGN KEY (`author`) REFERENCES `user` (`UserID`),
  CONSTRAINT `blog_category_fk` FOREIGN KEY (`category_id`) REFERENCES `blog_category` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_category`
--

DROP TABLE IF EXISTS `blog_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_category_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_category`
--

LOCK TABLES `blog_category` WRITE;
/*!40000 ALTER TABLE `blog_category` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `CartID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  PRIMARY KEY (`CartID`),
  KEY `fk_cart_user` (`UserID`),
  CONSTRAINT `fk_cart_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (1,4),(2,5),(3,6),(4,7),(5,9),(6,9),(7,9),(13,11),(14,21);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_item`
--

DROP TABLE IF EXISTS `cart_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart_item` (
  `cart_itemID` int NOT NULL AUTO_INCREMENT,
  `CartID` int DEFAULT NULL,
  `ProductID` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `VariationID` int DEFAULT NULL,
  PRIMARY KEY (`cart_itemID`),
  KEY `fk_cartitem_cart` (`CartID`),
  KEY `fk_cartitem_product` (`ProductID`),
  KEY `fk_cartitem_variation` (`VariationID`),
  CONSTRAINT `fk_cartitem_cart` FOREIGN KEY (`CartID`) REFERENCES `cart` (`CartID`),
  CONSTRAINT `fk_cartitem_product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`),
  CONSTRAINT `fk_cartitem_variation` FOREIGN KEY (`VariationID`) REFERENCES `variation` (`VariationID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_item`
--

LOCK TABLES `cart_item` WRITE;
/*!40000 ALTER TABLE `cart_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `CategoryID` int NOT NULL AUTO_INCREMENT,
  `CategoryName` varchar(200) DEFAULT NULL,
  `Category_img` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'DRESSES ','dresses.jpg'),(2,'DENIM','denim.jpg'),(3,'TEES & TANKS','tees.jpg'),(4,'BOTTOMS','bottoms.jpg'),(5,'TOPS','tops.jpg'),(6,'SHOES & ACCESSORIES ','shoes.jpg'),(7,'SWIM','swim.jpg'),(8,'SHORTS & SKIRTS','shortandskirt.jpg'),(9,'Result',NULL),(10,'NEW ARRIVALS','newarrival.jpg'),(11,'BEST SELLER','bestseller.jpg');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collection`
--

DROP TABLE IF EXISTS `collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collection` (
  `CollectionID` int NOT NULL AUTO_INCREMENT,
  `CollectionName` varchar(200) DEFAULT NULL,
  `collectionImg` varchar(200) DEFAULT NULL,
  `collection_description` longtext,
  `create_date` datetime DEFAULT NULL,
  `PromotionID` int DEFAULT NULL,
  PRIMARY KEY (`CollectionID`),
  KEY `fk_collection_promotion` (`PromotionID`),
  CONSTRAINT `fk_collection_promotion` FOREIGN KEY (`PromotionID`) REFERENCES `promotion` (`PromotionID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collection`
--

LOCK TABLES `collection` WRITE;
/*!40000 ALTER TABLE `collection` DISABLE KEYS */;
INSERT INTO `collection` VALUES (1,'Summer Collection','1.jpg','New Summer Collection',NULL,2),(2,'Winter Collection','winter.jpg','New Winterr Collection',NULL,2),(3,'Sprin Collection','spring.jpg','New Spring Collection',NULL,2),(4,'Autumn Collection','Autumn.jpg','New Autumn Collection',NULL,2);
/*!40000 ALTER TABLE `collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `color`
--

DROP TABLE IF EXISTS `color`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `color` (
  `color_ID` int NOT NULL AUTO_INCREMENT,
  `color_Name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`color_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `color`
--

LOCK TABLES `color` WRITE;
/*!40000 ALTER TABLE `color` DISABLE KEYS */;
INSERT INTO `color` VALUES (1,'White'),(2,'Blue'),(3,'Black'),(4,'Grey'),(5,'Green'),(6,'Brown'),(7,'Orange'),(8,'Pink'),(9,'Tan'),(10,'Red');
/*!40000 ALTER TABLE `color` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `CountryID` int NOT NULL AUTO_INCREMENT,
  `CountryName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`CountryID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Vietnam'),(2,'Japan'),(3,'Lao'),(4,'Thailand');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderdetails`
--

DROP TABLE IF EXISTS `orderdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderdetails` (
  `OrderDetailID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `OrderID` int DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `VariationID` int DEFAULT NULL,
  PRIMARY KEY (`OrderDetailID`),
  KEY `fk_orderdetails_product` (`ProductID`),
  KEY `fk_orderdetails_order` (`OrderID`),
  KEY `fk_orderdetails_variation` (`VariationID`),
  CONSTRAINT `fk_orderdetails_order` FOREIGN KEY (`OrderID`) REFERENCES `shop_order` (`shop_orderID`),
  CONSTRAINT `fk_orderdetails_product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`),
  CONSTRAINT `fk_orderdetails_variation` FOREIGN KEY (`VariationID`) REFERENCES `variation` (`VariationID`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderdetails`
--

LOCK TABLES `orderdetails` WRITE;
/*!40000 ALTER TABLE `orderdetails` DISABLE KEYS */;
INSERT INTO `orderdetails` VALUES (28,29,20,1,736400,'2024-06-12',517),(29,46,20,3,8100000,'2024-06-12',803),(30,46,20,2,5400000,'2024-06-12',812),(31,47,21,1,2405400,'2024-06-12',827),(32,56,21,1,1296000,'2024-06-12',958),(33,56,21,1,1296000,'2024-06-12',960),(34,16,22,1,1423600,'2024-06-12',280),(35,58,22,1,2160000,'2024-06-12',1009),(36,60,22,1,981800,'2024-06-12',1037),(37,22,23,2,981800,'2024-06-12',385),(38,22,23,2,981800,'2024-06-12',392),(39,61,24,1,981800,'2024-06-12',1055),(40,62,24,2,3129400,'2024-06-12',1058),(41,38,26,2,5400000,'2024-06-12',708),(42,38,26,2,5400000,'2024-06-12',714),(43,38,27,1,2700000,'2024-06-12',715),(44,4,28,3,300000,NULL,53),(45,4,29,3,300000,NULL,11),(46,3,29,1,450000,NULL,11);
/*!40000 ALTER TABLE `orderdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `OrderDetailID` int DEFAULT NULL,
  `type` tinyint DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_payment_user` (`UserID`),
  KEY `fk_payment_orderdetail` (`OrderDetailID`),
  CONSTRAINT `fk_payment_orderdetail` FOREIGN KEY (`OrderDetailID`) REFERENCES `orderdetails` (`OrderDetailID`),
  CONSTRAINT `fk_payment_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `ProductID` int NOT NULL AUTO_INCREMENT,
  `CategoryID` int DEFAULT NULL,
  `ProductName` varchar(200) DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `CollectionID` int DEFAULT NULL,
  `description` longtext,
  `status` tinyint DEFAULT '1',
  PRIMARY KEY (`ProductID`),
  KEY `fk_product_category` (`CategoryID`),
  KEY `fk_product_collection` (`CollectionID`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`CategoryID`),
  CONSTRAINT `fk_product_collection` FOREIGN KEY (`CollectionID`) REFERENCES `collection` (`CollectionID`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,1,'Áo thun nam cổ tròn',250000,1,'Áo thun cotton thoáng mát',1),(2,1,'Áo sơ mi nam dài tay',350000,1,'Áo sơ mi công sở lịch lãm',1),(3,2,'Quần jeans nam ống đứng',450000,2,'Quần jeans co giãn 4 chiều',1),(4,2,'Quần kaki nam slimfit',300000,2,'Quần kaki không nhăn',1),(5,3,'Đầm dự tiệc cổ V',650000,3,'Đầm dự tiệc sang trọng',1),(6,3,'Chân váy xếp ly',200000,3,'Chân váy công sở thanh lịch',1),(7,4,'Áo khoác dù nam',150000,4,'Áo khoác chống nước',1),(8,4,'Áo len nữ cổ lọ',180000,4,'Áo len giữ ấm',1),(9,5,'Giày thể thao nam',500000,5,'Giày chạy bộ đế êm',1),(10,5,'Giày cao gót nữ',300000,5,'Giày công sở cao 5cm',1),(72,11,'áo gile',1000,1,'nothing',1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_img`
--

DROP TABLE IF EXISTS `product_img`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_img` (
  `product_img_ID` int NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(200) DEFAULT NULL,
  `product_img_1` varchar(200) DEFAULT NULL,
  `product_img_2` varchar(200) DEFAULT NULL,
  `product_img_3` varchar(200) DEFAULT NULL,
  `product_img_name` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`product_img_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_img`
--

LOCK TABLES `product_img` WRITE;
/*!40000 ALTER TABLE `product_img` DISABLE KEYS */;
INSERT INTO `product_img` VALUES (5,'thumbnail_The Corduroy Wide-Leg Pant_Black.jpg','1_The Corduroy Wide-Leg Pant_Black.jpg','2_The Corduroy Wide-Leg Pant_Black.jpg','3_The Corduroy Wide-Leg Pant_Black.jpg',NULL),(6,'thumbnail_The Corduroy Wide-Leg Pant_Brown.jpg','1_The Corduroy Wide-Leg Pant_Brown.jpg','2_The Corduroy Wide-Leg Pant_Brown.jpg','2_The Corduroy Wide-Leg Pant_Brown.jpg',NULL),(7,'thumbnail_The Corduroy Wide-Leg Pant_White.jpg','1_The Corduroy Wide-Leg Pant_White.jpg','2_The Corduroy Wide-Leg Pant_White.jpg','2_The Corduroy Wide-Leg Pant_White.jpg',NULL),(8,'thumbnail_The Dream Pant_Black.jpg','1_The Dream Pant_Black.jpg','2_The Dream Pant_Black.jpg','3_The Dream Pant_Black.jpg',NULL),(9,'thumbnail_The Dream Pant_Blue.jpg','1_The Dream Pant_Blue.jpg','2_The Dream Pant_Blue.jpg','2_The Dream Pant_Blue.jpg',NULL),(10,'thumbnail_The Dream Pant_Brown.jpg','1_The Dream Pant_Brown.jpg','2_The Dream Pant_Brown.jpg','2_The Dream Pant_Brown.jpg',NULL),(11,'thumbnail_The Dream Pant_Green.jpg','1_The Dream Pant_Green.jpg','2_The Dream Pant_Green.jpg','2_The Dream Pant_Green.jpg',NULL),(12,'thumbnail_The Easy Pant_Black.jpg','1_The Easy Pant_Black.jpg','2_The Easy Pant_Black.jpg','3_The Easy Pant_Black.jpg',NULL),(13,'thumbnail_The Easy Pant_Blue.jpg','1_The Easy Pant_Blue.jpg	','2_The Easy Pant_Blue.jpg	','3_The Easy Pant_Blue.jpg	',NULL),(14,'thumbnail_The Easy Pant_Green.jpg	','1_The Easy Pant_Green.jpg	','2_The Easy Pant_Green.jpg	','3_The Easy Pant_Green.jpg	',NULL),(15,'thumbnail_The Easy Pant_White.jpg	','1_The Easy Pant_White.jpg	','2_The Easy Pant_White.jpg	','3_The Easy Pant_White.jpg	',NULL),(16,'thumbnail_The Organic Straight-Leg Pant_Black.jpg	','1_The Organic Straight-Leg Pant_Black.jpg	','2_The Organic Straight-Leg Pant_Black.jpg	','2_The Organic Straight-Leg Pant_Black.jpg	',NULL),(17,'thumbnail_The Organic Straight-Leg Pant_Blue.jpg	','1_The Organic Straight-Leg Pant_Blue.jpg	','2_The Organic Straight-Leg Pant_Blue.jpg	','2_The Organic Straight-Leg Pant_Blue.jpg	',NULL),(18,'thumbnail_The Organic Straight-Leg Pant_Brown.jpg	','1_The Organic Straight-Leg Pant_Brown.jpg	','2_The Organic Straight-Leg Pant_Brown.jpg	','3_The Organic Straight-Leg Pant_Brown.jpg',NULL),(19,'thumbnail_The Organic Straight-Leg Pant_White.jpg	','1_The Organic Straight-Leg Pant_White.jpg	','2_The Organic Straight-Leg Pant_White.jpg	','3_The Organic Straight-Leg Pant_White.jpg',NULL),(20,'thumbnail_The Perform Legging_Black.jpg	','1_The Perform Legging_Black.jpg	','2_The Perform Legging_Black.jpg	','2_The Perform Legging_Black.jpg	',NULL),(21,'thumbnail_The Perform Legging_Blue.jpg','1_The Perform Legging_Blue.jpg	','2_The Perform Legging_Blue.jpg	','2_The Perform Legging_Blue.jpg	',NULL),(22,'thumbnail_The Relaxed Chino_Black.jpg','1_The Relaxed Chino_Black.jpg','2_The Relaxed Chino_Black.jpg','3_The Relaxed Chino_Black.jpg',NULL),(23,'thumbnail_The Relaxed Chino_Brown.jpg','1_The Relaxed Chino_Brown.jpg','2_The Relaxed Chino_Brown.jpg','2_The Relaxed Chino_Brown.jpg',NULL),(24,'thumbnail_The Relaxed Chino_Tan.jpg','1_The Relaxed Chino_Tan.jpg','2_The Relaxed Chino_Tan.jpg','2_The Relaxed Chino_Tan.jpg',NULL),(25,'thumbnail_The Structured Cotton Belted Pant_Blue.jpg','1_The Structured Cotton Belted Pant_Blue.jpg','2_The Structured Cotton Belted Pant_Blue.jpg','2_The Structured Cotton Belted Pant_Blue.jpg',NULL),(26,'thumbnail_The Structured Cotton Belted Pant_Brown.jpg','1_The Structured Cotton Belted Pant_Brown.jpg','2_The Structured Cotton Belted Pant_Brown.jpg','2_The Structured Cotton Belted Pant_Brown.jpg',NULL),(27,'thumbnail_The Structured Cotton Belted Pant_White.jpg','1_The Structured Cotton Belted Pant_White.jpg','2_The Structured Cotton Belted Pant_White.jpg','3_The Structured Cotton Belted Pant_White.jpg',NULL),(28,'thumbnail_The Utility Barrel Pant_Black.jpg','1_The Utility Barrel Pant_Black.jpg','2_The Utility Barrel Pant_Black.jpg','3_The Utility Barrel Pant_Black.jpg',NULL),(29,'thumbnail_The Utility Barrel Pant_Green.jpg','1_The Utility Barrel Pant_Green.jpg','2_The Utility Barrel Pant_Green.jpg','3_The Utility Barrel Pant_Green.jpg',NULL),(30,'thumbnail_The Utility Barrel Pant_Red.jpg','1_The Utility Barrel Pant_Red.jpg','2_The Utility Barrel Pant_Red.jpg','3_The Utility Barrel Pant_Red.jpg',NULL),(31,'thumbnail_The Utility Barrel Pant_White.jpg','1_The Utility Barrel Pant_White.jpg','2_The Utility Barrel Pant_White.jpg','3_The Utility Barrel Pant_White.jpg',NULL),(32,'thumbnail_The Way-High Drape Pant_Green.jpg','1_The Way-High Drape Pant_Green.jpg','2_The Way-High Drape Pant_Green.jpg','2_The Way-High Drape Pant_Green.jpg',NULL),(33,'thumbnail_The A-Line Denim Short_Black.jpg','1_The A-Line Denim Short_Black.jpg','2_The A-Line Denim Short_Black.jpg','3_The A-Line Denim Short_Black.jpg',NULL),(34,'thumbnail_The A-Line Denim Short_Blue.jpg','1_The A-Line Denim Short_Blue.jpg','2_The A-Line Denim Short_Blue.jpg','3_The A-Line Denim Short_Blue.jpg',NULL),(35,'thumbnail_The A-Line Denim Short_Tan.jpg','1_The A-Line Denim Short_Tan.jpg','2_The A-Line Denim Short_Tan.jpg','3_The A-Line Denim Short_Tan.jpg',NULL),(36,'thumbnail_The Denim Utility Short_Black.jpg','1_The Denim Utility Short_Black.jpg','2_The Denim Utility Short_Black.jpg','3_The Denim Utility Short_Black.jpg',NULL),(37,'thumbnail_The Denim Utility Short_Blue.jpg','1_The Denim Utility Short_Blue.jpg','2_The Denim Utility Short_Blue.jpg','3_The Denim Utility Short_Blue.jpg',NULL),(38,'thumbnail_The Denim Utility Short_Gray.jpg','1_The Denim Utility Short_Gray.jpg','2_The Denim Utility Short_Gray.jpg','3_The Denim Utility Short_Gray.jpg',NULL),(39,'thumbnail_The Dream Maxi Skirt_Black.jpg','1_The Dream Maxi Skirt_Black.jpg','2_The Dream Maxi Skirt_Black.jpg','3_The Dream Maxi Skirt_Black.jpg',NULL),(40,'thumbnail_The Dream Maxi Skirt_Brown.jpg','1_The Dream Maxi Skirt_Brown.jpg','2_The Dream Maxi Skirt_Brown.jpg','3_The Dream Maxi Skirt_Brown.jpg',NULL),(41,'thumbnail_The Dream Mini Skirt_Black.jpg','1_The Dream Mini Skirt_Black.jpg','2_The Dream Mini Skirt_Black.jpg','3_The Dream Mini Skirt_Black.jpg',NULL),(42,'thumbnail_The Dream Mini Skirt_Brown.jpg','1_The Dream Mini Skirt_Brown.jpg','2_The Dream Mini Skirt_Brown.jpg','3_The Dream Mini Skirt_Brown.jpg',NULL),(43,'thumbnail_The Easy Short_Black.jpg','1_The Easy Short_Black.jpg','2_The Easy Short_Black.jpg','3_The Easy Short_Black.jpg',NULL),(44,'thumbnail_The Easy Short_White.jpg','1_The Easy Short_White.jpg','2_The Easy Short_White.jpg','3_The Easy Short_White.jpg',NULL),(45,'thumbnail_The Linen Wrap Skirt_Black.jpg','1_The Linen Wrap Skirt_Black.jpg','2_The Linen Wrap Skirt_Black.jpg','3_The Linen Wrap Skirt_Black.jpg',NULL),(46,'thumbnail_The Linen Wrap Skirt_Green.jpg','1_The Linen Wrap Skirt_Green.jpg','2_The Linen Wrap Skirt_Green.jpg','3_The Linen Wrap Skirt_Green.jpg',NULL),(47,'thumbnail_The Perform Bike Short_Black.jpg','1_The Perform Bike Short_Black.jpg','2_The Perform Bike Short_Black.jpg','3_The Perform Bike Short_Black.jpg',NULL),(48,'thumbnail_The Tencel Way-High Drape Short_Black.jpg','1_The Tencel Way-High Drape Short_Black.jpg','2_The Tencel Way-High Drape Short_Black.jpg','3_The Tencel Way-High Drape Short_Black.jpg',NULL),(49,'thumbnail_The Tencel Way-High Drape Short_Brown.jpg','1_The Tencel Way-High Drape Short_Brown.jpg','2_The Tencel Way-High Drape Short_Brown.jpg','3_The Tencel Way-High Drape Short_Brown.jpg',NULL),(50,'thumbnail_The Tencel Way-High Drape Short_Pink.jpg','1_The Tencel Way-High Drape Short_Pink.jpg','2_The Tencel Way-High Drape Short_Pink.jpg','3_The Tencel Way-High Drape Short_Pink.jpg',NULL),(51,'thumbnail_The Bikini Bottom_Black.jpg','1_The Bikini Bottom_Black.jpg','2_The Bikini Bottom_Black.jpg','3_The Bikini Bottom_Black.jpg',NULL),(52,'thumbnail_The Bikini Bottom_Blue.jpg','1_The Bikini Bottom_Blue.jpg','2_The Bikini Bottom_Blue.jpg','3_The Bikini Bottom_Blue.jpg',NULL),(53,'thumbnail_The Bikini Bottom_Red.jpg','1_The Bikini Bottom_Red.jpg','2_The Bikini Bottom_Red.jpg','3_The Bikini Bottom_Red.jpg',NULL),(54,'thumbnail_The ReNew Plunge Triangle Top_Black.jpg','1_The ReNew Plunge Triangle Top_Black.jpg','2_The ReNew Plunge Triangle Top_Black.jpg','3_The ReNew Plunge Triangle Top_Black.jpg',NULL),(55,'thumbnail_The ReNew Plunge Triangle Top_Blue.jpg','1_The ReNew Plunge Triangle Top_Blue.jpg','2_The ReNew Plunge Triangle Top_Blue.jpg','3_The ReNew Plunge Triangle Top_Blue.jpg',NULL),(56,'thumbnail_The ReNew Plunge Triangle Top_Green.jpg','1_The ReNew Plunge Triangle Top_Green.jpg','2_The ReNew Plunge Triangle Top_Green.jpg','3_The ReNew Plunge Triangle Top_Green.jpg',NULL),(57,'thumbnail_The Square-Neck Bikini Top_Black.jpg','1_The Square-Neck Bikini Top_Black.jpg','2_The Square-Neck Bikini Top_Black.jpg','3_The Square-Neck Bikini Top_Black.jpg',NULL),(58,'thumbnail_The Square-Neck Bikini Top_Blue.jpg','1_The Square-Neck Bikini Top_Blue.jpg','2_The Square-Neck Bikini Top_Blue.jpg','3_The Square-Neck Bikini Top_Blue.jpg',NULL),(59,'thumbnail_The Square-Neck Bikini Top_Green.jpg','1_The Square-Neck Bikini Top_Green.jpg','2_The Square-Neck Bikini Top_Green.jpg','3_The Square-Neck Bikini Top_Green.jpg',NULL),(60,'thumbnail_The Square-Neck One-Piece_Black.jpg','1_The Square-Neck One-Piece_Black.jpg','2_The Square-Neck One-Piece_Black.jpg','3_The Square-Neck One-Piece_Black.jpg',NULL),(61,'thumbnail_The Square-Neck One-Piece_Blue.jpg','1_The Square-Neck One-Piece_Blue.jpg','2_The Square-Neck One-Piece_Blue.jpg','3_The Square-Neck One-Piece_Blue.jpg',NULL),(62,'thumbnail_The Square-Neck One-Piece_Green.jpg','1_The Square-Neck One-Piece_Green.jpg','2_The Square-Neck One-Piece_Green.jpg','3_The Square-Neck One-Piece_Green.jpg',NULL),(63,'thumbnail_The String One-Piece_Black.jpg','1_The String One-Piece_Black.jpg','2_The String One-Piece_Black.jpg','3_The String One-Piece_Black.jpg',NULL),(64,'thumbnail_The Thigh-High Bikini Bottom_Black.jpg','1_The Thigh-High Bikini Bottom_Black.jpg','2_The Thigh-High Bikini Bottom_Black.jpg','3_The Thigh-High Bikini Bottom_Black.jpg',NULL),(65,'thumbnail_The Thigh-High Bikini Bottom_Blue.jpg','1_The Thigh-High Bikini Bottom_Blue.jpg','2_The Thigh-High Bikini Bottom_Blue.jpg','3_The Thigh-High Bikini Bottom_Blue.jpg',NULL),(66,'thumbnail_The Thigh-High Bikini Bottom_Green.jpg','1_The Thigh-High Bikini Bottom_Green.jpg','2_The Thigh-High Bikini Bottom_Green.jpg','3_The Thigh-High Bikini Bottom_Green.jpg',NULL),(67,'thumbnail_The Triangle Bikini Top_Black.jpg','1_The Triangle Bikini Top_Black.jpg','2_The Triangle Bikini Top_Black.jpg','3_The Triangle Bikini Top_Black.jpg',NULL),(68,'thumbnail_The Triangle Bikini Top_Blue.jpg','1_The Triangle Bikini Top_Blue.jpg','2_The Triangle Bikini Top_Blue.jpg','3_The Triangle Bikini Top_Blue.jpg',NULL),(69,'thumbnail_The Triangle Bikini Top_Red.jpg','1_The Triangle Bikini Top_Red.jpg','2_The Triangle Bikini Top_Red.jpg','3_The Triangle Bikini Top_Red.jpg',NULL),(70,'thumbnail_The V-Neck One-Piece_Blue.jpg','1_The V-Neck One-Piece_Blue.jpg','2_The V-Neck One-Piece_Blue.jpg','3_The V-Neck One-Piece_Blue.jpg',NULL),(71,'thumbnail_The V-Neck One-Piece_Red.jpg','1_The V-Neck One-Piece_Red.jpg','2_The V-Neck One-Piece_Red.jpg','3_The V-Neck One-Piece_Red.jpg',NULL),(72,'thumbnail_The Air Oversized Crew Tee_Black.jpg','1_The Air Oversized Crew Tee_Black.jpg','2_The Air Oversized Crew Tee_Black.jpg','3_The Air Oversized Crew Tee_Black.jpg',NULL),(73,'thumbnail_The Air Oversized Crew Tee_Brown.jpg','1_The Air Oversized Crew Tee_Brown.jpg','2_The Air Oversized Crew Tee_Brown.jpg','3_The Air Oversized Crew Tee_Brown.jpg',NULL),(74,'thumbnail_The Air Oversized Crew Tee_White.jpg','1_The Air Oversized Crew Tee_White.jpg','2_The Air Oversized Crew Tee_White.jpg','3_The Air Oversized Crew Tee_White.jpg',NULL),(75,'thumbnail_The Organic Cotton Box-Cut Tee_Black.jpg','1_The Organic Cotton Box-Cut Tee_Black.jpg','2_The Organic Cotton Box-Cut Tee_Black.jpg','3_The Organic Cotton Box-Cut Tee_Black.jpg',NULL),(76,'thumbnail_The Organic Cotton Box-Cut Tee_Gray.jpg','1_The Organic Cotton Box-Cut Tee_Gray.jpg','2_The Organic Cotton Box-Cut Tee_Gray.jpg','3_The Organic Cotton Box-Cut Tee_Gray.jpg',NULL),(77,'thumbnail_The Organic Cotton Box-Cut Tee_White.jpg','1_The Organic Cotton Box-Cut Tee_White.jpg','2_The Organic Cotton Box-Cut Tee_White.jpg','3_The Organic Cotton Box-Cut Tee_White.jpg',NULL),(78,'thumbnail_The Organic Cotton Cutaway Tank_Black.jpg','1_The Organic Cotton Cutaway Tank_Black.jpg','2_The Organic Cotton Cutaway Tank_Black.jpg','3_The Organic Cotton Cutaway Tank_Black.jpg',NULL),(79,'thumbnail_The Organic Cotton Cutaway Tank_Gray.jpg','1_The Organic Cotton Cutaway Tank_Gray.jpg','2_The Organic Cotton Cutaway Tank_Gray.jpg','3_The Organic Cotton Cutaway Tank_Gray.jpg',NULL),(80,'thumbnail_The Organic Cotton Cutaway Tank_White.jpg','1_The Organic Cotton Cutaway Tank_White.jpg','2_The Organic Cotton Cutaway Tank_White.jpg','3_The Organic Cotton Cutaway Tank_White.jpg',NULL),(81,'thumbnail_The Organic Cotton Raglan Tee_Black.jpg','1_The Organic Cotton Raglan Tee_Black.jpg','2_The Organic Cotton Raglan Tee_Black.jpg','3_The Organic Cotton Raglan Tee_Black.jpg',NULL),(82,'thumbnail_The Organic Cotton Raglan Tee_Gray.jpg','1_The Organic Cotton Raglan Tee_Gray.jpg','2_The Organic Cotton Raglan Tee_Gray.jpg','3_The Organic Cotton Raglan Tee_Gray.jpg',NULL),(83,'thumbnail_The Organic Cotton Raglan Tee_White.jpg','1_The Organic Cotton Raglan Tee_White.jpg','2_The Organic Cotton Raglan Tee_White.jpg','3_The Organic Cotton Raglan Tee_White.jpg',NULL),(84,'thumbnail_The Organic Cotton Relaxed Pocket Tee_Black.jpg','1_The Organic Cotton Relaxed Pocket Tee_Black.jpg','2_The Organic Cotton Relaxed Pocket Tee_Black.jpg','3_The Organic Cotton Relaxed Pocket Tee_Black.jpg',NULL),(85,'thumbnail_The Organic Cotton Relaxed Pocket Tee_Gray.jpg','1_The Organic Cotton Relaxed Pocket Tee_Gray.jpg','2_The Organic Cotton Relaxed Pocket Tee_Gray.jpg','3_The Organic Cotton Relaxed Pocket Tee_Gray.jpg',NULL),(86,'thumbnail_The Organic Cotton Relaxed Pocket Tee_White.jpg','1_The Organic Cotton Relaxed Pocket Tee_White.jpg','2_The Organic Cotton Relaxed Pocket Tee_White.jpg','3_The Organic Cotton Relaxed Pocket Tee_White.jpg',NULL),(87,'thumbnail_The Organic Cotton Tie Back Tee_Black.jpg','1_The Organic Cotton Tie Back Tee_Black.jpg','2_The Organic Cotton Tie Back Tee_Black.jpg','3_The Organic Cotton Tie Back Tee_Black.jpg',NULL),(88,'thumbnail_The Organic Cotton Tie Back Tee_Gray.jpg','1_The Organic Cotton Tie Back Tee_Gray.jpg','2_The Organic Cotton Tie Back Tee_Gray.jpg','3_The Organic Cotton Tie Back Tee_Gray.jpg',NULL),(89,'thumbnail_The Organic Cotton Tie Back Tee_White.jpg','1_The Organic Cotton Tie Back Tee_White.jpg','2_The Organic Cotton Tie Back Tee_White.jpg','3_The Organic Cotton Tie Back Tee_White.jpg',NULL),(90,'thumbnail_The Pima Micro-Rib Crew Tee_Black.jpg','1_The Pima Micro-Rib Crew Tee_Black.jpg','2_The Pima Micro-Rib Crew Tee_Black.jpg','3_The Pima Micro-Rib Crew Tee_Black.jpg',NULL),(91,'thumbnail_The Pima Micro-Rib Crew Tee_Gray.jpg','1_The Pima Micro-Rib Crew Tee_Gray.jpg','2_The Pima Micro-Rib Crew Tee_Gray.jpg','3_The Pima Micro-Rib Crew Tee_Gray.jpg',NULL),(92,'thumbnail_The Pima Micro-Rib Crew Tee_White.jpg','1_The Pima Micro-Rib Crew Tee_White.jpg','1_The Pima Micro-Rib Crew Tee_White.jpg','3_The Pima Micro-Rib Crew Tee_White.jpg',NULL),(93,'thumbnail_The Supima Sleeveless Top_Black.jpg','1_The Supima Sleeveless Top_Black.jpg','2_The Supima Sleeveless Top_Black.jpg','3_The Supima Sleeveless Top_Black.jpg',NULL),(94,'thumbnail_The Supima Sleeveless Top_Gray.jpg','1_The Supima Sleeveless Top_Gray.jpg','2_The Supima Sleeveless Top_Gray.jpg','3_The Supima Sleeveless Top_Gray.jpg',NULL),(95,'thumbnail_The Supima Sleeveless Top_White.jpg','1_The Supima Sleeveless Top_White.jpg','2_The Supima Sleeveless Top_White.jpg','3_The Supima Sleeveless Top_White.jpg',NULL),(96,'thumbnail_The Tube Top_Black.jpg','1_The Tube Top_Black.jpg','2_The Tube Top_Black.jpg','3_The Tube Top_Black.jpg',NULL),(97,'thumbnail_The Tube Top_Gray.jpg','1_The Tube Top_Gray.jpg','2_The Tube Top_Gray.jpg','3_The Tube Top_Gray.jpg',NULL),(98,'thumbnail_The Tube Top_White.jpg','1_The Tube Top_White.jpg','2_The Tube Top_White.jpg','3_The Tube Top_White.jpg',NULL),(99,'thumbnail_The ’90s Cheeky Jean_Black.jpg','1_The ’90s Cheeky Jean_Black.jpg','2_The ’90s Cheeky Jean_Black.jpg','2_The ’90s Cheeky Jean_Black.jpg',NULL),(100,'thumbnail_The ’90s Cheeky Jean_Blue.jpg','1_The ’90s Cheeky Jean_Blue.jpg','2_The ’90s Cheeky Jean_Blue.jpg','2_The ’90s Cheeky Jean_Blue.jpg',NULL),(101,'thumbnail_The ’90s Cheeky Jean_White.jpg','1_The ’90s Cheeky Jean_White.jpg','2_The ’90s Cheeky Jean_White.jpg','3_The ’90s Cheeky Jean_White.jpg',NULL),(102,'thumbnail_The Baggy Jean_Black.jpg','1_The Baggy Jean_Black.jpg','2_The Baggy Jean_Black.jpg','2_The Baggy Jean_Black.jpg',NULL),(103,'thumbnail_The Baggy Jean_Blue.jpg','1_The Baggy Jean_Blue.jpg','2_The Baggy Jean_Blue.jpg','2_The Baggy Jean_Blue.jpg',NULL),(104,'thumbnail_The Baggy Jean_Grey.jpg','1_The Baggy Jean_Grey.jpg','2_The Baggy Jean_Grey.jpg','2_The Baggy Jean_Grey.jpg',NULL),(105,'thumbnail_The Gardener Jean_Blue.jpg','1_The Gardener Jean_Blue.jpg','2_The Gardener Jean_Blue.jpg','3_The Gardener Jean_Blue.jpg',NULL),(106,'thumbnail_The Gardener Jean_Green.jpg','1_The Gardener Jean_Green.jpg','2_The Gardener Jean_Green.jpg','2_The Gardener Jean_Green.jpg',NULL),(107,'thumbnail_The Gardener Jean_White.jpg','1_The Gardener Jean_White.jpg','2_The Gardener Jean_White.jpg','3_The Gardener Jean_White.jpg',NULL),(108,'thumbnail_The High-Rise Flare Jean_Blue.jpg','1_The High-Rise Flare Jean_Blue.jpg','2_The High-Rise Flare Jean_Blue.jpg','2_The High-Rise Flare Jean_Blue.jpg',NULL),(109,'thumbnail_The Low-Rise Shortie Jean_Blue.jpg','1_The Low-Rise Shortie Jean_Blue.jpg','2_The Low-Rise Shortie Jean_Blue.jpg','3_The Low-Rise Shortie Jean_Blue.jpg',NULL),(110,'thumbnail_The Rigid Slouch Jean_Blue.jpg','1_The Rigid Slouch Jean_Blue.jpg','2_The Rigid Slouch Jean_Blue.jpg','2_The Rigid Slouch Jean_Blue.jpg',NULL),(111,'thumbnail_The Rigid Slouch Jean_Grey.jpg','1_The Rigid Slouch Jean_Grey.jpg','2_The Rigid Slouch Jean_Grey.jpg','2_The Rigid Slouch Jean_Grey.jpg',NULL),(112,'thumbnail_The Utility Barrel Jean_Blue.jpg','1_The Utility Barrel Jean_Blue.jpg','2_The Utility Barrel Jean_Blue.jpg','2_The Utility Barrel Jean_Blue.jpg',NULL),(113,'thumbnail_The Way-High Jean_Blue.jpg','1_The Way-High Jean_Blue.jpg','2_The Way-High Jean_Blue.jpg','3_The Way-High Jean_Blue.jpg',NULL),(114,'thumbnail_The Daytripper Shirtdress_Black.jpg','1_The Daytripper Shirtdress_Black.jpg','2_The Daytripper Shirtdress_Black.jpg','2_The Daytripper Shirtdress_Black.jpg',NULL),(115,'thumbnail_The Daytripper Shirtdress_White.jpg','1_The Daytripper Shirtdress_White.jpg','2_The Daytripper Shirtdress_White.jpg','3_The Daytripper Shirtdress_White.jpg',NULL),(116,'thumbnail_The Dream Shift Dress_Black.jpg','1_The Dream Shift Dress_Black.jpg','2_The Dream Shift Dress_Black.jpg','3_The Dream Shift Dress_Black.jpg',NULL),(117,'thumbnail_The Dream Shift Dress_Brown.jpg','1_The Dream Shift Dress_Brown.jpg','2_The Dream Shift Dress_Brown.jpg','2_The Dream Shift Dress_Brown.jpg',NULL),(118,'thumbnail_The Linen Jumpsuit_Black.jpg','1_The Linen Jumpsuit_Black.jpg','2_The Linen Jumpsuit_Black.jpg','2_The Linen Jumpsuit_Black.jpg',NULL),(119,'thumbnail_The Linen Jumpsuit_Green.jpg','1_The Linen Jumpsuit_Green.jpg','2_The Linen Jumpsuit_Green.jpg','2_The Linen Jumpsuit_Green.jpg',NULL),(120,'thumbnail_The Linen Jumpsuit_Grey.jpg','1_The Linen Jumpsuit_Grey.jpg','2_The Linen Jumpsuit_Grey.jpg','2_The Linen Jumpsuit_Grey.jpg',NULL),(121,'thumbnail_The Linen Workwear Dress_Green.jpg','1_The Linen Workwear Dress_Green.jpg','1_The Linen Workwear Dress_Green.jpg','1_The Linen Workwear Dress_Green.jpg',NULL),(122,'thumbnail_The Organic Cotton Weekend Tee Dress_Black.jpg','1_The Organic Cotton Weekend Tee Dress_Black.jpg','2_The Organic Cotton Weekend Tee Dress_Black.jpg','2_The Organic Cotton Weekend Tee Dress_Black.jpg',NULL),(123,'thumbnail_The Ribbed Tank Dress_Black.jpg','1_The Ribbed Tank Dress_Black.jpg','2_The Ribbed Tank Dress_Black.jpg','2_The Ribbed Tank Dress_Black.jpg',NULL),(124,'thumbnail_The Ribbed Tank Dress_Brown.jpg','1_The Ribbed Tank Dress_Brown.jpg','2_The Ribbed Tank Dress_Brown.jpg','3_The Ribbed Tank Dress_Brown.jpg',NULL),(125,'thumbnail_The Ribbed Tank Dress_White.jpg','1_The Ribbed Tank Dress_White.jpg','2_The Ribbed Tank Dress_White.jpg','2_The Ribbed Tank Dress_White.jpg',NULL),(126,'thumbnail_The Riviera Dress_Black.jpg','1_The Riviera Dress_Black.jpg','2_The Riviera Dress_Black.jpg','2_The Riviera Dress_Black.jpg',NULL),(127,'thumbnail_The Riviera Dress_Blue.jpg','1_The Riviera Dress_Blue.jpg','2_The Riviera Dress_Blue.jpg','3_The Riviera Dress_Blue.jpg',NULL),(128,'thumbnail_The Smock Dress_Black.jpg','1_The Smock Dress_Black.jpg','2_The Smock Dress_Black.jpg','2_The Smock Dress_Black.jpg','s'),(129,'thumbnail_The Air Cami_Black.jpg','1_The Air Cami_Black.jpg','2_The Air Cami_Black.jpg','3_The Air Cami_Black.jpg',NULL),(130,'thumbnail_The Air Cami_Brown.jpg','1_The Air Cami_Brown.jpg','2_The Air Cami_Brown.jpg','3_The Air Cami_Brown.jpg',NULL),(131,'thumbnail_The Air Cami_White.jpg','1_The Air Cami_White.jpg','2_The Air Cami_White.jpg','3_The Air Cami_White.jpg',NULL),(132,'thumbnail_The Air Scoop-Neck Tee_Black.jpg','1_The Air Scoop-Neck Tee_Black.jpg','2_The Air Scoop-Neck Tee_Black.jpg','3_The Air Scoop-Neck Tee_Black.jpg',NULL),(133,'thumbnail_The Air Scoop-Neck Tee_Gray.jpg','1_The Air Scoop-Neck Tee_Gray.jpg','2_The Air Scoop-Neck Tee_Gray.jpg','3_The Air Scoop-Neck Tee_Gray.jpg',NULL),(134,'thumbnail_The Air Scoop-Neck Tee_White.jpg','1_The Air Scoop-Neck Tee_White.jpg','2_The Air Scoop-Neck Tee_White.jpg','3_The Air Scoop-Neck Tee_White.jpg',NULL),(135,'thumbnail_The Boxy Oxford_Blue.jpg','1_The Boxy Oxford_Blue.jpg','2_The Boxy Oxford_Blue.jpg','3_The Boxy Oxford_Blue.jpg',NULL),(136,'thumbnail_The Boxy Oxford_White.jpg','1_The Boxy Oxford_White.jpg','2_The Boxy Oxford_White.jpg','3_The Boxy Oxford_White.jpg',NULL),(137,'thumbnail_The Hemp Scoop-Neck Muscle Tee_Black.jpg','1_The Hemp Scoop-Neck Muscle Tee_Black.jpg','2_The Hemp Scoop-Neck Muscle Tee_Black.jpg','3_The Hemp Scoop-Neck Muscle Tee_Black.jpg',NULL),(138,'thumbnail_The Hemp Scoop-Neck Muscle Tee_Brown.jpg','1_The Hemp Scoop-Neck Muscle Tee_Brown.jpg','2_The Hemp Scoop-Neck Muscle Tee_Brown.jpg','3_The Hemp Scoop-Neck Muscle Tee_Brown.jpg',NULL),(139,'thumbnail_The Hemp Scoop-Neck Muscle Tee_White.jpg','1_The Hemp Scoop-Neck Muscle Tee_White.jpg','2_The Hemp Scoop-Neck Muscle Tee_White.jpg','3_The Hemp Scoop-Neck Muscle Tee_White.jpg',NULL),(140,'thumbnail_The Linen Relaxed Shirt_Black.jpg','1_The Linen Relaxed Shirt_Black.jpg','2_The Linen Relaxed Shirt_Black.jpg','3_The Linen Relaxed Shirt_Black.jpg',NULL),(141,'thumbnail_The Linen Relaxed Shirt_Blue.jpg','1_The Linen Relaxed Shirt_Blue.jpg','2_The Linen Relaxed Shirt_Blue.jpg','3_The Linen Relaxed Shirt_Blue.jpg',NULL),(142,'thumbnail_The Linen Relaxed Shirt_White.jpg','1_The Linen Relaxed Shirt_White.jpg','2_The Linen Relaxed Shirt_White.jpg','3_The Linen Relaxed Shirt_White.jpg',NULL),(143,'thumbnail_The Organic Cotton Slouchy V-Neck_Black.jpg','1_The Organic Cotton Slouchy V-Neck_Black.jpg','2_The Organic Cotton Slouchy V-Neck_Black.jpg','3_The Organic Cotton Slouchy V-Neck_Black.jpg',NULL),(144,'thumbnail_The Organic Cotton Slouchy V-Neck_Gray.jpg','1_The Organic Cotton Slouchy V-Neck_Gray.jpg','2_The Organic Cotton Slouchy V-Neck_Gray.jpg','3_The Organic Cotton Slouchy V-Neck_Gray.jpg',NULL),(145,'thumbnail_The Organic Cotton Slouchy V-Neck_White.jpg','1_The Organic Cotton Slouchy V-Neck_White.jpg','2l_The Organic Cotton Slouchy V-Neck_White.jpg','3_The Organic Cotton Slouchy V-Neck_White.jpg',NULL),(146,'thumbnail_The Pima Micro-Rib Scoop-Neck Tee_Black.jpg','1_The Pima Micro-Rib Scoop-Neck Tee_Black.jpg','2_The Pima Micro-Rib Scoop-Neck Tee_Black.jpg','3_The Pima Micro-Rib Scoop-Neck Tee_Black.jpg',NULL),(147,'thumbnail_The Pima Micro-Rib Scoop-Neck Tee_Gray.jpg','1_The Pima Micro-Rib Scoop-Neck Tee_Gray.jpg','2_The Pima Micro-Rib Scoop-Neck Tee_Gray.jpg','3_The Pima Micro-Rib Scoop-Neck Tee_Gray.jpg',NULL),(148,'thumbnail_The Pima Micro-Rib Scoop-Neck Tee_White.jpg','1_The Pima Micro-Rib Scoop-Neck Tee_White.jpg','2_The Pima Micro-Rib Scoop-Neck Tee_White.jpg','3_The Pima Micro-Rib Scoop-Neck Tee_White.jpg',NULL),(149,'thumbnail_The Baseball Cap_Black.jpg','1_The Baseball Cap_Black.jpg','2_The Baseball Cap_Black.jpg','2_The Baseball Cap_Black.jpg',NULL),(150,'thumbnail_The Day Crossover Sandal_Black.jpg','1_The Day Crossover Sandal_Black.jpg','2_The Day Crossover Sandal_Black.jpg','2_The Day Crossover Sandal_Black.jpg',NULL),(151,'thumbnail_The Glove Mule in ReKnit_Black.jpg','1_The Glove Mule in ReKnit_Black.jpg','2_The Glove Mule in ReKnit_Black.jpg','2_The Glove Mule in ReKnit_Black.jpg',NULL),(152,'thumbnail_The Italian Leather Day Glove_Black.jpg','1_The Italian Leather Day Glove_Black.jpg','2_The Italian Leather Day Glove_Black.jpg','2_The Italian Leather Day Glove_Black.jpg',NULL),(153,'thumbnail_The Italian Leather Day Glove_Blue.jpg','1_The Italian Leather Day Glove_Blue.jpg','2_The Italian Leather Day Glove_Blue.jpg','2_The Italian Leather Day Glove_Blue.jpg',NULL),(154,'thumbnail_The Italian Leather Day Glove_Brown.jpg','1_The Italian Leather Day Glove_Brown.jpg','2_The Italian Leather Day Glove_Brown.jpg','2_The Italian Leather Day Glove_Brown.jpg',NULL),(155,'thumbnail_The Modern Loafer_Black.jpg','1_The Modern Loafer_Black.jpg','2_The Modern Loafer_Black.jpg','3_The Modern Loafer_Black.jpg',NULL),(156,'thumbnail_The Modern Loafer_Brown.jpg','1_The Modern Loafer_Brown.jpg','2_The Modern Loafer_Brown.jpg','2_The Modern Loafer_Brown.jpg',NULL),(157,'thumbnail_The Organic Cotton No-Show Sock 3-Pack_Black.jpg','1_The Organic Cotton No-Show Sock 3-Pack_Black.jpg','2_The Organic Cotton No-Show Sock 3-Pack_Black.jpg','2_The Organic Cotton No-Show Sock 3-Pack_Black.jpg',NULL),(158,'thumbnail_The Organic Cotton No-Show Sock 3-Pack_White.jpg','1_The Organic Cotton No-Show Sock 3-Pack_White.jpg','2_The Organic Cotton No-Show Sock 3-Pack_White.jpg','2_The Organic Cotton No-Show Sock 3-Pack_White.jpg',NULL),(159,'thumbnail_The ReKnit City Flatform Sandal_Black.jpg','1_The ReKnit City Flatform Sandal_Black.jpg','2_The ReKnit City Flatform Sandal_Black.jpg','3_The ReKnit City Flatform Sandal_Black.jpg',NULL),(160,'thumbnail_The ReKnit City Flatform Sandal_Brown.jpg','1_The ReKnit City Flatform Sandal_Brown.jpg','2_The ReKnit City Flatform Sandal_Brown.jpg','2_The ReKnit City Flatform Sandal_Brown.jpg',NULL),(161,'thumbnail_The Renew Transit Catch-All Case_Black.jpg','1_The Renew Transit Catch-All Case_Black.jpg','2_The Renew Transit Catch-All Case_Black.jpg','2_The Renew Transit Catch-All Case_Black.jpg',NULL),(162,'thumbnail_The Renew Transit Catch-All Case_Green.jpg','1_The Renew Transit Catch-All Case_Green.jpg','2_The Renew Transit Catch-All Case_Green.jpg','2_The Renew Transit Catch-All Case_Green.jpg',NULL),(163,'thumbnail_The Renew Transit Catch-All Case_White.jpg','1_The Renew Transit Catch-All Case_White.jpg','2_The Renew Transit Catch-All Case_White.jpg','2_The Renew Transit Catch-All Case_White.jpg',NULL),(164,'thumbnail_The ReNew Transit Sling_Black.jpg','1_The ReNew Transit Sling_Black.jpg','2_The ReNew Transit Sling_Black.jpg','3_The ReNew Transit Sling_Black.jpg',NULL),(165,'thumbnail_The ReNew Transit Sling_Blue.jpg','1_The ReNew Transit Sling_Blue.jpg','2_The ReNew Transit Sling_Blue.jpg','3_The ReNew Transit Sling_Blue.jpg',NULL),(166,'thumbnail_The ReNew Transit Sling_White.jpg','1_The ReNew Transit Sling_White.jpg','2_The ReNew Transit Sling_White.jpg','3_The ReNew Transit Sling_White.jpg',NULL),(167,'thumbnail_The ReNew Transit Weekender_Black.jpg','1_The ReNew Transit Weekender_Black.jpg','2_The ReNew Transit Weekender_Black.jpg','2_The ReNew Transit Weekender_Black.jpg',NULL),(168,'thumbnail_The ReNew Transit Weekender_Blue.jpg','1_The ReNew Transit Weekender_Blue.jpg','2_The ReNew Transit Weekender_Blue.jpg','2_The ReNew Transit Weekender_Blue.jpg',NULL),(169,'thumbnail_The ReNew Transit Weekender_White.jpg','1_The ReNew Transit Weekender_White.jpg','2_The ReNew Transit Weekender_White.jpg','3_The ReNew Transit Weekender_White.jpg',NULL),(170,'uploads/Ảnh chụp màn hình 2025-02-17 224841.png','uploads/Ảnh chụp màn hình 2025-02-17 224841.png','uploads/Ảnh chụp màn hình 2025-02-17 224906.png','uploads/Ảnh chụp màn hình 2025-02-17 224829.png','Variation Images');
/*!40000 ALTER TABLE `product_img` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `PromotionID` int NOT NULL AUTO_INCREMENT,
  `PromotionName` varchar(200) DEFAULT NULL,
  `PromotionDescription` longtext,
  `DiscountRate` double DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `background_color` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PromotionID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,NULL,NULL,100,'2023-07-23','9999-12-31',NULL),(2,'New Summer Markdowns',NULL,60,'2023-07-23','2023-07-25','rgb(122, 117, 112)');
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setting`
--

DROP TABLE IF EXISTS `setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `value` varchar(255) NOT NULL,
  `order` int NOT NULL DEFAULT '0',
  `status` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setting`
--

LOCK TABLES `setting` WRITE;
/*!40000 ALTER TABLE `setting` DISABLE KEYS */;
INSERT INTO `setting` VALUES (1,'System','Enable Debug Mode',1,'Active','2025-01-26 09:06:53','2025-02-14 16:38:56'),(2,'System','Maintenance Mode',2,'Inactive','2025-01-26 09:06:53','2025-01-26 09:06:53'),(3,'User','Maximum Login Attempts = 5',3,'Active','2025-01-26 09:06:53','2025-01-26 09:06:53'),(4,'User','Session Timeout = 30 mins',4,'Active','2025-01-26 09:06:53','2025-01-26 09:06:53'),(5,'Payment','Currency = USD',5,'Inactive','2025-01-26 09:06:53','2025-02-14 16:26:19'),(6,'Payment','Allow Refunds = True',6,'Inactive','2025-01-26 09:06:53','2025-01-26 09:06:53'),(7,'System','Logging Level = DEBUG',7,'Active','2025-02-14 16:40:52','2025-02-14 16:41:32'),(9,'System','API Rate Limit = 100 requests/min',8,'Active','2025-02-14 16:42:16','2025-02-14 16:43:59'),(10,'User','Password Length = 8 characters',9,'Active','2025-02-18 09:40:28','2025-02-18 09:41:14'),(11,'User','Allow Multiple Sessions = False',10,'Active','2025-02-18 09:42:20','2025-02-18 09:42:20'),(12,'Payment','Tax Rate = 10%',11,'Active','2025-02-18 09:43:01','2025-02-18 09:43:01');
/*!40000 ALTER TABLE `setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shop_order`
--

DROP TABLE IF EXISTS `shop_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shop_order` (
  `shop_orderID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `AddressID` int DEFAULT NULL,
  `Order_total` int DEFAULT NULL,
  `Order_status` int NOT NULL,
  `recipient` varchar(200) DEFAULT NULL,
  `recipent_phone` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`shop_orderID`),
  KEY `fk_shoporder_user` (`UserID`),
  KEY `fk_shoporder_address` (`AddressID`),
  KEY `fk_shoporder_status` (`Order_status`),
  CONSTRAINT `fk_shoporder_address` FOREIGN KEY (`AddressID`) REFERENCES `address` (`AddressID`),
  CONSTRAINT `fk_shoporder_status` FOREIGN KEY (`Order_status`) REFERENCES `Order_Status` (`id`),
  CONSTRAINT `fk_shoporder_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shop_order`
--

LOCK TABLES `shop_order` WRITE;
/*!40000 ALTER TABLE `shop_order` DISABLE KEYS */;
INSERT INTO `shop_order` VALUES (20,13,20,35872400,5,'Yamato','034543'),(21,13,21,5033400,5,'Nakata','035543'),(22,13,22,4601400,5,'Han','0459116'),(23,13,23,3963200,5,'Han','035466'),(24,13,24,7276600,5,'Minato','0143416'),(25,13,25,NULL,5,'Minato','0314155'),(26,13,26,21636000,5,'Minato','0344891'),(27,13,27,2736000,5,'Nguyen Van A','999999999'),(28,21,NULL,900000,1,'Bùi Quang Bình','0358258823'),(29,21,NULL,1350000,6,'Bùi Quang Bình','0358258823');
/*!40000 ALTER TABLE `shop_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `size`
--

DROP TABLE IF EXISTS `size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `size` (
  `size_ID` int NOT NULL AUTO_INCREMENT,
  `size_Name` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`size_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `size`
--

LOCK TABLES `size` WRITE;
/*!40000 ALTER TABLE `size` DISABLE KEYS */;
INSERT INTO `size` VALUES (1,'XXS'),(2,'XS'),(3,'S'),(4,'M'),(5,'L'),(6,'XL'),(7,'XXL'),(8,'5'),(9,'6'),(10,'7'),(11,'8');
/*!40000 ALTER TABLE `size` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `story`
--

DROP TABLE IF EXISTS `story`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `story` (
  `story_id` int NOT NULL AUTO_INCREMENT,
  `thumbnail` varchar(200) DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `description` longtext,
  `backlink` text,
  `status` enum('active','inactive') DEFAULT 'active',
  PRIMARY KEY (`story_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `story`
--

LOCK TABLES `story` WRITE;
/*!40000 ALTER TABLE `story` DISABLE KEYS */;
INSERT INTO `story` VALUES (1,'1.jpg','The Fashion Lane Sustainability Team','# At Fashion Lane, we design our timeless staples to be passed down, not tossed out—so you can curate the most beautiful wardrobe with the least impact on the planet.;\n\n!t(https://media.everlane.com/image/upload/c_scale,dpr_3.0,f_auto,q_auto,w_auto/c_limit,w_400/v1/i/d2ac1f92_5286.jpg);\n\nTo achieve this, our Sustainability Team diligently partners with various experts both inside and outside of Fashion Lane HQ to carefully consider every material as well as reduce waste, minimize natural resource use, and remove harmful chemicals and plastics that endanger people and ecosystems.;\n\nWe are big fans of our small, but mighty Sustainability Team, and wanted to take a moment to spotlight them and all their hard work by asking them to share their favorite consciously crafted pieces that they helped bring to life.',NULL,'active'),(2,'2.jpg','Ways To Wear Color: Summer Edition','# At Fashion Lane, we design our timeless staples to be passed down, not tossed out—so you can curate the most beautiful wardrobe with the least impact on the planet.',NULL,'active'),(3,'3.jpg','Styles to Pack for Your Next Getaway','# At Fashion Lane, we design our timeless staples to be passed down, not tossed out—so you can curate the most beautiful wardrobe with the least impact on the planet.',NULL,'active'),(4,'4.jpg','In Conversation With The ACLU','# At Fashion Lane, we design our timeless staples to be passed down, not tossed out—so you can curate the most beautiful wardrobe with the least impact on the planet.',NULL,'active');
/*!40000 ALTER TABLE `story` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(100) DEFAULT NULL,
  `Password` varchar(100) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `FirstName` varchar(100) DEFAULT NULL,
  `LastName` varchar(100) DEFAULT NULL,
  `Dob` date DEFAULT NULL,
  `Sex` tinyint DEFAULT NULL,
  `Role` int DEFAULT NULL,
  `Phone` varchar(100) DEFAULT NULL,
  `IsActive` tinyint DEFAULT '1',
  PRIMARY KEY (`UserID`),
  KEY `fk_user_role` (`Role`),
  CONSTRAINT `fk_user_role` FOREIGN KEY (`Role`) REFERENCES `Role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','202cb962ac59075b964b07152d234b70','admin@gmail.com','Admin','Admin','1997-01-20',1,1,'012345678',1),(2,'sale','567','sale@gmail.com','Sale','Sale','1997-01-20',0,2,'012345678',0),(3,'marketing','789','marketing@gmail.com','Marketing','Marketing ','1997-01-20',1,3,'012345678',1),(4,'cus1','123','cus1@gmail.com','A','A','1997-01-20',1,4,'012345678',0),(5,'cus2','113','cus2@gmail.com','B','B','1997-01-20',0,4,'012345678',0),(6,'cus3','114','cus3@gmail.com','C','C','1997-01-20',0,4,'012345678',1),(7,'cus4','115','cus4@gmail.com','D','D','1997-01-20',1,4,'012345678',1),(8,'cus5 ','116','cus5@gmail.com','E','E','1997-01-20',0,4,'012345678',0),(9,'cus6','117','cus6@gmail.com','F','F','1997-01-20',1,4,'012345678',0),(10,'cus7','118','cus7@gmail.com','G','G','1997-01-20',0,4,'012345678',1),(11,'cus8','119','cus8@gmail.com','H','H','1997-01-20',1,4,'012345678',0),(12,'cus9','110','def@gmail.com',NULL,NULL,'2000-01-23',NULL,4,NULL,1),(13,'cus10','1234','abc@gmail.com','Nguyen','Huong','2003-02-10',1,4,'12312312312',1),(17,'duong','123456','dohoangduong2708@gmail.com','Duong','Do','2004-03-04',1,2,'0705711546',1),(18,'phan','123456','duongdhhe186259@fpt.edu.vn','Phan','Anh','2004-02-05',1,4,'0705715343',1),(19,'anh12345','Duongmon123','anh@gmail.com','Do','Anh','2004-08-27',1,4,'0705711546',1),(20,'leduc','202cb962ac59075b964b07152d234b70','canhkimchi194@gmail.com',NULL,NULL,NULL,1,3,NULL,0),(21,'wangbinhbui1234','202cb962ac59075b964b07152d234b70','BinhBQHE172204@fpt.edu.vn','Bùi','Quang Bình','2013-01-08',1,3,'0358258823',0),(22,'y6ka','123','BinhBQHE172202@fpt.edu.vn','bùi','bình','2015-01-08',1,2,'012312312312',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useraddress`
--

DROP TABLE IF EXISTS `useraddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useraddress` (
  `AddressID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  KEY `fk_useraddress_address` (`AddressID`),
  KEY `fk_useraddress_user` (`UserID`),
  CONSTRAINT `fk_useraddress_address` FOREIGN KEY (`AddressID`) REFERENCES `address` (`AddressID`),
  CONSTRAINT `fk_useraddress_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useraddress`
--

LOCK TABLES `useraddress` WRITE;
/*!40000 ALTER TABLE `useraddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `useraddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userreview`
--

DROP TABLE IF EXISTS `userreview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userreview` (
  `UserReviewID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `rating_value` int DEFAULT NULL,
  `OrderDetailID` int DEFAULT NULL,
  `comment` longtext,
  KEY `fk_userreview_user` (`UserID`),
  KEY `fk_userreview_orderdetail` (`OrderDetailID`),
  CONSTRAINT `fk_userreview_orderdetail` FOREIGN KEY (`OrderDetailID`) REFERENCES `orderdetails` (`OrderDetailID`),
  CONSTRAINT `fk_userreview_user` FOREIGN KEY (`UserID`) REFERENCES `user` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userreview`
--

LOCK TABLES `userreview` WRITE;
/*!40000 ALTER TABLE `userreview` DISABLE KEYS */;
/*!40000 ALTER TABLE `userreview` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `variation`
--

DROP TABLE IF EXISTS `variation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `variation` (
  `VariationID` int NOT NULL AUTO_INCREMENT,
  `ProductID` int DEFAULT NULL,
  `color_ID` int DEFAULT NULL,
  `size_ID` int DEFAULT NULL,
  `qty_in_stock` int DEFAULT NULL,
  `product_img_ID` int DEFAULT NULL,
  PRIMARY KEY (`VariationID`),
  KEY `fk_variation_product` (`ProductID`),
  KEY `fk_variation_color` (`color_ID`),
  KEY `fk_variation_size` (`size_ID`),
  KEY `fk_variation_productimg` (`product_img_ID`),
  CONSTRAINT `fk_variation_color` FOREIGN KEY (`color_ID`) REFERENCES `color` (`color_ID`),
  CONSTRAINT `fk_variation_product` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`),
  CONSTRAINT `fk_variation_productimg` FOREIGN KEY (`product_img_ID`) REFERENCES `product_img` (`product_img_ID`),
  CONSTRAINT `fk_variation_size` FOREIGN KEY (`size_ID`) REFERENCES `size` (`size_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `variation`
--

LOCK TABLES `variation` WRITE;
/*!40000 ALTER TABLE `variation` DISABLE KEYS */;
INSERT INTO `variation` VALUES (11,3,3,1,1000,5),(12,3,3,2,1000,5),(13,3,3,3,998,5),(14,3,3,4,1000,5),(15,3,3,5,1000,5),(16,3,3,6,1000,5),(17,3,3,7,1000,5),(18,3,6,1,1000,6),(19,3,6,2,1000,6),(20,3,6,3,1000,6),(21,3,6,4,1000,6),(22,3,6,5,998,6),(23,3,6,6,1000,6),(24,3,6,7,1000,6),(25,3,1,1,1000,7),(26,3,1,2,998,7),(27,3,1,3,1000,7),(28,3,1,4,1000,7),(29,3,1,5,1000,7),(30,3,1,6,1000,7),(31,3,1,7,1000,7),(46,4,3,1,1000,8),(47,4,3,2,1000,8),(48,4,3,3,999,8),(49,4,3,4,1000,8),(50,4,3,5,999,8),(51,4,3,6,1000,8),(52,4,3,7,1000,8),(53,4,2,1,1000,9),(54,4,2,2,1000,9),(55,4,2,3,1000,9),(56,4,2,4,1000,9),(57,4,2,5,1000,9),(58,4,2,6,1000,9),(59,4,2,7,1000,9),(60,4,6,1,1000,10),(61,4,6,2,1000,10),(62,4,6,3,1000,10),(63,4,6,4,1000,10),(64,4,6,5,1000,10),(65,4,6,6,1000,10),(66,4,6,7,1000,10),(67,4,5,1,1000,11),(68,4,5,2,1000,11),(69,4,5,3,1000,11),(70,4,5,4,999,11),(71,4,5,5,1000,11),(72,4,5,6,1000,11),(73,4,5,7,1000,11),(74,5,3,1,1000,12),(75,5,3,2,1000,12),(76,5,3,3,1000,12),(77,5,3,4,1000,12),(78,5,3,5,1000,12),(79,5,3,6,1000,12),(80,5,3,7,1000,12),(81,5,2,1,1000,13),(82,5,2,2,1000,13),(83,5,2,3,1000,13),(84,5,2,4,1000,13),(85,5,2,5,1000,13),(86,5,2,6,1000,13),(87,5,2,7,1000,13),(88,5,3,1,1000,14),(89,5,3,2,1000,14),(90,5,3,3,1000,14),(91,5,3,4,1000,14),(92,5,3,5,1000,14),(93,5,3,6,1000,14),(94,5,3,7,1000,14),(95,5,1,1,1000,15),(96,5,1,2,1000,15),(97,5,1,3,1000,15),(98,5,1,4,1000,15),(99,5,1,5,1000,15),(100,5,1,6,1000,15),(101,5,1,7,1000,15),(102,6,3,1,1000,16),(103,6,3,2,1000,16),(104,6,3,3,1000,16),(105,6,3,4,1000,16),(106,6,3,5,1000,16),(107,6,3,6,1000,16),(108,6,3,7,1000,16),(116,6,6,1,1000,18),(117,6,6,2,1000,18),(118,6,6,3,1000,18),(119,6,6,4,1000,18),(120,6,6,5,1000,18),(121,6,6,6,1000,18),(122,6,6,7,1000,18),(123,6,1,1,1000,19),(124,6,1,2,1000,19),(125,6,1,3,1000,19),(126,6,1,4,1000,19),(127,6,1,5,1000,19),(128,6,1,6,1000,19),(129,6,1,7,1000,19),(130,7,3,1,1000,20),(131,7,3,2,1000,20),(132,7,3,3,1000,20),(133,7,3,4,1000,20),(134,7,3,5,1000,20),(135,7,3,6,1000,20),(136,7,3,7,1000,20),(137,7,2,1,1000,21),(138,7,2,2,1000,21),(139,7,2,3,1000,21),(140,7,2,4,1000,21),(141,7,2,5,1000,21),(142,7,2,6,1000,21),(143,7,2,7,1000,21),(144,8,9,1,1000,24),(145,8,9,2,1000,24),(146,8,9,3,1000,24),(147,8,9,4,1000,24),(148,8,9,5,1000,24),(149,8,9,6,1000,24),(150,8,9,7,1000,24),(151,8,3,1,1000,22),(152,8,3,2,1000,22),(153,8,3,3,1000,22),(154,8,3,4,1000,22),(155,8,3,5,1000,22),(156,8,3,6,1000,22),(157,8,3,7,1000,22),(158,8,6,1,1000,23),(159,8,6,2,1000,23),(160,8,6,3,1000,23),(161,8,6,4,1000,23),(162,8,6,5,1000,23),(163,8,6,6,1000,23),(164,8,6,7,1000,23),(165,10,2,1,1000,25),(166,10,2,2,1000,25),(167,10,2,3,1000,25),(168,10,2,4,1000,25),(169,10,2,5,1000,25),(170,10,2,6,1000,25),(171,10,2,7,1000,25),(172,10,1,1,1000,27),(173,10,1,2,1000,27),(174,10,1,3,1000,27),(175,10,1,4,1000,27),(176,10,1,5,1000,27),(177,10,1,6,1000,27),(178,10,1,7,1000,27),(179,11,3,1,1000,28),(180,11,3,2,1000,28),(181,11,3,3,1000,28),(182,11,3,4,1000,28),(183,11,3,5,1000,28),(184,11,3,6,1000,28),(185,11,3,7,1000,28),(186,11,5,1,1000,29),(187,11,5,2,1000,29),(188,11,5,3,1000,29),(189,11,5,4,1000,29),(190,11,5,5,1000,29),(191,11,5,6,1000,29),(192,11,5,7,1000,29),(193,11,1,1,1000,31),(194,11,1,2,1000,31),(195,11,1,3,1000,31),(196,11,1,4,1000,31),(197,11,1,5,1000,31),(198,11,1,6,1000,31),(199,11,1,7,1000,31),(207,12,5,1,1000,32),(208,12,5,2,1000,32),(209,12,5,3,1000,32),(210,12,5,4,1000,32),(211,12,5,5,1000,32),(212,12,5,6,1000,32),(213,12,5,7,1000,32),(221,13,2,1,1000,34),(222,13,2,2,1000,34),(223,13,2,3,1000,34),(224,13,2,4,1000,34),(225,13,2,5,1000,34),(226,13,2,6,1000,34),(227,13,2,7,1000,34),(228,13,3,1,1000,34),(229,13,3,2,1000,34),(230,13,3,3,1000,34),(231,13,3,4,1000,34),(232,13,3,5,1000,34),(233,13,3,6,1000,34),(234,13,3,7,1000,34),(235,13,9,1,1000,35),(236,13,9,2,1000,35),(237,13,9,3,1000,35),(238,13,9,4,1000,35),(239,13,9,5,1000,35),(240,13,9,6,1000,35),(241,13,9,7,1000,35),(242,14,3,1,1000,36),(243,14,3,2,1000,36),(244,14,3,3,1000,36),(245,14,3,4,1000,36),(246,14,3,5,1000,36),(247,14,3,6,1000,36),(248,14,3,7,1000,36),(249,14,2,1,1000,37),(250,14,2,2,1000,37),(251,14,2,3,1000,37),(252,14,2,4,1000,37),(253,14,2,5,1000,37),(254,14,2,6,1000,37),(255,14,2,7,1000,37),(256,14,4,1,1000,38),(257,14,4,2,1000,38),(258,14,4,3,1000,38),(259,14,4,4,1000,38),(260,14,4,5,1000,38),(261,14,4,6,1000,38),(262,14,4,7,1000,38),(263,15,3,1,1000,39),(264,15,3,2,1000,39),(265,15,3,3,1000,39),(266,15,3,4,1000,39),(267,15,3,5,1000,39),(268,15,3,6,1000,39),(269,15,3,7,1000,39),(270,15,6,1,1000,40),(271,15,6,2,1000,40),(272,15,6,3,1000,40),(273,15,6,4,1000,40),(274,15,6,5,1000,40),(275,15,6,6,1000,40),(276,15,6,7,1000,40),(277,16,3,1,1000,41),(278,16,3,2,1000,41),(279,16,3,3,1000,41),(280,16,3,4,999,41),(281,16,3,5,1000,41),(282,16,3,6,1000,41),(283,16,3,7,1000,41),(284,16,6,1,1000,42),(285,16,6,2,1000,42),(286,16,6,3,1000,42),(287,16,6,4,1000,42),(288,16,6,5,1000,42),(289,16,6,6,1000,42),(290,16,6,7,1000,42),(291,17,1,1,1000,44),(292,17,1,2,1000,44),(293,17,1,3,1000,44),(294,17,1,4,1000,44),(295,17,1,5,1000,44),(296,17,1,6,1000,44),(297,17,1,7,1000,44),(312,18,3,1,1000,45),(313,18,3,2,1000,45),(314,18,3,3,1000,45),(315,18,3,4,1000,45),(316,18,3,5,1000,45),(317,18,3,6,1000,45),(318,18,3,7,1000,45),(326,19,3,1,1000,47),(327,19,3,2,1000,47),(328,19,3,3,1000,47),(329,19,3,4,1000,47),(330,19,3,5,1000,47),(331,19,3,6,1000,47),(332,19,3,7,1000,47),(333,20,8,1,1000,50),(334,20,8,2,1000,50),(335,20,8,3,1000,50),(336,20,8,4,1000,50),(337,20,8,5,1000,50),(338,20,8,6,1000,50),(339,20,8,7,1000,50),(340,20,3,1,1000,48),(341,20,3,2,1000,48),(342,20,3,3,1000,48),(343,20,3,4,1000,48),(344,20,3,5,1000,48),(345,20,3,6,1000,48),(346,20,3,7,1000,48),(347,20,6,1,1000,49),(348,20,6,2,1000,49),(349,20,6,3,1000,49),(350,20,6,4,1000,49),(351,20,6,5,1000,49),(352,20,6,6,1000,49),(353,20,6,7,1000,49),(354,21,3,1,1000,51),(355,21,3,2,1000,51),(356,21,3,3,1000,51),(357,21,3,4,999,51),(358,21,3,5,1000,51),(359,21,3,6,1000,51),(360,21,3,7,999,51),(361,21,2,1,1000,52),(362,21,2,2,1000,52),(363,21,2,3,996,52),(364,21,2,4,1000,52),(365,21,2,5,1000,52),(366,21,2,6,1000,52),(367,21,2,7,1000,52),(368,21,10,1,1000,53),(369,21,10,2,1000,53),(370,21,10,3,1000,53),(371,21,10,4,1000,53),(372,21,10,5,1000,53),(373,21,10,6,1000,53),(374,21,10,7,1000,53),(375,22,3,1,1000,54),(376,22,3,2,1000,54),(377,22,3,3,1000,54),(378,22,3,4,1000,54),(379,22,3,5,1000,54),(380,22,3,6,1000,54),(381,22,3,7,1000,54),(382,22,2,1,1000,55),(383,22,2,2,1000,55),(384,22,2,3,1000,55),(385,22,2,4,998,55),(386,22,2,5,1000,55),(387,22,2,6,1000,55),(388,22,2,7,1000,55),(389,22,5,1,1000,56),(390,22,5,2,1000,56),(391,22,5,3,1000,56),(392,22,5,4,998,56),(393,22,5,5,1000,56),(394,22,5,6,1000,56),(395,22,5,7,1000,56),(396,23,3,1,1000,57),(397,23,3,2,1000,57),(398,23,3,3,1000,57),(399,23,3,4,1000,57),(400,23,3,5,1000,57),(401,23,3,6,1000,57),(402,23,3,7,1000,57),(403,23,2,1,1000,58),(404,23,2,2,1000,58),(405,23,2,3,1000,58),(406,23,2,4,1000,58),(407,23,2,5,1000,58),(408,23,2,6,1000,58),(409,23,2,7,1000,58),(410,23,5,1,1000,59),(411,23,5,2,1000,59),(412,23,5,3,1000,59),(413,23,5,4,1000,59),(414,23,5,5,1000,59),(415,23,5,6,1000,59),(416,23,5,7,1000,59),(417,24,3,1,1000,60),(418,24,3,2,1000,60),(419,24,3,3,1000,60),(420,24,3,4,1000,60),(421,24,3,5,1000,60),(422,24,3,6,1000,60),(423,24,3,7,1000,60),(424,24,2,1,1000,61),(425,24,2,2,1000,61),(426,24,2,3,1000,61),(427,24,2,4,1000,61),(428,24,2,5,1000,61),(429,24,2,6,1000,61),(430,24,2,7,1000,61),(431,24,5,1,1000,62),(432,24,5,2,1000,62),(433,24,5,3,1000,62),(434,24,5,4,1000,62),(435,24,5,5,1000,62),(436,24,5,6,1000,62),(437,24,5,7,1000,62),(438,25,3,1,1000,63),(439,25,3,2,1000,63),(440,25,3,3,1000,63),(441,25,3,4,1000,63),(442,25,3,5,1000,63),(443,25,3,6,1000,63),(444,25,3,7,1000,63),(445,26,3,1,1000,64),(446,26,3,2,1000,64),(447,26,3,3,1000,64),(448,26,3,4,1000,64),(449,26,3,5,1000,64),(450,26,3,6,1000,64),(451,26,3,7,1000,64),(452,10,6,1,1000,26),(453,10,6,2,1000,26),(454,10,6,3,1000,26),(455,10,6,4,1000,26),(456,10,6,5,1000,26),(457,10,6,6,1000,26),(458,10,6,7,1000,26),(459,26,2,1,1000,65),(460,26,2,2,1000,65),(461,26,2,3,1000,65),(462,26,2,4,1000,65),(463,26,2,5,1000,65),(464,26,2,6,1000,65),(465,26,2,7,1000,65),(466,26,5,1,1000,66),(467,26,5,2,1000,66),(468,26,5,3,1000,66),(469,26,5,4,1000,66),(470,26,5,5,1000,66),(471,26,5,6,1000,66),(472,26,5,7,1000,66),(473,27,3,1,1000,67),(474,27,3,2,1000,67),(475,27,3,3,1000,67),(476,27,3,4,1000,67),(477,27,3,5,1000,67),(478,27,3,6,1000,67),(479,27,3,7,1000,67),(480,27,2,1,1000,68),(481,27,2,2,1000,68),(482,27,2,3,1000,68),(483,27,2,4,1000,68),(484,27,2,5,1000,68),(485,27,2,6,1000,68),(486,27,2,7,1000,68),(487,27,10,1,1000,69),(488,27,10,2,1000,69),(489,27,10,3,1000,69),(490,27,10,4,1000,69),(491,27,10,5,1000,69),(492,27,10,6,1000,69),(493,27,10,7,1000,69),(494,28,2,1,1000,70),(495,28,2,2,1000,70),(496,28,2,3,1000,70),(497,28,2,4,1000,70),(498,28,2,5,1000,70),(499,28,2,6,1000,70),(500,28,2,7,1000,70),(501,28,10,1,1000,71),(502,28,10,2,1000,71),(503,28,10,3,1000,71),(504,28,10,4,1000,71),(505,28,10,5,1000,71),(506,28,10,6,1000,71),(507,28,10,7,1000,71),(508,29,3,1,1000,72),(509,29,3,2,1000,72),(510,29,3,3,1000,72),(511,29,3,4,1000,72),(512,29,3,5,999,72),(513,29,3,6,1000,72),(514,29,3,7,1000,72),(515,29,6,1,1000,73),(516,29,6,2,1000,73),(517,29,6,3,999,73),(518,29,6,4,1000,73),(519,29,6,5,1000,73),(520,29,6,6,1000,73),(521,29,6,7,1000,73),(522,29,1,1,1000,74),(523,29,1,2,998,74),(524,29,1,3,1000,74),(525,29,1,4,1000,74),(526,29,1,5,1000,74),(527,29,1,6,1000,74),(528,29,1,7,1000,74),(529,30,3,1,1000,75),(530,30,3,2,1000,75),(531,30,3,3,1000,75),(532,30,3,4,1000,75),(533,30,3,5,1000,75),(534,30,3,6,1000,75),(535,30,3,7,1000,75),(536,30,4,1,1000,76),(537,30,4,2,1000,76),(538,30,4,3,1000,76),(539,30,4,4,1000,76),(540,30,4,5,1000,76),(541,30,4,6,1000,76),(542,30,4,7,1000,76),(543,30,1,1,1000,77),(544,30,1,2,1000,77),(545,30,1,3,1000,77),(546,30,1,4,1000,77),(547,30,1,5,1000,77),(548,30,1,6,1000,77),(549,30,1,7,1000,77),(571,32,3,1,998,78),(572,32,3,2,1000,78),(573,32,3,3,1000,78),(574,32,3,4,1000,78),(575,32,3,5,1000,78),(576,32,3,6,1000,78),(577,32,3,7,1000,78),(578,32,4,1,1000,79),(579,32,4,2,1000,79),(580,32,4,3,1000,79),(581,32,4,4,998,79),(582,32,4,5,1000,79),(583,32,4,6,1000,79),(584,32,4,7,1000,79),(585,32,1,1,1000,80),(586,32,1,2,998,80),(587,32,1,3,1000,80),(588,32,1,4,1000,80),(589,32,1,5,1000,80),(590,32,1,6,1000,80),(591,32,1,7,1000,80),(592,33,3,1,1000,81),(593,33,3,2,1000,81),(594,33,3,3,1000,81),(595,33,3,4,1000,81),(596,33,3,5,1000,81),(597,33,3,6,1000,81),(598,33,3,7,1000,81),(599,33,4,1,1000,82),(600,33,4,2,1000,82),(601,33,4,3,1000,82),(602,33,4,4,1000,82),(603,33,4,5,1000,82),(604,33,4,6,1000,82),(605,33,4,7,1000,82),(606,33,1,1,1000,83),(607,33,1,2,1000,83),(608,33,1,3,1000,83),(609,33,1,4,1000,83),(610,33,1,5,1000,83),(611,33,1,6,1000,83),(612,33,1,7,1000,83),(613,34,3,1,1000,84),(614,34,3,2,1000,84),(615,34,3,3,1000,84),(616,34,3,4,1000,84),(617,34,3,5,1000,84),(618,34,3,6,1000,84),(619,34,3,7,1000,84),(620,34,4,1,1000,85),(621,34,4,2,1000,85),(622,34,4,3,1000,85),(623,34,4,4,1000,85),(624,34,4,5,1000,85),(625,34,4,6,1000,85),(626,34,4,7,1000,85),(627,34,1,1,1000,86),(628,34,1,2,1000,86),(629,34,1,3,1000,86),(630,34,1,4,1000,86),(631,34,1,5,1000,86),(632,34,1,6,1000,86),(633,34,1,7,1000,86),(634,35,3,1,1000,87),(635,35,3,2,1000,87),(636,35,3,3,1000,87),(637,35,3,4,1000,87),(638,35,3,5,1000,87),(639,35,3,6,1000,87),(640,35,3,7,1000,87),(641,35,4,1,1000,88),(642,35,4,2,1000,88),(643,35,4,3,1000,88),(644,35,4,4,1000,88),(645,35,4,5,1000,88),(646,35,4,6,1000,88),(647,35,4,7,1000,88),(648,35,1,1,1000,89),(649,35,1,2,1000,89),(650,35,1,3,1000,89),(651,35,1,4,1000,89),(652,35,1,5,1000,89),(653,35,1,6,1000,89),(654,35,1,7,1000,89),(656,36,3,1,1000,90),(657,36,3,2,1000,90),(658,36,3,3,1000,90),(659,36,3,4,1000,90),(660,36,3,5,1000,90),(661,36,3,6,1000,90),(662,36,3,7,1000,90),(663,36,4,1,1000,91),(664,36,4,2,1000,91),(665,36,4,3,1000,91),(666,36,4,4,1000,91),(667,36,4,5,1000,91),(668,36,4,6,1000,91),(669,36,4,7,1000,91),(670,36,1,1,1000,92),(671,36,1,2,1000,92),(672,36,1,3,1000,92),(673,36,1,4,1000,92),(674,36,1,5,1000,92),(675,36,1,6,1000,92),(676,36,1,7,1000,92),(677,37,3,1,1000,96),(678,37,3,2,1000,96),(679,37,3,3,1000,96),(680,37,3,4,1000,96),(681,37,3,5,1000,96),(682,37,3,6,1000,96),(683,37,3,7,1000,96),(684,37,4,1,1000,97),(685,37,4,2,1000,97),(686,37,4,3,1000,97),(687,37,4,4,1000,97),(688,37,4,5,1000,97),(689,37,4,6,1000,97),(690,37,4,7,1000,97),(691,37,1,1,1000,98),(692,37,1,2,1000,98),(693,37,1,3,1000,98),(694,37,1,4,1000,98),(695,37,1,5,1000,98),(696,37,1,6,1000,98),(697,37,1,7,1000,98),(698,38,3,1,999,99),(699,38,3,2,1000,99),(700,38,3,3,1000,99),(701,38,3,4,1000,99),(702,38,3,5,1000,99),(703,38,3,6,1000,99),(704,38,3,7,1000,99),(705,38,2,1,1000,100),(706,38,2,2,1000,100),(707,38,2,3,998,100),(708,38,2,4,998,100),(709,38,2,5,1000,100),(710,38,2,6,1000,100),(711,38,2,7,999,100),(712,38,1,1,1000,101),(713,38,1,2,998,101),(714,38,1,3,998,101),(715,38,1,4,999,101),(716,38,1,5,1000,101),(717,38,1,6,1000,101),(718,38,1,7,1000,101),(719,39,3,1,1000,102),(720,39,3,2,1000,102),(721,39,3,3,1000,102),(722,39,3,4,1000,102),(723,39,3,5,1000,102),(724,39,3,6,1000,102),(725,39,3,7,1000,102),(726,39,2,1,1000,103),(727,39,2,2,1000,103),(728,39,2,3,1000,103),(729,39,2,4,1000,103),(730,39,2,5,1000,103),(731,39,2,6,1000,103),(732,39,2,7,1000,103),(733,39,4,1,1000,104),(734,39,4,2,1000,104),(735,39,4,3,1000,104),(736,39,4,4,1000,104),(737,39,4,5,1000,104),(738,39,4,6,1000,104),(739,39,4,7,1000,104),(740,40,1,1,1000,107),(741,40,1,2,1000,107),(742,40,1,3,1000,107),(743,40,1,4,1000,107),(744,40,1,5,1000,107),(745,40,1,6,1000,107),(746,40,1,7,1000,107),(747,40,2,1,1000,105),(748,40,2,2,1000,105),(749,40,2,3,1000,105),(750,40,2,4,1000,105),(751,40,2,5,1000,105),(752,40,2,6,1000,105),(753,40,2,7,1000,105),(754,40,5,1,1000,106),(755,40,5,2,1000,106),(756,40,5,3,1000,106),(757,40,5,4,1000,106),(758,40,5,5,1000,106),(759,40,5,6,1000,106),(760,40,5,7,1000,106),(761,41,2,1,1000,108),(762,41,2,2,1000,108),(763,41,2,3,1000,108),(764,41,2,4,1000,108),(765,41,2,5,1000,108),(766,41,2,6,1000,108),(767,41,2,7,1000,108),(768,42,2,1,1000,109),(769,42,2,2,1000,109),(770,42,2,3,1000,109),(771,42,2,4,1000,109),(772,42,2,5,1000,109),(773,42,2,6,1000,109),(774,42,2,7,1000,109),(775,43,2,1,1000,110),(776,43,2,2,1000,110),(777,43,2,3,1000,110),(778,43,2,4,1000,110),(779,43,2,5,1000,110),(780,43,2,6,1000,110),(781,43,2,7,1000,110),(782,43,4,1,1000,111),(783,43,4,2,1000,111),(784,43,4,3,1000,111),(785,43,4,4,1000,111),(786,43,4,5,1000,111),(787,43,4,6,1000,111),(788,43,4,7,1000,111),(789,44,2,1,1000,112),(790,44,2,2,1000,112),(791,44,2,3,1000,112),(792,44,2,4,1000,112),(793,44,2,5,1000,112),(794,44,2,6,1000,112),(795,44,2,7,1000,112),(796,45,2,1,1000,113),(797,45,2,2,1000,113),(798,45,2,3,1000,113),(799,45,2,4,1000,113),(800,45,2,5,1000,113),(801,45,2,6,1000,113),(802,45,2,7,1000,113),(803,46,3,1,997,114),(804,46,3,2,1000,114),(805,46,3,3,1000,114),(806,46,3,4,1000,114),(807,46,3,5,1000,114),(808,46,3,6,1000,114),(809,46,3,7,999,114),(810,46,1,1,1000,115),(811,46,1,2,1000,115),(812,46,1,3,998,115),(813,46,1,4,1000,115),(814,46,1,5,1000,115),(815,46,1,6,1000,115),(816,46,1,7,998,115),(817,47,3,1,1000,116),(818,47,3,2,1000,116),(819,47,3,3,1000,116),(820,47,3,4,1000,116),(821,47,3,5,1000,116),(822,47,3,6,1000,116),(823,47,3,7,1000,116),(824,47,6,1,1000,117),(825,47,6,2,1000,117),(826,47,6,3,1000,117),(827,47,6,4,999,117),(828,47,6,5,1000,117),(829,47,6,6,1000,117),(830,47,6,7,1000,117),(831,48,3,1,1000,118),(832,48,3,2,1000,118),(833,48,3,3,1000,118),(834,48,3,4,1000,118),(835,48,3,5,1000,118),(836,48,3,6,1000,118),(837,48,3,7,1000,118),(838,48,5,1,1000,119),(839,48,5,2,1000,119),(840,48,5,3,1000,119),(841,48,5,4,1000,119),(842,48,5,5,1000,119),(843,48,5,6,1000,119),(844,48,5,7,1000,119),(845,48,4,1,1000,120),(846,48,4,2,1000,120),(847,48,4,3,1000,120),(848,48,4,4,1000,120),(849,48,4,5,1000,120),(850,48,4,6,1000,120),(851,48,4,7,1000,120),(852,49,5,1,1000,121),(853,49,5,2,1000,121),(854,49,5,3,1000,121),(855,49,5,4,1000,121),(856,49,5,5,1000,121),(857,49,5,6,1000,121),(858,49,5,7,1000,121),(859,50,3,1,1000,122),(860,50,3,2,1000,122),(861,50,3,3,1000,122),(862,50,3,4,1000,122),(863,50,3,5,1000,122),(864,50,3,6,1000,122),(865,50,3,7,1000,122),(866,51,1,1,1000,125),(867,51,1,2,1000,125),(868,51,1,3,1000,125),(869,51,1,4,1000,125),(870,51,1,5,1000,125),(871,51,1,6,1000,125),(872,51,1,7,1000,125),(873,51,6,1,1000,124),(874,51,6,2,1000,124),(875,51,6,3,1000,124),(876,51,6,4,1000,124),(877,51,6,5,1000,124),(878,51,6,6,1000,124),(879,51,6,7,1000,124),(880,51,3,1,1000,123),(881,51,3,2,1000,123),(882,51,3,3,1000,123),(883,51,3,4,1000,123),(884,51,3,5,1000,123),(885,51,3,6,1000,123),(886,51,3,7,1000,123),(887,52,3,1,1000,126),(888,52,3,2,1000,126),(889,52,3,3,1000,126),(890,52,3,4,1000,126),(891,52,3,5,1000,126),(892,52,3,6,1000,126),(893,52,3,7,1000,126),(894,52,2,1,1000,127),(895,52,2,2,1000,127),(896,52,2,3,1000,127),(897,52,2,4,1000,127),(898,52,2,5,1000,127),(899,52,2,6,1000,127),(900,52,2,7,1000,127),(908,53,3,1,1000,128),(909,53,3,2,1000,128),(910,53,3,3,1000,128),(911,53,3,4,1000,128),(912,53,3,5,1000,128),(913,53,3,6,1000,128),(914,53,3,7,1000,128),(915,54,3,1,1000,129),(916,54,3,2,1000,129),(917,54,3,3,1000,129),(918,54,3,4,1000,129),(919,54,3,5,1000,129),(920,54,3,6,1000,129),(921,54,3,7,1000,129),(922,54,6,1,1000,130),(923,54,6,2,1000,130),(924,54,6,3,1000,130),(925,54,6,4,998,130),(926,54,6,5,1000,130),(927,54,6,6,1000,130),(928,54,6,7,1000,130),(929,54,1,1,1000,131),(930,54,1,2,997,131),(931,54,1,3,1000,131),(932,54,1,4,1000,131),(933,54,1,5,1000,131),(934,54,1,6,1000,131),(935,54,1,7,1000,131),(936,55,3,1,1000,132),(937,55,3,2,1000,132),(938,55,3,3,1000,132),(939,55,3,4,1000,132),(940,55,3,5,1000,132),(941,55,3,6,1000,132),(942,55,3,7,1000,132),(943,55,4,1,1000,133),(944,55,4,2,1000,133),(945,55,4,3,1000,133),(946,55,4,4,1000,133),(947,55,4,5,1000,133),(948,55,4,6,1000,133),(949,55,4,7,1000,133),(950,55,1,1,1000,134),(951,55,1,2,1000,134),(952,55,1,3,1000,134),(953,55,1,4,1000,134),(954,55,1,5,1000,134),(955,55,1,6,1000,134),(956,55,1,7,1000,134),(957,56,2,1,1000,135),(958,56,2,2,999,135),(959,56,2,3,1000,135),(960,56,2,4,999,135),(961,56,2,5,1000,135),(962,56,2,6,1000,135),(963,56,2,7,1000,135),(964,56,1,1,1000,136),(965,56,1,2,1000,136),(966,56,1,3,1000,136),(967,56,1,4,1000,136),(968,56,1,5,1000,136),(969,56,1,6,1000,136),(970,56,1,7,1000,136),(971,57,3,1,1000,137),(972,57,3,2,1000,137),(973,57,3,3,1000,137),(974,57,3,4,1000,137),(975,57,3,5,1000,137),(976,57,3,6,1000,137),(977,57,3,7,1000,137),(978,57,6,1,1000,138),(979,57,6,2,1000,138),(980,57,6,3,1000,138),(981,57,6,4,1000,138),(982,57,6,5,1000,138),(983,57,6,6,1000,138),(984,57,6,7,1000,138),(985,57,1,1,1000,139),(986,57,1,2,1000,139),(987,57,1,3,1000,139),(988,57,1,4,1000,139),(989,57,1,5,1000,139),(990,57,1,6,1000,139),(991,57,1,7,1000,139),(992,58,3,1,1000,140),(993,58,3,2,1000,140),(994,58,3,3,1000,140),(995,58,3,4,1000,140),(996,58,3,5,1000,140),(997,58,3,6,1000,140),(998,58,3,7,1000,140),(999,58,2,1,1000,141),(1000,58,2,2,1000,141),(1001,58,2,3,1000,141),(1002,58,2,4,1000,141),(1003,58,2,5,1000,141),(1004,58,2,6,1000,141),(1005,58,2,7,1000,141),(1006,58,1,1,1000,142),(1007,58,1,2,1000,142),(1008,58,1,3,1000,142),(1009,58,1,4,999,142),(1010,58,1,5,1000,142),(1011,58,1,6,1000,142),(1012,58,1,7,1000,142),(1013,59,3,1,1000,143),(1014,59,3,2,1000,143),(1015,59,3,3,1000,143),(1016,59,3,4,1000,143),(1017,59,3,5,1000,143),(1018,59,3,6,1000,143),(1019,59,3,7,1000,143),(1020,59,4,1,1000,144),(1021,59,4,2,1000,144),(1022,59,4,3,1000,144),(1023,59,4,4,1000,144),(1024,59,4,5,1000,144),(1025,59,4,6,1000,144),(1026,59,4,7,1000,144),(1027,59,1,1,1000,145),(1028,59,1,2,1000,145),(1029,59,1,3,1000,145),(1030,59,1,4,1000,145),(1031,59,1,5,1000,145),(1032,59,1,6,1000,145),(1033,59,1,7,1000,145),(1034,60,1,1,1000,148),(1035,60,1,2,1000,148),(1036,60,1,3,1000,148),(1037,60,1,4,999,148),(1038,60,1,5,1000,148),(1039,60,1,6,1000,148),(1040,60,1,7,1000,148),(1041,60,3,1,1000,146),(1042,60,3,2,1000,146),(1043,60,3,3,1000,146),(1044,60,3,4,1000,146),(1045,60,3,5,1000,146),(1046,60,3,6,1000,146),(1047,60,3,7,1000,146),(1048,60,4,1,1000,147),(1049,60,4,2,1000,147),(1050,60,4,3,1000,147),(1051,60,4,4,1000,147),(1052,60,4,5,1000,147),(1053,60,4,6,1000,147),(1054,60,4,7,1000,147),(1055,61,3,4,994,149),(1056,62,3,8,1000,150),(1057,62,3,9,1000,150),(1058,62,3,10,998,150),(1059,62,3,11,1000,150),(1060,63,3,8,1000,151),(1061,63,3,9,999,151),(1062,63,3,10,1000,151),(1063,63,3,11,999,151),(1064,64,3,8,1000,152),(1065,64,3,9,1000,152),(1066,64,3,10,1000,152),(1067,64,3,11,1000,152),(1068,64,2,8,1000,153),(1069,64,2,9,999,153),(1070,64,2,10,1000,153),(1071,64,2,11,1000,153),(1072,64,6,8,1000,154),(1073,64,6,9,1000,154),(1074,64,6,10,1000,154),(1075,64,6,11,1000,154),(1076,65,3,8,1000,155),(1077,65,3,9,1000,155),(1078,65,3,10,1000,155),(1079,65,3,11,1000,155),(1080,65,6,8,1000,156),(1081,65,6,9,1000,156),(1082,65,6,10,1000,156),(1083,65,6,11,1000,156),(1084,66,3,3,1000,157),(1085,66,3,4,1000,157),(1086,66,3,5,1000,157),(1087,66,1,3,1000,158),(1088,66,1,4,1000,158),(1089,66,1,5,1000,158),(1090,67,3,8,1000,159),(1091,67,3,9,1000,159),(1092,67,3,10,1000,159),(1093,67,3,11,1000,159),(1094,67,6,8,1000,160),(1095,67,6,9,1000,160),(1096,67,6,10,1000,160),(1097,67,6,11,1000,160),(1098,68,3,4,1000,161),(1099,68,5,4,1000,162),(1100,68,1,4,1000,163),(1101,69,3,4,1000,164),(1102,69,2,4,1000,165),(1103,69,1,4,1000,166),(1104,70,3,4,1000,167),(1105,70,2,4,1000,168),(1106,70,1,4,1000,169),(1107,71,3,1,1000,93),(1108,71,3,2,1000,93),(1109,71,3,3,1000,93),(1110,71,3,4,1000,93),(1111,71,3,5,1000,93),(1112,71,3,6,1000,93),(1113,71,3,7,1000,93),(1114,71,4,1,1000,94),(1115,71,4,2,1000,94),(1116,71,4,3,1000,94),(1117,71,4,4,1000,94),(1118,71,4,5,1000,94),(1119,71,4,6,1000,94),(1120,71,4,7,1000,94),(1121,71,1,1,1000,95),(1122,71,1,2,1000,95),(1123,71,1,3,1000,95),(1124,71,1,4,1000,95),(1125,71,1,5,1000,95),(1126,71,1,6,1000,95),(1127,71,1,7,1000,95),(1128,72,1,1,1000,170);
/*!40000 ALTER TABLE `variation` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-21  1:37:21
