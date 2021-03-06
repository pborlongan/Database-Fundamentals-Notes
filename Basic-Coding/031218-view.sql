--View Exercise
-- If an operation fails write a brief explanation why. Do not just quote the error message genereated by the server!

USE [A01-School]
GO

--1.  Create a view of staff full names called StaffList.
IF OBJECT_ID('StaffList', 'V') IS NOT NULL
    DROP VIEW StaffList
GO
CREATE VIEW StaffList
AS
    SELECT  FirstName + ' ' + LastName AS 'StaffFullName'
    FROM    Staff
GO

-- Now we can use the stafflist view as if it were a table
SELECT StaffFullName
FROM StaffList

-- SP_HELPTEXT StaffList    -- Gets the text of the View
-- SP_HELP StaffList        -- Gets schema info on the View

--2.  Create a view of staff ID's, full names, positionID's and datehired called StaffConfidential.
IF OBJECT_ID('StaffConfidential', 'V') IS NOT NULL
	DROP VIEW StaffConfidential
GO

CREATE VIEW StaffConfidential
AS
	SELECT StaffID,
		   FirstName + ' ' + LastName AS 'FullName',
		   PositionID,
		   DateHired
	FROM Staff
GO
-- I can use it accordingly:
SELECT FullName, DateHired
FROM StaffConfidential

--2.a. Alter the StaffConfidential view so that it includes the position name
ALTER VIEW StaffConfidential
AS
	SELECT StaffID,
		   FirstName + ' ' + LastName AS 'FullName',
		   P.PositionID,
		   P.PositionDescription AS 'Position',
		   DateHired
	FROM Staff S 
		INNER JOIN Position P ON S.PositionID = P.PositionID
GO

SELECT FullName, Position, PositionID
FROM StaffConfidential


--3.  Create a view of student ID's, full names, courseId's, course names, and grades called StudentGrades.
IF OBJECT_ID('StudentGrades', 'V') IS NOT NULL
	DROP VIEW StudentGrades
GO

CREATE VIEW StudentGrades
AS
	SELECT	S.StudentID,
			S.FirstName + ' ' + S.LastName AS 'FullName',
			C.CourseId,
			C.CourseName,
			R.Mark
	FROM STUDENT S
		INNER JOIN Registration R ON S.StudentID = R.StudentID
		INNER JOIN Course C ON C.CourseId = R.CourseId 
GO

SELECT StudentID, FullName, CourseId, CourseName, Mark
FROM StudentGrades


--4.  Use the student grades view to create a grade report for studentID 199899200 that shows the students ID, full name, course names and marks.
SELECT StudentID, FullName, CourseId, CourseName, Mark
FROM StudentGrades
WHERE StudentID = 199899200

--5.  Select the same information using the student grades view for studentID 199912010.
SELECT StudentID, FullName, CourseId, CourseName, Mark
FROM StudentGrades
WHERE StudentID = 199912010

--6.  Using the student grades view update the mark for studentID 199899200 in course dmit152 to be 90  and change the coursename to be 'basket weaving 101'.
UPDATE StudentGrades
	SET Mark = 90
	WHERE StudentID = 199899200 AND CourseId = 'DMIT152'

UPDATE StudentGrades
	SET CourseName = 'Basket Weaving 101'
	WHERE CourseId = 'DMIT152'

--7.  Using the student grades view, update the  mark for studentID 199899200 in course dmit152 to be 90.
UPDATE StudentGrades
	SET Mark = 90
	WHERE StudentID = 199899200 AND CourseId = 'DMIT152'

--8.  Using the student grades view, delete the same record from question 7.
DELETE FROM StudentGrades
WHERE StudentID = 199899200 AND Mark = 90

--9.  Retrieve the code for the student grades view from the database.
SP_HELPTEXT StudentGrades
