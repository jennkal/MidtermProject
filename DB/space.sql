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
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `role` VARCHAR(45) NULL,
  `image_url` VARCHAR(2000) NULL,
  `about` TEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `classification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `classification` ;

CREATE TABLE IF NOT EXISTS `classification` (
  `id` INT NOT NULL,
  `name` VARCHAR(250) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `category` ;

CREATE TABLE IF NOT EXISTS `category` (
  `id` INT NOT NULL,
  `name` VARCHAR(250) NOT NULL,
  `classification_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_category_classification1_idx` (`classification_id` ASC),
  CONSTRAINT `fk_category_classification1`
    FOREIGN KEY (`classification_id`)
    REFERENCES `classification` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `celestial_body`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `celestial_body` ;

CREATE TABLE IF NOT EXISTS `celestial_body` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `enabled` TINYINT NOT NULL,
  `updated_at` DATETIME NULL,
  `description` TEXT NULL,
  `image_url` VARCHAR(2000) NULL,
  `tracking_url` VARCHAR(2000) NULL,
  `category_id` INT NOT NULL,
  `parent_celestial_body_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_celestial_body_celestial_body1_idx` (`parent_celestial_body_id` ASC),
  INDEX `fk_celestial_body_category1_idx` (`category_id` ASC),
  CONSTRAINT `fk_celestial_body_celestial_body1`
    FOREIGN KEY (`parent_celestial_body_id`)
    REFERENCES `celestial_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_celestial_body_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `celestial_body_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `celestial_body_comment` ;

CREATE TABLE IF NOT EXISTS `celestial_body_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` TEXT NOT NULL,
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `celestial_body_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comment_User_idx` (`user_id` ASC),
  INDEX `fk_comment_celestial_body1_idx` (`celestial_body_id` ASC),
  INDEX `fk_celestial_body_comment_celestial_body_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_Comment_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_celestial_body1`
    FOREIGN KEY (`celestial_body_id`)
    REFERENCES `celestial_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_celestial_body_comment_celestial_body_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `celestial_body_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(250) NULL,
  `address` VARCHAR(250) NULL,
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  `zip_code` VARCHAR(25) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `encounter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `encounter` ;

CREATE TABLE IF NOT EXISTS `encounter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(250) NOT NULL,
  `description` TEXT NOT NULL,
  `behavior` TEXT NOT NULL,
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `encounter_date` DATE NOT NULL,
  `encounter_time` TIME NULL,
  `capture_method` TEXT NULL,
  `user_id` INT NOT NULL,
  `celestial_body_id` INT NOT NULL,
  `location_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Encounter_User1_idx` (`user_id` ASC),
  INDEX `fk_encounter_celestial_body1_idx` (`celestial_body_id` ASC),
  INDEX `fk_encounter_location1_idx` (`location_id` ASC),
  CONSTRAINT `fk_Encounter_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_encounter_celestial_body1`
    FOREIGN KEY (`celestial_body_id`)
    REFERENCES `celestial_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_encounter_location1`
    FOREIGN KEY (`location_id`)
    REFERENCES `location` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `user_id` INT NOT NULL,
  `encounter_id` INT NOT NULL,
  `rating_value` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  INDEX `fk_rating_user1_idx` (`user_id` ASC),
  PRIMARY KEY (`user_id`, `encounter_id`),
  INDEX `fk_rating_encounter1_idx` (`encounter_id` ASC),
  CONSTRAINT `fk_rating_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rating_encounter1`
    FOREIGN KEY (`encounter_id`)
    REFERENCES `encounter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `encounter_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `encounter_comment` ;

CREATE TABLE IF NOT EXISTS `encounter_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `body` TEXT NOT NULL,
  `enabled` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `encounter_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comment_User_idx` (`user_id` ASC),
  INDEX `fk_encounter_comment_encounter1_idx` (`encounter_id` ASC),
  INDEX `fk_encounter_comment_encounter_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_Comment_User0`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_encounter_comment_encounter1`
    FOREIGN KEY (`encounter_id`)
    REFERENCES `encounter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_encounter_comment_encounter_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `encounter_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `encounter_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `encounter_image` ;

