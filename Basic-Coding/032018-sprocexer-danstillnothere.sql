-- Stored Procedures (Sprocs)
-- Validating Parameter Values

USE [A01-School]
GO

/* ********* SPROC Template ************
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SprocName')
    DROP PROCEDURE SprocName
GO
CREATE PROCEDURE SprocName
    -- Parameters here
AS
    -- Body of procedure here
RETURN
GO
************************************** */

-- 1. Create a stored procedure called AddClub that will add a new club to the database. (No validation is required).
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'AddClub')
    DROP PROCEDURE AddClub
GO
-- sp_help Club -- Running the sp_help stored procedure will give you information about a table, sproc, etc.
CREATE PROCEDURE AddClub
    -- Parameters here
    @ClubId     varchar(10),
    @ClubName   varchar(50)
AS
    -- Body of procedure here
    -- Should put some validation here.....

    INSERT INTO Club(ClubId, ClubName)
    VALUES (@ClubId, @ClubName)
RETURN
GO

-- 1.b. Modify the AddClub procedure to ensure that the club name and id are actually supplied. Use the RAISERROR() function to report that this data is required.
ALTER PROCEDURE AddClub
    -- Parameters here
    @ClubId     varchar(10),
    @ClubName   varchar(50)
AS
    -- Body of procedure here
    IF @ClubId IS NULL OR @ClubName IS NULL
    BEGIN
        RAISERROR('Club ID and Name are required', 16, 1)
    END
    ELSE
    BEGIN
        INSERT INTO Club(ClubId, ClubName)
        VALUES (@ClubId, @ClubName)
    END
RETURN
GO


-- 2. Create a stored procedure that will change the mailing address for a student. Call it ChangeMailingAddress.
--    Make sure all the parameter values are supplied before running the UPDATE (ie: no NULLs).
-- sp_help Student
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'ChangeMailingAddress')
    DROP PROCEDURE ChangeMailingAddress
GO
CREATE PROCEDURE ChangeMailingAddress
    -- Parameters here
    @StudentId  int,
    @Street     varchar(35), -- Model the type/size of parameters to match what's needed in the database tables
    @City       varchar(30),
    @Province   char(2),
    @PostalCode char(6)
AS
    -- Body of procedure here
    -- Validate
    IF (@StudentId IS NULL OR @Street IS NULL OR @City IS NULL OR @Province IS NULL or @PostalCode IS NULL)
    BEGIN --  { A...
        RAISERROR('All parameters require a value (NULL is not accepted)', 16, 1)
    END   -- ...A }
    ELSE
    BEGIN -- { B...
        UPDATE  Student
        SET     StreetAddress = @Street
               ,City = @City
               ,Province = @Province
               ,PostalCode = @PostalCode
        WHERE   StudentId = @StudentId 
    END   -- ...B }
RETURN


-- 3. Create a stored procedure that will remove a student from a club. Call it RemoveFromClub.


-- Query-based Stored Procedures
-- 4. Create a stored procedure that will display all the staff and their position in the school.
--    Show the full name of the staff member and the description of their position.

-- 5. Display all the final course marks for a given student. Include the name and number of the course
--    along with the student's mark.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SelectMarks')
    DROP PROCEDURE SelectMarks
GO

CREATE PROCEDURE SelectMarks
    -- Parameters here
AS
    -- Body of procedure here
	SELECT S.FirstName + ' ' + S.LastName AS 'FullName',
		   R.Mark
	FROM Student S
		LEFT OUTER JOIN Registration R ON S.StudentID = R.StudentID
RETURN
GO

-- 6. Display the students that are enrolled in a given course on a given semester.
--    Display the course name and the student's full name and mark.
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'SelectEnrolledStudents')
    DROP PROCEDURE SelectEnrolledStudents
GO

ALTER PROCEDURE SelectEnrolledStudents 
    -- Parameters here
	@CourseID char(7) = NULL,
	@Semester char(5) = NULL
AS
    -- Body of procedure here
	IF @CourseID IS NULL OR @Semester IS NULL
		BEGIN
			RAISERROR('CourseId and Semester are required', 16, 1)
		END

    ELSE
		BEGIN
			SELECT S.FirstName + ' ' + S.LastName AS 'Full Name',
				   R.Mark,
				   C.CourseName
			FROM Student S
				   INNER JOIN Registration R ON S.StudentID = R.StudentID
				   INNER JOIN Course C ON R.CourseId = C.CourseId
			WHERE C.CourseId = @CourseID AND R.Semester = @Semester
		END
RETURN
GO

SELECT * FROM Registration
SelectEnrolledStudents 'DMIT101','2000S'

-- 7. The school is running out of money! Find out who still owes money for the courses they are enrolled in.

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_TYPE = N'PROCEDURE' AND ROUTINE_NAME = 'BrokeAssStudents')
    DROP PROCEDURE BrokeAssStudents
GO

CREATE PROCEDURE BrokeAssStudents
    -- Parameters here
AS
    -- Body of procedure here
	SELECT *
	FROM Student S
RETURN
GO

