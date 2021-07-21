--Init DATABASE
--DROP DATABASE DB_SCHOOL;
--CREATE DATABASE DB_SCHOOL;

DROP TABLE IF EXISTS ExamResults;
DROP TABLE IF EXISTS Exams;
DROP TABLE IF EXISTS Subjects;
DROP TABLE IF EXISTS Students;
CREATE TABLE Students (
	id bigint GENERATED ALWAYS AS IDENTITY,
	name varchar,
	surname varchar NOT NULL,
	second_name varchar,
	birthday date,
	phone_numbers varchar,
	primary_skill text,
	created_datetime timestamptz,
	updated_datetime timestamptz,
	PRIMARY KEY (id)
);

CREATE TABLE Subjects(
	id bigint GENERATED ALWAYS AS IDENTITY,
	name varchar,
	created_datetime timestamptz,
	updated_datetime timestamptz,
	PRIMARY KEY (id)
);

CREATE TABLE Exams(
	id bigint GENERATED ALWAYS AS IDENTITY,
	name varchar NOT NULL,
	created_datetime timestamptz,
	updated_datetime timestamptz,
	PRIMARY KEY (id)
);

CREATE TABLE ExamResults(
	id bigint GENERATED ALWAYS AS IDENTITY,
	student_id bigint NOT NULL,
	exam_id bigint NOT NULL,
	subject_id bigint NOT NULL,
	score int NOT NULL,
	created_datetime timestamptz,
	updated_datetime timestamptz,
	PRIMARY KEY (id),
	CONSTRAINT fk_students
		FOREIGN KEY (student_id)
			REFERENCES Students(id),
	CONSTRAINT fk_subjects
		FOREIGN KEY (subject_id)
			REFERENCES Subjects(id),
	CONSTRAINT fk_exams
		FOREIGN KEY (exam_id)
			REFERENCES Exams(id)
);

INSERT INTO Students(name, surname, second_name, primary_skill, created_datetime)
VALUES 
('Tony', 'Stark', 'Iron Man', 'Java-Kotlin', CURRENT_TIMESTAMP),
('Thor', 'Odinson', null, 'React', CURRENT_TIMESTAMP),
('Steve', 'Roger', 'Captain America', '.net C# C++', CURRENT_TIMESTAMP),
('Loki', 'Laufeyson', 'G.', 'Python', CURRENT_TIMESTAMP);

INSERT INTO Subjects(name, created_datetime)
VALUES 
('Algorithm', CURRENT_TIMESTAMP),
('OOP', CURRENT_TIMESTAMP),
('FP', CURRENT_TIMESTAMP);

INSERT INTO Exams(name, created_datetime)
VALUES
('Semester 1', CURRENT_TIMESTAMP),
('Semester 2', CURRENT_TIMESTAMP),
('Semester 3', CURRENT_TIMESTAMP);

INSERT INTO ExamResults(student_id, exam_id, subject_id, score, created_datetime)
VALUES
(1, 1, 1, 100, CURRENT_TIMESTAMP),
(1, 1, 2, 50, CURRENT_TIMESTAMP),
(1, 1, 3, 10, CURRENT_TIMESTAMP),

(2, 1, 1, 80, CURRENT_TIMESTAMP),
(2, 1, 2, 90, CURRENT_TIMESTAMP),
(2, 1, 3, 20, CURRENT_TIMESTAMP),

(3, 1, 1, 30, CURRENT_TIMESTAMP),
(3, 1, 2, 50, CURRENT_TIMESTAMP),
(3, 1, 3, 10, CURRENT_TIMESTAMP),

(1, 2, 1, 60, CURRENT_TIMESTAMP),
(1, 2, 2, 50, CURRENT_TIMESTAMP),
(1, 2, 3, 10, CURRENT_TIMESTAMP),
	
(2, 2, 1, 30, CURRENT_TIMESTAMP),
(2, 2, 2, 90, CURRENT_TIMESTAMP),
(2, 2, 3, 20, CURRENT_TIMESTAMP),
	
(3, 2, 1, 70, CURRENT_TIMESTAMP),
(3, 2, 2, 30, CURRENT_TIMESTAMP),
(3, 2, 3, 60, CURRENT_TIMESTAMP);

--1. Select all primary skills that contain more than one word (please note that both ‘-‘ and ‘ ’ could be used as a separator). – 0.2 points
SELECT primary_skill
FROM Students
WHERE primary_skill LIKE '% %'
OR primary_skill LIKE '%-%';

--2. Select all students who do not have a second name (it is absent or consists of only one letter/letter with a dot). – 0.2 points
SELECT *
FROM Students
WHERE second_name is NULL
OR second_name LIKE '_.';

--3. Select number of students passed exams for each subject and order result by a number of student descending. – 0.2 points
SELECT s.name AS Subject, COUNT(*) AS Passed
FROM ExamResults AS r
INNER JOIN Subjects AS s ON r.subject_id = s.id
WHERE r.score >= 50
GROUP BY s.name
ORDER BY Passed DESC

--4. Select the number of students with the same exam marks for each subject. – 0.2 points
SELECT s.name AS Subject, r.score as Marks, COUNT(*) AS Count
FROM ExamResults AS r
INNER JOIN Subjects AS s ON r.subject_id = s.id
GROUP BY s.name, r.score
ORDER BY s.name ASC, r.score DESC;

--5. Select students who passed at least two exams for different subjects. – 0.3 points
SELECT Student, Count(*) AS ExamCount
FROM (
	SELECT DISTINCT Student, Exam
	FROM (
		SELECT Student, Subject, Exam 
		FROM (
			SELECT st.name AS Student, s.name as Subject, e.name AS Exam, Count(*) AS ExamCount
			FROM ExamResults AS r
			INNER JOIN Subjects AS s ON s.id = r.subject_id
			INNER JOIN Exams AS e ON e.id = r.exam_id
			INNER JOIN Students AS st ON st.id = r.student_id
			WHERE r.score >= 50
			GROUP BY Subject, Student, Exam 
		) AS Sub
	) AS Sub2
) AS Sub3
GROUP BY Student
ORDER BY Student

--6. Select students who passed at least two exams for the same subject. – 0.3 points
SELECT Student, Subject, ExamCount
FROM (
	SELECT st.name AS Student, s.name as Subject, Count(*) AS ExamCount
	FROM ExamResults AS r
	INNER JOIN Subjects AS s ON s.id = r.subject_id
	INNER JOIN Exams AS e ON e.id = r.exam_id
	INNER JOIN Students AS st ON st.id = r.student_id
	WHERE r.score >= 50
	GROUP BY Subject, Student
) AS Sub
WHERE ExamCount >= 2
ORDER BY Student;

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