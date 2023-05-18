-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spacedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `spacedb` ;

-- -----------------------------------------------------
-- Schema spacedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spacedb` DEFAULT CHARACTER SET utf8 ;
USE `spacedb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `enabled` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `comment` ;

CREATE TABLE IF NOT EXISTS `comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `User_id` INT NOT NULL,
  `time_entered` DATETIME NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `body` TEXT(20000) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comment_User_idx` (`User_id` ASC),
  CONSTRAINT `fk_Comment_User`
    FOREIGN KEY (`User_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `encounter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `encounter` ;

CREATE TABLE IF NOT EXISTS `encounter` (
  `id` INT NOT NULL,
  `User_id` INT NOT NULL,
  `time_entered` DATETIME NOT NULL,
  `capture_method` VARCHAR(45) NOT NULL,
  `user_location` VARCHAR(100) NULL,
  `body` TEXT(20000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Encounter_User1_idx` (`User_id` ASC),
  CONSTRAINT `fk_Encounter_User1`
    FOREIGN KEY (`User_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `celestial_body`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `celestial_body` ;

CREATE TABLE IF NOT EXISTS `celestial_body` (
  `id` INT NOT NULL,
  `name` VARCHAR(250) NOT NULL,
  `category_id` INT NOT NULL,
  `description` TEXT(200000) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_celestial_body_category1_idx` (`category_id` ASC),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  CONSTRAINT `fk_celestial_body_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `image` ;

CREATE TABLE IF NOT EXISTS `image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `celestial_body_id` INT NOT NULL,
  `link` VARCHAR(20000) NOT NULL,
  `capture_method` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_image_celestial_body1_idx` (`celestial_body_id` ASC),
  CONSTRAINT `fk_image_celestial_body1`
    FOREIGN KEY (`celestial_body_id`)
    REFERENCES `celestial_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `celestial_body_has_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `celestial_body_has_comment` ;

CREATE TABLE IF NOT EXISTS `celestial_body_has_comment` (
  `celestial_body_id` INT NOT NULL,
  `comment_id` INT NOT NULL,
  PRIMARY KEY (`celestial_body_id`, `comment_id`),
  INDEX `fk_celestial_body_has_comment_comment1_idx` (`comment_id` ASC),
  INDEX `fk_celestial_body_has_comment_celestial_body1_idx` (`celestial_body_id` ASC),
  CONSTRAINT `fk_celestial_body_has_comment_celestial_body1`
    FOREIGN KEY (`celestial_body_id`)
    REFERENCES `celestial_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_celestial_body_has_comment_comment1`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `celestial_body_has_encounter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `celestial_body_has_encounter` ;

CREATE TABLE IF NOT EXISTS `celestial_body_has_encounter` (
  `celestial_body_id` INT NOT NULL,
  `encounter_id` INT NOT NULL,
  PRIMARY KEY (`celestial_body_id`, `encounter_id`),
  INDEX `fk_celestial_body_has_encounter_encounter1_idx` (`encounter_id` ASC),
  INDEX `fk_celestial_body_has_encounter_celestial_body1_idx` (`celestial_body_id` ASC),
  CONSTRAINT `fk_celestial_body_has_encounter_celestial_body1`
    FOREIGN KEY (`celestial_body_id`)
    REFERENCES `celestial_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_celestial_body_has_encounter_encounter1`
    FOREIGN KEY (`encounter_id`)
    REFERENCES `encounter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `star`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `star` ;

CREATE TABLE IF NOT EXISTS `star` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `description` TEXT(20000) NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `solar_system`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `solar_system` ;

CREATE TABLE IF NOT EXISTS `solar_system` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `description` TEXT(20000) NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nebula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nebula` ;

CREATE TABLE IF NOT EXISTS `nebula` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `description` TEXT(20000) NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS spaceuser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'spaceuser'@'localhost' IDENTIFIED BY 'spaceuser';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'spaceuser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `role`) VALUES (1, 'admin', '1234', 1, 'ADMIN');

COMMIT;

