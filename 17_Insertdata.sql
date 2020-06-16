INSERT INTO `entitlement`.`company`
(`CompanyId`,
`Name`,
`Currency`,
`MinDaysBeforeTravel`)
VALUES
(
	100, 'HP India', 'INR', 14
);


INSERT INTO `entitlement`.`city_tier`
(`CityTier`,
`Description`)
VALUES
('D11', 'Domestic Tier 1'), 
('D21', 'Domestic Tier 2'),
('D31', 'Domestic Tier 3'),
('I11', 'International Tier 1'),
('XX1', 'Default');


INSERT INTO `entitlement`.`city_entitlement`
(`CityTier`,
`Grade`,
`Entitlement`,
`Month`,
`Year`,
`CompanyId`)
VALUES
(
	'D1', 'L4', '10000', '10', '2019', 100
);


INSERT INTO `entitlement`.`company_city_tier`
(`CompanyId`,
`City`,
`State`,
`Country`,
`CityTier`)
VALUES
(
	'100', 'Gurgaon', 'Haryana', 'India', 'D1'
);


INSERT INTO `entitlement`.`employee_grade`
(`CompanyId`,
`Grade`,
`Description`,
`MaxStarRating`)
VALUES
(100, 'L1', 'ntern/Trainee\r\nntern/Trainee\r\nIntern/Trainee', 0),
(100, 'L2', 'Sr. Executive/Executive', 0),
(100, 'L3', 'Sr. Manager/Manager/Dy. Manager/Asst. Manager', 0),
(100, 'L4', 'GM/DGM/AGM', 4),
(100, 'L5', 'VP/Director', 0);


INSERT INTO `entitlement`.`employee_types`
(`EmpType`,
`EmpTypeId`)
VALUES
('Consultant', 2),
('Employee', 1),
('Super Travel Manager', 4),
('Travel Manager (TM)', 3);


INSERT INTO `entitlement`.`hotel_entitlement`
(`CompanyId`,
`CityTier`,
`Grade`,
`Entitlement`,
`Month`,
`Year`)
VALUES
(100, 'D1', 'L4', '10000', 'Dec', '2019'),
(100, 'XX', 'XX', '8000', 'XXX', '9999');

INSERT INTO `entitlement`.`travel_compliance_profile`
(`companyId`,
`ruleOrder`,
`rule`,
`ruleType`,
`complianceProfile`)
VALUES
(100, 20, 'H_ADV_BOOKING', 'Hotel', 'General'),
(100, 30, 'H_ENTITLEMENT', 'Hotel', 'General'), 
(100, 40, 'H_RATING', 'Hotel', 'General'),
(100, 10, 'H_STM_BYPASS', 'Hotel', 'General');



INSERT INTO `entitlement`.`employee`
(`CompanyId`,
`EmployeeId`,
`Name`,
`SupervisorId`,
`Grade`,
`Email`,
`Mobile`,
`EmpTypeId`,
`ApproverId`)
VALUES
(100, 1234, 'John Doe', 9999, 'L4', NULL, NULL, 1, 5000),
(100, 5000, 'Approver', NULL, 'L2', 'approver@getout.travel', NULL, 1, NULL),
(100, 9999, 'Jane Smith', NULL, 'L2', NULL, NULL, 4, NULL);


INSERT INTO `entitlement`.`travel_compliance_profile`
(`companyId`,
`ruleOrder`,
`rule`,
`ruleType`,
`complianceProfile`)
VALUES
('100', '20', 'H_ADV_BOOKING', 'Hotel', 'General'),
('100', '30', 'H_ENTITLEMENT', 'Hotel', 'General'),
('100', '40', 'H_RATING', 'Hotel', 'General'),
('100', '10', 'H_STM_BYPASS', 'Hotel', 'General'),
('1001', '1', 'log', 'Hotel', 'General')
