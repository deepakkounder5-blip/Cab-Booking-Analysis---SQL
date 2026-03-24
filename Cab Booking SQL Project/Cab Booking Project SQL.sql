CREATE DATABASE CB;
use CB;
CREATE TABLE Customers (
        CustomerID INT PRIMARY KEY AUTO_INCREMENT,
        FirstName VARCHAR(50),
        LastName VARCHAR(50),
        Email VARCHAR(100) UNIQUE,
        PhoneNumber VARCHAR(20) UNIQUE,
        RegistrationDate DATETIME DEFAULT CURRENT_TIMESTAMP
    );
    
CREATE TABLE Drivers (     
		DriverID INT PRIMARY KEY AUTO_INCREMENT,     
        FirstName VARCHAR(50),     LastName VARCHAR(50),     
        PhoneNumber VARCHAR(20) UNIQUE,     
        LicenseNumber VARCHAR(50) UNIQUE,     
        AverageRating DECIMAL(3, 2) DEFAULT 5.0 
        );
        
	CREATE TABLE Cabs (
    CabID INT PRIMARY KEY AUTO_INCREMENT,
    DriverID INT,
    VehicleModel VARCHAR(50),
    VehicleType VARCHAR(20), -- e.g., 'Sedan', 'SUV', 'Hatchback'
    LicensePlate VARCHAR(20) UNIQUE,
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID)
);

CREATE TABLE Bookings (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    DriverID INT,
    CabID INT,
    BookingTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PickupLocation VARCHAR(255),
    DropoffLocation VARCHAR(255),
    BookingStatus VARCHAR(20), -- e.g., 'Completed', 'Canceled', 'Ongoing'
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (DriverID) REFERENCES Drivers(DriverID),
    FOREIGN KEY (CabID) REFERENCES Cabs(CabID)
);

