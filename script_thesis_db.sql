-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema thesis_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema thesis_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `thesis_db` DEFAULT CHARACTER SET utf8 ;
USE `thesis_db` ;

-- -----------------------------------------------------
-- Table `thesis_db`.`basic_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`basic_details` (
  `tag` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `address` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `employment_status` ENUM("Yes", "No") NULL,
  `employment_info` TEXT NULL,
  `annual_income_range` VARCHAR(45) NULL,
  `income_source` VARCHAR(45) NULL,
  `religion` TEXT NULL,
  `political_ideology` VARCHAR(45) NULL,
  `caste` TEXT NULL,
  PRIMARY KEY (`tag`),
  UNIQUE INDEX `tag_UNIQUE` (`tag` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thesis_db`.`lda_topic_model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`lda_topic_model` (
  `topic_id` INT NOT NULL,
  `topic_name` VARCHAR(45) NULL,
  `topic_analysis` TEXT NULL,
  PRIMARY KEY (`topic_id`),
  UNIQUE INDEX `topic_id_UNIQUE` (`topic_id` ASC) VISIBLE,
  UNIQUE INDEX `topic_name_UNIQUE` (`topic_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thesis_db`.`transcript_analysis`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`transcript_analysis` (
  `ptag_transcript` VARCHAR(45) NOT NULL,
  `top_topic_id` INT NOT NULL,
  `top_topic_name` TEXT NULL,
  `top_word` VARCHAR(45) NULL,
  `top_word_freq` SMALLINT NULL,
  `sentiment_polarity` FLOAT NULL,
  `sentiment_subjectivity` FLOAT NULL,
  PRIMARY KEY (`ptag_transcript`),
  UNIQUE INDEX `person_tag_UNIQUE` (`ptag_transcript` ASC) VISIBLE,
  INDEX `top topic_idx` (`top_topic_id` ASC) VISIBLE,
  CONSTRAINT `person_tag`
    FOREIGN KEY (`ptag_transcript`)
    REFERENCES `thesis_db`.`basic_details` (`tag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `topTopic`
    FOREIGN KEY (`top_topic_id`)
    REFERENCES `thesis_db`.`lda_topic_model` (`topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thesis_db`.`vipassana_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`vipassana_details` (
  `ptag_vip` VARCHAR(45) NOT NULL,
  `vipassana_first_attended` VARCHAR(45) NULL,
  `vipassana_motivation` TEXT NULL,
  `oneday_vip_courses` VARCHAR(45) NULL,
  `location_vip_course` VARCHAR(45) NULL,
  `primary_language` VARCHAR(45) NULL,
  `service_in_vip` VARCHAR(45) NULL,
  `obj_before_vip` INT NULL,
  `obj_after_vip` INT NULL,
  `awareness_before_vip` INT NULL,
  `awareness_after_vip` INT NULL,
  `attachment_before_vip` INT NULL,
  `attachment_after_vip` INT NULL,
  `empathy_before_vip` INT NULL,
  `empathy_after_vip` INT NULL,
  `positive_affect_vip` INT NULL,
  `negative_affect_vip` INT NULL,
  `maitri_before_vip` INT NULL,
  `maitri_after_vip` INT NULL,
  PRIMARY KEY (`ptag_vip`),
  UNIQUE INDEX `person_tag_UNIQUE` (`ptag_vip` ASC) VISIBLE,
  CONSTRAINT `person tag`
    FOREIGN KEY (`ptag_vip`)
    REFERENCES `thesis_db`.`basic_details` (`tag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thesis_db`.`ner_freq`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`ner_freq` (
  `ptag_ner` VARCHAR(45) NOT NULL,
  `org` INT NULL,
  `date` INT NULL,
  `person` INT NULL,
  `cardinal` INT NULL,
  `gpe` INT NULL,
  `ordinal` INT NULL,
  PRIMARY KEY (`ptag_ner`),
  UNIQUE INDEX `person_tag_UNIQUE` (`ptag_ner` ASC) VISIBLE,
  CONSTRAINT `person_tag_fk`
    FOREIGN KEY (`ptag_ner`)
    REFERENCES `thesis_db`.`basic_details` (`tag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thesis_db`.`word_weight_pairs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`word_weight_pairs` (
  `ptag_wwpairs` VARCHAR(45) NOT NULL,
  `dominant_topic_id` INT NULL,
  `word` VARCHAR(45) NULL,
  `weight` DECIMAL(3) NULL,
  PRIMARY KEY (`ptag_wwpairs`),
  INDEX `domTopic_idx` (`dominant_topic_id` ASC) VISIBLE,
  CONSTRAINT `ptag`
    FOREIGN KEY (`ptag_wwpairs`)
    REFERENCES `thesis_db`.`basic_details` (`tag`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `domTopic`
    FOREIGN KEY (`dominant_topic_id`)
    REFERENCES `thesis_db`.`lda_topic_model` (`topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `thesis_db`.`lda_topic_makeup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `thesis_db`.`lda_topic_makeup` (
  `lda_topic_id` INT NOT NULL,
  `lda_topic_keyword` VARCHAR(45) NULL,
  `kw_weight` DECIMAL(3) NULL,
  PRIMARY KEY (`lda_topic_id`),
  CONSTRAINT `topic id`
    FOREIGN KEY (`lda_topic_id`)
    REFERENCES `thesis_db`.`lda_topic_model` (`topic_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
