-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema clube_recreativo
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `clube_recreativo` ;

-- -----------------------------------------------------
-- Schema clube_recreativo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `clube_recreativo` DEFAULT CHARACTER SET utf8 ;
USE `clube_recreativo` ;

-- -----------------------------------------------------
-- Table `clube_recreativo`.`Pessoas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Pessoas` (
  `idPessoas` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Data_nascimento` DATE NOT NULL,
  PRIMARY KEY (`idPessoas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Plano_Assinatura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Plano_Assinatura` (
  `idPlano` INT NOT NULL AUTO_INCREMENT,
  `Nome_plano` VARCHAR(45) NOT NULL,
  `Valor_plano` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idPlano`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Socio_titular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Socio_titular` (
  `idTitular` INT NOT NULL AUTO_INCREMENT,
  `CPF` VARCHAR(14) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Plano_Assinatura_idPlano` INT NOT NULL,
  `Pessoas_idPessoas` INT NOT NULL,
  PRIMARY KEY (`idTitular`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_Socio_titular_Plano_Assinatura_idx` (`Plano_Assinatura_idPlano` ASC) VISIBLE,
  INDEX `fk_Socio_titular_Pessoas1_idx` (`Pessoas_idPessoas` ASC) VISIBLE,
  CONSTRAINT `fk_Socio_titular_Plano_Assinatura`
    FOREIGN KEY (`Plano_Assinatura_idPlano`)
    REFERENCES `clube_recreativo`.`Plano_Assinatura` (`idPlano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Socio_titular_Pessoas1`
    FOREIGN KEY (`Pessoas_idPessoas`)
    REFERENCES `clube_recreativo`.`Pessoas` (`idPessoas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Dependente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Dependente` (
  `idDependente` INT NOT NULL AUTO_INCREMENT,
  `Parentesco` VARCHAR(45) NOT NULL,
  `Socio_titular_idTitular` INT NOT NULL,
  `Pessoas_idPessoas` INT NOT NULL,
  PRIMARY KEY (`idDependente`, `Pessoas_idPessoas`),
  INDEX `fk_Dependente_Socio_titular1_idx` (`Socio_titular_idTitular` ASC) VISIBLE,
  INDEX `fk_Dependente_Pessoas1_idx` (`Pessoas_idPessoas` ASC) VISIBLE,
  CONSTRAINT `fk_Dependente_Socio_titular1`
    FOREIGN KEY (`Socio_titular_idTitular`)
    REFERENCES `clube_recreativo`.`Socio_titular` (`idTitular`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dependente_Pessoas1`
    FOREIGN KEY (`Pessoas_idPessoas`)
    REFERENCES `clube_recreativo`.`Pessoas` (`idPessoas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Area_lazer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Area_lazer` (
  `idArea` INT NOT NULL AUTO_INCREMENT,
  `Nome_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idArea`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Acesso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Acesso` (
  `idAcesso` INT NOT NULL AUTO_INCREMENT,
  `Data_Acesso` DATE NOT NULL,
  `Hora_Acesso` TIME NOT NULL,
  `Pessoas_idPessoas` INT NOT NULL,
  `Area_lazer_idArea` INT NOT NULL,
  PRIMARY KEY (`idAcesso`, `Pessoas_idPessoas`, `Area_lazer_idArea`),
  INDEX `fk_Acesso_Pessoas1_idx` (`Pessoas_idPessoas` ASC) VISIBLE,
  INDEX `fk_Acesso_Area_lazer1_idx` (`Area_lazer_idArea` ASC) VISIBLE,
  CONSTRAINT `fk_Acesso_Pessoas1`
    FOREIGN KEY (`Pessoas_idPessoas`)
    REFERENCES `clube_recreativo`.`Pessoas` (`idPessoas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Acesso_Area_lazer1`
    FOREIGN KEY (`Area_lazer_idArea`)
    REFERENCES `clube_recreativo`.`Area_lazer` (`idArea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Metodo_Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Metodo_Pagamento` (
  `idMetodo` INT NOT NULL AUTO_INCREMENT,
  `Descricao_metodo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMetodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clube_recreativo`.`Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `clube_recreativo`.`Pagamento` (
  `idPagamento` INT NOT NULL AUTO_INCREMENT,
  `Data_pagamento` DATE NOT NULL,
  `Valor_total` DECIMAL(10,2) NOT NULL,
  `Status` ENUM('PAGO', 'PENDENTE', 'ATRASADO') NOT NULL,
  `Socio_titular_idTitular` INT NOT NULL,
  `Metodo_Pagamento_idMetodo` INT NOT NULL,
  PRIMARY KEY (`idPagamento`, `Socio_titular_idTitular`, `Metodo_Pagamento_idMetodo`),
  INDEX `fk_Pagamento_Socio_titular1_idx` (`Socio_titular_idTitular` ASC) VISIBLE,
  INDEX `fk_Pagamento_Metodo_Pagamento1_idx` (`Metodo_Pagamento_idMetodo` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Socio_titular1`
    FOREIGN KEY (`Socio_titular_idTitular`)
    REFERENCES `clube_recreativo`.`Socio_titular` (`idTitular`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pagamento_Metodo_Pagamento1`
    FOREIGN KEY (`Metodo_Pagamento_idMetodo`)
    REFERENCES `clube_recreativo`.`Metodo_Pagamento` (`idMetodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
