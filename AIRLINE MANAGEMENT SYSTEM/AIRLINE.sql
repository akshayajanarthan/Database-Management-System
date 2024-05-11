create database airlines_database;

use airlines_database;

CREATE TABLE Login (
    Login_id INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL
);
INSERT INTO Login (Login_id, Username, Password) 
VALUES 
    ('1', 'user1', 'password1'),
    ('2', 'user2', 'password2'),
    ('3', 'user3', 'password3'),
    ('4', 'user4', 'password4'),
    ('5', 'user5', 'password5'),
    ('6', 'user6', 'password6');
SELECT * FROM Login;

CREATE TABLE Flight (
    FlightID INT PRIMARY KEY,
    FlightSource VARCHAR(255),
    FlightDestination VARCHAR(255),
    FlightTime TIME,
    FlightDate DATE
);
select F.FlightDestination,F.FlightSource,F.FlightID,R.FlightID
from Flight F
inner join Runway R on F.FlightID = R.FlightID
where F.FlightID = 1;
grant select, insert on Flight to '1';
    
INSERT INTO Flight (FlightID, FlightSource, FlightDestination, FlightTime, FlightDate) 
VALUES 
    (1, 'London', 'Paris', '08:00:00', '2024-04-06'),
    (2, 'Paris', 'Madrid', '10:30:00', '2024-04-06'),
    (3, 'Madrid', 'Berlin', '12:45:00', '2024-04-06'),
    (4, 'Berlin', 'Rome', '15:15:00', '2024-04-06'),
    (5, 'Rome', 'Tokyo', '18:00:00', '2024-04-06'),
    (6, 'Tokyo', 'London', '21:30:00', '2024-04-06');
    SELECT* FROM FLIGHT;
    
CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY,
    FlightID INT,
    PassengerName VARCHAR(255),
    PassengerCell VARCHAR(20),
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);
INSERT INTO Passenger (PassengerID,FlightID, PassengerName, PassengerCell) 
VALUES 
    (101,1, 'John Doe', '123-456-7890'),
    (102,2, 'Jane Smith', '987-654-3210'),
    (103,3, 'Michael Johnson', '456-789-0123'),
    (104,4, 'Emily Davis', '789-012-3456'),
    (105,5, 'David Wilson', '321-654-9870'),
    (106,6, 'Sarah Brown', '654-321-0987');
SELECT * FROM Passenger;

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY,
    PassengerID INT,
    TicketType VARCHAR(50),
    Booking_id INT,
    Booking_type VARCHAR(255),
    Booking_desc TEXT,
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID)
);
INSERT INTO Ticket (TicketID,PassengerID, TicketType, Booking_id, Booking_type, Booking_desc) 
VALUES 
    ('001',101,'Economy', 101, 'Online', 'Standard economy ticket booked online'),
    ('002',102, 'Business', 102, 'Counter', 'Business class ticket booked at counter'),
    ('003',103, 'Economy', 103, 'Online', 'Standard economy ticket booked online'),
    ('004',104, 'First Class', 104, 'Online', 'First class ticket booked online'),
    ('005',105, 'Economy', 105, 'Counter', 'Standard economy ticket booked at counter'),
    ('006',106, 'Business', 106, 'Online', 'Business class ticket booked online');
SELECT * FROM Ticket;

CREATE TABLE Staff (
    StaffMemberID INT PRIMARY KEY,
    StaffMemberName VARCHAR(255),
    StaffMemberDesignation VARCHAR(255),
    StaffMemberContact VARCHAR(20),
    TowerAssigned VARCHAR(255)
);
INSERT INTO Staff (StaffMemberID,StaffMemberName, StaffMemberDesignation, StaffMemberContact, TowerAssigned) 
VALUES 
    ('001','Alice Johnson', 'Air Traffic Controller', '111-222-3333', 'Tower A'),
    ('002','Bob Smith', 'Ground Crew', '444-555-6666', 'Tower B'),
    ('003','Charlie Brown', 'Flight Operations Manager', '777-888-9999', 'Tower C'),
    ('004','Diana Wilson', 'Security Officer', '123-456-7890', 'Tower D'),
    ('005','Ethan Davis', 'Aircraft Maintenance Engineer', '321-654-9870', 'Tower E'),
    ('006','Fiona Taylor', 'Customer Service Representative', '987-654-3210', 'Tower F');
