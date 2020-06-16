DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `H_ENTITLEMENT`(
	IN inGuid varchar(255),
    IN inTripId int,
    IN inCompanyId int,
    IN inEmployeeId int,
    IN inAmout int, 
    IN city varchar(1024),
    IN tmId int,
    IN travelDate date,
    IN bookingDate date,
    IN inStarRating int, 
    out responseStatus varchar(45),
    out responseDetails varchar(1024)
)
BEGIN

	declare varEntitlement int default -1;
    
   
		-- Check employee entitlements    
			select 
				he.Entitlement into varEntitlement
			from 
				employee e
				, company_city_tier cct
				, hotel_entitlement he
			where
				e.EmployeeId = inEmployeeId
				and e.CompanyId = cct.CompanyId
				and e.CompanyId = inCompanyId
				and e.grade = he.grade
				and cct.CityTier = he.CityTier
				and he.Month = date_format(travelDate, '%b')
				and he.Year = year(travelDate)
				and cct.city = city;
				
			
					
			if (varEntitlement = -1) then
				-- No employee entitlement found. Check company default
				-- call log('No employee entitlement found');
				select 
					he.Entitlement into varEntitlement
				from 
					employee e, company_city_tier cct, hotel_entitlement he
				where
					e.EmployeeId = inEmployeeId
					and e.CompanyId = cct.CompanyId
					and e.CompanyId = inCompanyId
					and he.grade = 'XX'
					and he.CityTier = 'XX'
					and he.Month = 'XXX'
					and he.Year = 9999;
				-- if row count is zero, then default not defined for company.
				-- if row count is = 1, then default found
				if (varEntitlement = -1) then
					set @varDefaultMatchCriteria = 'Default entitlement not defined for company';
				else
					set @varDefaultMatchCriteria = 'Default entitlement defined for company';
				end if;
			else
				set @varDefaultMatchCriteria = 'Employee entitlment match found';
				
			end if;
			
			
			-- check employee's entitlement
			if varEntitlement = -1 then
				set responseStatus = 'KO';
				set responseDetails = 'No matching entitlement criteria found';
			elseif varEntitlement >= inAmout then
				
				set responseStatus = 'OK';
				set responseDetails = concat('Employee amount is within the allowed hotel entitlment amount (', varEntitlement, ').. Search criteria = ', @varDefaultMatchCriteria);
			else
				set responseStatus = 'KO';
				set responseDetails = concat('Employee amount is greater than the allowed hotel entitlment amount (', varEntitlement, ').. Search criteria = ', @varDefaultMatchCriteria);
			end if;
		

END$$
DELIMITER ;
