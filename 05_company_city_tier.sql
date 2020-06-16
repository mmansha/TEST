CREATE TABLE `company_city_tier` (
  `CompanyId` int(11) NOT NULL,
  `City` varchar(512) NOT NULL,
  `State` varchar(1024) NOT NULL,
  `Country` varchar(1024) NOT NULL,
  `CityTier` varchar(25) NOT NULL,
  PRIMARY KEY (`CompanyId`),
  UNIQUE KEY `CompanyId_UNIQUE` (`CompanyId`),
  CONSTRAINT `companyCityTier_Company_CompanyId` FOREIGN KEY (`CompanyId`) REFERENCES `company` (`CompanyId`)
);
