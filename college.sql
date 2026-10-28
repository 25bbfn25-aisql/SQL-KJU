CREATE DATABASE college;
USE college;

CREATE TABLE students
(
  student_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  age INT,
  city VARCHAR(30),
  marks INT
);

INSERT INTO students(student_id, name, age, city, marks)
VALUES
(1, 'Rahul', 19, 'Bangalore', 88),
(2, 'Priya', 20, 'Mumbai', 76),
(3, 'Karthik', 21, 'Delhi', 92);

SELECT * FROM students;

SELECT name, marks FROM students;

SELECT * FROM students WHERE age = 19;

SELECT * FROM students WHERE marks > 80;

UPDATE students
SET marks = 95
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 2;

SELECT * FROM students ORDER BY marks;

SELECT * FROM students ORDER BY marks DESC;

SELECT * FROM students LIMIT 3;

SELECT * FROM students ORDER BY marks DESC LIMIT 5;

SELECT * FROM students
WHERE city = 'Delhi' AND marks > 70;

SELECT * FROM students
WHERE city = 'Delhi' OR city = 'Chennai';

SELECT * FROM students
WHERE city IN ('Delhi', 'Mumbai', 'Chennai');

SELECT * FROM students
WHERE marks BETWEEN 70 AND 90;