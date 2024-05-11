create database railways_database;
use railways_database;
CREATE TABLE Login (
    Login_id INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL
);
CREATE TABLE Passenger (
    Passenger_ID INT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    Contact_Number VARCHAR(20),
    Email VARCHAR(255)
);
CREATE TABLE Booking (
    Booking_id INT PRIMARY KEY AUTO_INCREMENT,
    Booking_type VARCHAR(255),
    Booking_desc TEXT,
    Passenger_ID INT,
    FOREIGN KEY (passenger_id)REFERENCES passenger(passenger_id)
);
CREATE TABLE Train (
    Train_ID INT PRIMARY KEY,
    Train_Name VARCHAR(255),
    Source_Station VARCHAR(255),
    Destination_Station VARCHAR(255),
    Departure_Time TIME,
    Arrival_Time TIME
);
CREATE TABLE Ticket (
    Ticket_ID INT PRIMARY KEY,
    Train_ID INT,
    Passenger_ID INT,
    Seat_Number VARCHAR(20),
    Class VARCHAR(50),
    Fare DECIMAL(10, 2),
    FOREIGN KEY (Train_ID) REFERENCES Train(Train_ID),
    FOREIGN KEY (Passenger_ID) REFERENCES Passenger(Passenger_ID)
);
CREATE TABLE Station (
    Station_ID INT PRIMARY KEY,
    Station_Name VARCHAR(255),
    Location VARCHAR(255),
    Zone VARCHAR(50)
);
CREATE TABLE Schedule (
    Schedule_ID INT PRIMARY KEY,
    Train_ID INT,
    Station_ID INT,
    Arrival_Time TIME,
    Departure_Time TIME,
    FOREIGN KEY (Train_ID) REFERENCES Train(Train_ID),
    FOREIGN KEY (Station_ID) REFERENCES Station(Station_ID)
);
INSERT INTO Passenger (Passenger_ID, Name, Age, Gender, Contact_Number, Email) 
VALUES 
(1, 'John Doe', 30, 'Male', '1234567890', 'john.doe@example.com'),
(2, 'Jane Smith', 25, 'Female', '9876543210', 'jane.smith@example.com'),
(3, 'Alice Johnson', 35, 'Female', '5555555555', 'alice.johnson@example.com');
-- Adding data to the Train table
INSERT INTO Train (Train_ID, Train_Name, Source_Station, Destination_Station, Departure_Time, Arrival_Time) 
VALUES 
(1, 'Express 1', 'Station A', 'Station B', '08:00:00', '12:00:00'),
(2, 'Local 1', 'Station C', 'Station D', '09:30:00', '11:45:00'),
(3, 'Express 2', 'Station B', 'Station E', '10:00:00', '15:30:00');

-- Adding data to the Ticket table
INSERT INTO Ticket (Ticket_ID, Train_ID, Passenger_ID, Seat_Number, Class, Fare) 
VALUES 
(1, 1, 1, 'A101', 'First Class', 50.00),
(2, 2, 2, 'B202', 'Second Class', 30.00),
(3, 3, 3, 'C303', 'First Class', 70.00);
-- Adding data to the Station table
INSERT INTO Station (Station_ID, Station_Name, Location, Zone)
VALUES 
(1, 'Station A', 'City A', 'Zone 1'),
(2, 'Station B', 'City B', 'Zone 2'),
(3, 'Station C', 'City C', 'Zone 3');

-- Adding data to the Schedule table
INSERT INTO Schedule (Schedule_ID, Train_ID, Station_ID, Arrival_Time, Departure_Time)
VALUES 
(1, 1, 1, '08:00:00', '08:05:00'),
(2, 1, 2, '09:00:00', '09:05:00'),
(3, 2, 3, '10:00:00', '10:05:00');


SELECT Ticket.Ticket_ID, Ticket.Seat_Number, Ticket.Class, Ticket.Fare,
       Passenger.Name AS Passenger_Name, Passenger.Age, Passenger.Gender, Passenger.Contact_Number, Passenger.Email,
       Train.Train_Name, Train.Source_Station, Train.Destination_Station
FROM Ticket
INNER JOIN Passenger ON Ticket.Passenger_ID = Passenger.Passenger_ID
INNER JOIN Train ON Ticket.Train_ID = Train.Train_ID
WHERE Ticket.Ticket_ID = '1';


SELECT Schedule.Schedule_ID, Schedule.Arrival_Time, Schedule.Departure_Time,
       Train.Train_Name, Train.Source_Station, Train.Destination_Station
FROM Station
INNER JOIN Schedule ON Station.Station_ID = Schedule.Station_ID
INNER JOIN Train ON Schedule.Train_ID = Train.Train_ID
WHERE Station.Station_ID = '2';



