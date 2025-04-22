-- CREATE TRIGGERS
----- After a new donation
CREATE TRIGGER update_ecoDebt_after_donation_insert
AFTER INSERT ON Donation
BEGIN
    UPDATE User
    SET ecoDebt = totalCarbonFootprint - (
        SELECT COALESCE(SUM(amount), 0) * 2
        FROM Donation
        WHERE donorId = NEW.donorId
    )
    WHERE id = NEW.donorId;
END;

----- After deleting a donation
CREATE TRIGGER update_ecoDebt_after_donation_delete
AFTER DELETE ON Donation
BEGIN
    UPDATE User
    SET ecoDebt = totalCarbonFootprint - (
        SELECT COALESCE(SUM(amount), 0) * 2
        FROM Donation
        WHERE donorId = OLD.donorId
    )
    WHERE id = OLD.donorId;
END;

----- After totalCarbonFootprint change
CREATE TRIGGER update_ecoDebt_after_CF_change
AFTER INSERT ON UserSubscription
BEGIN
    UPDATE User
    SET ecoDebt = (
        SELECT totalCarbonFootprint - COALESCE((
            SELECT SUM(amount) * 2
            FROM Donation
            WHERE donorId = NEW.userId
        ), 0)
    )
    WHERE id = NEW.userId;
END;

----- Trigger to prevent inserting a duplicate active subscription
CREATE TRIGGER prevent_duplicate_active_subscription
BEFORE INSERT ON UserSubscription
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1
            FROM UserSubscription us
            JOIN Subscription s ON us.subId = s.id
            WHERE us.userId = NEW.userId
              AND s.platform = (SELECT platform FROM Subscription WHERE id = NEW.subId)
              AND us.endDate IS NULL
        ) THEN
            RAISE (ABORT, 'User already has an active subscription for this platform.')
    END;
END;


