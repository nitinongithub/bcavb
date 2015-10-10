-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Oct 10, 2015 at 07:16 AM
-- Server version: 5.6.11
-- PHP Version: 5.5.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `kdmm`
--
CREATE DATABASE IF NOT EXISTS `kdmm` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `kdmm`;

-- --------------------------------------------------------

--
-- Table structure for table `assign_question`
--

CREATE TABLE IF NOT EXISTS `assign_question` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `TID` int(11) NOT NULL,
  `QID` int(11) NOT NULL,
  `RID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `TID` (`TID`,`QID`,`RID`),
  KEY `QID` (`QID`),
  KEY `RID` (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `game_status`
--

CREATE TABLE IF NOT EXISTS `game_status` (
  `STID` int(11) NOT NULL,
  `STATUS` char(10) NOT NULL,
  PRIMARY KEY (`STID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `question_status`
--

CREATE TABLE IF NOT EXISTS `question_status` (
  `QSTID` int(11) NOT NULL,
  `STATUS` char(10) NOT NULL,
  PRIMARY KEY (`QSTID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `q_a`
--

CREATE TABLE IF NOT EXISTS `q_a` (
  `QID` int(11) NOT NULL AUTO_INCREMENT,
  `QUESTION` text NOT NULL,
  `A` text NOT NULL,
  `B` text NOT NULL,
  `C` text NOT NULL,
  `D` text NOT NULL,
  `ANSWER` char(1) NOT NULL,
  `FSFQ` int(11) NOT NULL,
  `FSFA` int(11) NOT NULL,
  `QSTID` int(11) NOT NULL COMMENT 'Question Status (Main or BackUp)',
  `STID` int(11) NOT NULL COMMENT 'Game Status (WordPOwer or Quiz)',
  `SESSID` int(11) NOT NULL,
  PRIMARY KEY (`QID`),
  KEY `QSTID` (`QSTID`),
  KEY `STID` (`STID`),
  KEY `SESSID` (`SESSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `rounds`
--

CREATE TABLE IF NOT EXISTS `rounds` (
  `RID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME_` varchar(30) NOT NULL,
  `STATUS` int(11) NOT NULL,
  PRIMARY KEY (`RID`),
  KEY `STATUS` (`STATUS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `SESSID` int(11) NOT NULL AUTO_INCREMENT,
  `SESSION` int(11) NOT NULL,
  PRIMARY KEY (`SESSID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`SESSID`, `SESSION`) VALUES
(1, 2014),
(2, 2015);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `TID` int(11) NOT NULL AUTO_INCREMENT,
  `NAME_` varchar(25) NOT NULL,
  `COLLEGE` varchar(100) NOT NULL,
  `CITY` varchar(20) NOT NULL,
  `STID` int(11) NOT NULL,
  PRIMARY KEY (`TID`),
  KEY `STID` (`STID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `team_score`
--

CREATE TABLE IF NOT EXISTS `team_score` (
  `SCID` int(11) NOT NULL AUTO_INCREMENT,
  `TID` int(11) NOT NULL,
  `RID` int(11) NOT NULL,
  `SCORE` int(11) NOT NULL,
  `STID` int(11) NOT NULL,
  `SESSID` int(11) NOT NULL,
  PRIMARY KEY (`SCID`),
  KEY `TID` (`TID`,`RID`,`SCORE`,`STID`,`SESSID`),
  KEY `RID` (`RID`),
  KEY `STID` (`STID`),
  KEY `SESSID` (`SESSID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assign_question`
--
ALTER TABLE `assign_question`
  ADD CONSTRAINT `id_for_round` FOREIGN KEY (`RID`) REFERENCES `rounds` (`RID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_for_question` FOREIGN KEY (`QID`) REFERENCES `q_a` (`QID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_for_team` FOREIGN KEY (`TID`) REFERENCES `teams` (`TID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `q_a`
--
ALTER TABLE `q_a`
  ADD CONSTRAINT `q_a_ibfk_1` FOREIGN KEY (`SESSID`) REFERENCES `sessions` (`SESSID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `id_for_game_category` FOREIGN KEY (`STID`) REFERENCES `game_status` (`STID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `qid_for_question_status` FOREIGN KEY (`QSTID`) REFERENCES `question_status` (`QSTID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rounds`
--
ALTER TABLE `rounds`
  ADD CONSTRAINT `stid__for_game` FOREIGN KEY (`STATUS`) REFERENCES `game_status` (`STID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teams`
--
ALTER TABLE `teams`
  ADD CONSTRAINT `stid_for_game` FOREIGN KEY (`STID`) REFERENCES `game_status` (`STID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `team_score`
--
ALTER TABLE `team_score`
  ADD CONSTRAINT `team_score_ibfk_4` FOREIGN KEY (`SESSID`) REFERENCES `sessions` (`SESSID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `team_score_ibfk_1` FOREIGN KEY (`TID`) REFERENCES `teams` (`TID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `team_score_ibfk_2` FOREIGN KEY (`RID`) REFERENCES `rounds` (`RID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `team_score_ibfk_3` FOREIGN KEY (`STID`) REFERENCES `game_status` (`STID`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
