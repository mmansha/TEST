CREATE TABLE `employee_grade` (
  `CompanyId` int(11) NOT NULL,
  `Grade` varchar(45) NOT NULL,
  `Description` varchar(1024) NOT NULL,
  `MaxStarRating` int(11) NOT NULL,
  PRIMARY KEY (`CompanyId`,`Grade`)
) ;
