CREATE TABLE `entitlement`.`hcompliant_audit` (
  `guid` VARCHAR(255) NOT NULL,
  `request_dt` DATETIME NULL,
  `request_dt_utc` DATETIME NULL,
  `companyId` INT NULL,
  `employeeId` INT NULL,
  `cityId` INT NULL,
  `tmId` INT NULL,
  `amount` INT NULL,
  PRIMARY KEY (`guid`));


ALTER TABLE `entitlement`.`hcompliant_audit` 
ADD COLUMN `responseStatus` VARCHAR(45) NULL AFTER `amount`,
ADD COLUMN `responseDetails` VARCHAR(10245) NULL AFTER `responseStatus`;