CREATE TABLE IF NOT EXISTS `encounter_image` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `image_url` VARCHAR(2000) NOT NULL,
  `encounter_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_encounter_image_encounter1_idx` (`encounter_id` ASC),
  CONSTRAINT `fk_encounter_image_encounter1`
    FOREIGN KEY (`encounter_id`)
    REFERENCES `encounter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_favorited_encounter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_favorited_encounter` ;

CREATE TABLE IF NOT EXISTS `user_favorited_encounter` (
  `user_id` INT NOT NULL,
  `encounter_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `encounter_id`),
  INDEX `fk_user_has_encounter_encounter1_idx` (`encounter_id` ASC),
  INDEX `fk_user_has_encounter_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_encounter_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_encounter_encounter1`
    FOREIGN KEY (`encounter_id`)
    REFERENCES `encounter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (1, 'admin', '1234', 1, '2023-05-18', '2023-05-19', 'ADMIN', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `classification`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `classification` (`id`, `name`) VALUES (1, 'Nebula');
INSERT INTO `classification` (`id`, `name`) VALUES (2, 'Solar System');
INSERT INTO `classification` (`id`, `name`) VALUES (3, 'Star');
INSERT INTO `classification` (`id`, `name`) VALUES (4, 'Planet');
INSERT INTO `classification` (`id`, `name`) VALUES (5, 'Comet');
INSERT INTO `classification` (`id`, `name`) VALUES (6, 'Asteroid');

COMMIT;


-- -----------------------------------------------------
-- Data for table `category`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (1, 'Emission', 1);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (2, 'Planetary', 1);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (3, 'Supernova Remnant', 1);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (4, 'Dark', 1);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (5, 'Ordered', 2);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (6, 'Anti-Ordered', 2);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (7, 'Mixed', 2);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (8, 'Similar', 2);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (9, 'Neutron', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (10, 'Red Dwarf', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (11, 'Brown Drawf', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (12, 'White Dwarf', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (13, 'Yellow Dwarf', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (14, 'Red Giant', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (15, 'Proto', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (16, 'Pulsar', 3);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (17, 'Rocky', 4);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (18, 'Gas', 4);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (19, 'Ice', 4);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (20, 'Minor', 4);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (21, 'Periodic', 5);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (22, 'Non-Periodic', 5);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (23, 'Non-Orbit', 5);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (24, 'Lost', 5);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (25, 'Carbon', 6);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (26, 'Metallic', 6);
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (27, 'Silicon', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `celestial_body`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (1, 'Messier-16 (Eagle)', '2023-05-19', 1, NULL, 'open-cluster of stars in the constellation Serpens. Discovered in 1745.', 'https://cdn.spacetelescope.org/archives/images/screen/opo9544b.jpg', NULL, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `celestial_body_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (1, 'I hope you\'ll like this super neat picture I found!', 1, '2023-05-19', NULL, 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (1, NULL, '123 Protect Yourself Way', 'Puhlease', 'NO', 'USA', '90210');

COMMIT;


-- -----------------------------------------------------
-- Data for table `encounter`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (1, 'Eagle Sighting!', 'It was a glowing and colorful night. Who could resist some telescope time? Lucky idea since I captured this boss image.', 'I caught it spitting out baby stars!', 1, '2023-05-19', NULL, '2023-05-18', NULL, 'QHY 5III585C Planetary Camera and Guider', 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (1, 1, 5, '2023-05-19', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `encounter_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `encounter_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `encounter_id`, `in_reply_to_id`) VALUES (1, 'Why hasn\'t anyone commented yet about how amazing my photo is?', 1, '2023-05-19', NULL, 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `encounter_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (1, 'http://cs.astronomy.com/cfs-file.ashx/__key/telligent-evolution-components-attachments/13-59-00-00-00-49-12-35/M16-_2D00_-SHO_2D00_RGB.jpg', 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_favorited_encounter`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `user_favorited_encounter` (`user_id`, `encounter_id`) VALUES (1, 1);

COMMIT;

