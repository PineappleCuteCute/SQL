create database BTL08
use BTL08

select *from tbl_Media
select *from tbl_Category
select *from tbl_Question
select *from tbl_Answer
SELECT *FROM tbl_User
select * from tbl_Quiz
select * from tbl_User_Quiz
select * from quiz_question
--thêm user
INSERT INTO
	tbl_User (fullName, name, password) 
VALUES 
	('John Doe', 'john', 'password'),
	('Jane Smith', 'jane', 'pass456'),
	('David Brown', 'david', '123abc')
SELECT *
FROM tbl_User

 --THÊM CATEGORY

INSERT INTO Tbl_CATEGORY (category_id, name, info, questioncount, Parent_id) 
VALUES (1,'Category 1', 'Information about Category 1', 4, NULL); 
INSERT INTO Tbl_CATEGORY (category_id,name, info, questioncount, Parent_id) 
VALUES (2,'Category 2', 'Information about Category 2', 2, 1); 
INSERT INTO Tbl_CATEGORY (category_id,name, info, questioncount, Parent_id) 
VALUES (3,'Subcategory 1', 'Information about Subcategory 1', 1, 1); 
INSERT INTO Tbl_CATEGORY (category_id,name, info, questioncount, Parent_id) 
VALUES (4,'Subcategory 2', 'Information about Subcategory 2', 1, NULL);

SELECT *
FROM Tbl_CATEGORY

--thêm quiz
INSERT INTO Tbl_Quiz (name, timeOpen, timeClose, Limit_Time, description) 
VALUES ('Quiz 1', '2023-06-21 09:00:00', '2023-06-21 10:00:00', '00:59:00', 'Description for Quiz 1'); 
INSERT INTO Tbl_Quiz (name, timeOpen, timeClose, Limit_Time, description) 
VALUES ('Quiz 2', '2023-06-22 13:00:00', '2023-06-22 14:30:00', '01:30:00', 'Description for Quiz 2'); 
INSERT INTO Tbl_Quiz (name, timeOpen, timeClose, Limit_Time, description) 
VALUES ('Quiz 3', '2023-06-23 10:30:00', '2023-06-23 12:00:00', '01:30:00', 'Description for Quiz 3'); 

select*
from Tbl_Quiz 

--thêm question
INSERT INTO Tbl_QUESTION (mark, name, text,category_id) 
VALUES (10, 'Q1', 'What is the capital of France?',2); 
INSERT INTO Tbl_QUESTION (mark, name, text,category_id) 
VALUES (5, 'Q2', 'Who painted the Mona Lisa?',3); 
INSERT INTO Tbl_QUESTION (mark, name, text,category_id) 
VALUES (8, 'Q3', 'What is the square root of 64?',2); 
INSERT INTO Tbl_QUESTION (mark, name, text,category_id) 
VALUES (8, 'Q4', 'What is this?',4); 
INSERT INTO Tbl_QUESTION (mark, name, text,category_id) 
VALUES (10, 'Q5', 'How old are you?',1); 
SELECT *
FROM Tbl_QUESTION

--thêm answer
INSERT INTO tbl_Answer(Question_id, choice,is_choice ,grade) 
VALUES (6, 'A',1 ,1); 
INSERT INTO tbl_Answer(Question_id, choice,is_choice ,grade) 
VALUES (7, 'B',1, 1); 
INSERT INTO tbl_Answer(Question_id, choice,is_choice ,grade) 
VALUES (8, 'C', 0, 1); 
INSERT INTO tbl_Answer(Question_id, choice,is_choice ,grade) 
VALUES (9, 'B',1, 1); 
INSERT INTO tbl_Answer(Question_id, choice,is_choice ,grade) 
VALUES (10, 'C', 0, 1); 
 
select *
from tbl_Answer


--thêm Tbl_User_Quiz

INSERT INTO Tbl_User_Quiz ( User_id, Quiz_id, grade) 
VALUES ( 1, 2, 8.5); 
 
INSERT INTO Tbl_User_Quiz ( User_id, Quiz_id, grade) 
VALUES (2, 3, 7.2); 
 
INSERT INTO Tbl_User_Quiz ( User_id, Quiz_id, grade) 
VALUES (3, 1, 9.0); 

select *
from Tbl_User_Quiz


--them Quiz_question

INSERT INTO Quiz_question (Quiz_id, Question_id) 
 VALUES (1, 6),
 (1, 7),
 (1, 8),
 (2, 9),
 (2, 10),
 (2, 6),
 (3, 7),
 (3, 8),
 (3, 9),
 (3, 10)
 
 select *
 from Quiz_question
 

 


select sum(questionCount) as total from tbl_Category where category_id = 1 or parent_id = 1