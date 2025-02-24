-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema baybayin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema baybayin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `baybayin` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `baybayin` ;

-- -----------------------------------------------------
-- Table `baybayin`.`chapter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`chapter` (
  `Chapter_ID` INT NOT NULL AUTO_INCREMENT,
  `Chapter_Number` TEXT NULL DEFAULT NULL,
  `Completion_Criteria` TEXT NULL DEFAULT NULL,
  `Chapter_Description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`Chapter_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`episode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`episode` (
  `Episode_ID` INT NOT NULL AUTO_INCREMENT,
  `Episode_Name` VARCHAR(100) NOT NULL,
  `Episode_Number` VARCHAR(100) NOT NULL,
  `Episode_Objective` TEXT NULL DEFAULT NULL,
  `Chapter_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Episode_ID`),
  INDEX `Chapter_ID` (`Chapter_ID` ASC) VISIBLE,
  CONSTRAINT `episode_ibfk_1`
    FOREIGN KEY (`Chapter_ID`)
    REFERENCES `baybayin`.`chapter` (`Chapter_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`batch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`batch` (
  `Batch_ID` INT NOT NULL AUTO_INCREMENT,
  `Batch_Name` VARCHAR(100) NOT NULL,
  `Batch_Number` VARCHAR(100) NOT NULL,
  `Batch_Description` TEXT NULL DEFAULT NULL,
  `Episode_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Batch_ID`),
  INDEX `Episode_ID` (`Episode_ID` ASC) VISIBLE,
  CONSTRAINT `batch_ibfk_1`
    FOREIGN KEY (`Episode_ID`)
    REFERENCES `baybayin`.`episode` (`Episode_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`activity` (
  `Activity_ID` INT NOT NULL AUTO_INCREMENT,
  `Activity_Name` VARCHAR(100) NULL DEFAULT NULL,
  `Activity_Type` VARCHAR(100) NULL DEFAULT NULL,
  `Batch_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Activity_ID`),
  INDEX `Batch_ID` (`Batch_ID` ASC) VISIBLE,
  CONSTRAINT `activity_ibfk_1`
    FOREIGN KEY (`Batch_ID`)
    REFERENCES `baybayin`.`batch` (`Batch_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`challenge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`challenge` (
  `Challenge_ID` INT NOT NULL AUTO_INCREMENT,
  `Challenge_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Challenge_Type` VARCHAR(45) NULL DEFAULT NULL,
  `Difficulty_Level` VARCHAR(45) NULL DEFAULT NULL,
  `Time_Limit` TIME NULL DEFAULT NULL,
  `Challenge_Reward` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Challenge_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`item_inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`item_inventory` (
  `Item_ID` INT NOT NULL AUTO_INCREMENT,
  `Item_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Description` VARCHAR(45) NULL DEFAULT NULL,
  `Price` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Item_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`users` (
  `User_ID` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(10) NOT NULL,
  `Password` VARCHAR(10) NOT NULL,
  `Authentication_status` VARCHAR(10) NULL DEFAULT NULL,
  `Avatar` INT NULL DEFAULT NULL,
  `Ingame_name` VARCHAR(10) NULL DEFAULT NULL,
  `in_game_currency` INT NULL DEFAULT NULL,
  `Owned_item` INT NULL DEFAULT NULL,
  `OTP_Verification_Status` INT NULL DEFAULT NULL,
  `Created_At` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`notification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`notification` (
  `Notification_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT NULL,
  `message_content` VARCHAR(45) NULL DEFAULT NULL,
  `status (read/unread)` TINYINT NULL DEFAULT NULL,
  `notification_type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Notification_ID`),
  INDEX `User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `notification_ibfk_1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `baybayin`.`users` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`practice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`practice` (
  `Practice_ID` INT NOT NULL AUTO_INCREMENT,
  `Practice_Name` VARCHAR(45) NULL DEFAULT NULL,
  `Practice_Type` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Practice_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`purchase_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`purchase_history` (
  `Purchase_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT NULL,
  `Item_ID` INT NULL DEFAULT NULL,
  `Purchased_Date` VARCHAR(45) NULL DEFAULT NULL,
  `Status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`Purchase_ID`),
  INDEX `Item_ID` (`Item_ID` ASC) VISIBLE,
  INDEX `User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `purchase_history_ibfk_1`
    FOREIGN KEY (`Item_ID`)
    REFERENCES `baybayin`.`item_inventory` (`Item_ID`),
  CONSTRAINT `purchase_history_ibfk_2`
    FOREIGN KEY (`User_ID`)
    REFERENCES `baybayin`.`users` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`question`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`question` (
  `Question_ID` INT NOT NULL AUTO_INCREMENT,
  `Question` TEXT NULL DEFAULT NULL,
  `Question_Type` VARCHAR(100) NULL DEFAULT NULL,
  `Answer` TEXT NULL DEFAULT NULL,
  `Answer_No.` INT NULL,
  `Activity_ID` INT NULL DEFAULT NULL,
  `Question_Reward` INT NULL,
  PRIMARY KEY (`Question_ID`),
  INDEX `Activity_ID` (`Activity_ID` ASC) VISIBLE,
  CONSTRAINT `question_ibfk_1`
    FOREIGN KEY (`Activity_ID`)
    REFERENCES `baybayin`.`activity` (`Activity_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`user_practice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`user_practice` (
  `User_Practice_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT NULL,
  `Practice_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`User_Practice_ID`),
  INDEX `Practice_ID` (`Practice_ID` ASC) VISIBLE,
  INDEX `User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `user_practice_ibfk_1`
    FOREIGN KEY (`Practice_ID`)
    REFERENCES `baybayin`.`practice` (`Practice_ID`),
  CONSTRAINT `user_practice_ibfk_2`
    FOREIGN KEY (`User_ID`)
    REFERENCES `baybayin`.`users` (`User_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`user_progress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`user_progress` (
  `User_Progress_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT NULL DEFAULT NULL,
  `Challenge_ID` INT NULL DEFAULT NULL,
  `Activity_ID` INT NULL DEFAULT NULL,
  `rewards_earned` VARCHAR(45) NULL DEFAULT NULL,
  `Score` VARCHAR(45) NULL DEFAULT NULL,
  `Completion_Status` VARCHAR(45) NULL DEFAULT NULL,
  `Timestamp` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`User_Progress_ID`),
  INDEX `User_ID` (`User_ID` ASC) VISIBLE,
  INDEX `Challenge_ID` (`Challenge_ID` ASC) VISIBLE,
  INDEX `Activity_ID` (`Activity_ID` ASC) VISIBLE,
  CONSTRAINT `user_progress_ibfk_1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `baybayin`.`users` (`User_ID`),
  CONSTRAINT `user_progress_ibfk_2`
    FOREIGN KEY (`Challenge_ID`)
    REFERENCES `baybayin`.`challenge` (`Challenge_ID`),
  CONSTRAINT `user_progress_ibfk_3`
    FOREIGN KEY (`Activity_ID`)
    REFERENCES `baybayin`.`activity` (`Activity_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `baybayin`.`answer_data`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `baybayin`.`answer_data` (
  `Answer_ID` INT NOT NULL AUTO_INCREMENT,
  `User_ID` INT NULL,
  `Activity_ID` INT NULL,
  `Challenge_ID` INT NULL,
  `Question_ID` INT NULL,
  `User_Answer` VARCHAR(45) NULL,
  `Is_Correct` VARCHAR(45) NULL,
    PRIMARY KEY (`Answer_ID`),
  INDEX `User_ID` (`User_ID` ASC) VISIBLE,
  CONSTRAINT `answer_data_ibfk_1`
    FOREIGN KEY (`User_ID`)
    REFERENCES `baybayin`.`users` (`User_ID`),
     INDEX `Challenge_ID` (`Challenge_ID` ASC) VISIBLE,
      CONSTRAINT `answer_data_ibfk_2`
     FOREIGN KEY (`Challenge_ID`)
    REFERENCES `baybayin`.`challenge` (`Challenge_ID`),
     INDEX `Activity_ID` (`Activity_ID` ASC) VISIBLE,
      CONSTRAINT `answer_data_ibfk_3`
  FOREIGN KEY (`Activity_ID`)
    REFERENCES `baybayin`.`activity` (`Activity_ID`),
      INDEX `Question_ID` (`Question_ID` ASC) VISIBLE,
       CONSTRAINT `answer_data_ibfk_4`
  FOREIGN KEY (`Question_ID`)
    REFERENCES `baybayin`.`question` (`Question_ID`))
  
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
