DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `H_ADV_BOOKING`(
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
    out outResponseStatus varchar(45),
    out outResponseDetails varchar(1024)
)
BEGIN
	DECLARE varCompanyMinDaysBeforeTravel int;
    DECLARE varCalNoOfDaysBetweenBookingAndTravel int;
    
    select 
		c.MinDaysBeforeTravel into @varCompanyMinDaysBeforeTravel
	from 
		company c
	where 
		c.CompanyId = inCompanyId;
        
	
    select 
		datediff(inTravelDate, inBookingDate) 
	into 
		varCalNoOfDaysBetweenBookingAndTravel;
        
	

	if @varCalNoOfDaysBetweenBookingAndTravel < varCompanyMinDaysBeforeTravel then
			set outResponseStatus = 'KO';
            if length(outResponseDetails) > 0 then
				set outResponseDetails = concat(outResponseDetails, '\n', 'Travel date is not within booking threshold');
			else
				set outResponseDetails = concat('Travel date is not within booking threshold');
			end if;
	else
		set outResponseStatus = 'OK';
        set outResponseDetails = concat('Travel date is within booking threshold');
        
	end if;
        
END$$
DELIMITER ;
