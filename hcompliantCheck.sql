CREATE DEFINER=`root`@`%` PROCEDURE `hcompliantCheck`(
	IN guid varchar(255),
    IN tripId int,
    in companyId int,
    in employeeId int,
    in amount int, 
    in city varchar(1024),
    in tmId int,
    out responseStatus varchar(45),
    out responseDetails varchar(1024)
)
BEGIN
    DECLARE tmIdForCompany int default 0;
    DECLARE constantSuperTravelManager varchar(255) ;
    DECLARE varEmployeeType varchar(255);
    DECLARE varEntitlement int;
    DECLARE varDefaultMatchCriteria varchar(1024);
    
    set @constantSuperTravelManager = 'Super Travel Manager';
    set @varEmployeeType ='Not defined';
    set @varEntitlement =  -1;
    
    -- Check if the tmid is a super travel manager for the company
    if tmId > 0 then
		
		select 
			et.empType into @varEmployeeType
		from
			employee_types et, employee e
		where
			e.empTypeId = et.empTypeId
            and e.employeeId = tmId
            and e.companyId = companyId;
            

		if (strcmp(@varEmployeeType,@constantSuperTravelManager)) = 0 then
			set responseStatus = 'APPROVED';
            set responseDetails = @varEmployeeType;
		else 
			set responseStatus = 'DENIED';
            set responseDetails = 'The tmId supplied is not a super travel manager';
        end if;
    
   
    else 
    -- tmId not provided. Check employee entitlements
		select 
			he.Entitlement into @varEntitlement
		from 
			employee e, company_city_tier cct, hotel_entitlement he
		where
			e.EmployeeId = employeeId
			and e.CompanyId = cct.CompanyId
			and e.CompanyId = companyId
			and e.grade = he.grade
			and cct.CityTier = he.CityTier
			and he.Month = month(curdate())
			and he.Year = year(curdate())
            and cct.city = city;
				
		if (found_rows() = 0) then
			set @varDefaultMatchCriteria = 'Default found';
			select 
				he.Entitlement into @varEntitlement
			from 
				employee e, company_city_tier cct, hotel_entitlement he
			where
				e.EmployeeId = employeeId
				and e.CompanyId = cct.CompanyId
				and e.CompanyId = companyId
				and he.grade = 'XX'
				and he.CityTier = 'XX'
				and he.Month = -1
				and he.Year = year(curdate());
		else
			set @varDefaultMatchCriteria = 'Match found';
		end if;
    
		-- check employee's entitlement
        if @varEntitlement = -1 then
			set responseStatus = 'DENIED';
            set responseDetails = 'No matching entitlement criteria found';
        else
			-- check if the entitlement is in the amount allocated
            if @varEntitlement >= amount then
				set responseStatus = 'APPROVED';
				set responseDetails = concat('Employee amount is within the allowed hotel entitlment amount (', @varEntitlement, '). Search criteria = ', @varDefaultMatchCriteria);
			else
				set responseStatus = 'DENIED';
				set responseDetails = concat('Employee amount is greater than the allowed hotel entitlment amount (', @varEntitlement, '). Search criteria = ', @varDefaultMatchCriteria);
			end if;
        end if;
        
     end if;
   
    
END