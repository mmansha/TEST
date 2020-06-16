CREATE TABLE `hotel_entitlement` (
  `CompanyId` int(11) NOT NULL,
  `CityTier` varchar(25) NOT NULL,
  `Grade` varchar(45) NOT NULL,
  `Entitlement` int(11) NOT NULL,
  `Month` varchar(10) NOT NULL,
  `Year` int(11) NOT NULL,
  PRIMARY KEY (`Grade`,`CityTier`,`CompanyId`),
  KEY `hotelEntitlement_company_id_idx` (`CompanyId`),
  CONSTRAINT `hotelEntitlement_company_id` FOREIGN KEY (`CompanyId`) REFERENCES `company` (`CompanyId`)
);
