--table for Readers
CREATE TABLE Readers (
    User_ID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    PhoneNo VARCHAR(20),
    Address VARCHAR(255)
);

--table for Staff
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Name VARCHAR(100)
);

-- table for Publisher
CREATE TABLE Publisher (
    Publisher_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    YearOfPublication YEAR
);

--table for Books
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Title VARCHAR(255),
    Category VARCHAR(100),
    Edition VARCHAR(50),
    Price DECIMAL(10, 2),
    AuthNo VARCHAR(100),
    Publisher_ID INT,
    FOREIGN KEY (Publisher_ID) REFERENCES Publisher(Publisher_ID)
);

--table for Authentication System
CREATE TABLE AuthenticationSystem (
    LoginID INT PRIMARY KEY,
    Password VARCHAR(100)
);

-- Readers log in using AuthenticationSystem
ALTER TABLE Readers
ADD LoginID INT,
ADD FOREIGN KEY (LoginID) REFERENCES AuthenticationSystem(LoginID);

-- Staff log in using AuthenticationSystem
ALTER TABLE Staff
ADD LoginID INT,
ADD FOREIGN KEY (LoginID) REFERENCES AuthenticationSystem(LoginID);

--table for Reports (Issue/Return)
CREATE TABLE Reports (
    Reg_No INT PRIMARY KEY,
    User_ID INT,
    Book_No VARCHAR(20),
    IssueReturn VARCHAR(20),
    FOREIGN KEY (User_ID) REFERENCES Readers(User_ID),
    FOREIGN KEY (Book_No) REFERENCES Books(ISBN)
);

-- table for Reservation (Many-to-Many between Readers and Books)
CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT,
    Book_No VARCHAR(20),
    ReserveDate DATE,
    ReturnDate DATE,
    DueDate DATE,
    FOREIGN KEY (User_ID) REFERENCES Readers(User_ID),
    FOREIGN KEY (Book_No) REFERENCES Books(ISBN)
);

--table to track which Staff manages which Readers
CREATE TABLE StaffReader (
    Staff_ID INT,
    User_ID INT,
    PRIMARY KEY (Staff_ID, User_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (User_ID) REFERENCES Readers(User_ID)
);
