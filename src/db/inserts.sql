-- INSERTS
----- USERS
INSERT INTO User (isAdmin, username, name, surname, password_hash, totalCarbonFootprint, ecoDebt) VALUES
(1, 'adminuser', 'Alice', 'Green', 'hash_admin', 0, 0),
(0, 'john_doe', 'John', 'Doe', 'hash_john', 53.409, 15.409),
(0, 'jane_smith', 'Jane', 'Smith', 'hash_jane', 71.794, 51.794),
(0, 'emma_white', 'Emma', 'White', 'hash_emma', 177.957, 159.957),
(0, 'liam_brown', 'Liam', 'Brown', 'hash_liam', 208.834, 186.834);


----- SUBSCRIPTIONS
INSERT INTO Subscription (type, platform, monthlyPrice, monthlyCarbonFootprint) VALUES
('Single', 'Netflix', 13.99, 1.433),
('Duo', 'Netflix', 17.99, 2.866),
('Family', 'Netflix', 21.99, 7.165),
('Single', 'Disney+', 8.99, 1.067),
('Duo', 'Disney+', 11.99, 2.133),
('Family', 'Disney+', 14.99, 5.333),
('Single', 'Amazon Prime', 8.99, 1.125),
('Duo', 'Amazon Prime', 11.99, 2.25),
('Family', 'Amazon Prime', 14.99, 5.625),
('Single', 'Spotify', 9.99, 0.023),
('Duo', 'Spotify', 12.99, 0.046),
('Family', 'Spotify', 14.99, 0.115),
('Single', 'Deezer', 9.99, 0.023),
('Single', 'Youtube Premium', 11.99, 1.125),
('Family', 'Youtube Premium', 17.99, 5.625),
('Single', 'Apple Music', 9.99, 0.023),
('Single', 'Crunchyroll', 7.99, 1.125),
('Duo', 'Crunchyroll', 11.99, 2.25),
('Family', 'Crunchyroll', 15.99, 5.625),
('Student', 'Spotify', 4.99, 0.023);

----- ECO PROJECTS
INSERT INTO EcoProject (name, description, dateLaunch, goalMoney, collectedMoney, founderCompany) VALUES
('Green Forest', 'Reforestation in the Amazon', '2022-04-22', 10000, 6400, 'EcoCorp'),
('Ocean Cleanup', 'Removing plastic from oceans', '2023-06-05', 15000, 8200, 'BlueWave'),
('Solar Village', 'Solar panels for remote villages', '2021-09-10', 12000, 9100, 'SunPower'),
('Clean Air', 'Urban air purification project', '2022-12-01', 8000, 5400, 'AirPure'),
('Wildlife Protection', 'Protecting endangered species', '2023-03-15', 9000, 3000, 'GreenLife');

----- DONATIONS
INSERT INTO Donation (donorId, projectId, amount, dateDonation) VALUES
(2, 1, 10, '2024-01-10'),
(2, 2, 5, '2024-02-15'),
(3, 1, 3, '2024-03-01'),
(4, 3, 6, '2024-01-20'),
(5, 4, 5, '2024-04-02'),
(2, 3, 4, '2024-02-25'),
(3, 2, 3, '2024-03-22'),
(4, 5, 2, '2024-04-05'),
(5, 1, 4, '2024-02-18'),
(3, 5, 3, '2024-02-05'),
(4, 2, 1, '2024-04-10'),
(5, 3, 2, '2024-04-15');

----- USER SUBSCRIPTIONS (1 per platform per user)
INSERT INTO UserSubscription (userId, subId, startDate, endDate, userSubCarbonFootprint) VALUES
(2, 1, '2023-01-01', '2024-03-01', 21.495),
(2, 10, '2023-01-01', NULL, 0.345),
(2, 14, '2024-01-01', NULL, 2.25),
(2, 16, '2024-02-01', NULL, 0.069),
(2, 17, '2023-03-01', NULL, 29.25),

(3, 4, '2023-06-01', NULL, 10.67),
(3, 11, '2023-06-01', NULL, 0.46),
(3, 18, '2023-10-01', NULL, 15.75),
(3, 14, '2024-03-01', NULL, 2.25),
(3, 6, '2023-09-01', NULL, 42.664),

(4, 7, '2022-05-01', '2024-04-01', 25.875),
(4, 13, '2023-07-01', NULL, 0.207),
(4, 9, '2023-02-01', '2024-04-01', 78.75),
(4, 19, '2023-03-01', NULL, 73.125),

(5, 8, '2023-08-01', NULL, 18.0),
(5, 14, '2024-01-01', NULL, 22.5),
(5, 3, '2022-10-01', '2024-03-01', 121.805),
(5, 11, '2023-05-01', '2024-04-01', 0.506),
(5, 19, '2023-09-01', NULL, 45.0),
(5, 15, '2024-04-01', NULL, 0.023);

