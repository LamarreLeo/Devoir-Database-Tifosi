-- -----------------------------------------------------
-- BASE DE DONNÉES TIFOSI
-- Script de création du schéma et de l'utilisateur
-- -----------------------------------------------------
-- Description : Création de la base de données pour le restaurant Tifosi
--               incluant les tables, contraintes et utilisateur d'administration.
--               La majeur partie du code a été générée par le programme MySQL Workbench.
-- -----------------------------------------------------

-- -----------------------------------------------------
-- SAUVEGARDE DES PARAMÈTRES MYSQL
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- CRÉATION DE LA BASE DE DONNÉES
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS tifosi;
CREATE SCHEMA IF NOT EXISTS tifosi DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE tifosi;

-- -----------------------------------------------------
-- CRÉATION DE L'UTILISATEUR TIFOSI
-- -----------------------------------------------------
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi2025!';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES; 

-- -----------------------------------------------------
-- CRÉATION DES TABLES
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `tifosi`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`client` (
    `id_client` INT NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `email` VARCHAR(150) NOT NULL,
    `code_postal` INT NOT NULL,
    PRIMARY KEY (`id_client`),
    UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`focaccia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`focaccia` (
    `id_focaccia` INT NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `prix` DECIMAL(5,2) NOT NULL,
    PRIMARY KEY (`id_focaccia`),
    UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`menu` (
    `id_menu` INT NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `prix` DECIMAL(5,2) NOT NULL,
    `id_focaccia` INT NOT NULL,
    PRIMARY KEY (`id_menu`),
    UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE,
    INDEX `fk_menu_foccacia_idx` (`id_focaccia` ASC) VISIBLE,
    CONSTRAINT `fk_menu_foccacia`
        FOREIGN KEY (`id_focaccia`)
        REFERENCES `tifosi`.`focaccia` (`id_focaccia`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`achete`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`achete` (
    `id_client` INT NOT NULL,
    `id_menu` INT NOT NULL,
    `date_achat` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_client`, `id_menu`, `date_achat`),
    INDEX `fk_achete_menu_idx` (`id_menu` ASC) VISIBLE,
    CONSTRAINT `fk_achete_client`
        FOREIGN KEY (`id_client`)
        REFERENCES `tifosi`.`client` (`id_client`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_achete_menu`
        FOREIGN KEY (`id_menu`)
        REFERENCES `tifosi`.`menu` (`id_menu`)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`marque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`marque` (
    `id_marque` INT NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id_marque`),
    UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`boisson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`boisson` (
    `id_boisson` INT NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    `id_marque` INT NOT NULL,
    PRIMARY KEY (`id_boisson`),
    INDEX `fk_boisson_marque_idx` (`id_marque` ASC) VISIBLE,
    CONSTRAINT `fk_boisson_marque`
        FOREIGN KEY (`id_marque`)
        REFERENCES `tifosi`.`marque` (`id_marque`)
        ON DELETE RESTRICT
        ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`ingredient` (
    `id_ingredient` INT NOT NULL AUTO_INCREMENT,
    `nom` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id_ingredient`),
    UNIQUE INDEX `nom_UNIQUE` (`nom` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`comprend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`comprend` (
    `id_focaccia` INT NOT NULL,
    `id_ingredient` INT NOT NULL,
    `quantite` INT NOT NULL,
    PRIMARY KEY (`id_focaccia`, `id_ingredient`),
    INDEX `fk_comprend_ingredient_idx` (`id_ingredient` ASC) VISIBLE,
    CONSTRAINT `fk_comprend_focaccia`
        FOREIGN KEY (`id_focaccia`)
        REFERENCES `tifosi`.`focaccia` (`id_focaccia`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_comprend_ingredient`
        FOREIGN KEY (`id_ingredient`)
        REFERENCES `tifosi`.`ingredient` (`id_ingredient`)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `tifosi`.`contient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tifosi`.`contient` (
    `id_menu` INT NOT NULL,
    `id_boisson` INT NOT NULL,
    PRIMARY KEY (`id_menu`, `id_boisson`),
    INDEX `fk_contient_boisson_idx` (`id_boisson` ASC) VISIBLE,
    CONSTRAINT `fk_contient_boisson`
        FOREIGN KEY (`id_boisson`)
        REFERENCES `tifosi`.`boisson` (`id_boisson`)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT `fk_contient_menu`
        FOREIGN KEY (`id_menu`)
        REFERENCES `tifosi`.`menu` (`id_menu`)
        ON DELETE CASCADE
        ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- RESTAURATION DES PARAMÈTRES MYSQL
-- -----------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;