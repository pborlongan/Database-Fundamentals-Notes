--Simple Select Exercise 2
-- This set of exercises demonstrates performing simple Aggregate functions
-- to get results such as SUM(), AVG(), COUNT() 
-- All aggregates are done using built-in functions in the database
Use [A01-School]
GO

--1.	Select the average Mark from all the Marks in the registration table
        SELECT AVG(Mark) AS 'Average Mark'
        FROM Registration

--1.a.  Show the average mark, the total of all marks, and a count of all marks.
 SELECT AVG(Mark) AS 'Average Mark',
	   SUM(Mark) AS 'Total of Marks',
	   COUNT(Mark) AS 'How Many Marks'
FROM Registration

--2.	Select the average Mark of all the students who are taking DMIT104
SELECT AVG(Mark) AS 'Average Mark'
FROM Registration
WHERE CourseId = 'DMIT104'


--3.	Select how many students are there in the Student Table
SELECT COUNT(StudentID) AS 'Total Number of Students'
FROM Student

--4.	Select how many students are taking (have a grade for) DMIT152
SELECT COUNT(StudentID) AS 'Total Number of Students taking DMIT152'
FROM Registration
WHERE Mark > 0 AND CourseId = 'DMIT152'

--5.	Select the average payment amount for payment type 5
SELECT AVG(Amount) AS 'Average Payment Amount for Payment Type 5'
FROM Payment
WHERE PaymentTypeID = '5'


-- Given that there are some other aggregate methods like MAX(columnName) and MIN(columnName), complete the following two questions:
--6. Select the highest payment amount
SELECT MAX(Amount) AS 'Highest Payment Amount'
FROM Payment


--7.	 Select the lowest payment amount
SELECT MIN(Amount) AS 'Lowest Payment Amount'
FROM Payment


--8. Select the total of all the payments that have been made
SELECT SUM(Amount) AS 'Overall Total Payment'
FROM Payment

--9. How many different payment types does the school accept?
SELECT COUNT(PaymentTypeID) AS 'Payment Types Available'
FROM PaymentType

--10. How many students are in club 'CSS'?
SELECT COUNT(StudentID) AS 'Students in CSS Club'
FROM Activity
WHERE ClubId = 'CSS'
