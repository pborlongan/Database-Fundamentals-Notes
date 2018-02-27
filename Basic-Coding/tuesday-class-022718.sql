-- SIMPLE SELECT EXERCISE 1

USE [A01-School]
GO

-- simple select, without any other clauses
SELECT 'Dan', 'Gilleland'

-- simple select with expressions
SELECT 'Dan' + ' ' + 'Gilleland', 18 * 52

-- specify a column name with some hard-code/calculated values
SELECT 'Dan' + ' ' + 'Gilleland' AS 'Instructor',
		18 * 52 AS 'Weeks at the job'

-- use the SELECT statement with database table

-- 1. Select all the information from the Club table
SELECT ClubId, ClubName
FROM Club
-- pro-tip: if you write the FROM clause before specifying the columns,
--			you will get intellisense help on the column table names
-- pro-tip: press [ctrl] + [shift] + [r] to "refresh" intellisense

-- 2. Select the FirstName and LastName of all students
SELECT FirstName, LastName
FROM Student
-- 2.a. Repeat the above query, but using column aliases
SELECT FirstName AS 'First Name', LastName AS 'Last Name'
FROM Student
-- 2.b. Select the student id and full name of all the students
SELECT StudentId, FirstName + ' ' + LastName AS 'Full Name'
FROM Student

-- 3. Select all the CourseId and CourseName of all the courses. Use the column aliases of Course ID and Course Name
SELECT CourseId as 'Course ID', CourseName AS 'Course Name'
FROM Course

-- 4. Select all the course information for courseID 'DMIT101'
--	  Dan will mark the following as a ZERO
--			SELECT * FROM COURSE
SELECT CourseId, CourseName, CourseHours, MaxStudents, CourseCost
FROM Course
WHERE CourseID = 'DMIT101'

-- 5. Select the staff names who have positionID of 3
SELECT FirstName + ' ' + LastName AS 'Full Name'
	-- , PositionID  -- PRESS [CTRL] + [K], THEN [CTRL] + [U] TO UN-COMMENT
FROM Staff
WHERE PositionID = '3'

-- BTW, what is PositionID of 3 referring to
SELECT PositionID, PositionDescription
FROM Position

-- 6. Select the Course Names whose course hours are less than 96
SELECT C.CourseName
FROM Course C -- I can have an alias to the table
WHERE C.CourseHours < 96

-- 7. Select the StudentIds, CourseID, and mark where mark is between 70 and 80
SELECT StudentId, CourseId, Mark
FROM Registration
WHERE Mark >= 70 AND Mark <= 80

-- 7.a. Select the StudentIds where the withdrawal status is null
SELECT StudentId
FROM Registration
WHERE WithdrawYN IS NULL

-- 7.b. Select the StudentIds of students who have withdrawn from a course
SELECT StudentId, CourseId
FROM Registration
WHERE WithdrawYN = 'Y'

-- 8. Select the StudentIds, CourseID, and mark where the mark is between 70 and 80
--	  and the courseID is DMIT223 or DMIT168
SELECT R.StudentId, R.CourseID, R.Mark
FROM Registration R
WHERE R.Mark BETWEEN 70 AND 80 AND (CourseId ='DMIT223' OR CourseId = 'DMIT168')

-- 8.a. Select the StudentIds, CourseID and mark where the mark is 80 and 85
SELECT R.StudentId, R.CourseID, R.Mark
FROM Registration R
WHERE R.MARK = 80 OR R.Mark = 85


/**
        NEW STUFF HERE BITCHHHH
**/

-- The next two questions introcduce the idea of "wildcards" and patter matching in the WHERE clause
-- _ is a wildcard for a single character
-- % is a wildcard for zero or more characters
-- [] is a pattern for a single character matching the pattern in the square brackets

-- 9. Select the students first and last name who have last names starting with S
SELECT FirstName, LastName
FROM Student
WHERE LastName LIKE 'S%' 

-- 10. Select CourseNames whose CourseID have a 1 as the fifth character
SELECT CourseName, CourseId
FROM Course
WHERE CourseId LIKE '____1%'

-- 11. Select the CourseIds and CourseNames where the CourseName contains the word 'programming'
SELECT CourseId, CourseName
FROM Course
WHERE CourseName LIKE '%programming%'

-- 12. Select all the ClubNames which start with n or c.
SELECT ClubName
FROM Club
WHERE ClubName LIKE 'N%' OR ClubName LIKE 'C%'

-- 13. Select Student Name, Street Address and City where the LastName has only 3 letters long
SELECT FirstName + ' ' + LastName AS 'Student Name', StreetAddress + ' ' City 
FROM Student
WHERE LastName LIKE '[A-Z][A-Z][A-Z]'

-- 14. Select all the StudentIDs where the PaymentAmount < 500 or PaymentTypeID is 5
SELECT StudentID, Amount, PaymentTypeID
FROM Payment
WHERE Amount < 500 OR PaymentTypeID = 5