DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `HComplianceProfileCheck`(
	IN inGuid varchar(255),
    IN inTripId int,
    IN inCompanyId int,
    IN inEmployeeId int,
    IN inAmount int, 
    IN inCity varchar(1024),
    IN inTmId int,
    IN inTravelDate date,
    IN inBookingDate date,
    IN inQuotationId varchar(256),
    IN inComplianceProfile varchar(1024),
    IN inStarRating int, 
    out outResponseStatus varchar(45),
    out outResponseDetails varchar(5000)
)
BEGIN
	
    DECLARE varRuleOrder int;
    DECLARE varDone BOOLEAN DEFAULT 0;
    DECLARE varRuleName varchar(1024);
    DEClare varSqlStatment varchar (5000);
    DECLARE varComplianceProfile varchar(1024);
    DECLARE varResponseDeatils varchar(5000);
    DECLARE varPreviousResponseStatus varchar(200);
    DECLARE varJsonObject JSON;
    
    
    
    -- Define the cursor
    DECLARE 
		complainceCur cursor for 
			select 
				ruleOrder, rule 
			from 
				entitlement.travel_compliance_profile 
			where 
				companyId = inCompanyId 
				and complianceProfile = inComplianceProfile
			order by 
				ruleOrder;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET varDone = TRUE;
    set varJsonObject = json_object('a', 'result');
    
    set @json_object = JSON_OBJECT('guid', inGuid, 'tripid', inTripId, 'quotationId', inQuotationId,
                                    'companyid', inCompanyId, 'employeeid', inEmployeeId, 'amount', inAmount, 
                                    'city', inCity, 'tmid', inTmId, 'startRating', inStarRating,
                                    'traveldate', inTravelDate, 'bookingdate', inBookingDate);
    CALL INSERT_AUDIT(NULL, inGuid, inCompanyId, inEmployeeId, 'Request', 'Hotel', @json_object, inQuotationId);
    
    
	set @guid = inGuid;
	set @tripId = inTripId;
	set @companyId = inCompanyId;
	set @employeeId = inEmployeeId;
	set @amount = inAmount;
    set @city = inCity;
    set @tmId = inTmId;
    set @travelDate = inTravelDate;
    set @bookingDate = inBookingDate;
    set @starRating = inStarRating;
    set @responseJsonArray = json_array('input');
    set varResponseDeatils = '';
    set outResponseStatus = 'KO';
    set outResponseDetails = 'No rules defined in the system';
    set varPreviousResponseStatus = '';
    
    -- Check if employee id is valid
    if ( select exists(SELECT employeeId FROM employee WHERE employeeId = inEmployeeId) = 0) then
		set outResponseStatus = 'KO';
        set outResponseDetails = 'Employee id invalid.';
	-- Check if travel profile exists for the comapny
	elseif (select exists(select t.* from travel_compliance_profile t, employee e where t.companyId = inCompanyId and t.complianceProfile = inComplianceProfile and e.EmployeeId = inEmployeeId) = 0) then
		set outResponseStatus = 'KO';
        set outResponseDetails = 'Travel compliance profile invalid.';
    
    else
		
		OPEN complainceCur;

			read_loop: LOOP
				fetch  complainceCur into varRuleOrder, varRuleName;
				 IF varDone THEN
					LEAVE read_loop;
				END IF;
				
				-- Iterate in loop
				set @sql = concat('call ', varRuleName, '(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)');
				prepare varSqlStatment from @sql;
				
				execute varSqlStatment using 
							@guid, @tripId, @companyId, 
							@employeeId, @amount, @city, @tmId, @travelDate, 
							@bookingDate, @starRating, @status, @details;
                            
				-- call log(concat('status/details = ', @status, '/', @details));
				
                -- If the status returned is NA then we ignore updating variables
					-- If varPreviousResponseStatus is blank then set the value to status
					-- if varPreviousResponseStatus is not blank status is 'KO'then 
                    -- if status is 'KO' then concat varReponseDetils
                    
				-- if varPreviousResponseStatus = 'OK' then updadate outResponseDetails to 'Accepted'
                
                
                if (varRuleName = 'H_STM_BYPASS' and @status = 'OK') then
					set varPreviousResponseStatus = 'OK';
                    set varResponseDeatils = 'Approved by STM. No additional checks required';
                    leave read_loop;
                end if;
                
                if (@status = 'OK' or @status = 'KO') then
					if (length(varPreviousResponseStatus) = 0 or @status = 'KO') then
						set varPreviousResponseStatus = @status;
                        if (@status = 'KO') then 
							if length(varResponseDeatils > 0) then
								set varResponseDeatils = concat(varResponseDeatils, ' \n', @details);
							else
								set varResponseDeatils = @details;
							end if;
						end if;
					end if;
                    
                end if;
                
				
			end loop;
			set outResponseStatus = varPreviousResponseStatus;
            
            if length(varResponseDeatils) = 0 then
				set varResponseDeatils = 'Entitlement check for hotels completed successfully';
			end if;
            
			set outResponseDetails = varResponseDeatils;
            
		-- deallocate prepare sqlStatement;
		close complainceCur;
        
		set @json_object = JSON_OBJECT('response_status', outResponseStatus, 'response_details', outResponseDetails);
		CALL INSERT_AUDIT(NULL, inGuid, inCompanyId, inEmployeeId, 'Response', 'Hotel', @json_object, inQuotationId);
	end if;
END$$
DELIMITER ;
