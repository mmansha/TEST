DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `H_RATING`(
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
	DECLARE varEmployeeRating int;
	
	SELECT 
		eg.MaxStarRating  into varEmployeeRating 
	FROM 
		employee_grade eg, employee e
	WHERE 
		e.EmployeeId = inEmployeeId
		and e.CompanyId = inCompanyId
		and e.Grade = eg.Grade
		and e.CompanyId = eg.CompanyId;
        
	if inStarRating <= varEmployeeRating then
		set outResponseStatus = 'OK';
        set outResponseDetails = 'Star rating within threshold';
	else
		set outResponseStatus = 'KO';
        set outResponseDetails = 'Star rating not in threshold';
	end if;
END$$
DELIMITER ;
