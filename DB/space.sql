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
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (1, 'admin', '3%^bGD7cz', 1, '2023-05-18', '2023-05-19', 'ADMIN', NULL, NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (2, 'usagi_seramun', 'h6dfYDf(%', 1, '2023-05-22', NULL, 'USER', 'https://images2.fanpop.com/images/photos/2900000/Sailor-Moon-sailor-moon-2949296-1024-768.jpg', 'Protecting Earth with my Sailor Guardians and Luna. Sharing what I see along the way.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (3, 'AstroJets', '2&%D45nfg3', 1, '2023-05-22', NULL, 'USER', 'https://static.wikia.nocookie.net/thejetsons/images/8/8f/Astro_from_The_Jetsons1.jpg', 'I have a stellar view from my treadmill at the Jetsons\' crib.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (4, 'solrock', '453HD6d09', 1, '2023-05-22', NULL, 'USER', 'https://img.pokemondb.net/artwork/large/solrock.jpg', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (5, 'NicCopernicus', 'X74cdL4gd$', 1, '2023-05-22', NULL, 'USER', 'https://cdn.britannica.com/s:690x388,c:crop/83/74283-050-B94F541D/Nicolaus-Copernicus.jpg', 'Get over yourself. Look out to the sky. The universe doesn\'t revolve around you, after all.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (6, 'dottieVaughn', 'sFS^$bs%#', 1, '2023-05-22', NULL, 'USER', 'https://images.newscientist.com/wp-content/uploads/2017/01/20115302/young-dorothy-vaughan.jpg', 'Computing since before my pet \"business machine\" came to NASA. Sending astronauts into orbit along the way.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (7, 'galileo64', '@$g73wZc', 1, '2023-05-22', NULL, 'USER', 'https://miro.medium.com/v2/resize:fit:4800/format:webp/1*XmTUmo5asGFVNQ-y1DkePw.jpeg', NULL);
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (8, 'shawking', 'xgSG*5sfAS', 1, '2023-05-22', NULL, 'USER', 'https://cdn.mos.cms.futurecdn.net/RrYtmYe8zwRQdSvC8kgio4-1200-80.jpg', 'What begins must end.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (9, 'NeildGTHarvard94', 'A%$#xsea%', 1, '2023-05-22', NULL, 'USER', 'https://en.wikipedia.org/wiki/Nova_ScienceNow#/media/File:NovaScienceNow.jpg', 'Cosmos explorer. Space communicator.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (10, 'tribble', '5d%%DGs323', 1, '2023-05-22', NULL, 'USER', 'https://upload.wikimedia.org/wikipedia/en/5/50/ST_TroubleWithTribbles.jpg', 'We\'re no trouble. Check out our view from  Iota Geminorum IV.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (11, 'DarthMuffinTop', '1234', 1, '2023-05-25', NULL, 'USER', 'http://pre14.deviantart.net/b219/th/pre/i/2014/077/0/a/darth_vader_by_ephebopus365-d7apejw.jpg', 'stuff and things');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (12, 'joseph', '1234', 1, '2023-05-25', NULL, 'USER', 'https://cdni.rbth.com/rbthmedia/images/2020.10/original/5f7b34a315e9f946b1535491.jpg', 'I like space, but I\'m a noob. Be nice.');
INSERT INTO `user` (`id`, `username`, `password`, `enabled`, `created_at`, `updated_at`, `role`, `image_url`, `about`) VALUES (13, 'kris', '1234', 1, '2023-05-25', NULL, 'USER', 'https://clipground.com/images/animal-astronaut-clipart-5.jpg', 'Space cowgirl. Basically an astronaut ...');

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
INSERT INTO `category` (`id`, `name`, `classification_id`) VALUES (28, 'Binary', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `celestial_body`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (1, 'Messier 16 (Eagle)', '2023-05-19', 1, '2023-05-22', 'Open-cluster of stars in the constellation Serpens. Discovered in 1745. AKA Star Queen Nebula.', 'https://cdn.spacetelescope.org/archives/images/screen/opo9544b.jpg', 'https://stellarium-web.org/skysource/EagleNebula', 1, NULL);
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (2, 'Alpha Canis Majoris (Sirius)', '2023-05-22', 1, NULL, 'Brightest star in the night sky. AKA Dog Star.', 'https://cdn.mos.cms.futurecdn.net/uxdsce4CMFwqPDRKEKvbX4-1920-80.jpeg', 'https://stellarium-web.org/skysource/Sirius', 28, NULL);
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (3, 'Solar System', '2023-05-22', 1, NULL, 'Planetary system home to Earth.', 'https://www.britannica.com/explore/space/wp-content/uploads/sites/5/2019/05/solar-system-hero.jpg', 'https://stellarium-web.org/', 5, NULL);
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (4, '19 Fortuna (A852 QA)', '2023-05-22', 1, NULL, 'Large main-belt asteroid between Mars and Jupiter. Orbits the Sun every 1,390 days.', 'http://1.bp.blogspot.com/-rN3Yz4azC7c/VhvWrm2y_VI/AAAAAAABWiA/yNJudvpIPCg/s640/Asteroid-2.jpg', 'https://stellarium-web.org/skysource/Fortuna', 25, 3);
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (5, 'Ceres', '2023-05-22', 1, NULL, 'Dwarf planet - the first one visited by spacecraft. Largest object in the asteroid belt. Discovered in 1801.', 'https://static.wikia.nocookie.net/terraforming/images/2/24/Ceres.png', 'https://stellarium-web.org/skysource/Ceres', 20, 3);
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (6, 'Mars', '2023-05-22', 1, NULL, 'Fourth planet from the Sun. Farthest terrestrial planet, formed 4.5 billion years ago.', 'https://static.scientificamerican.com/sciam/cache/file/67256189-61A5-402D-8C9FA043722F4B4D_source.jpg', 'https://stellarium-web.org/skysource/Mars', 17, 3);
INSERT INTO `celestial_body` (`id`, `name`, `created_at`, `enabled`, `updated_at`, `description`, `image_url`, `tracking_url`, `category_id`, `parent_celestial_body_id`) VALUES (7, 'Halley (1P/Halley)', '2023-05-22', 1, NULL, 'Short-period comet that can be seen from Earth every 75-79 years. ', 'https://upload.wikimedia.org/wikipedia/commons/5/55/Halley%27s_Comet%2C_1910.JPG', 'https://stellarium-web.org/skysource/Halley', 21, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `celestial_body_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (1, 'I really dig this. It looks likes towers out in space.', 1, '2023-05-19', NULL, 1, 1, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (2, 'We barely understood this star factory before the Hubble captured images in the \'90s - wild.', 1, '2023-05-20', NULL, 4, 1, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (3, 'The Pillars of Creation alway amaze me.', 1, '2023-05-22', NULL, 7, 1, 1);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (4, 'Agreed! It\'s fascinating.', 1, '2023-05-22', NULL, 5, 1, 1);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (5, 'Do you think the satellit radio station was named for this star?', 1, '2023-05-20', NULL, 3, 2, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (6, 'Duh, Astro.', 1, '2023-05-20', NULL, 11, 2, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (7, 'I\'ve read that it can change colors as it flickers, one of its nicknames is the rainbow star.', 1, '2023-05-24', NULL, 2, 2, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (8, 'Isn\'t it bizarre that our solar system is simply called THE Solar System?', 1, '2023-05-22', NULL, 6, 3, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (9, 'Not really. Same for our moon and sun, even though there are lots more of each out there. Naming evolved as out understanding of the universe grew. ', 1, '2023-05-23', NULL, 8, 3, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (10, 'Interesting that it\'s an asteroid, but an asteroid is still a minor planet. So it gets a minor planet designation. I\'m still figuring this all out. ', 1, '2023-05-25', NULL, 13, 4, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (11, 'Hey! For south atlantic people, tonight: 19 Fortuna is visible between 22:30 and 04:08. It will become accessible around 22:30, when it rises to an altitude of 21° above your south-eastern horizon.', 1, '2023-05-25', NULL, 12, 4, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (12, 'Oh, I will be checking it out for sure. Thanks, Joe.', 1, '2023-05-25', NULL, 9, 4, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (13, 'Who\'s read about the NASA Dawn craft and its findings for Ceres? Surface is a mixture of water, ice, and minerals.', 1, '2023-05-19', NULL, 10, 5, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (14, 'Neil, apparently it has \"brines\" instead of oceans!', 1, '2023-05-20', NULL, 5, 5, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (15, 'Ceres is always inside Neptune\'s orbit ... whoa.', 1, '2023-05-23', NULL, 1, 5, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (16, 'In 2014 it was observed to produce an exosphere. Prior to that we thought a dwarf planet couldn\'t.', 1, '2023-05-24', NULL, 4, 5, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (17, 'A year over there is 687 Earth Days. So when we colonize, birthdays will be half as frequent.', 1, '2023-05-20', NULL, 6, 6, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (18, 'Fourth rock from the Sun!', 1, '2023-05-22', NULL, 7, 6, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (19, 'I always think of Mars as being huge, but it\'s the second-smallest planet in our solar system.', 1, '2023-05-22', NULL, 9, 6, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (20, 'And our next door neighbor, Gali ;-)', 1, '2023-05-23', NULL, 12, 6, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (21, 'Life on Mars? We might know soon. https://www.jpl.nasa.gov/news/signs-of-life-on-mars-nasas-perseverance-rover-begins-the-hunt', 1, '2023-05-24', NULL, 11, 6, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (22, 'Neil, six Mars could fit inside Earth\'s volume.', 1, '2023-05-25', NULL, 3, 6, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (23, 'Every year twice a year when it moves into the inner solar system, it causes meteor showers.', 1, '2023-05-19', NULL, 5, 7, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (24, 'I\'m always confused whether it\'s Halley comet or Halley\'s comet.', 1, '2023-05-21', NULL, 8, 7, NULL);
INSERT INTO `celestial_body_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `celestial_body_id`, `in_reply_to_id`) VALUES (25, 'The closest it\'s been to Earth was 3 million miiles away, and when that happened it was almost as brilliant as Venus from our perspective.', 1, '2023-05-24', NULL, 10, 7, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `location`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (1, NULL, '123 Protect Yourself Way', 'Puhlease', 'NO', 'USA', '90210');
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (2, 'McDonald Observatory', '3640 Dark Sky Drive', 'McDonald Observatory', 'TX', 'USA', '79734');
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (3, 'James Webb Space Telescope', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (4, 'International Space Station', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (5, 'Griffith Observatory', '2800 East Observatory Road', 'Los Angeles', 'CA', 'USA', '90027');
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (6, '', '595 Sesame Ave', 'Secret', 'NV', 'USA', '86753');
INSERT INTO `location` (`id`, `name`, `address`, `city`, `state`, `country`, `zip_code`) VALUES (7, 'Royal Observatory Greenwich', 'Blackheath Ave', 'London', 'FXGX+PQ', 'UK', 'SE10 8XJ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `encounter`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (1, 'Eagle Sighting!', 'It was a glowing and colorful night. Lucky idea to look into the telescope since I captured this image.', 'I caught it spitting out baby stars!', 1, '2023-05-19', NULL, '2023-05-18', '02:38', 'QHY 5III585C Planetary Camera and Guider', 12, 1, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (2, 'Latest JWST Images', 'I didn\'t capture these myself, but you can clearly see The Pillars.', 'The infrared from JWST is showing the birth of stars that have since died.', 1, '2023-05-20', NULL, '2023-01-12', NULL, 'James Webb Space Telescope', 4, 1, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (3, 'Nebulous', 'It had a reddish tint which seemed unusual.', 'It\'s as if it\'s illuminated within.', 1, '2023-05-22', NULL, '2023-05-20', NULL, 'Celestron NexStar 4SE', 1, 1, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (4, 'Dominating the Night Sky', 'It was the brightest among the sea of stars.', 'It appeared to change color from orange to red.', 1, '2023-05-22', NULL, '2023-05-19', '02:14', 'Camera-only: Leica SL2', 3, 2, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (5, 'Rainbow Star', 'It appeared red when I viewed it a few nights ago.', 'It stands out among the other stars for sure.', 1, '2023-05-24', NULL, '2023-05-21', '22:35', 'Sky-Watcher Skymax 127 SynScan', 11, 2, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (6, 'Charts', 'Star charts, mostly.', 'Mostly we cannot observe the tail in these images.', 1, '2023-05-22', NULL, '2023-05-20', NULL, 'Unistellar eQuinox 2', 10, 4, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (7, 'Dawn Images', 'The bright spot is the Occator Crater.', 'The coloration indicates the surface composition.', 1, '2023-05-19', NULL, '2014-03-14', NULL, 'Vaonis Vespera', 9, 5, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (8, 'Good views of the complete body.', 'Spherical form with visible surface craters.', 'Relatively static.', 1, '2023-05-20', NULL, '2023-05-23', NULL, 'Sky-Watcher Explorer 130 EQ2', 7, 5, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (9, 'Colorful Capture', 'The body was red, but it had a blue tinge about its outline.', 'The atmosphere appeared hazy.', 1, '2023-05-18', NULL, '2023-05-16', '04:15', 'Celestron Inspire 100AZ', 4, 6, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (10, 'Surface Textures', 'You can sense the surface topography.', 'I used specific filters to penetrate the haze of the atmosphere.', 1, '2023-05-20', NULL, '2023-05-20', '05:17', 'Orion Skyline 6-inch Dobsonian Reflector Telescope', 8, 6, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (11, 'Rover Images', 'Here are shots from the rover.', 'The dry, irregular terrain is apparent.', 1, '2023-05-21', NULL, '2023-05-19', NULL, 'Unistellar eQuinox 2', 3, 6, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (12, 'Red Planet', 'The color is vivid.', 'Storms are visible.', 1, '2023-05-21', NULL, '2023-05-20', NULL, 'Coronado Personal Solar Telescope', 5, 6, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (13, 'Amid the Milky Way', 'Smaller scale for context.', 'The motion creates the contrast amid the asteroid belt.', 1, '2023-05-23', NULL, '2023-05-14', NULL, 'Meade 8\" f/10 LX90 ACF Telescope with Field Tripod Meade 8\" f/10 LX90 ACF Telescope with Field Tripod', 6, 7, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (14, 'Vibrant', 'Mid-range captures, form appears quite spherical.', 'The illumination trail fans out.', 1, '2023-05-23', NULL, '2023-05-22', '06:22', 'Orion StarBlast II 4.5 EQ', 2, 7, NULL);
INSERT INTO `encounter` (`id`, `title`, `description`, `behavior`, `enabled`, `created_at`, `updated_at`, `encounter_date`, `encounter_time`, `capture_method`, `user_id`, `celestial_body_id`, `location_id`) VALUES (15, 'Fiery motion', 'This is highly magnified.', 'The colors of the tail alludes to its high velocity.', 1, '2023-05-25', NULL, '2023-05-25', NULL, 'Celestron Omni XLT 102', 13, 7, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `rating`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (1, 1, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (5, 1, 3, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (9, 1, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (6, 2, 1, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (4, 2, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (3, 2, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (1, 3, 2, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (2, 3, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (3, 3, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (4, 5, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (5, 5, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (6, 5, 1, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (7, 6, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (8, 6, 3, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (9, 7, 2, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (10, 7, 3, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (11, 7, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (12, 8, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (13, 8, 2, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (1, 8, 1, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (2, 9, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (3, 9, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (4, 10, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (5, 11, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (6, 11, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (7, 12, 1, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (8, 12, 4, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (9, 12, 2, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (10, 13, 2, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (11, 13, 3, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (12, 14, 2, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (13, 15, 1, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (1, 15, 5, '2023-05-26', NULL);
INSERT INTO `rating` (`user_id`, `encounter_id`, `rating_value`, `created_at`, `updated_at`) VALUES (2, 15, 5, '2023-05-26', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `encounter_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `encounter_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `encounter_id`, `in_reply_to_id`) VALUES (1, 'Why hasn\'t anyone commented yet about how amazing my photo is?', 1, '2023-05-19', NULL, 1, 1, NULL);
INSERT INTO `encounter_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `encounter_id`, `in_reply_to_id`) VALUES (2, 'It\'s a rad image, for sure! Thanks for posting.', 1, '2023-05-20', NULL, 6, 1, 1);
INSERT INTO `encounter_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `encounter_id`, `in_reply_to_id`) VALUES (3, 'I\'m so happy every time I spot Sirius. Leica is a sick camera, makes me not want to share my phone images.', 1, '2023-05-22', NULL, 3, 2, NULL);
INSERT INTO `encounter_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `encounter_id`, `in_reply_to_id`) VALUES (4, 'Same - last I was on the road, listening to my satellite radio of a similar name.', 1, '2023-05-22', NULL, 2, 2, 3);
INSERT INTO `encounter_comment` (`id`, `body`, `enabled`, `created_at`, `updated_at`, `user_id`, `encounter_id`, `in_reply_to_id`) VALUES (5, 'Good thing that YOU didn\'t try to take a picture.', 1, '2023-05-22', NULL, 9, 2, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `encounter_image`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (1, 'http://cs.astronomy.com/cfs-file.ashx/__key/telligent-evolution-components-attachments/13-59-00-00-00-49-12-35/M16-_2D00_-SHO_2D00_RGB.jpg', 1);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (2, 'https://i.pinimg.com/originals/62/37/36/623736b9d363314111a4e525434275d9.jpg', 2);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (3, 'https://images.hdqwalls.com/wallpapers/eagle-nebula-s3.jpg', 2);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (4, 'https://visibledark.ca/wp-content/uploads/2016/01/M16-Eagle-Nebula.jpg', 3);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (5, 'https://upload.wikimedia.org/wikipedia/commons/c/c6/Sirius.jpg', 4);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (6, 'https://upload.wikimedia.org/wikipedia/commons/b/b1/Hubble_heic0206j.jpg', 4);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (7, 'https://stargazerslounge.com/uploads/monthly_2016_02/56d2ef3d147a3_siriuscloseup.png.d98853e0b6291409e9d129597815d9e1.png', 4);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (8, 'https://i.pinimg.com/736x/4c/35/6f/4c356f4c584293ce80adc1bfabc79a89.jpg', 5);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (9, 'https://static.spektrum.de/fm/1027/f2000/M1%20mit%20TMB%20105_910%20SuW.jpg', 6);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (10, 'https://static.independent.co.uk/s3fs-public/thumbnails/image/2019/12/20/11/asteroid.jpeg', 6);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (11, 'http://www.richweb.f9.co.uk/astro/images/MPL_19_Fortuna.20050930.im95101-03.av3x60s.C.neg.an.jpg', 6);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (12, 'https://asteroidoccultation.com/2023_06/0610_19_80992_Map.gif', 6);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (13, 'http://www.illustratedcuriosity.com/files/media/35880/image_3503_1e-Ceres-Bright-Spots.jpg', 7);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (14, 'https://www.universetoday.com/wp-content/uploads/2016/03/Ceres-GRand-neutron-ice-1024x722.jpg', 7);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (15, 'https://cdn.mos.cms.futurecdn.net/7yojSnrjnEZHoXtA2XLHxF.jpg', 8);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (16, 'https://truththeory.com/wp-content/uploads/2020/08/3d-Rendering-Dwarf-Planet-Ceres-900x720.jpg', 8);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (17, 'https://www.universetoday.com/wp-content/uploads/2016/03/Ceres-Occator-color-tight-1024x687.jpg', 7);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (18, 'http://cdn.spacetelescope.org/archives/images/screen/opo9715c4.jpg', 9);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (19, 'https://nssdc.gsfc.nasa.gov/image/planetary/mars/marsglobe3.jpg', 10);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (20, 'https://pixelz.cc/wp-content/uploads/2017/11/hubble-telescope-pictures-of-mars-surface-uhd-4k-wallpaper.jpg', 10);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (21, 'https://www.nasa.gov/sites/default/files/pia17760_ss1.jpg', 11);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (22, 'https://scx2.b-cdn.net/gfx/news/hires/2015/5672f340db86f.jpg', 11);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (23, 'https://cdn.mos.cms.futurecdn.net/L3HYK4hkM2gUTjBQbBMVkG-1200-80.jpg', 11);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (24, 'https://apod.nasa.gov/apod/image/0605/bumpyboulder_spirit_big.jpg', 11);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (25, 'https://3dprint.com/wp-content/uploads/2015/08/marstotal.jpg', 12);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (26, 'https://cdn.eso.org/images/large/comethalley-21mar198.jpg', 13);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (27, 'https://endtimeheadlines.org/wp-content/uploads/2019/10/shutterstock_1234048213.jpg', 14);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (28, 'http://3.bp.blogspot.com/-n9kLJooTd-c/VO7e0SD5u3I/AAAAAAABKDk/IMEM2_QBFcU/s1600/halleys%2B1986.jpg', 14);
INSERT INTO `encounter_image` (`id`, `image_url`, `encounter_id`) VALUES (29, 'https://cropper.watch.aetnd.com/cdn.watch.aetnd.com/sites/2/2018/05/GettyImages-455493-001.jpg', 15);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_favorited_encounter`
-- -----------------------------------------------------
START TRANSACTION;
USE `spacedb`;
INSERT INTO `user_favorited_encounter` (`user_id`, `encounter_id`) VALUES (1, 1);
INSERT INTO `user_favorited_encounter` (`user_id`, `encounter_id`) VALUES (8, 1);
INSERT INTO `user_favorited_encounter` (`user_id`, `encounter_id`) VALUES (4, 2);

COMMIT;

