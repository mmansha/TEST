CREATE TABLE `employee` (
  `CompanyId` int(11) NOT NULL,
  `EmployeeId` int(11) NOT NULL,
  `Name` varchar(45) DEFAULT NULL,
  `SupervisorId` varchar(45) DEFAULT NULL,
  `Grade` varchar(45) DEFAULT NULL,
  `Email` varchar(1024) DEFAULT NULL,
  `Mobile` varchar(1024) DEFAULT NULL,
  `EmpTypeId` int(11) DEFAULT NULL,
  `ApproverId` int(11) DEFAULT NULL,
  PRIMARY KEY (`EmployeeId`,`CompanyId`),
  KEY `emp_employeeType_empType_idx` (`EmpTypeId`),
  KEY `emp_company_companyId_idx` (`CompanyId`),
  KEY `emp_employeeId_approverId_idx` (`ApproverId`),
  CONSTRAINT `emp_company_companyId` FOREIGN KEY (`CompanyId`) REFERENCES `company` (`CompanyId`),
  CONSTRAINT `emp_employeeId_approverId` FOREIGN KEY (`ApproverId`) REFERENCES `employee` (`EmployeeId`),
  CONSTRAINT `emp_employeeType_empTypeId` FOREIGN KEY (`EmpTypeId`) REFERENCES `employee_types` (`EmpTypeId`)
);
