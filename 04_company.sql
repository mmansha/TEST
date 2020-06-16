CREATE TABLE `company` (
  `CompanyId` int(11) NOT NULL,
  `Name` varchar(2048) NOT NULL,
  `Currency` varchar(45) NOT NULL,
  `MinDaysBeforeTravel` int(11) DEFAULT NULL,
  UNIQUE KEY `CompanyId_UNIQUE` (`CompanyId`)
) ;
