DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `INSERT_AUDIT`(
	in inAuditDateTime datetime, 
    inout inoutUuid varchar(256),
    in inCompanyId int, 
    in inEmployeeId int,
    in inStatus varchar(256),
    in inEntitlementCheck varchar(256),
    in inPayload json,
    IN inQuotationId varchar(256)
)
BEGIN
	DECLARE varLocalUUID varchar(256);
    
    if inoutUuid is null then
		set inoutUuid = md5(uuid());
    end if;
    
    if inAuditDateTime is not null then
		INSERT INTO `entitlement`.`auditlog`
			(
				`auditdatetime`,
				`uuid`,
				`status`,
				`entitlementCheck`,
				`companyId`,
				`employeeId`,
				`payload`, 
                `quotationId`
			) VALUES 
            (
				inAuditDateTime, 
                inoutUuid,
                inStatus,
                inEntitlementCheck,
                inCompanyId,
                inEmployeeId,
                inPayload,
                inQuotationId
            );
    else
		INSERT INTO `entitlement`.`auditlog`
			(
				`uuid`,
				`status`,
				`entitlementCheck`,
				`companyId`,
				`employeeId`,
				`payload`,
                `quotationId`
			) VALUES 
            (
                inoutUuid,
                inStatus,
                inEntitlementCheck,
                inCompanyId,
                inEmployeeId,
                inPayload,
                inQuotationId
            );
    end if;
END$$
DELIMITER ;
