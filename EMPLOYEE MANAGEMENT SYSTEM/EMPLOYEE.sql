create database employee_database;
show databases;
use employee_database;
CREATE TABLE employees (
    employee_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone_number VARCHAR(255),
    hire_date DATE
);
select*from employees;
CREATE TABLE departments (
    department_id VARCHAR(255) PRIMARY KEY,
    department_name VARCHAR(255) NOT NULL
);
CREATE TABLE positions (
    position_id VARCHAR(255) PRIMARY KEY,
    position_title VARCHAR(255) NOT NULL
);
CREATE TABLE salary (
    salary_id VARCHAR(255) PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    employee_id VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
RENAME TABLE salarys TO salaries;
show tables;

CREATE TABLE attendance (
    attendance_id VARCHAR(255) PRIMARY KEY,
    employee_id VARCHAR(255),
    date DATE,
    time_in TIME,
    time_out TIME,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
CREATE TABLE `leave` (
    leave_id VARCHAR(255) PRIMARY KEY,
    employee_id VARCHAR(255),
    start_date DATE,
    end_date DATE,
    reason TEXT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
CREATE TABLE projects (
    project_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    start_date DATE,
    end_date DATE
);
CREATE TABLE project_employee (
    project_id VARCHAR(255),
    employee_id VARCHAR(255),
    PRIMARY KEY (project_id, employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
show tables;

select*from employees;
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, hire_date)
VALUES ('004', 'John', 'Doe', 'john.doe@example.com', '1234567890', '2023-01-15');
select * from employees;

UPDATE employees
SET email = 'akshayajanarthanreddy@gmail.com', phone_number = '9345983566'
WHERE employee_id = '002';

DELETE FROM employees
WHERE employee_id = '004';

