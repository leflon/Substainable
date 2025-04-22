-- DROP TABLES IF THEY EXIST
DROP TABLE IF EXISTS Donation;
DROP TABLE IF EXISTS UserSubscription;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS EcoProject;

-- CREATE TABLES
CREATE TABLE User(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    isAdmin INTEGER NOT NULL,
    username TEXT NOT NULL,
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    -- Sum of userSubCarbonFootprints of the user
    totalCarbonFootprint REAL,
    -- Computed as :
    -- totalCarbonFootprint - (totalDonation in € * offset)
    -- Here, the offset was arbitrarily set as 2kgCO2e "saved" per 1€
    ecoDebt REAL
);

CREATE TABLE Subscription(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type TEXT CHECK (type IN ('Single', 'Duo', 'Family', 'Student')) NOT NULL,
    platform TEXT NOT NULL,
    monthlyPrice REAL NOT NULL,
    -- Data taken from
    -- https://greenly.earth/en-gb/leaf-media/data-stories/the-carbon-cost-of-streaming
    monthlyCarbonFootprint REAL NOT NULL
);

CREATE TABLE EcoProject(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    dateLaunch TEXT NOT NULL,
    goalMoney REAL NOT NULL,
    collectedMoney REAL NOT NULL,
    founderCompany TEXT NOT NULL
);

CREATE TABLE Donation(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    donorId INTEGER NOT NULL,
    projectId INTEGER NOT NULL,
    amount REAL NOT NULL,
    dateDonation TEXT NOT NULL,
    FOREIGN KEY(donorId) REFERENCES User(id),
    FOREIGN KEY(projectId) REFERENCES EcoProject(id)
);


CREATE TABLE UserSubscription(
    userId INTEGER NOT NULL,
    subId INTEGER NOT NULL,
    startDate TEXT NOT NULL,
    endDate TEXT,
    -- Computed as :
    -- monthlyCarbonFootprint * number of months since subscription
    userSubCarbonFootprint REAL NOT NULL,
    PRIMARY KEY(userId, subId, startDate),
    FOREIGN KEY(userId) REFERENCES User(id),
    FOREIGN KEY(subId) REFERENCES Subscription(id)
);

