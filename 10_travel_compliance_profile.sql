CREATE TABLE `travel_compliance_profile` (
  `companyId` int(11) NOT NULL,
  `ruleOrder` int(11) NOT NULL,
  `rule` varchar(512) NOT NULL,
  `ruleType` varchar(100) NOT NULL,
  `complianceProfile` varchar(1024) NOT NULL,
  PRIMARY KEY (`companyId`,`rule`)
) ;
