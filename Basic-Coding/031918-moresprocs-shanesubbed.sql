-- shane subbed
-- more freakin sprocs
-- = null always returns false

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AddClub')
    DROP PROCEDURE AddClub
GO

CREATE PROCEDURE AddClub
    -- Parameters here
	-- MUST start with @
	@ClubID varchar(10),
	@ClubName varchar(50)
AS
    -- Body of procedure here
	INSERT INTO Club(ClubId, ClubName)
	VALUES (@ClubID, @ClubName)
RETURN
GO

-- exeute the procedure
EXEC AddClub 'SQL1', 'SQL Dance Club'

-- try this
EXEC AddClub

-- fails because you did not provide values for parameters
-- get the sp source code from db
sp_helptext AddClub

-- Check for parameter values not being passed
ALTER PROCEDURE AddClub
    -- Parameters here
	-- MUST start with @
	-- default the parameters to null so they always have a value, even if not passed one
	@ClubID varchar(10),
	@ClubName varchar(50)
AS
    -- Body of procedure here
	IF @ClubID IS NULL OR @ClubName IS NULL
		BEGIN
			RAISERROR('ClubID and ClubName are required', 16, 1)
		END
	ELSE
		BEGIN
			INSERT INTO Club(ClubId, ClubName)
			VALUES (@ClubID, @ClubName)
		END
RETURN

EXEC AddClub

-- create a proc that will change the mailing address for a student. call it ChangeMailingAddress
-- Make sure all the parameter values are supplied before running the update (not null)

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ChangeMailingAddress')
    DROP PROCEDURE ChangeMailingAddress
GO
CREATE PROCEDURE ChangeMailingAddress
    -- Parameters here
	@StudentID int = null,
	@StreetAddress varchar(35) = null,
	@City varchar(30) = null,
	@Province char(2) = null,
	@PostalCode char(6) = null
AS

    -- Body of procedure here
	IF @StudentID IS NULL OR @StreetAddress IS NULL OR @City IS NULL OR @Province IS NULL OR @PostalCode IS NULL
		BEGIN
			RAISERROR('You are missing a required field', 16, 1)
		END
	ELSE
		BEGIN
			UPDATE Student
				SET StreetAddress = @StreetAddress, City = @City, Province = @Province, PostalCode = @PostalCode
				WHERE StudentID = @StudentID
		END
RETURN
GO
