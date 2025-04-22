-- CREATE VIEWS
CREATE VIEW UserFootprintSummary AS
SELECT
    u.id AS userId,
    u.username,
    u.totalCarbonFootprint,
    COALESCE(SUM(d.amount), 0) AS totalDonations,
    u.ecoDebt
FROM User u
LEFT JOIN Donation d ON u.id = d.donorId
GROUP BY u.id;

CREATE VIEW DonationSummaryPerProject AS
SELECT
    e.id AS projectId,
    e.name AS projectName,
    SUM(d.amount) AS totalReceived
FROM EcoProject e
LEFT JOIN Donation d ON e.id = d.projectId
GROUP BY e.id;

CREATE VIEW AllSubscriptions AS
SELECT
    u.id, username, platform, type, startDate, endDate, userSubCarbonFootprint
FROM User AS u
JOIN UserSubscription AS us ON u.id = us.userId
JOIN Subscription AS s ON us.subId = s.id
ORDER BY u.id;
