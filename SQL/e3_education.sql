SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';



DROP SCHEMA IF EXISTS `e3erp` ;

CREATE SCHEMA IF NOT EXISTS `e3erp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;

USE `e3erp` ;



-- -----------------------------------------------------

-- Table `e3erp`.`center`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`center` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`center` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`id`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`course`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`course` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`course` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NOT NULL ,

  `description` VARCHAR(255) NULL ,

  PRIMARY KEY (`id`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`batch`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`batch` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`batch` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NOT NULL ,

  `start_date` DATE NOT NULL ,

  `status` CHAR(1) NOT NULL ,

  `description` VARCHAR(255) NULL ,

  `end_date` DATE NOT NULL ,

  `course_id` INT NOT NULL ,

  `center_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_batch_course_idx` (`course_id` ASC) ,

  INDEX `fk_batch_center1_idx` (`center_id` ASC) ,

  CONSTRAINT `fk_batch_course`

    FOREIGN KEY (`course_id` )

    REFERENCES `e3erp`.`course` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_batch_center1`

    FOREIGN KEY (`center_id` )

    REFERENCES `e3erp`.`center` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`user`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`user` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`user` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `username` VARCHAR(45) NOT NULL ,

  `password` VARCHAR(45) NOT NULL ,

  `isactive` CHAR(1) NOT NULL ,

  PRIMARY KEY (`id`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`user_family_details`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`user_family_details` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`user_family_details` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `user_id` INT NOT NULL ,

  `name` VARCHAR(255) NOT NULL ,

  `birth_date` DATE NULL ,

  `gender` CHAR(1) NULL ,

  `relation` VARCHAR(20) NULL ,

  `educational_qualification` VARCHAR(45) NULL ,

  `professional_designation` VARCHAR(45) NULL ,

  `email` VARCHAR(255) NULL ,

  `mobile` VARCHAR(45) NULL ,

  `job_profile` VARCHAR(255) NULL ,

  `company_name` VARCHAR(255) NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_person_user1_idx` (`user_id` ASC) ,

  CONSTRAINT `fk_person_user1`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`role`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`role` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`role` (

  `id` INT NOT NULL ,

  `name` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`id`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`batch_groups`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`batch_groups` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`batch_groups` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NOT NULL ,

  `batch_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_batch_groups_batch1_idx` (`batch_id` ASC) ,

  CONSTRAINT `fk_batch_groups_batch1`

    FOREIGN KEY (`batch_id` )

    REFERENCES `e3erp`.`batch` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`batch_user`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`batch_user` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`batch_user` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `batch_id` INT NOT NULL ,

  `user_id` INT NOT NULL ,

  `role_id` INT NOT NULL ,

  `batch_groups_id` INT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_batch_users_batch1_idx` (`batch_id` ASC) ,

  INDEX `fk_batch_users_user1_idx` (`user_id` ASC) ,

  INDEX `fk_batch_users_role1_idx` (`role_id` ASC) ,

  INDEX `fk_batch_users_batch_groups1_idx` (`batch_groups_id` ASC) ,

  CONSTRAINT `fk_batch_users_batch1`

    FOREIGN KEY (`batch_id` )

    REFERENCES `e3erp`.`batch` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_batch_users_user1`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_batch_users_role1`

    FOREIGN KEY (`role_id` )

    REFERENCES `e3erp`.`role` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_batch_users_batch_groups1`

    FOREIGN KEY (`batch_groups_id` )

    REFERENCES `e3erp`.`batch_groups` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`session`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`session` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`session` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NOT NULL ,

  `date` DATE NOT NULL ,

  `start_time` TIME NOT NULL ,

  `end_time` TIME NOT NULL ,

  `venue` VARCHAR(255) NOT NULL ,

  `batch_id` INT NOT NULL ,

  `isactive` CHAR(1) NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_session_batch1_idx` (`batch_id` ASC) ,

  CONSTRAINT `fk_session_batch1`

    FOREIGN KEY (`batch_id` )

    REFERENCES `e3erp`.`batch` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`session_assignment`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`session_assignment` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`session_assignment` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NOT NULL ,

  `description` VARCHAR(255) NULL ,

  `session_id` INT NOT NULL ,

  `isactive` CHAR(1) NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_assignment_session1_idx` (`session_id` ASC) ,

  CONSTRAINT `fk_assignment_session1`

    FOREIGN KEY (`session_id` )

    REFERENCES `e3erp`.`session` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`meeting`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`meeting` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`meeting` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `title` VARCHAR(45) NOT NULL ,

  `agenda` VARCHAR(255) NULL ,

  `venue` VARCHAR(45) NOT NULL ,

  `batch_id` INT NOT NULL ,

  `batch_groups_id` INT NULL ,

  `is_jumbo_call` CHAR(1) NULL ,

  `date` DATE NOT NULL ,

  `start_time` TIME NOT NULL ,

  `end_time` TIME NOT NULL ,

  `conference_number` VARCHAR(45) NULL ,

  `conference_other_details` VARCHAR(45) NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_meeting_batch1_idx` (`batch_id` ASC) ,

  INDEX `fk_meeting_batch_groups1_idx` (`batch_groups_id` ASC) ,

  CONSTRAINT `fk_meeting_batch1`

    FOREIGN KEY (`batch_id` )

    REFERENCES `e3erp`.`batch` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_meeting_batch_groups1`

    FOREIGN KEY (`batch_groups_id` )

    REFERENCES `e3erp`.`batch_groups` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`session_distinction`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`session_distinction` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`session_distinction` (

  `id` INT NOT NULL ,

  `name` VARCHAR(45) NOT NULL ,

  `description` VARCHAR(255) NULL ,

  `session_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_distiction_session1_idx` (`session_id` ASC) ,

  CONSTRAINT `fk_distiction_session1`

    FOREIGN KEY (`session_id` )

    REFERENCES `e3erp`.`session` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`session_attendance`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`session_attendance` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`session_attendance` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `session_id` INT NOT NULL ,

  `batch_user_id` INT NOT NULL ,

  `in_time` TIME NOT NULL ,

  `out_time` TIME NULL ,

  `is_session_payment_complete` CHAR(1) NULL ,

  `is_present` CHAR(1) NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_session_registration_session1_idx` (`session_id` ASC) ,

  INDEX `fk_session_registration_batch_user1_idx` (`batch_user_id` ASC) ,

  CONSTRAINT `fk_session_registration_session1`

    FOREIGN KEY (`session_id` )

    REFERENCES `e3erp`.`session` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_session_registration_batch_user1`

    FOREIGN KEY (`batch_user_id` )

    REFERENCES `e3erp`.`batch_user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`session_sharing`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`session_sharing` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`session_sharing` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `sharing_details` VARCHAR(255) NULL ,

  `session_id` INT NOT NULL ,

  `batch_user_id` INT NOT NULL ,

  `sharing_time` TIME NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_session_sharing_session1_idx` (`session_id` ASC) ,

  INDEX `fk_session_sharing_batch_user1_idx` (`batch_user_id` ASC) ,

  CONSTRAINT `fk_session_sharing_session1`

    FOREIGN KEY (`session_id` )

    REFERENCES `e3erp`.`session` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_session_sharing_batch_user1`

    FOREIGN KEY (`batch_user_id` )

    REFERENCES `e3erp`.`batch_user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`assignment_status`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`assignment_status` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`assignment_status` (

  `id` INT NOT NULL ,

  `name` VARCHAR(45) NOT NULL ,

  PRIMARY KEY (`id`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`user_assignment_status`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`user_assignment_status` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`user_assignment_status` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `assignment_id` INT NOT NULL ,

  `batch_user_id` INT NOT NULL ,

  `approved_by_user_id` INT NOT NULL ,

  `assignment_status_id` INT NOT NULL ,

  `user_comment` VARCHAR(1024) NULL ,

  `approver_comment` VARCHAR(1024) NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_user_assignment_status_assignment1_idx` (`assignment_id` ASC) ,

  INDEX `fk_user_assignment_status_batch_user1_idx` (`batch_user_id` ASC) ,

  INDEX `fk_user_assignment_status_batch_user2_idx` (`approved_by_user_id` ASC) ,

  INDEX `fk_user_assignment_status_assignment_status1_idx` (`assignment_status_id` ASC) ,

  CONSTRAINT `fk_user_assignment_status_assignment1`

    FOREIGN KEY (`assignment_id` )

    REFERENCES `e3erp`.`session_assignment` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_user_assignment_status_batch_user1`

    FOREIGN KEY (`batch_user_id` )

    REFERENCES `e3erp`.`batch_user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_user_assignment_status_batch_user2`

    FOREIGN KEY (`approved_by_user_id` )

    REFERENCES `e3erp`.`batch_user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_user_assignment_status_assignment_status1`

    FOREIGN KEY (`assignment_status_id` )

    REFERENCES `e3erp`.`assignment_status` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`meeting_attendance`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`meeting_attendance` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`meeting_attendance` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `batch_user_id` INT NOT NULL ,

  `meeting_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_meeting_attendance_batch_user1_idx` (`batch_user_id` ASC) ,

  INDEX `fk_meeting_attendance_meeting1_idx` (`meeting_id` ASC) ,

  CONSTRAINT `fk_meeting_attendance_batch_user1`

    FOREIGN KEY (`batch_user_id` )

    REFERENCES `e3erp`.`batch_user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_meeting_attendance_meeting1`

    FOREIGN KEY (`meeting_id` )

    REFERENCES `e3erp`.`meeting` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`center_user`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`center_user` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`center_user` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `user_id` INT NOT NULL ,

  `center_id` INT NOT NULL ,

  `role_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_center_user_user1_idx` (`user_id` ASC) ,

  INDEX `fk_center_user_center1_idx` (`center_id` ASC) ,

  INDEX `fk_center_user_role1_idx` (`role_id` ASC) ,

  CONSTRAINT `fk_center_user_user1`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_center_user_center1`

    FOREIGN KEY (`center_id` )

    REFERENCES `e3erp`.`center` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_center_user_role1`

    FOREIGN KEY (`role_id` )

    REFERENCES `e3erp`.`role` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`user_address_details`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`user_address_details` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`user_address_details` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `address_line_1` VARCHAR(45) NULL ,

  `address_line_2` VARCHAR(45) NULL ,

  `city` VARCHAR(45) NULL ,

  `state` VARCHAR(45) NULL ,

  `user_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_user_address_details_user1_idx` (`user_id` ASC) ,

  CONSTRAINT `fk_user_address_details_user1`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`user_books`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`user_books` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`user_books` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(45) NULL ,

  `user_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_user_books_user1_idx` (`user_id` ASC) ,

  CONSTRAINT `fk_user_books_user1`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`session_media`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`session_media` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`session_media` (

  `id` INT NOT NULL ,

  `url` VARCHAR(45) NOT NULL ,

  `type` VARCHAR(25) NOT NULL ,

  `session_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_session_media_session1_idx` (`session_id` ASC) ,

  CONSTRAINT `fk_session_media_session1`

    FOREIGN KEY (`session_id` )

    REFERENCES `e3erp`.`session` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`person`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`person` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`person` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `name` VARCHAR(255) NOT NULL ,

  `birth_date` DATE NOT NULL ,

  `gender` CHAR(1) NOT NULL ,

  `email` VARCHAR(255) NOT NULL ,

  `mobile` VARCHAR(45) NOT NULL ,

  `life_goals` VARCHAR(255) NULL ,

  `e3_goals` VARCHAR(45) NULL ,

  `office_reg_no` VARCHAR(45) NULL ,

  `company_name` VARCHAR(45) NULL ,

  `designation` VARCHAR(45) NULL ,

  `qualification` VARCHAR(45) NULL ,

  `user_id` INT NOT NULL ,

  `referred_by` VARCHAR(255) NULL ,

  `job_profile` VARCHAR(45) NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_person_user2_idx` (`user_id` ASC) ,

  CONSTRAINT `fk_person_user2`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`forgot_password_otp`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`forgot_password_otp` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`forgot_password_otp` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `username` VARCHAR(100) NOT NULL ,

  `otp` VARCHAR(10) NOT NULL ,

  `created_datetime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,

  `expire_on` DATETIME NOT NULL ,

  `active` CHAR(1) NOT NULL DEFAULT 'N' ,

  PRIMARY KEY (`id`) )

ENGINE = InnoDB;





-- -----------------------------------------------------

-- Table `e3erp`.`token`

-- -----------------------------------------------------

DROP TABLE IF EXISTS `e3erp`.`token` ;



CREATE  TABLE IF NOT EXISTS `e3erp`.`token` (

  `id` INT NOT NULL AUTO_INCREMENT ,

  `token` VARCHAR(45) NOT NULL ,

  `expired_by` TIMESTAMP NOT NULL ,

  `refresh_by` DATETIME NOT NULL ,

  `isactive` CHAR(1) NOT NULL ,

  `user_id` INT NOT NULL ,

  `role_id` INT NOT NULL ,

  PRIMARY KEY (`id`) ,

  INDEX `fk_token_user1_idx` (`user_id` ASC) ,

  INDEX `fk_token_role1_idx` (`role_id` ASC) ,

  CONSTRAINT `fk_token_user1`

    FOREIGN KEY (`user_id` )

    REFERENCES `e3erp`.`user` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION,

  CONSTRAINT `fk_token_role1`

    FOREIGN KEY (`role_id` )

    REFERENCES `e3erp`.`role` (`id` )

    ON DELETE NO ACTION

    ON UPDATE NO ACTION)

ENGINE = InnoDB;



USE `e3erp` ;





SET SQL_MODE=@OLD_SQL_MODE;

SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;

SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



-- -----------------------------------------------------

-- Data for table `e3erp`.`role`

-- -----------------------------------------------------

START TRANSACTION;

USE `e3erp`;

INSERT INTO `e3erp`.`role` (`id`, `name`) VALUES (1, 'ADMIN');

INSERT INTO `e3erp`.`role` (`id`, `name`) VALUES (2, 'LEADER');

INSERT INTO `e3erp`.`role` (`id`, `name`) VALUES (3, 'STUDENT');

INSERT INTO `e3erp`.`role` (`id`, `name`) VALUES (4, 'COACH');



COMMIT;

