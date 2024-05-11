create database stud_database;
show databases;
use stud_database;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    father_name VARCHAR(255),
    mother_name VARCHAR(255),
    guardian_name VARCHAR(255),
    phone_no VARCHAR(15),
    email VARCHAR(255),
    address VARCHAR(255),
    blood_group VARCHAR(10),
    grades VARCHAR(255),
    courses VARCHAR(255),
    identification_marks VARCHAR(255),
    medical_problems VARCHAR(255)
);
describe students;

CREATE TABLE admins (
    admin_id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    student_id VARCHAR(255),
    staff_id VARCHAR(255),
    phone_no VARCHAR(255)
);

CREATE TABLE teachers (
    staff_id VARCHAR(255) PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    student_id VARCHAR(255),
    password VARCHAR(255) NOT NULL,
    class_id VARCHAR(255),
    name VARCHAR(255) NOT NULL,
    phone_no VARCHAR(255),
    address TEXT,
    courses TEXT
);

CREATE TABLE parents (
    parent_id VARCHAR(255) PRIMARY KEY,
    father_name VARCHAR(255),
    mother_name VARCHAR(255),
    guardian_name VARCHAR(255),
    phone_no VARCHAR(255),
    annual_income DECIMAL(10, 2),
    student_id VARCHAR(255),
    fees_details TEXT
);

DESCRIBE students;
select * from students;
SELECT name
FROM students
WHERE name LIKE '%C%';

SELECT name,grades
FROM students
ORDER BY grades;

SELECT name
FROM teachers
WHERE phone_number = '09';

INSERT INTO admins (admin_id, username, password, student_id, staff_id, phone_no)
VALUES ('ADM001', 'admin', 'adminpassword', NULL, NULL, '9876543210');

SELECT* FROM admins;
UPDATE admins
SET phone_no = '9876543211'
WHERE admin_id = 'ADM001';

DELETE FROM admins
WHERE admin_id = 'ADM001';

