--Simple Select Exercise 3
-- This sample set illustrates the GROUP BY syntax and the use of Aggregate functions
-- with GROUP BY.
-- It also demonstrates the HAVING clause to filter on aggregate values.

/**
	GROUP BY - Takes the results of SELECT and FROM and produces another set of results where similar values exist for the group-by columns
	HAVING - used to filter the results based on the aggregate values
**/
USE [A01-School]
GO


--1. Select the average mark for each course. Display the CourseID and the average mark
--	 Let's begin by exploring the registration table to see the date we are working with
SELECT CourseId, Mark
FROM Registration
ORDER BY CourseId
--	 Answer to #1

SELECT CourseId,					-- this column is a non-aggregate
	   AVG(Mark) AS 'Average Mark'	-- this column performs aggregate (produce 1 value)
FROM Registration
GROUP BY CourseId					-- group by the non-aggregate columns
-- when performing an aggregate function in the SELECT clause, if you have any other non-aggregate columns in the SELECT clause, then these must be listed in the GROUP BY clause

--2. How many payments where made for each payment type. Display the Payment Type ID and the count
SELECT PaymentTypeID,								-- Non-aggregate column (an FK)
	   COUNT(PaymentID) AS 'Count of Pay Type'		-- Aggeregate column
FROM Payment
GROUP BY PaymentTypeID

--2.A. Do the same as above, but sort it from most frequent payment type to the least frequent
SELECT PaymentTypeID,								-- Non-aggregate column (an FK)
	   COUNT(PaymentID) AS 'Count of Pay Type'		-- Aggeregate column
FROM Payment
GROUP BY PaymentTypeID
ORDER BY COUNT(PaymentTypeID)

--3. Select the average Mark for each studentID. Display the StudentId and their average mark
SELECT StudentID,
	   AVG(Mark) AS 'Student Average Mark'
FROM Registration
GROUP BY StudentID

--4. Select the same data as question 3 but only show the studentID's and averages that are > 80
SELECT StudentID,
	   AVG(Mark) AS 'Student Average Mark'
FROM Registration
GROUP BY StudentID
-- The having clause is where we do filtering of aggregate information
HAVING AVG(Mark) > 80

--5. How many students are from each city? Display the City and the count.
SELECT City,
	   COUNT(City) AS 'Students From This City'
FROM Student
GROUP BY City

--6. Which cities have 2 or more students from them? (HINT, remember that fields that we use in the where or having do not need to be selected.....)
SELECT City
--	   , COUNT(StudentID) AS 'Student Count'
FROM Student
GROUP BY City
HAVING COUNT(StudentID) >= 2

--7. What is the highest, lowest and average payment amount for each payment type?
SELECT	MAX(Amount) AS 'Highest Payment Amount',
		MIN(Amount) AS 'Lowest Payment Amount',
		AVG(Amount) AS 'Average Payment Amount'
FROM Payment
GROUP BY PaymentTypeID

--8. How many students are there in each club? Show the clubID and the count
SELECT ClubId,
	   COUNT(ClubId) AS 'Student Count'
FROM Activity
GROUP BY ClubId

--9. Which clubs have 3 or more students in them?
SELECT ClubId,
	   COUNT(ClubId) AS 'Student Count'
FROM Activity
GROUP BY ClubId
HAVING COUNT(ClubId) >= 3