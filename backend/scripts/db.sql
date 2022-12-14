-- MySQL Script generated by MySQL Workbench
-- Fri Sep  9 00:53:05 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema todo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema todo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `todo` DEFAULT CHARACTER SET utf8 ;
USE `todo` ;

-- -----------------------------------------------------
-- Table `todo`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(210) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `todo`.`todo_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo`.`todo_list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(24) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_todo_user_idx` (`user_id` ASC) ,
  CONSTRAINT `fk_todo_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `todo`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `todo`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `todo`.`task` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `todo_id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `task_parent_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_table1_todo1_idx` (`todo_id` ASC) ,
  INDEX `fk_task_task1_idx` (`task_parent_id` ASC) ,
  CONSTRAINT `fk_table1_todo1`
    FOREIGN KEY (`todo_id`)
    REFERENCES `todo`.`todo_list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_task1`
    FOREIGN KEY (`task_parent_id`)
    REFERENCES `todo`.`task` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
