-- MySQL dump 10.17  Distrib 10.3.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	10.3.14-MariaDB-1:10.3.14+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `craft_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetindexdata`
--

LOCK TABLES `craft_assetindexdata` WRITE;
/*!40000 ALTER TABLE `craft_assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assets`
--

DROP TABLE IF EXISTS `craft_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `craft_assets_folderId_idx` (`folderId`),
  KEY `craft_assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assets`
--

LOCK TABLES `craft_assets` WRITE;
/*!40000 ALTER TABLE `craft_assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransformindex`
--

LOCK TABLES `craft_assettransformindex` WRITE;
/*!40000 ALTER TABLE `craft_assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_idx` (`groupId`),
  KEY `craft_categories_parentId_fk` (`parentId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categorygroups_name_idx` (`name`),
  KEY `craft_categorygroups_handle_idx` (`handle`),
  KEY `craft_categorygroups_structureId_idx` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_categorygroups_sites`
--

DROP TABLE IF EXISTS `craft_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `craft_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups_sites`
--

LOCK TABLES `craft_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_content_siteId_idx` (`siteId`),
  KEY `craft_content_title_idx` (`title`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
INSERT INTO `craft_content` VALUES (1,1,1,NULL,'2019-06-16 10:44:36','2019-06-16 10:44:36','74c52b94-de1e-4ec6-bfcd-0dc5cd56d068');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_craftidtokens`
--

DROP TABLE IF EXISTS `craft_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craft_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_craftidtokens`
--

LOCK TABLES `craft_craftidtokens` WRITE;
/*!40000 ALTER TABLE `craft_craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elementindexsettings`
--

DROP TABLE IF EXISTS `craft_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `craft_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
INSERT INTO `craft_elements` VALUES (1,NULL,'craft\\elements\\User',1,0,'2019-06-16 10:44:36','2019-06-16 10:44:36',NULL,'1488ce2f-9310-4a28-b2cf-0b914d3836ee');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_elements_sites`
--

DROP TABLE IF EXISTS `craft_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_elements_sites_siteId_idx` (`siteId`),
  KEY `craft_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `craft_elements_sites_enabled_idx` (`enabled`),
  KEY `craft_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `craft_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements_sites`
--

LOCK TABLES `craft_elements_sites` WRITE;
/*!40000 ALTER TABLE `craft_elements_sites` DISABLE KEYS */;
INSERT INTO `craft_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-06-16 10:44:36','2019-06-16 10:44:36','6cd2208f-8b80-47d5-a93f-a1b506179810');
/*!40000 ALTER TABLE `craft_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_idx` (`authorId`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_parentId_fk` (`parentId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `craft_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entrydrafts_siteId_idx` (`siteId`),
  KEY `craft_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `craft_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_idx` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_sectionId_idx` (`sectionId`),
  KEY `craft_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entryversions_siteId_idx` (`siteId`),
  KEY `craft_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
INSERT INTO `craft_fieldgroups` VALUES (1,'Common','2019-06-16 10:44:36','2019-06-16 10:44:36','b97afee6-7b6b-4373-8449-c442c53bbe0d');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_groupId_idx` (`groupId`),
  KEY `craft_fields_context_idx` (`context`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_globalsets_name_idx` (`name`),
  KEY `craft_globalsets_handle_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `config` mediumtext DEFAULT NULL,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
INSERT INTO `craft_info` VALUES (1,'3.1.30','3.1.28',0,'a:6:{s:11:\"fieldGroups\";a:1:{s:36:\"b97afee6-7b6b-4373-8449-c442c53bbe0d\";a:1:{s:4:\"name\";s:6:\"Common\";}}s:10:\"siteGroups\";a:1:{s:36:\"71e56ce7-cb6b-4fc1-b22a-96a1c3b58c83\";a:1:{s:4:\"name\";s:4:\"Test\";}}s:5:\"sites\";a:1:{s:36:\"91bd5f85-df24-4e3d-b13f-248a4c67b07c\";a:8:{s:7:\"baseUrl\";s:17:\"$DEFAULT_SITE_URL\";s:6:\"handle\";s:7:\"default\";s:7:\"hasUrls\";b:1;s:8:\"language\";s:2:\"en\";s:4:\"name\";s:4:\"Test\";s:7:\"primary\";b:1;s:9:\"siteGroup\";s:36:\"71e56ce7-cb6b-4fc1-b22a-96a1c3b58c83\";s:9:\"sortOrder\";i:1;}}s:5:\"email\";a:3:{s:9:\"fromEmail\";s:21:\"matt@mattgrayisok.com\";s:8:\"fromName\";s:4:\"Test\";s:13:\"transportType\";s:37:\"craft\\mail\\transportadapters\\Sendmail\";}s:6:\"system\";a:5:{s:7:\"edition\";s:4:\"solo\";s:4:\"name\";s:4:\"Test\";s:4:\"live\";b:1;s:13:\"schemaVersion\";s:6:\"3.1.28\";s:8:\"timeZone\";s:19:\"America/Los_Angeles\";}s:5:\"users\";a:5:{s:24:\"requireEmailVerification\";b:1;s:23:\"allowPublicRegistration\";b:0;s:12:\"defaultGroup\";N;s:14:\"photoVolumeUid\";N;s:12:\"photoSubpath\";s:0:\"\";}}','[]','yutzYTs8Zyr1','2019-06-16 10:44:36','2019-06-16 10:44:36','9f3b3abe-39a1-4a23-901d-e335bc91f4fd');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_migrations_pluginId_idx` (`pluginId`),
  KEY `craft_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
INSERT INTO `craft_migrations` VALUES (1,NULL,'app','Install','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','25f0867d-2fd2-431f-835a-1459c9933c06'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','54334ed8-02b5-48d5-b5c3-e940d582c630'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b5a19227-34a9-4977-b0b6-b98c3b1879e2'),(4,NULL,'app','m150403_184533_field_version','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','737a1d35-92e2-4a47-b581-427cf52cad4e'),(5,NULL,'app','m150403_184729_type_columns','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','df17be8a-6a61-4ce0-b7c2-2f78513c7c6d'),(6,NULL,'app','m150403_185142_volumes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','108ca255-0ee3-4a2a-be27-522913bcad4c'),(7,NULL,'app','m150428_231346_userpreferences','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','a3ab381a-6621-4032-9cd3-7cea0ea5d545'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','9cff1a6c-41f2-42c1-9a9a-7804dc1d3c63'),(9,NULL,'app','m150617_213829_update_email_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','bd945e28-114c-4dd4-98ab-a377ec6a3876'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','25152dbe-9c4d-489f-860e-661ef76b56ef'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','766d82b9-f901-4363-a36b-3a789ef0e111'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e17efca6-7ec2-4efb-9ba1-56a6f55bd764'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e34d23d7-866e-42b5-b423-824c97d21448'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','26d9e85d-1944-448b-bd5d-58272b3f3e30'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d6c703a1-92ff-45ef-842f-5997b4a9ef21'),(16,NULL,'app','m151209_000000_move_logo','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','7de35428-e6e1-414b-8731-62393ab09a9f'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','dee4c152-2cc2-49b9-a15a-187a3a531a35'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','deb05e13-b62f-478d-b086-39b1d93b81e6'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','ef0c3049-02e3-4c11-8858-b6519eaa4b34'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','f8c5f3e3-53c0-483d-b0a1-699dfeb3ddba'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','74f7b53e-5de6-4d96-939e-2cd6994b33d3'),(22,NULL,'app','m160727_194637_column_cleanup','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','59b7a214-526e-42f0-bb97-4411d3182495'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b8fc7cb8-7c7c-4fb4-a68d-8adac567ac63'),(24,NULL,'app','m160807_144858_sites','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','cc92cbae-eeec-476c-b207-a9bd27c4c0bc'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','07bffe64-5637-47a0-81c5-2e05c96df063'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','6baec999-a436-47b2-87b9-af233b047550'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d350b6ae-36a9-4a97-b177-81fcbdc39c33'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d7edb4c3-20ea-4a7f-af4b-db01140dbb73'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','84df7c56-5e67-4fe5-b786-5929fbce45d0'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d54d322a-aeff-4e58-9ac0-a5e31a06093c'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','9c4aadb8-5f7a-47a0-9396-d62e4cfb1ffb'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','3e527d71-fdba-4671-a9ab-8c1da42aad0b'),(33,NULL,'app','m161007_130653_update_email_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b8ea60d3-3b33-4816-adc9-21accb6dcb87'),(34,NULL,'app','m161013_175052_newParentId','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b259bcbb-9720-4b7f-81cd-205b2424cee8'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','970da818-1c03-4f42-bf14-5594cbdc6ef9'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','44badaea-f073-41cb-ace8-f869b0d76331'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d2783214-5710-475e-b254-3bbad78d14a1'),(38,NULL,'app','m161029_124145_email_message_languages','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d39b1044-9890-4534-b3f1-3859d1ede3dc'),(39,NULL,'app','m161108_000000_new_version_format','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','7a3a03d6-0971-4c1c-ab2a-eb37df917e23'),(40,NULL,'app','m161109_000000_index_shuffle','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','306f314a-8deb-4565-b3c0-106c759e7a57'),(41,NULL,'app','m161122_185500_no_craft_app','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','0e12dfb9-b2d2-46d8-84fa-52bba5822f36'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','7fbfe5f4-2bcf-4fba-afe4-5ee17e63a9e5'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','4d3b6edc-5473-441f-a8f8-a812585aeeb4'),(44,NULL,'app','m170114_161144_udates_permission','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','785cff77-2bb1-4a25-9f11-ceaef4656d30'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','a22cde93-71a2-478a-8aa9-0588a81db47c'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','8fc15d2d-a1e7-4f8f-8319-4702ab2dec42'),(47,NULL,'app','m170206_142126_system_name','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','0862bb63-490d-45ea-94cf-5147f214af62'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','a054aab6-4c8b-46f6-be2b-e8724ba6959b'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','806ab0cc-3ff3-4990-a91b-40fd2f6d9c70'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','2d372308-9ca7-4821-aa41-3fe116af5b1c'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','205f09ff-727a-4b8f-bb09-9ffc6d372aa8'),(52,NULL,'app','m170228_171113_system_messages','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d5682e6d-1bb7-407f-be48-22b324995f16'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','47c3b526-4037-4cac-956c-2ef753b107a8'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','587fd3b0-bc8d-47a7-8700-f43c9ff4e2b8'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e738b7dc-6dc9-42c0-ad15-9485c4688311'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','20c38b08-735b-44b6-99e0-0b39ee966d23'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','c49d3c31-c523-4933-b3ea-e52281f426d3'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b1583b7b-c182-49fa-8824-6c47c41f0c55'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','dcba598d-40c9-43b6-bec3-07841b09619c'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','cb8d30e7-708e-4f41-ba40-4dd45b2bdabc'),(61,NULL,'app','m170704_134916_sites_tables','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','a8efd121-560a-4efb-ad48-f05c4034497a'),(62,NULL,'app','m170706_183216_rename_sequences','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','f39357db-f14c-4443-bd84-89aaef75f8e4'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','0af2c706-dc67-4f9c-9e4f-3efab536759d'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','abe2c695-e841-42a0-a7a5-5cb2445ebadd'),(65,NULL,'app','m170810_201318_create_queue_table','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d46e872d-1339-4019-a783-7eda73209935'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','1a9972e7-4d86-49e8-9fe0-7c3e9094427c'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','0e1b675e-41d3-40f7-ba2e-da11327aadd5'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e475a3aa-f37e-41e6-b48a-f464a713b1b9'),(69,NULL,'app','m171011_214115_site_groups','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d1e17597-23dd-474d-9415-639023ffe21a'),(70,NULL,'app','m171012_151440_primary_site','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','517511c8-87b3-41d9-970e-01a600e6645d'),(71,NULL,'app','m171013_142500_transform_interlace','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d0a7b13c-413d-49f4-af01-a6ac35893674'),(72,NULL,'app','m171016_092553_drop_position_select','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','6be6d73a-44a7-4c26-87c7-f20e345481c2'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e7728f57-4fde-49e9-99b6-ea28f99c3314'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','caddb27f-82f7-4843-8ef4-19362aea76c1'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','9b8af31e-624e-4fe8-a993-ac7b2fe6d1d5'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','0f7c1b03-9e2d-4a27-ad02-b921cdf6256e'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','759a6723-055b-443a-a6fb-b304bae71dbc'),(78,NULL,'app','m171202_004225_update_email_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e20c9cad-aaf2-4e4e-83cb-1ef2bcb156ca'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','30d623de-bfde-46e8-a8ff-ca056e969416'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','5fee8ac0-8782-487b-aefe-5c41eab676be'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','72ab4f7f-86e5-4f17-a7c5-0bb410f66ab3'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','8d62e052-595e-4049-adcc-3161f7a0c39f'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','bbddb27d-31a9-4f69-bddd-a7545f84b16c'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','516dbbe6-1d4b-4af2-830e-ac501f80f3ad'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','54c3c357-7cab-489d-953c-fbedb7ad4781'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','bc7ba98e-b4dc-4b25-8307-7a409033d3d9'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','1f5163b9-1de1-4ecf-a52c-b6d95d6fefeb'),(88,NULL,'app','m180217_172123_tiny_ints','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','183156f7-9242-4092-ba78-08d94222ff38'),(89,NULL,'app','m180321_233505_small_ints','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','84c4a092-68b1-49df-86b6-0fecc6dbc743'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','544d4a73-c326-46d7-b711-4df247ef6af4'),(91,NULL,'app','m180404_182320_edition_changes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','f4bef646-d6aa-4c43-99d9-6fc835029446'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','1c404511-866d-4b2b-a2ee-e777397fcf22'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','c326e59b-07ec-4fa3-83b1-638312ece96b'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e8d4ed8c-6ba3-4be3-9c5b-1d2640273d9c'),(95,NULL,'app','m180425_203349_searchable_fields','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','ae579d8d-8cd0-421f-a98e-64795dec9f33'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','229e1727-fd5e-421e-9028-d3ef27b3c0c9'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','a1a89335-b403-4368-82e7-362ba47bf302'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','94b68f5e-03d5-4166-9668-2b6477b332bd'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','09d29fa9-0c94-4bf3-8f90-7e2a5ced1a2a'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','45698726-1ddb-436d-b027-a84274e058f2'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','a1fa8c4c-507e-4982-8f20-d00b7f6ccde8'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','1cff50aa-a12b-4a51-b735-b049bd9bd825'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','fd46555d-8786-4d3e-9548-7518bc66665b'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','96071137-b449-41f2-b7ae-081757949b6c'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','70d1f603-b05b-4ae4-adf4-b1f7bf267a6c'),(106,NULL,'app','m180904_112109_permission_changes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','7ca8aaa2-e1dd-437a-9815-5d976679599a'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','cb85faae-9c66-4154-bef1-32e2753519d5'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','db70b4c7-9e71-49c2-a778-ca2785706401'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e04ca9f1-d185-4f3b-b6e5-bf4d416c8224'),(110,NULL,'app','m181017_225222_system_config_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','5cd7ead4-6d4e-4db8-ac8f-2232b7f3af1d'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','546150fc-e54f-4031-abe5-35549a5ebac5'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','1ac3bf6f-9ed8-44d0-bc22-cb3a594bc391'),(113,NULL,'app','m181112_203955_sequences_table','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','8b3a30b4-b683-46ac-8751-565521b41888'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','cab6edf2-a174-443b-a061-96e730234ca6'),(115,NULL,'app','m181128_193942_fix_project_config','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','33c48d37-19b9-49c2-9d96-8c1052482a73'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','dee34208-0056-4e26-a5cd-81d9c858b893'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','6422366d-e86c-43cf-a081-4427e18ebab4'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','4afd8e8f-3451-4bb5-8e46-270820c962b3'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','ef14ac8b-855e-4cf0-b561-b781140e176b'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','00ee77dc-6377-40b8-a998-6a3f64193770'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b243ec0a-dd84-4c20-afb8-7cd50b06a823'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e1528b9f-ae46-4e18-b4d0-410d70c1d3fb'),(123,NULL,'app','m190109_172845_fix_colspan','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e4e09d47-900d-4e4a-bfc4-c098af3e83c3'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','cb0f28e4-4773-43fe-a23f-dc25a0942eb1'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','424cceea-d461-442b-a09a-a12fb70ab866'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','485a39ce-48fd-4fc7-80a2-560da9298a45'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','946f41f0-7645-4be5-8c4f-724ab42cb910'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e3a07509-e7b1-473c-b955-89ed7f29dfda'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','d55167f9-02c4-4cdc-95de-53099eec2d6b'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','abb91287-c4cd-47fd-becc-65dfee798129'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','dd198106-fb91-4409-a223-0547341e99db'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','9383abcb-21e1-4fa8-919b-ecf483042643'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','e0b38917-054e-4203-87c0-2038710d351b'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','467d44b0-3ab8-43e0-adf4-36f5ccdc701a'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','30ad5c86-de9c-4ec4-91bc-aeb8d52cae03'),(136,NULL,'app','m190401_223843_drop_old_indexes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','7cea743e-5509-47b5-bf11-4bb071a6e73d'),(137,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b37d9def-ad47-49d1-936a-f97306138f81'),(138,NULL,'app','m190502_122019_store_default_user_group_uid','2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:36','b500717c-4227-4cea-b67a-08c478f41683');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_queue`
--

DROP TABLE IF EXISTS `craft_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `craft_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_queue`
--

LOCK TABLES `craft_queue` WRITE;
/*!40000 ALTER TABLE `craft_queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `craft_relations_sourceId_idx` (`sourceId`),
  KEY `craft_relations_targetId_idx` (`targetId`),
  KEY `craft_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_resourcepaths`
--

DROP TABLE IF EXISTS `craft_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_resourcepaths`
--

LOCK TABLES `craft_resourcepaths` WRITE;
/*!40000 ALTER TABLE `craft_resourcepaths` DISABLE KEYS */;
INSERT INTO `craft_resourcepaths` VALUES ('4b1834bd','@lib/fileupload'),('53f03543','@lib/picturefill'),('54540981','@lib/jquery-touch-events'),('5d551512','@lib/d3'),('6ee80294','@lib/garnishjs'),('78dc8d6f','@app/web/assets/dashboard/dist'),('78e18c7','@lib/selectize'),('7baed6aa','@lib/fabric'),('807c651c','@lib/jquery-ui'),('8e24e2ae','@app/web/assets/installer/dist'),('96b40a01','@app/web/assets/craftsupport/dist'),('9826a6c0','@app/web/assets/updateswidget/dist'),('a69ce4ae','@app/web/assets/recententries/dist'),('bbd1c323','@app/web/assets/cp/dist'),('c2ca889d','@app/web/assets/feed/dist'),('ced5feb9','@lib/velocity'),('d2f25151','@lib/jquery.payment'),('de25c4d','@lib/xregexp'),('df5a09c4','@bower/jquery/dist'),('f0caa231','@lib/element-resize-detector');
/*!40000 ALTER TABLE `craft_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,1,' matt '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' matt mattgrayisok com '),(1,'slug',0,1,'');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagateEntries` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sections_handle_idx` (`handle`),
  KEY `craft_sections_name_idx` (`name`),
  KEY `craft_sections_structureId_idx` (`structureId`),
  KEY `craft_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sections_sites`
--

DROP TABLE IF EXISTS `craft_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `craft_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections_sites`
--

LOCK TABLES `craft_sections_sites` WRITE;
/*!40000 ALTER TABLE `craft_sections_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sequences`
--

DROP TABLE IF EXISTS `craft_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sequences`
--

LOCK TABLES `craft_sequences` WRITE;
/*!40000 ALTER TABLE `craft_sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_idx` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sessions`
--

LOCK TABLES `craft_sessions` WRITE;
/*!40000 ALTER TABLE `craft_sessions` DISABLE KEYS */;
INSERT INTO `craft_sessions` VALUES (1,1,'pcnpLgBUJQo46vL4hLWX8CJy9cXBardsPDb14MCtaUa5z0iTZXocmiDXA8JVjwCB7LGZIx1BN8sLYlPv_RjUQHReKYZDxDGvkWFt','2019-06-16 10:44:36','2019-06-16 10:45:38','ef23555b-f25c-4dbc-9c04-12b2c0145250');
/*!40000 ALTER TABLE `craft_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sitegroups`
--

DROP TABLE IF EXISTS `craft_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sitegroups`
--

LOCK TABLES `craft_sitegroups` WRITE;
/*!40000 ALTER TABLE `craft_sitegroups` DISABLE KEYS */;
INSERT INTO `craft_sitegroups` VALUES (1,'Test','2019-06-16 10:44:36','2019-06-16 10:44:36',NULL,'71e56ce7-cb6b-4fc1-b22a-96a1c3b58c83');
/*!40000 ALTER TABLE `craft_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_sites`
--

DROP TABLE IF EXISTS `craft_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sites_handle_idx` (`handle`),
  KEY `craft_sites_sortOrder_idx` (`sortOrder`),
  KEY `craft_sites_groupId_fk` (`groupId`),
  CONSTRAINT `craft_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sites`
--

LOCK TABLES `craft_sites` WRITE;
/*!40000 ALTER TABLE `craft_sites` DISABLE KEYS */;
INSERT INTO `craft_sites` VALUES (1,1,1,'Test','default','en',1,'$DEFAULT_SITE_URL',1,'2019-06-16 10:44:36','2019-06-16 10:44:36',NULL,'91bd5f85-df24-4e3d-b13f-248a4c67b07c');
/*!40000 ALTER TABLE `craft_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_systemmessages`
--

DROP TABLE IF EXISTS `craft_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `craft_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_systemmessages`
--

LOCK TABLES `craft_systemmessages` WRITE;
/*!40000 ALTER TABLE `craft_systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_taggroups_name_idx` (`name`),
  KEY `craft_taggroups_handle_idx` (`handle`),
  KEY `craft_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_idx` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecacheelements`
--

LOCK TABLES `craft_templatecacheelements` WRITE;
/*!40000 ALTER TABLE `craft_templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecachequeries`
--

DROP TABLE IF EXISTS `craft_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `craft_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `craft_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecachequeries`
--

LOCK TABLES `craft_templatecachequeries` WRITE;
/*!40000 ALTER TABLE `craft_templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `craft_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `craft_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecaches`
--

LOCK TABLES `craft_templatecaches` WRITE;
/*!40000 ALTER TABLE `craft_templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `craft_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_userpreferences`
--

DROP TABLE IF EXISTS `craft_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `craft_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpreferences`
--

LOCK TABLES `craft_userpreferences` WRITE;
/*!40000 ALTER TABLE `craft_userpreferences` DISABLE KEYS */;
INSERT INTO `craft_userpreferences` VALUES (1,'{\"language\":\"en\"}');
/*!40000 ALTER TABLE `craft_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_email_idx` (`email`),
  KEY `craft_users_username_idx` (`username`),
  KEY `craft_users_photoId_fk` (`photoId`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `craft_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
INSERT INTO `craft_users` VALUES (1,'matt',NULL,NULL,NULL,'matt@mattgrayisok.com','$2y$13$642Sv54HCvxoKA3Q0T0O/uMJ0Rf4nIoxmuGcAcwpvlKlkIv1iKUQ6',1,0,0,0,'2019-06-16 10:44:36',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-06-16 10:44:36','2019-06-16 10:44:36','2019-06-16 10:44:37','4fd239ca-cf93-453e-af66-3db7a14adb2c');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_volumefolders`
--

DROP TABLE IF EXISTS `craft_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `craft_volumefolders_parentId_idx` (`parentId`),
  KEY `craft_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_volumefolders`
--

LOCK TABLES `craft_volumefolders` WRITE;
/*!40000 ALTER TABLE `craft_volumefolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_volumes`
--

DROP TABLE IF EXISTS `craft_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_volumes_name_idx` (`name`),
  KEY `craft_volumes_handle_idx` (`handle`),
  KEY `craft_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_volumes`
--

LOCK TABLES `craft_volumes` WRITE;
/*!40000 ALTER TABLE `craft_volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `craft_volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_idx` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
INSERT INTO `craft_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2019-06-16 10:44:37','2019-06-16 10:44:37','d621583f-0798-45e4-a5e9-f415848a1181'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-06-16 10:44:37','2019-06-16 10:44:37','bd266393-1bff-43ef-9a00-fb55f51cfcdc'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-06-16 10:44:37','2019-06-16 10:44:37','afc67757-ebd5-4a36-9ec2-55b06d860ee1'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-06-16 10:44:37','2019-06-16 10:44:37','c3d57abd-26c4-43dd-bb09-46c77f262cda');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-06-16 19:44:36
