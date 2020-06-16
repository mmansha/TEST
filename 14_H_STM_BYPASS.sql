DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `H_STM_BYPASS`(
	IN inGuid varchar(255),
    IN inTripId int,
    IN inCompanyId int,
    IN inEmployeeId int,
    IN inAmount int, 
    IN inCity varchar(1024),
    IN inTmId int,
    IN inTravelDate date,
    IN inBookingDate date,
    IN inStarRating int, 
    out OutResponseStatus varchar(45),
    out OutResponseDetails varchar(1024)
)
BEGIN
	DECLARE varEmpType varchar(250);
    DECLARE varConstantSuperTravelManager varchar(1024) DEFAULT 'Super Travel Manager';
    
    -- Check if tmId is 0. 
    if (inTmId = 0) then
		set OutResponseStatus = 'NA';
        set OutResponseDetails = '';
	elseif (inTmId = inEmployeeId) then
		set OutResponseStatus = 'KO';
        set OutResponseDetails = 'STMI id and Employee id are identical';
    else
		select 
			et.empType into varEmpType
		from 
			employee_types et,
			employee e
		where 
			e.EmployeeId = inTmId 
			and e.EmpTypeId = et.EmpTypeId
			and e.companyId = inCompanyId;
		
        -- call log(concat('Str compare ', strcmp(@arEmpType,varConstantSuperTravelManager)));
		if (strcmp(varEmpType,varConstantSuperTravelManager)) = 0 then
			set OutResponseStatus = 'OK';
			set OutResponseDetails = 'Approved via STM';
		else
			set OutResponseStatus = 'KO';
			set OutResponseDetails = 'STM ID provider is not valid';
		end if;
	end if;
END$$
DELIMITER ;
