CREATE TABLE `auditlog` (
  `auditdatetime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `uuid` varchar(256) NOT NULL,
  `status` varchar(256) NOT NULL,
  `entitlementCheck` varchar(256) NOT NULL,
  `companyId` int(11) DEFAULT NULL,
  `employeeId` int(11) DEFAULT NULL,
  `payload` json DEFAULT NULL,
  `quotationId` varchar(256) DEFAULT NULL
) ;