SELECT * FROM Staff;

CREATE TABLE Runway (
    RunwayID INT PRIMARY KEY,
    RunwayTrack VARCHAR(255),
    FlightID INT,
    FOREIGN KEY (FlightID) REFERENCES Flight(FlightID)
);
INSERT INTO Runway (RunwayID,RunwayTrack, FlightID) 
VALUES 
    ('001','Track 1', 1),
    ('002','Track 2', 2),
    ('003','Track 3', 3),
    ('004','Track 4', 4),
    ('005','Track 5', 5),
    ('006','Track 6', 6);
SELECT * FROM Runway; 
INSERT INTO Flight (FlightID, FlightSource, FlightDestination, FlightTime, FlightDate)
VALUES 
(1, 'City A', 'City B', '08:00:00', '2024-03-17'),
(2, 'City C', 'City D', '09:30:00', '2024-03-18'),
(3, 'City E', 'City F', '11:00:00', '2024-03-19');

-- Inserting into the Passenger table
INSERT INTO Passenger (PassengerID, FlightID, PassengerName, PassengerCell)
VALUES 
(1, 1, 'John Doe', '1234567890'),
(2, 2, 'Jane Smith', '9876543210'),
(3, 3, 'Alice Johnson', '5555555555');

-- Inserting into the Ticket table
INSERT INTO Ticket (TicketID, PassengerID, TicketType, Booking_type, Booking_desc)
VALUES 
(1,1, 'Economy', 'Online', 'Booking for John Doe on Flight 1'),
(2,2, 'Business', 'Offline', 'Booking for Jane Smith on Flight 2'),
(3,3, 'First Class', 'Online', 'Booking for Alice Johnson on Flight 3');

-- Inserting into the Staff table
INSERT INTO Staff (StaffMemberID, StaffMemberName, StaffMemberDesignation, StaffMemberContact, TowerAssigned)
VALUES 
(1, 'Staff Member 1', 'Pilot', '1234567890', 'Tower 1'),
(2, 'Staff Member 2', 'Flight Attendant', '9876543210', 'Tower 2'),
(3, 'Staff Member 3', 'Ground Crew', '5555555555', 'Tower 3');

-- Inserting into the Runway table
INSERT INTO Runway (RunwayID, RunwayTrack, FlightID)
VALUES 
(1, 'Track 1', 1),
(2, 'Track 2', 2),
(3, 'Track 3', 3);

SELECT Flight.FlightID, Flight.FlightSource, Flight.FlightDestination, Flight.FlightTime, Flight.FlightDate,
       Passenger.PassengerID, Passenger.PassengerName, Passenger.PassengerCell,
       Ticket.TicketID, Ticket.TicketType
FROM Flight
INNER JOIN Passenger ON Flight.FlightID = Passenger.FlightID
INNER JOIN Ticket ON Passenger.PassengerID = Ticket.PassengerID
WHERE Flight.FlightID = '2';

DELETE FROM Staff
WHERE StaffMemberID = 1;
select * from Staff;

SELECT Passenger.PassengerID, Passenger.PassengerName, Passenger.PassengerCell,
       Ticket.TicketID, Ticket.TicketType
FROM Passenger
INNER JOIN Ticket ON Passenger.PassengerID = Ticket.PassengerID
WHERE Passenger.FlightID = '3';

SELECT COUNT(*) FROM Flight;


SELECT *
FROM Flight
WHERE FlightSource = 'City A' AND FlightDestination = 'City B';

DELETE FROM Ticket 
WHERE Booking_id = 101;
SELECT * FROM Ticket;


SELECT * FROM Passenger WHERE FlightID IN (SELECT FlightID FROM Flight WHERE FlightSource = 'London');

SELECT Flight.FlightID, Flight.FlightSource, Flight.FlightDestination, Passenger.PassengerName
FROM Flight
INNER JOIN Passenger ON Flight.FlightID = Passenger.FlightID;

SELECT COUNT(*) AS TotalFlights FROM Flight;
UPDATE Flight 
SET FlightTime = '09:00:00' 
WHERE FlightID = 1;



