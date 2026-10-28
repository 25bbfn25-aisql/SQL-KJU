CREATE DATABASE student;
USE student;

CREATE TABLE details
(
  student_id INT,
  name VARCHAR(50),
  age INT,
  city VARCHAR(30),
  marks INT
);

INSERT INTO details(student_id, name, age, city, marks)
VALUES
(1, 'Priya', 19, 'Mumbai', 88),
(2, 'Rahul', 21, 'Pune', 76),
(3, 'Sneha', 20, 'Bengaluru', 92);

SELECT * FROM details;