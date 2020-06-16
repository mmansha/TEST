CREATE TABLE `employee_types` (
  `EmpType` varchar(250) NOT NULL,
  `EmpTypeId` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`EmpTypeId`),
  UNIQUE KEY `EmpType_UNIQUE` (`EmpType`)
) ;
