CREATE TABLE `city_entitlement` (
  `CityTier` varchar(25) NOT NULL,
  `Grade` varchar(45) NOT NULL,
  `Entitlement` int(11) DEFAULT NULL,
  `Month` int(11) DEFAULT NULL,
  `Year` int(11) DEFAULT NULL,
  `CompanyId` varchar(45) NOT NULL,
  PRIMARY KEY (`Grade`,`CityTier`),
  KEY `CityTierFK_idx` (`CityTier`),
  CONSTRAINT `CityTierFK` FOREIGN KEY (`CityTier`) REFERENCES `city_tier` (`CityTier`)
) ;
