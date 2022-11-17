-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema pbdvacuna
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pbdvacuna
-- -----------------------------------------------------
CREATE database IF NOT EXISTS `pbdvacuna` DEFAULT CHARACTER SET utf8mb4 ;
USE `pbdvacuna` ;

-- -----------------------------------------------------
-- Table `pbdvacuna`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `usuario` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `app` VARCHAR(45) NOT NULL,
  `apm` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(45) NOT NULL,
  `edad` INT(11) NOT NULL,
  `curp` VARCHAR(18) NOT NULL,
  `tipo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idusuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pbdvacuna`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `paciente` (
  `idpaciente` INT(11) NOT NULL AUTO_INCREMENT,
  `idusuario` INT(11) NOT NULL,
  PRIMARY KEY (`idpaciente`),
  INDEX `fk_paciente_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_paciente_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `pbdvacuna`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pbdvacuna`.`enfermero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `enfermero` (
  `idenfermero` INT(11) NOT NULL AUTO_INCREMENT,
  `idusuario` INT(11) NOT NULL,
  PRIMARY KEY (`idenfermero`),
  INDEX `fk_enfermero_usuario1_idx` (`idusuario` ASC) ,
  CONSTRAINT `fk_enfermero_usuario1`
    FOREIGN KEY (`idusuario`)
    REFERENCES `pbdvacuna`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pbdvacuna`.`campania`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `campania` (
  `idCampania` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) BINARY NOT NULL,
  `fechaInicio` VARCHAR(45) NOT NULL,
  `fechaFin` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `idvacuna` INT(11) NOT NULL,
  `idenfermero` INT(11) NOT NULL,
  PRIMARY KEY (`idCampania`),
  INDEX `fk_Campania_vacuna1_idx` (`idvacuna` ASC) ,
  INDEX `fk_campania_enfermero1_idx` (`idenfermero` ASC) ,
  CONSTRAINT `fk_Campania_vacuna1`
    FOREIGN KEY (`idvacuna`)
    REFERENCES `mydb`.`vacuna` (`idvacuna`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_campania_enfermero1`
    FOREIGN KEY (`idenfermero`)
    REFERENCES `pbdvacuna`.`enfermero` (`idenfermero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pbdvacuna`.`aplicar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `aplicar` (
  `idaplicacion` INT(11) NOT NULL AUTO_INCREMENT,
  `estado` INT(11) NOT NULL,
  `paciente_idpaciente` INT(11) NOT NULL,
  `campania_idCampania` INT(11) NOT NULL,
  PRIMARY KEY (`idaplicacion`),
  INDEX `fk_aplicar_paciente1_idx` (`paciente_idpaciente` ASC) ,
  INDEX `fk_aplicar_campania1_idx` (`campania_idCampania` ASC) ,
  CONSTRAINT `fk_aplicar_paciente1`
    FOREIGN KEY (`paciente_idpaciente`)
    REFERENCES `pbdvacuna`.`paciente` (`idpaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aplicar_campania1`
    FOREIGN KEY (`campania_idCampania`)
    REFERENCES `pbdvacuna`.`campania` (`idCampania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pbdvacuna`.`historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `historial` (
  `idHistorial` INT(11) NOT NULL AUTO_INCREMENT,
  `idaplicacion` INT(11) NOT NULL,
  `aplicar_idaplicacion` INT(11) NOT NULL,
  PRIMARY KEY (`idHistorial`),
  INDEX `fk_Historial_aplicacion1_idx` (`idaplicacion` ASC) ,
  INDEX `fk_historial_aplicar1_idx` (`aplicar_idaplicacion` ASC) ,
  CONSTRAINT `fk_Historial_aplicacion1`
    FOREIGN KEY (`idaplicacion`)
    REFERENCES `mydb`.`aplicar` (`idaplicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historial_aplicar1`
    FOREIGN KEY (`aplicar_idaplicacion`)
    REFERENCES `pbdvacuna`.`aplicar` (`idaplicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pbdvacuna`.`vacuna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `vacuna` (
  `idvacuna` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `num_dosis` INT(11) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `rango` INT(11) NOT NULL,
  `campania_idCampania` INT(11) NOT NULL,
  PRIMARY KEY (`idvacuna`),
  INDEX `fk_vacuna_campania1_idx` (`campania_idCampania` ASC) ,
  CONSTRAINT `fk_vacuna_campania1`
    FOREIGN KEY (`campania_idCampania`)
    REFERENCES `pbdvacuna`.`campania` (`idCampania`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
