CREATE DATABASE KJU;
USE KJU;
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
(1, 'PRIYA', 19, 'Mumbai', 88),
(2, 'RAHUL', 21, 'Chennai', 76),
(3, 'SNEHA', 20, 'Bengaluru', 92),
(4, 'KARTHIK', 22, 'Hyderabad', 81),
(5, 'DIVYA', 19, 'Delhi', 75),
(6, 'ROHAN', 18, 'Pune', 86),
(7, 'MEENA', 21, 'Chennai', 79),
(8, 'ARJUN', 20, 'Bengaluru', 95),
(9, 'PAVITHRA', 18, 'Mumbai', 68),
(10, 'VIKRAM', 22, 'Delhi', 85);
SELECT *FROM students;
SELECT name, marks FROM students;
SELECT *FROM students WHERE age = 20;
SELECT *FROM students WHERE marks > 80;