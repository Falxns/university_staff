-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema olympic_games
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema olympic_games
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `olympic_games` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `olympic_games` ;

-- -----------------------------------------------------
-- Table `olympic_games`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`countries` (
  `countryID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`countryID`),
  INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`cities` (
  `cityID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `countryID` INT NOT NULL,
  PRIMARY KEY (`cityID`),
  INDEX `countryID` (`countryID` ASC) VISIBLE,
  INDEX `name` (`name` ASC) VISIBLE,
  CONSTRAINT `cities_ibfk_1`
    FOREIGN KEY (`countryID`)
    REFERENCES `olympic_games`.`countries` (`countryID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`season`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`season` (
  `seasonID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`seasonID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympicgames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympicgames` (
  `olympicGameID` INT NOT NULL AUTO_INCREMENT,
  `cityID` INT NOT NULL,
  `year` INT NOT NULL,
  `sequnce` INT NOT NULL,
  `seasonID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`olympicGameID`, `seasonID`),
  UNIQUE INDEX `sequnce` (`sequnce` ASC) VISIBLE,
  INDEX `cityID` (`cityID` ASC) VISIBLE,
  INDEX `fk_olympicgames_season1_idx` (`seasonID` ASC) VISIBLE,
  UNIQUE INDEX `year_UNIQUE` (`year` ASC) VISIBLE,
  CONSTRAINT `olympicgames_ibfk_1`
    FOREIGN KEY (`cityID`)
    REFERENCES `olympic_games`.`cities` (`cityID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_olympicgames_season1`
    FOREIGN KEY (`seasonID`)
    REFERENCES `olympic_games`.`season` (`seasonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportkinds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportkinds` (
  `sportKindID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`sportKindID`),
  INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportdisciplines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportdisciplines` (
  `sportDisciplineID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `sportKindID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`sportDisciplineID`),
  INDEX `sportKindID` (`sportKindID` ASC) VISIBLE,
  INDEX `name` (`name` ASC) VISIBLE,
  CONSTRAINT `sportdiciplines_ibfk_1`
    FOREIGN KEY (`sportKindID`)
    REFERENCES `olympic_games`.`sportkinds` (`sportKindID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympicgamesdiciplines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympicgamesdiciplines` (
  `olympicGameID` INT NOT NULL,
  `diciplineID` INT NOT NULL,
  PRIMARY KEY (`olympicGameID`, `diciplineID`),
  INDEX `diciplineID` (`diciplineID` ASC) VISIBLE,
  CONSTRAINT `olympicgamesdiciplines_ibfk_1`
    FOREIGN KEY (`olympicGameID`)
    REFERENCES `olympic_games`.`olympicgames` (`olympicGameID`)
    ON UPDATE CASCADE,
  CONSTRAINT `olympicgamesdiciplines_ibfk_2`
    FOREIGN KEY (`diciplineID`)
    REFERENCES `olympic_games`.`sportdisciplines` (`sportDisciplineID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympicgameslogos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympicgameslogos` (
  `olympicGameID` INT NOT NULL AUTO_INCREMENT,
  `nameLogo` VARCHAR(50) NOT NULL,
  `imageLogo` BLOB NOT NULL,
  PRIMARY KEY (`olympicGameID`),
  CONSTRAINT `olympicgameslogos_ibfk_1`
    FOREIGN KEY (`olympicGameID`)
    REFERENCES `olympic_games`.`olympicgames` (`olympicGameID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`gender` (
  `genderID` INT UNSIGNED NOT NULL,
  `type` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`genderID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`persons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`persons` (
  `personID` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(100) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `middleName` VARCHAR(100) NULL DEFAULT NULL,
  `dateBirth` DATE NOT NULL,
  `genderID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`personID`, `genderID`),
  INDEX `firstName` (`firstName` ASC) VISIBLE,
  INDEX `fk_persons_gender1_idx` (`genderID` ASC) VISIBLE,
  CONSTRAINT `fk_persons_gender1`
    FOREIGN KEY (`genderID`)
    REFERENCES `olympic_games`.`gender` (`genderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympicgamesparticipants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympicgamesparticipants` (
  `olympicGameID` INT NOT NULL,
  `personID` INT NOT NULL,
  `countryID` INT NOT NULL,
  `disciplineID` INT NOT NULL,
  PRIMARY KEY (`olympicGameID`, `personID`),
  INDEX `countryID` (`countryID` ASC) VISIBLE,
  INDEX `diciplineID` (`disciplineID` ASC) VISIBLE,
  INDEX `personID` (`personID` ASC) VISIBLE,
  CONSTRAINT `olympicgamesparticipants_ibfk_1`
    FOREIGN KEY (`olympicGameID`)
    REFERENCES `olympic_games`.`olympicgames` (`olympicGameID`)
    ON UPDATE CASCADE,
  CONSTRAINT `olympicgamesparticipants_ibfk_2`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`)
    ON UPDATE CASCADE,
  CONSTRAINT `olympicgamesparticipants_ibfk_3`
    FOREIGN KEY (`countryID`)
    REFERENCES `olympic_games`.`countries` (`countryID`)
    ON UPDATE CASCADE,
  CONSTRAINT `olympicgamesparticipants_ibfk_4`
    FOREIGN KEY (`disciplineID`)
    REFERENCES `olympic_games`.`sportdisciplines` (`sportDisciplineID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sponsors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sponsors` (
  `sponsorID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `tagline` TEXT NOT NULL,
  PRIMARY KEY (`sponsorID`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympicgamessponsors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympicgamessponsors` (
  `olympicGameID` INT NOT NULL,
  `sponsorID` INT NOT NULL,
  PRIMARY KEY (`olympicGameID`, `sponsorID`),
  INDEX `sponsorID` (`sponsorID` ASC) VISIBLE,
  CONSTRAINT `olympicgamessponsors_ibfk_1`
    FOREIGN KEY (`olympicGameID`)
    REFERENCES `olympic_games`.`olympicgames` (`olympicGameID`)
    ON UPDATE CASCADE,
  CONSTRAINT `olympicgamessponsors_ibfk_2`
    FOREIGN KEY (`sponsorID`)
    REFERENCES `olympic_games`.`sponsors` (`sponsorID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympictalismanlogos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympictalismanlogos` (
  `olympicTalismanID` INT NOT NULL,
  `image` BLOB NOT NULL,
  PRIMARY KEY (`olympicTalismanID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`olympictalismans`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`olympictalismans` (
  `olympicTalismanID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `description` TEXT NOT NULL,
  `olympicGameID` INT NOT NULL,
  PRIMARY KEY (`olympicTalismanID`),
  INDEX `olympicGameID` (`olympicGameID` ASC) VISIBLE,
  CONSTRAINT `olympictalismans_ibfk_1`
    FOREIGN KEY (`olympicGameID`)
    REFERENCES `olympic_games`.`olympicgames` (`olympicGameID`),
  CONSTRAINT `olympictalismans_ibfk_2`
    FOREIGN KEY (`olympicTalismanID`)
    REFERENCES `olympic_games`.`olympictalismanlogos` (`olympicTalismanID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`documents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`documents` (
  `documentID` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(50) NOT NULL,
  `date` DATE NOT NULL,
  `priority` INT NOT NULL,
  `dbLoadingDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`documentID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`documentcontent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`documentcontent` (
  `documentID` INT NOT NULL,
  `content` BLOB NOT NULL,
  PRIMARY KEY (`documentID`),
  CONSTRAINT `otherdocumentcontent_ibfk_1`
    FOREIGN KEY (`documentID`)
    REFERENCES `olympic_games`.`documents` (`documentID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportcompetitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportcompetitions` (
  `sportCompetitionID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `sportDisciplineID` INT NOT NULL,
  `isCommand` CHAR(2) NOT NULL,
  PRIMARY KEY (`sportCompetitionID`),
  INDEX `sportDiciplineID` (`sportDisciplineID` ASC) VISIBLE,
  INDEX `name` (`name` ASC) VISIBLE,
  CONSTRAINT `sportcompetitions_ibfk_1`
    FOREIGN KEY (`sportDisciplineID`)
    REFERENCES `olympic_games`.`sportdisciplines` (`sportDisciplineID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportobjects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportobjects` (
  `sportObjectID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `capacity` INT NOT NULL,
  `olympicGamesID` INT NOT NULL,
  PRIMARY KEY (`sportObjectID`),
  INDEX `name` (`name` ASC) VISIBLE,
  INDEX `olympicGamesID` (`olympicGamesID` ASC) VISIBLE,
  CONSTRAINT `sportobjects_ibfk_1`
    FOREIGN KEY (`olympicGamesID`)
    REFERENCES `olympic_games`.`olympicgames` (`olympicGameID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportobjectplaces`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportobjectplaces` (
  `sportObjectPlaceID` INT NOT NULL AUTO_INCREMENT,
  `sportObjectID` INT NOT NULL,
  `placeType` VARCHAR(50) NOT NULL,
  `number` INT NULL DEFAULT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`sportObjectPlaceID`),
  INDEX `sportObjectID` (`sportObjectID` ASC) VISIBLE,
  CONSTRAINT `sportobjectplaces_ibfk_1`
    FOREIGN KEY (`sportObjectID`)
    REFERENCES `olympic_games`.`sportobjects` (`sportObjectID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`stage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`stage` (
  `stageID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`stageID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportevents`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportevents` (
  `sportEventID` INT NOT NULL AUTO_INCREMENT,
  `competitionID` INT NOT NULL,
  `competitionPlaceID` INT NOT NULL,
  `date` DATE NOT NULL,
  `timeStart` TIME NOT NULL,
  `timeEnd` TIME NULL DEFAULT NULL,
  `stageID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`sportEventID`, `stageID`),
  INDEX `competitionID` (`competitionID` ASC) VISIBLE,
  INDEX `competitionPlaceID` (`competitionPlaceID` ASC) VISIBLE,
  INDEX `date` (`date` ASC) VISIBLE,
  INDEX `fk_sportevents_stage1_idx` (`stageID` ASC) VISIBLE,
  CONSTRAINT `sportevents_ibfk_1`
    FOREIGN KEY (`competitionID`)
    REFERENCES `olympic_games`.`sportcompetitions` (`sportCompetitionID`)
    ON UPDATE CASCADE,
  CONSTRAINT `sportevents_ibfk_2`
    FOREIGN KEY (`competitionPlaceID`)
    REFERENCES `olympic_games`.`sportobjectplaces` (`sportObjectPlaceID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sportevents_stage1`
    FOREIGN KEY (`stageID`)
    REFERENCES `olympic_games`.`stage` (`stageID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`documentevent`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`documentevent` (
  `documentID` INT NOT NULL,
  `eventID` INT NOT NULL,
  PRIMARY KEY (`documentID`, `eventID`),
  INDEX `eventID` (`eventID` ASC) VISIBLE,
  CONSTRAINT `otherdocumentevent_ibfk_1`
    FOREIGN KEY (`documentID`)
    REFERENCES `olympic_games`.`documents` (`documentID`)
    ON UPDATE CASCADE,
  CONSTRAINT `otherdocumentevent_ibfk_2`
    FOREIGN KEY (`eventID`)
    REFERENCES `olympic_games`.`sportevents` (`sportEventID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`personawards`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`personawards` (
  `awardID` INT NOT NULL AUTO_INCREMENT,
  `name` INT NOT NULL,
  `disciplineID` INT NOT NULL,
  PRIMARY KEY (`awardID`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE,
  INDEX `diciplineID` (`disciplineID` ASC) VISIBLE,
  CONSTRAINT `personawards_ibfk_1`
    FOREIGN KEY (`disciplineID`)
    REFERENCES `olympic_games`.`sportdisciplines` (`sportDisciplineID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`personawardshistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`personawardshistory` (
  `personID` INT NOT NULL,
  `awardID` INT NOT NULL,
  `date` DATE NOT NULL,
  `currency` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY USING BTREE (`awardID`, `date`),
  INDEX `personID` (`personID` ASC) VISIBLE,
  CONSTRAINT `personawardshistory_ibfk_2`
    FOREIGN KEY (`awardID`)
    REFERENCES `olympic_games`.`personawards` (`awardID`)
    ON UPDATE CASCADE,
  CONSTRAINT `personawardshistory_ibfk_3`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`persondiciplineshistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`persondiciplineshistory` (
  `personID` INT NOT NULL,
  `diciplineID` INT NOT NULL,
  `startDate` DATE NOT NULL,
  PRIMARY KEY (`personID`, `diciplineID`, `startDate`),
  INDEX `diciplineID` (`diciplineID` ASC) VISIBLE,
  CONSTRAINT `persondiciplineshistory_ibfk_1`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`)
    ON UPDATE CASCADE,
  CONSTRAINT `persondiciplineshistory_ibfk_2`
    FOREIGN KEY (`diciplineID`)
    REFERENCES `olympic_games`.`sportdisciplines` (`sportDisciplineID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`disqreason`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`disqreason` (
  `disqreasonID` INT UNSIGNED NOT NULL,
  `reason` TEXT NOT NULL,
  PRIMARY KEY (`disqreasonID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`persondisqhistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`persondisqhistory` (
  `personID` INT NOT NULL,
  `startDate` DATE NOT NULL,
  `endDate` DATE NULL DEFAULT NULL,
  `disqReasonID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`personID`, `startDate`, `disqReasonID`),
  INDEX `fk_persondisqhstr_disqreason1_idx` (`disqReasonID` ASC) VISIBLE,
  CONSTRAINT `persondisqhstr_ibfk_1`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_persondisqhstr_disqreason1`
    FOREIGN KEY (`disqReasonID`)
    REFERENCES `olympic_games`.`disqreason` (`disqreasonID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`married`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`married` (
  `marriedID` INT UNSIGNED NOT NULL,
  `status` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`marriedID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`disability`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`disability` (
  `disabilityID` INT UNSIGNED NOT NULL,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`disabilityID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`personinfohistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`personinfohistory` (
  `personInfoID` INT NOT NULL AUTO_INCREMENT,
  `personID` INT NOT NULL,
  `height` INT NOT NULL,
  `weight` INT NOT NULL,
  `modifiedDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `marriedID` INT UNSIGNED NOT NULL,
  `disabilityID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`personInfoID`, `marriedID`, `disabilityID`),
  INDEX `personID` (`personID` ASC) VISIBLE,
  INDEX `fk_personinfohistory_married1_idx` (`marriedID` ASC) VISIBLE,
  INDEX `fk_personinfohistory_disability1_idx` (`disabilityID` ASC) VISIBLE,
  CONSTRAINT `personinfohistory_ibfk_1`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_personinfohistory_married1`
    FOREIGN KEY (`marriedID`)
    REFERENCES `olympic_games`.`married` (`marriedID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personinfohistory_disability1`
    FOREIGN KEY (`disabilityID`)
    REFERENCES `olympic_games`.`disability` (`disabilityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`injurytype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`injurytype` (
  `idinjuryTypeID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idinjuryTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`personinjuries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`personinjuries` (
  `injuryID` INT NOT NULL AUTO_INCREMENT,
  `idinjuryTypeID` INT UNSIGNED NOT NULL,
  `dateStart` DATE NOT NULL,
  `duration` DATE NOT NULL,
  `injuryComment` TEXT NOT NULL,
  PRIMARY KEY (`injuryID`, `idinjuryTypeID`),
  INDEX `fk_personinjuries_injurytype1_idx` (`idinjuryTypeID` ASC) VISIBLE,
  CONSTRAINT `fk_personinjuries_injurytype1`
    FOREIGN KEY (`idinjuryTypeID`)
    REFERENCES `olympic_games`.`injurytype` (`idinjuryTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`personinjurieshistory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`personinjurieshistory` (
  `injuryID` INT NOT NULL,
  `personID` INT NOT NULL,
  PRIMARY KEY (`injuryID`, `personID`),
  INDEX `personID` (`personID` ASC) VISIBLE,
  CONSTRAINT `personinjurieshistory_ibfk_1`
    FOREIGN KEY (`injuryID`)
    REFERENCES `olympic_games`.`personinjuries` (`injuryID`)
    ON UPDATE CASCADE,
  CONSTRAINT `personinjurieshistory_ibfk_2`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportapplications`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportapplications` (
  `applicationID` INT NOT NULL AUTO_INCREMENT,
  `parent_appID` INT NULL DEFAULT NULL,
  `eventID` INT NOT NULL,
  `personID` INT NULL DEFAULT NULL,
  `countryID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`applicationID`),
  INDEX `eventID` (`eventID` ASC) VISIBLE,
  INDEX `parent_appID` (`parent_appID` ASC) VISIBLE,
  INDEX `personID` (`personID` ASC) VISIBLE,
  INDEX `countryID` (`countryID` ASC) VISIBLE,
  CONSTRAINT `sportapplications_ibfk_1`
    FOREIGN KEY (`parent_appID`)
    REFERENCES `olympic_games`.`sportapplications` (`applicationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `sportapplications_ibfk_2`
    FOREIGN KEY (`eventID`)
    REFERENCES `olympic_games`.`sportevents` (`sportEventID`)
    ON UPDATE CASCADE,
  CONSTRAINT `sportapplications_ibfk_3`
    FOREIGN KEY (`personID`)
    REFERENCES `olympic_games`.`persons` (`personID`)
    ON UPDATE CASCADE,
  CONSTRAINT `sportapplications_ibfk_4`
    FOREIGN KEY (`countryID`)
    REFERENCES `olympic_games`.`countries` (`countryID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportobjectaddresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportobjectaddresses` (
  `sportObjectID` INT NOT NULL,
  `cityID` INT NOT NULL,
  `streetName` VARCHAR(50) NOT NULL,
  `buildingNumber` INT NOT NULL,
  `longitute` FLOAT NOT NULL,
  `latitude` FLOAT NOT NULL,
  PRIMARY KEY (`sportObjectID`),
  INDEX `cityID` (`cityID` ASC) VISIBLE,
  CONSTRAINT `sportobjectaddresses_ibfk_1`
    FOREIGN KEY (`sportObjectID`)
    REFERENCES `olympic_games`.`sportobjects` (`sportObjectID`)
    ON UPDATE CASCADE,
  CONSTRAINT `sportobjectaddresses_ibfk_2`
    FOREIGN KEY (`cityID`)
    REFERENCES `olympic_games`.`cities` (`cityID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`medaltype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`medaltype` (
  `medalTypeID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`medalTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`resulttype`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`resulttype` (
  `resultTypeID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`resultTypeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`sportresults`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`sportresults` (
  `applicationID` INT NOT NULL,
  `place` INT NOT NULL,
  `isDisq` CHAR(2) NOT NULL,
  `isFail` CHAR(2) NOT NULL,
  `failComment` TEXT NULL DEFAULT NULL,
  `isRecord` CHAR(2) NOT NULL,
  `medalTypeID` INT UNSIGNED NOT NULL,
  `resultTypeID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`applicationID`, `medalTypeID`, `resultTypeID`),
  INDEX `fk_sportresults_medaltype1_idx` (`medalTypeID` ASC) VISIBLE,
  INDEX `fk_sportresults_resulttype1_idx` (`resultTypeID` ASC) VISIBLE,
  CONSTRAINT `sportresults_ibfk_1`
    FOREIGN KEY (`applicationID`)
    REFERENCES `olympic_games`.`sportapplications` (`applicationID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_sportresults_medaltype1`
    FOREIGN KEY (`medalTypeID`)
    REFERENCES `olympic_games`.`medaltype` (`medalTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sportresults_resulttype1`
    FOREIGN KEY (`resultTypeID`)
    REFERENCES `olympic_games`.`resulttype` (`resultTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`tvchannels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`tvchannels` (
  `tvChannelID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`tvChannelID`),
  INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`tvchannelsbroadcasts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`tvchannelsbroadcasts` (
  `tvChannelsBroadcastID` INT NOT NULL AUTO_INCREMENT,
  `tvChannelID` INT NOT NULL,
  `eventID` INT NOT NULL,
  `date` DATE NOT NULL,
  `timeStart` TIME NOT NULL,
  `timeEnd` TIME NULL DEFAULT NULL,
  `isLive` CHAR(2) NOT NULL,
  PRIMARY KEY (`tvChannelsBroadcastID`),
  INDEX `tvChannelID` (`tvChannelID` ASC) VISIBLE,
  INDEX `eventID` (`eventID` ASC) VISIBLE,
  CONSTRAINT `tvchannelsbroadcasts_ibfk_1`
    FOREIGN KEY (`tvChannelID`)
    REFERENCES `olympic_games`.`tvchannels` (`tvChannelID`)
    ON UPDATE CASCADE,
  CONSTRAINT `tvchannelsbroadcasts_ibfk_2`
    FOREIGN KEY (`eventID`)
    REFERENCES `olympic_games`.`sportevents` (`sportEventID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`users` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `dateBirth` DATE NOT NULL,
  `dateRegistration` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`userID`),
  UNIQUE INDEX `login` (`login` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`uactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`uactions` (
  `actionID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `userID` INT NOT NULL,
  PRIMARY KEY (`actionID`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE,
  INDEX `fk_uactions_users1_idx` (`userID` ASC) VISIBLE,
  CONSTRAINT `fk_uactions_users1`
    FOREIGN KEY (`userID`)
    REFERENCES `olympic_games`.`users` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`ulanguages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`ulanguages` (
  `languageID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`languageID`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`uroles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`uroles` (
  `roleID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`roleID`),
  UNIQUE INDEX `name` (`name` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`uroleactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`uroleactions` (
  `roleID` INT NOT NULL,
  `actionID` INT NOT NULL,
  PRIMARY KEY (`roleID`, `actionID`),
  INDEX `actionID` (`actionID` ASC) VISIBLE,
  CONSTRAINT `uroleactions_ibfk_1`
    FOREIGN KEY (`roleID`)
    REFERENCES `olympic_games`.`uroles` (`roleID`)
    ON UPDATE CASCADE,
  CONSTRAINT `uroleactions_ibfk_2`
    FOREIGN KEY (`actionID`)
    REFERENCES `olympic_games`.`uactions` (`actionID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`userlanguage`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`userlanguage` (
  `userID` INT NOT NULL,
  `languageID` INT NOT NULL,
  PRIMARY KEY (`userID`, `languageID`),
  INDEX `languageID` (`languageID` ASC) VISIBLE,
  CONSTRAINT `userlanguage_ibfk_1`
    FOREIGN KEY (`userID`)
    REFERENCES `olympic_games`.`users` (`userID`)
    ON UPDATE CASCADE,
  CONSTRAINT `userlanguage_ibfk_2`
    FOREIGN KEY (`languageID`)
    REFERENCES `olympic_games`.`ulanguages` (`languageID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`userroles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`userroles` (
  `userID` INT NOT NULL,
  `roleID` INT NOT NULL,
  PRIMARY KEY (`userID`, `roleID`),
  INDEX `roleID` (`roleID` ASC) VISIBLE,
  CONSTRAINT `userroles_ibfk_1`
    FOREIGN KEY (`userID`)
    REFERENCES `olympic_games`.`users` (`userID`)
    ON UPDATE CASCADE,
  CONSTRAINT `userroles_ibfk_2`
    FOREIGN KEY (`roleID`)
    REFERENCES `olympic_games`.`uroles` (`roleID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `olympic_games`.`winddirection`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`winddirection` (
  `winddirectionID` INT UNSIGNED NOT NULL,
  `name` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`winddirectionID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `olympic_games`.`weatherconditions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `olympic_games`.`weatherconditions` (
  `eventID` INT NOT NULL,
  `temperature` INT NOT NULL,
  `snowLevel` INT NULL DEFAULT NULL,
  `windSpeed` INT NOT NULL,
  `waterLevel` INT NULL DEFAULT NULL,
  `preassure` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `winddirectionID` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`eventID`, `winddirectionID`),
  INDEX `fk_weatherconditions_winddirection1_idx` (`winddirectionID` ASC) VISIBLE,
  CONSTRAINT `weatherconditions_ibfk_1`
    FOREIGN KEY (`eventID`)
    REFERENCES `olympic_games`.`sportevents` (`sportEventID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_weatherconditions_winddirection1`
    FOREIGN KEY (`winddirectionID`)
    REFERENCES `olympic_games`.`winddirection` (`winddirectionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
