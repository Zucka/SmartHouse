-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 21, 2013 at 02:07 PM
-- Server version: 5.5.33
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `smartparentalcontrol`
--
CREATE DATABASE IF NOT EXISTS `smartparentalcontrol` DEFAULT CHARACTER SET utf8;
USE `smartparentalcontrol`;

-- --------------------------------------------------------

--
-- Table structure for table `action`
--

CREATE TABLE `action` (
  `AId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `RId` bigint(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `points` double DEFAULT NULL,
  `controllerId` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`AId`),
  UNIQUE KEY `AId` (`AId`),
  KEY `controllerId` (`controllerId`),
  KEY `RId` (`RId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `chores`
--

CREATE TABLE `chores` (
  `CId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CSId` bigint(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `defaultPoints` double unsigned DEFAULT '0',
  PRIMARY KEY (`CId`),
  UNIQUE KEY `CId` (`CId`),
  KEY `CSId` (`CSId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `chores`
--

INSERT INTO `chores` (`CId`, `CSId`, `name`, `description`, `defaultPoints`) VALUES
(1, 1, 'dishwashing', NULL, 3),
(2, 1, 'vacuum room', 'the living room', 7),
(3, 1, 'garbage', NULL, 6),
(4, 1, 'clean own room', 'dust, vacuum,windows', 3);

-- --------------------------------------------------------

--
-- Table structure for table `cond_timeperiod`
--

CREATE TABLE `cond_timeperiod` (
  `condTimepId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `condId` bigint(20) unsigned DEFAULT NULL,
  `timeFrom` datetime NOT NULL,
  `timeTo` datetime NOT NULL,
  `weekdays` set('monday','tuesday','wednesday','thursday','friday','saturday','sunday') DEFAULT NULL,
  `weekly` tinyint(1) DEFAULT '0',
  `ndWeekly` tinyint(1) DEFAULT '0',
  `rdWeekly` tinyint(1) DEFAULT '0',
  `firstInMonth` tinyint(1) DEFAULT '0',
  `lastInMonth` tinyint(1) DEFAULT '0',
  `weekNumber` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`condTimepId`),
  UNIQUE KEY `condTimepId` (`condTimepId`),
  KEY `condId` (`condId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cond_timestamp`
--

CREATE TABLE `cond_timestamp` (
  `condTimesId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `condId` bigint(20) unsigned NOT NULL,
  `onTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`condTimesId`),
  UNIQUE KEY `condTimesId` (`condTimesId`),
  KEY `condId` (`condId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `controller`
--

CREATE TABLE `controller` (
  `CSerieNo` bigint(20) unsigned NOT NULL,
  `CSId` bigint(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `location` varchar(30) DEFAULT NULL,
  `status` enum('!','GREEN','RED') DEFAULT '!',
  PRIMARY KEY (`CSerieNo`),
  UNIQUE KEY `CSerieNo` (`CSerieNo`),
  KEY `CSId` (`CSId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `controller`
--

INSERT INTO `controller` (`CSerieNo`, `CSId`, `name`, `location`, `status`) VALUES
(123, 1, 'TV', 'livingroom', '!'),
(124, 1, 'playstation', NULL, '!');

-- --------------------------------------------------------

--
-- Table structure for table `controller_used_by_tag`
--

CREATE TABLE `controller_used_by_tag` (
  `TSerieNo` bigint(20) unsigned NOT NULL,
  `CSerieNo` bigint(20) unsigned NOT NULL,
  `starttime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `endtime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`TSerieNo`,`CSerieNo`,`starttime`),
  KEY `CSerieNo` (`CSerieNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `control_system`
--

CREATE TABLE `control_system` (
  `CSId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `street` varchar(50) DEFAULT NULL,
  `postcode` varchar(30) DEFAULT NULL,
  `phoneNo` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`CSId`),
  UNIQUE KEY `CSId` (`CSId`),
  UNIQUE KEY `username` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `control_system`
--

INSERT INTO `control_system` (`CSId`, `name`, `street`, `postcode`, `phoneNo`) VALUES
(1, 'sys1', NULL, NULL, NULL),
(2, 'sys2', 'bakerstreet', '9000', '12345678');

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `PId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CSId` bigint(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `points` double DEFAULT '0',
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `role` enum('user','manager') NOT NULL DEFAULT 'user',
  PRIMARY KEY (`PId`),
  UNIQUE KEY `PId` (`PId`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  KEY `CSId` (`CSId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`PId`, `CSId`, `name`, `points`, `username`, `password`, `email`, `phone`, `role`) VALUES
(1, 1, 'Johan Sørensen', 0, 'johans', '$2a$10$i7eknel51kJMbofxMeagce5AxId6GNgiQej55stomKshOdxHWe22W', 'johan.soerensen6@gmail.com', '26136946', 'manager'),
(2, 1, 'Allan Hansen', 0, 'allan', '$2a$10$nW4o5dFai5wuv0uRKgWdoehYWyU/UPBCnidg5rPxrdef4HKfejgEy', 'allan@smartparentalcontrol.com', '12345678', 'user'),
(3, 1, 'Hermann Hansen', 0, 'hermann', '$2a$10$osOBcuybeXxjzhJVrjkpjuqbNpc4jDQUXWZkk0rr8LgUSuqlaDKeG', 'hermann@smartparentalcontrol.com', '87654321', 'manager');


-- --------------------------------------------------------

--
-- Table structure for table `profile_did_chores`
--

CREATE TABLE `profile_did_chores` (
  `PId` bigint(20) unsigned NOT NULL,
  `CId` bigint(20) unsigned NOT NULL,
  `actualPoints` double DEFAULT NULL,
  `timeOfCreation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PId`,`CId`,`timeOfCreation`),
  KEY `CId` (`CId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `profile_has_rules`
--

CREATE TABLE `profile_has_rules` (
  `PId` bigint(20) unsigned NOT NULL,
  `RId` bigint(20) unsigned NOT NULL,
  `validFromTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`PId`,`RId`),
  KEY `RId` (`RId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `rcondition`
--

CREATE TABLE `rcondition` (
  `condId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `RId` bigint(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `controllerId` bigint(20) unsigned,
  PRIMARY KEY (`condId`),
  UNIQUE KEY `condId` (`condId`),
  KEY `controllerId` (`controllerId`),
  KEY `RId` (`RId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rules`
--

CREATE TABLE `rules` (
  `RId` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CSId` bigint(20) unsigned NOT NULL,
  `name` varchar(30) NOT NULL,
  `isPermission` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`RId`),
  UNIQUE KEY `RId` (`RId`),
  KEY `CSId` (`CSId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `TSerieNo` bigint(20) unsigned NOT NULL,
  `CSId` bigint(20) unsigned NOT NULL,
  `profileId` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`TSerieNo`),
  UNIQUE KEY `TSerieNo` (`TSerieNo`),
  KEY `CSId` (`CSId`),
  KEY `profileId` (`profileId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`TSerieNo`, `CSId`, `profileId`, `name`, `active`) VALUES
(234, 1, 1, 'ring', 1),
(235, 1, 2, NULL, 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action`
--
ALTER TABLE `action`
  ADD CONSTRAINT `action_ibfk_1` FOREIGN KEY (`controllerId`) REFERENCES `controller` (`CSerieNo`),
  ADD CONSTRAINT `action_ibfk_2` FOREIGN KEY (`RId`) REFERENCES `rules` (`RId`);

--
-- Constraints for table `chores`
--
ALTER TABLE `chores`
  ADD CONSTRAINT `chores_ibfk_1` FOREIGN KEY (`CSId`) REFERENCES `control_system` (`CSId`);

--
-- Constraints for table `cond_timeperiod`
--
ALTER TABLE `cond_timeperiod`
  ADD CONSTRAINT `cond_timeperiod_ibfk_1` FOREIGN KEY (`condId`) REFERENCES `rcondition` (`condId`);

--
-- Constraints for table `cond_timestamp`
--
ALTER TABLE `cond_timestamp`
  ADD CONSTRAINT `cond_timestamp_ibfk_1` FOREIGN KEY (`condId`) REFERENCES `rcondition` (`condId`);

--
-- Constraints for table `controller`
--
ALTER TABLE `controller`
  ADD CONSTRAINT `controller_ibfk_1` FOREIGN KEY (`CSId`) REFERENCES `control_system` (`CSId`);

--
-- Constraints for table `controller_used_by_tag`
--
ALTER TABLE `controller_used_by_tag`
  ADD CONSTRAINT `controller_used_by_tag_ibfk_1` FOREIGN KEY (`TSerieNo`) REFERENCES `tag` (`TSerieNo`),
  ADD CONSTRAINT `controller_used_by_tag_ibfk_2` FOREIGN KEY (`CSerieNo`) REFERENCES `controller` (`CSerieNo`);

--
-- Constraints for table `profile`
--
ALTER TABLE `profile`
  ADD CONSTRAINT `profile_ibfk_1` FOREIGN KEY (`CSId`) REFERENCES `control_system` (`CSId`);

--
-- Constraints for table `profile_did_chores`
--
ALTER TABLE `profile_did_chores`
  ADD CONSTRAINT `profile_did_chores_ibfk_2` FOREIGN KEY (`CId`) REFERENCES `chores` (`CId`),
  ADD CONSTRAINT `profile_did_chores_ibfk_1` FOREIGN KEY (`PId`) REFERENCES `profile` (`PId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `profile_has_rules`
--
ALTER TABLE `profile_has_rules`
  ADD CONSTRAINT `profile_has_rules_ibfk_2` FOREIGN KEY (`RId`) REFERENCES `rules` (`RId`),
  ADD CONSTRAINT `profile_has_rules_ibfk_1` FOREIGN KEY (`PId`) REFERENCES `profile` (`PId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rcondition`
--
ALTER TABLE `rcondition`
  ADD CONSTRAINT `rcondition_ibfk_1` FOREIGN KEY (`controllerId`) REFERENCES `controller` (`CSerieNo`),
  ADD CONSTRAINT `rcondition_ibfk_2` FOREIGN KEY (`RId`) REFERENCES `rules` (`RId`);

--
-- Constraints for table `rules`
--
ALTER TABLE `rules`
  ADD CONSTRAINT `rules_ibfk_1` FOREIGN KEY (`CSId`) REFERENCES `control_system` (`CSId`);

--
-- Constraints for table `tag`
--
ALTER TABLE `tag`
  ADD CONSTRAINT `tag_ibfk_1` FOREIGN KEY (`CSId`) REFERENCES `control_system` (`CSId`),
  ADD CONSTRAINT `tag_ibfk_2` FOREIGN KEY (`profileId`) REFERENCES `profile` (`PId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