CREATE TABLE TripDetails (
    TripID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT,
    TripStartTime DATETIME,
    TripEndTime DATETIME,
    DistanceKM DECIMAL(10, 2),
    Fare DECIMAL(10, 2),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    BookingID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comments TEXT,
    FeedbackTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    CancellationReason VARCHAR(255), -- To store reason if the trip was canceled
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

INSERT INTO Customers (FirstName, LastName, Email, PhoneNumber) VALUES
('Aarav', 'Sharma', 'aarav.sharma@example.com', '9876543210'),
('Priya', 'Patel', 'priya.patel@example.com', '9876543211'),
('Rohan', 'Singh', 'rohan.singh@example.com', '9876543212'),
('Sneha', 'Gupta', 'sneha.gupta@example.com', '9876543213'),
('Vikram', 'Kumar', 'vikram.kumar@example.com', '9876543214');

INSERT INTO Drivers (FirstName, LastName, PhoneNumber, LicenseNumber, AverageRating) VALUES
('Raj', 'Verma', '8765432109', 'DL01XYZ1234', 4.8),
('Anita', 'Joshi', '8765432108', 'MH02ABC5678', 2.9),
('Sanjay', 'Mishra', '8765432107', 'KA03DEF9012', 4.9),
('Pooja', 'Chauhan', '8765432106', 'TN04GHI3456', 3.5),
('Amit', 'Yadav', '8765432105', 'UP05JKL7890', 2.5);

INSERT INTO Cabs (DriverID, VehicleModel, VehicleType, LicensePlate) VALUES
(1, 'Maruti Suzuki Dzire', 'Sedan', 'DL 1C A1234'),
(2, 'Toyota Innova Crysta', 'SUV', 'MH 2B B5678'),
(3, 'Hyundai Verna', 'Sedan', 'KA 3C C9012'),
(4, 'Tata Nexon', 'SUV', 'TN 4D D3456'),
(5, 'Maruti Suzuki Swift', 'Hatchback', 'UP 5E E7890');

INSERT INTO Bookings (CustomerID, DriverID, CabID, BookingTime, PickupLocation, DropoffLocation, BookingStatus) VALUES
-- Completed Bookings
(1, 1, 1, '2025-06-20 10:00:00', 'Andheri, Mumbai', 'Bandra, Mumbai', 'Completed'),
(2, 3, 3, '2025-06-15 14:30:00', 'Koramangala, Bangalore', 'Indiranagar, Bangalore', 'Completed'),
(1, 1, 1, '2025-05-10 09:00:00', 'Andheri, Mumbai', 'Bandra, Mumbai', 'Completed'),
(3, 4, 4, '2025-04-25 18:00:00', 'T. Nagar, Chennai', 'Adyar, Chennai', 'Completed'),
(4, 2, 2, '2025-03-12 20:00:00', 'Connaught Place, Delhi', 'Gurgaon', 'Completed'),
(5, 5, 5, '2025-02-01 11:00:00', 'Lucknow', 'Kanpur', 'Completed'),
(1, 3, 3, '2025-01-15 16:45:00', 'Koramangala, Bangalore', 'Whitefield, Bangalore', 'Completed'),
(2, 1, 1, '2024-12-20 22:00:00', 'Andheri, Mumbai', 'Juhu, Mumbai', 'Completed'),
-- Canceled Bookings
(2, 2, 2, '2025-06-22 11:00:00', 'T. Nagar, Chennai', 'Velachery, Chennai', 'Canceled'),
(4, 1, 1, '2025-05-18 19:30:00', 'Andheri, Mumbai', 'Powai, Mumbai', 'Canceled'),
(4, null, null, '2025-04-10 12:00:00', 'Koramangala, Bangalore', 'HSR Layout, Bangalore', 'Canceled'), -- Canceled by customer before driver assignment
(4, 5, 5, '2025-03-05 08:00:00', 'Lucknow', 'Gomti Nagar, Lucknow', 'Canceled');

INSERT INTO TripDetails (BookingID, TripStartTime, TripEndTime, DistanceKM, Fare) VALUES
(1, '2025-06-20 10:05:00', '2025-06-20 10:35:00', 10.5, 350.00),
(2, '2025-06-15 14:35:00', '2025-06-15 15:00:00', 8.2, 280.50),
(3, '2025-05-10 09:02:00', '2025-05-10 09:40:00', 11.0, 380.00),
(4, '2025-04-25 18:10:00', '2025-04-25 18:55:00', 15.0, 450.75),
(5, '2025-03-12 20:05:00', '2025-03-12 21:05:00', 25.5, 800.00),
(6, '2025-02-01 11:10:00', '2025-02-01 13:00:00', 85.0, 2500.00),
(7, '2025-01-15 16:50:00', '2025-01-15 17:45:00', 18.0, 550.00),
(8, '2024-12-20 22:05:00', '2024-12-20 22:25:00', 5.0, 150.25);

INSERT INTO Feedback (BookingID, Rating, Comments, CancellationReason) VALUES
(1, 5, 'Great driver, clean car.', NULL),
(2, 4, 'Good ride.', NULL),
(3, 5, 'Always a pleasure.', NULL),
(4, 3, 'AC was not effective.', NULL),
(5, 2, 'Driver was late.', NULL),
(6, 2, 'Took a longer route.', NULL),
(7, 5, 'Excellent service!', NULL),
(8, 4, 'Polite driver.', NULL),
(9, NULL, 'Driver denied duty.', 'Driver Canceled'),
(10, NULL, 'Changed my mind.', 'Customer Canceled'),
(11, NULL, 'Found a cheaper option.', 'Customer Canceled'),
(12, NULL, 'Driver was not moving.', 'Driver Canceled');

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(b.BookingID) AS CompletedBookings
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
WHERE b.BookingStatus = 'Completed'
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY CompletedBookings DESC
LIMIT 5;

SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(b.BookingID) AS TotalBookings,
    SUM(CASE WHEN b.BookingStatus = 'Canceled' THEN 1 ELSE 0 END) AS CanceledBookings,
    (SUM(CASE WHEN b.BookingStatus = 'Canceled' THEN 1 ELSE 0 END) * 100.0 / COUNT(b.BookingID)) AS CancellationPercentage
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING (SUM(CASE WHEN b.BookingStatus = 'Canceled' THEN 1 ELSE 0 END) * 100.0 / COUNT(b.BookingID)) > 30
ORDER BY CancellationPercentage DESC;

SELECT
    DAYNAME(BookingTime) AS DayOfWeek,
    COUNT(BookingID) AS NumberOfBookings
FROM Bookings
GROUP BY DayOfWeek
ORDER BY NumberOfBookings DESC;

SELECT
    d.DriverID,
    d.FirstName,
    d.LastName,
    d.AverageRating
FROM Drivers d
WHERE d.AverageRating < 3.0;

SELECT
    d.DriverID,
    d.FirstName,
    d.LastName,
    SUM(td.DistanceKM) AS TotalDistance
FROM Drivers d
JOIN Bookings b ON d.DriverID = b.DriverID
JOIN TripDetails td ON b.BookingID = td.BookingID
WHERE b.BookingStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.LastName
ORDER BY TotalDistance DESC
LIMIT 5;

SELECT
    d.DriverID,
    d.FirstName,
    d.LastName,
    COUNT(b.BookingID) AS TotalAssignedBookings,
    SUM(CASE WHEN b.BookingStatus = 'Canceled' THEN 1 ELSE 0 END) AS CanceledByDriver,
    (SUM(CASE WHEN b.BookingStatus = 'Canceled' THEN 1 ELSE 0 END) * 100.0 / COUNT(b.BookingID)) AS DriverCancellationPercentage
FROM Drivers d
JOIN Bookings b ON d.DriverID = b.DriverID
GROUP BY d.DriverID, d.FirstName, d.LastName
HAVING DriverCancellationPercentage > 0 -- Filter for drivers who have canceled at least one trip
ORDER BY DriverCancellationPercentage DESC;

SELECT
    SUM(td.Fare) AS TotalRevenue
FROM TripDetails td
JOIN Bookings b ON td.BookingID = b.BookingID
WHERE b.BookingStatus = 'Completed'
  AND b.BookingTime >= DATE_SUB(NOW(), INTERVAL 6 MONTH);
  
  SELECT
    DATE_FORMAT(b.BookingTime, '%Y-%m') AS RevenueMonth,
    SUM(td.Fare) AS MonthlyRevenue
FROM TripDetails td
JOIN Bookings b ON td.BookingID = b.BookingID
WHERE b.BookingStatus = 'Completed'
GROUP BY RevenueMonth
ORDER BY RevenueMonth;

SELECT
    PickupLocation,
    DropoffLocation,
    COUNT(*) AS TripCount
FROM Bookings
WHERE BookingStatus = 'Completed'
GROUP BY PickupLocation, DropoffLocation
ORDER BY TripCount DESC
LIMIT 3;

SELECT
    d.DriverID,
    d.FirstName,
    d.AverageRating,
    COUNT(b.BookingID) AS TripsCompleted,
    SUM(td.Fare) AS TotalEarnings
FROM Drivers d
JOIN Bookings b ON d.DriverID = b.DriverID
JOIN TripDetails td ON b.BookingID = td.BookingID
WHERE b.BookingStatus = 'Completed'
GROUP BY d.DriverID, d.FirstName, d.AverageRating
ORDER BY d.AverageRating DESC;

SELECT
    b.PickupLocation,
    AVG(TIMESTAMPDIFF(MINUTE, b.BookingTime, td.TripStartTime)) AS AvgWaitTimeMinutes
FROM Bookings b
JOIN TripDetails td ON b.BookingID = td.BookingID
WHERE b.BookingStatus = 'Completed' AND td.TripStartTime IS NOT NULL
GROUP BY b.PickupLocation
ORDER BY AvgWaitTimeMinutes DESC;

SELECT
    CancellationReason,
    COUNT(*) AS CancellationCount
FROM Feedback
WHERE CancellationReason IS NOT NULL
GROUP BY CancellationReason
ORDER BY CancellationCount DESC;

SELECT
    CASE
        WHEN td.DistanceKM < 10 THEN 'Short (_10km)'
        WHEN td.DistanceKM >= 10 AND td.DistanceKM < 25 THEN 'Medium (10-25km)'
        ELSE 'Long (25+ km)'
    END AS TripCategory,
    COUNT(td.TripID) AS NumberOfTrips,
    SUM(td.Fare) AS TotalRevenueFromCategory
FROM TripDetails td
GROUP BY TripCategory
ORDER BY TotalRevenueFromCategory DESC;

SELECT
        c.VehicleType,
        SUM(td.Fare) AS TotalRevenue
    FROM Cabs c
    JOIN Bookings b ON c.CabID = b.CabID
    JOIN TripDetails td ON b.BookingID = td.BookingID
    WHERE b.BookingStatus = 'Completed' AND c.VehicleType IN ('Sedan', 'SUV')
    GROUP BY c.VehicleType
    ORDER BY TotalRevenue DESC;
    
    SELECT
    CustomerID,
    FirstName,
    LastName,
    MAX(BookingTime) AS LastBookingDate,
    DATEDIFF(NOW(), MAX(BookingTime)) AS DaysSinceLastBooking
FROM Customers
JOIN Bookings USING (CustomerID)
WHERE BookingStatus = 'Completed'
GROUP BY CustomerID, FirstName, LastName
HAVING DaysSinceLastBooking > 90 -- Customers who haven't booked in 3 months
ORDER BY LastBookingDate ASC;

SELECT
    CASE
        WHEN DAYOFWEEK(BookingTime) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,
    COUNT(b.BookingID) AS NumberOfBookings,
    AVG(td.Fare) AS AverageFare
FROM Bookings b
JOIN TripDetails td ON b.BookingID = td.BookingID
WHERE b.BookingStatus = 'Completed'
GROUP BY
    CASE
        WHEN DAYOFWEEK(BookingTime) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END
ORDER BY NumberOfBookings DESC;





