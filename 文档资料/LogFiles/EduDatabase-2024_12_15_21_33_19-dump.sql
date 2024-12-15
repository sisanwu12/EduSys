-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: school
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `CLID` int NOT NULL COMMENT '班级唯一标识',
  `Name` varchar(100) NOT NULL COMMENT '班级名称',
  `SNUM` int DEFAULT NULL COMMENT '班级学生数',
  `CHeadID` int DEFAULT NULL COMMENT '班长',
  `DID` int NOT NULL COMMENT '所属学科系',
  PRIMARY KEY (`CLID`),
  KEY `DID` (`DID`),
  KEY `CHeadID` (`CHeadID`),
  CONSTRAINT `class_ibfk_1` FOREIGN KEY (`DID`) REFERENCES `department` (`DID`),
  CONSTRAINT `class_ibfk_2` FOREIGN KEY (`CHeadID`) REFERENCES `student` (`SID`),
  CONSTRAINT `chk_snum` CHECK ((`SNUM` between 0 and 60))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='班级表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `CID` int NOT NULL COMMENT '课程唯一标识',
  `TID` int NOT NULL COMMENT '教师',
  `Name` varchar(100) NOT NULL COMMENT '课程名称',
  `Type` varchar(4) NOT NULL COMMENT '课程类型',
  `Credits` decimal(3,1) NOT NULL COMMENT '学分',
  `DID` int NOT NULL COMMENT '所属学科系',
  PRIMARY KEY (`CID`),
  KEY `TID` (`TID`),
  KEY `DID` (`DID`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`TID`) REFERENCES `teacher` (`TID`),
  CONSTRAINT `course_ibfk_2` FOREIGN KEY (`DID`) REFERENCES `department` (`DID`),
  CONSTRAINT `chk_cre` CHECK ((`Credits` between 0 and 100)),
  CONSTRAINT `chk_ctype` CHECK ((`Type` = ((0 <> _utf8mb4'必修') or (0 <> _utf8mb4'选修'))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='课程表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `DID` int NOT NULL COMMENT '学科系标识',
  `Name` varchar(100) NOT NULL COMMENT '学科系名称',
  `DHeadID` int DEFAULT NULL COMMENT '学科系主任',
  PRIMARY KEY (`DID`),
  KEY `DHeadID` (`DHeadID`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`DHeadID`) REFERENCES `teacher` (`TID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学科系表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment`
--

DROP TABLE IF EXISTS `enrollment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment` (
  `EID` int NOT NULL COMMENT '选课记录标识',
  `SID` int NOT NULL COMMENT '学生标识',
  `CID` int NOT NULL COMMENT '课程标识',
  `Grade` decimal(5,2) DEFAULT NULL COMMENT '成绩',
  PRIMARY KEY (`EID`),
  UNIQUE KEY `chk_sc` (`SID`,`CID`),
  KEY `CID` (`CID`),
  CONSTRAINT `enrollment_ibfk_1` FOREIGN KEY (`SID`) REFERENCES `student` (`SID`),
  CONSTRAINT `enrollment_ibfk_2` FOREIGN KEY (`CID`) REFERENCES `course` (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='选课表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment`
--

LOCK TABLES `enrollment` WRITE;
/*!40000 ALTER TABLE `enrollment` DISABLE KEYS */;
/*!40000 ALTER TABLE `enrollment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `RID` int NOT NULL COMMENT '教室唯一标识',
  `Location` varchar(200) NOT NULL COMMENT '教室位置',
  `Capacity` int NOT NULL COMMENT '容量',
  `Type` varchar(4) NOT NULL COMMENT '教室类型',
  `State` char(1) NOT NULL DEFAULT 'T' COMMENT '教室状态',
  PRIMARY KEY (`RID`),
  CONSTRAINT `chk_cap` CHECK ((`Capacity` between 0 and 100000)),
  CONSTRAINT `chk_rtype` CHECK ((`Type` in (_utf8mb4'普通',_utf8mb4'体育',_utf8mb4'电脑',_utf8mb4'物理',((0 <> _utf8mb4'化学') or (0 <> _utf8mb4'天文'))))),
  CONSTRAINT `chk_state` CHECK ((`State` = ((0 <> _utf8mb4'T') or (0 <> _utf8mb4'F'))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教室表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule` (
  `SCID` int NOT NULL COMMENT '排课唯一标识',
  `CID` int NOT NULL COMMENT '对应课程',
  `RID` int NOT NULL COMMENT '授课教室',
  `SNUM` int DEFAULT NULL COMMENT '学生人数',
  `Time` datetime NOT NULL COMMENT '时间段',
  PRIMARY KEY (`SCID`),
  UNIQUE KEY `chk_rt` (`RID`,`Time`),
  KEY `CID` (`CID`),
  CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`CID`) REFERENCES `course` (`CID`),
  CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`RID`) REFERENCES `room` (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='排课表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule`
--

LOCK TABLES `schedule` WRITE;
/*!40000 ALTER TABLE `schedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `schedule` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `chk_snum` BEFORE INSERT ON `schedule` FOR EACH ROW BEGIN
        DECLARE Num INT;
        select room.Capacity INTO Num
        FROM room
        where room.RID = NEW.RID;
        IF NEW.SNUM > Num THEN
            SIGNAL SQLSTATE '45000' /*用于抛出自定义错误，45000 是通用错误代码。*/
            SET MESSAGE_TEXT = '超出教室容量！';
        end IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `SID` int NOT NULL COMMENT '学生唯一标识',
  `Name` varchar(10) NOT NULL COMMENT '学生姓名',
  `Sex` char(2) NOT NULL COMMENT '性别',
  `Age` int DEFAULT NULL COMMENT '年龄',
  `CLID` int DEFAULT NULL COMMENT '所在班级',
  `DID` int NOT NULL COMMENT '所属学科系',
  PRIMARY KEY (`SID`),
  KEY `CLID` (`CLID`),
  KEY `DID` (`DID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`SID`) REFERENCES `user` (`ID`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`CLID`) REFERENCES `class` (`CLID`),
  CONSTRAINT `student_ibfk_3` FOREIGN KEY (`DID`) REFERENCES `department` (`DID`),
  CONSTRAINT `chk_sage` CHECK ((`Age` between 10 and 80)),
  CONSTRAINT `chk_ssex` CHECK ((`Sex` = ((0 <> _utf8mb4'男') or (0 <> _utf8mb4'女'))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='学生表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `TID` int NOT NULL COMMENT '老师唯一标识',
  `Name` varchar(10) NOT NULL COMMENT '老师姓名',
  `Sex` char(2) NOT NULL COMMENT '性别',
  `Age` int DEFAULT NULL COMMENT '年龄',
  `DID` int NOT NULL COMMENT '所属学科系',
  PRIMARY KEY (`TID`),
  KEY `DID` (`DID`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`TID`) REFERENCES `user` (`ID`),
  CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`DID`) REFERENCES `department` (`DID`),
  CONSTRAINT `chk_tage` CHECK ((`Age` between 18 and 90)),
  CONSTRAINT `chk_tsex` CHECK ((`Sex` = ((0 <> _utf8mb4'男') or (0 <> _utf8mb4'女'))))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='教师表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `UID` int NOT NULL COMMENT '用户唯一标识',
  `UName` varchar(50) NOT NULL COMMENT '用户名',
  `Password` varchar(255) NOT NULL COMMENT '密码',
  `Role` char(1) NOT NULL COMMENT '用户角色',
  `ID` int NOT NULL COMMENT '对应角色标识',
  PRIMARY KEY (`UID`),
  UNIQUE KEY `UName` (`UName`),
  UNIQUE KEY `ID` (`ID`),
  CONSTRAINT `chk_role` CHECK ((`Role` in (_utf8mb4'S',_utf8mb4'T',_utf8mb4'A')))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-15 21:33:19
