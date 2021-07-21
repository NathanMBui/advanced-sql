--Init DATABASE

--1. Select all primary skills that contain more than one word (please note that both ‘-‘ and ‘ ’ could be used as a separator). – 0.2 points

--2. Select all students who do not have a second name (it is absent or consists of only one letter/letter with a dot). – 0.2 points

--3. Select number of students passed exams for each subject and order result by a number of student descending. – 0.2 points

--4. Select the number of students with the same exam marks for each subject. – 0.2 points

--5. Select students who passed at least two exams for different subjects. – 0.3 points

--6. Select students who passed at least two exams for the same subject. – 0.3 points

--7. Select all subjects which exams passed only students with the same primary skills. – 0.3 points

--8. Select all subjects which exams passed only students with the different primary skills. It means that all students passed the exam for the one subject must have different primary skill. – 0.4 points

--9. Select students who do not pass any exam using each of the following operator: – 0.5 points
--	* Outer join
--	* Subquery with ‘not in’ clause
--	* Subquery with ‘any ‘ clause Check which approach is faster for 1000, 10K, 100K exams and 10, 1K, 100K students
--10. Select all students whose average mark is bigger than the overall average mark. – 0.3 points

--11. Select the top 5 students who passed their last exam better than average students. – 0.3 points

--12. Select the biggest mark for each student and add text description for the mark (use COALESCE and WHEN operators) – 0.3 points
--	* In case if the student has not passed any exam ‘not passed' should be returned.
--	* If the student mark is 1,2,3 – it should be returned as ‘BAD’
--	* If the student mark is 4,5,6 – it should be returned as ‘AVERAGE’
--	* If the student mark is 7,8 – it should be returned as ‘GOOD’
--	* If the student mark is 9,10 – it should be returned as ‘EXCELLENT’

--13. Select the number of all marks for each mark type (‘BAD’, ‘AVERAGE’,…). – 0.4 points 