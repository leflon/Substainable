DROP TABLE IF EXISTS Donation;
DROP TABLE IF EXISTS EcoProject;
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS SubscriptionProvider;
DROP TABLE IF EXISTS User;

CREATE TABLE User(
    id TEXT PRIMARY KEY,
    is_admin INTEGER DEFAULT 0,
    email TEXT,
    password_hash TEXT
);

CREATE TABLE SubscriptionProvider(
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    logo_url TEXT,
    -- Some providers will be provided by us to improve UX, but users can input any provider they want.
    is_custom INTEGER DEFAULT 1,
    created_by TEXT,
    /* For non-custom providers, this value is set by us. Else, the user can (but is not forced to) enter the estimated footprint of this
    provider. */
    carbon_footprint REAL,
    FOREIGN KEY (created_by) REFERENCES User(id)
);

CREATE TABLE Subscription(
    id TEXT PRIMARY KEY,
    provider_id TEXT,
    user_id TEXT, 
    -- We do not store the price in the provider, because prices vary too much based on time, location, subscription type, etc. 
    -- And the user could also be sharing this subscription with someone else, making the price even more variable. So it is up
    -- to the user to enter the price of the subscription.
    price REAL,
    baseDate INTEGER, -- Stored as UNIX timestamp
    recurrence_unit TEXT, -- per week, per month, per year, etc.
    recurrence INTEGER, -- e.g. 1 for weekly/monthly/yearly, 2 for every 2
    -- weeks/2 months/2 years, etc.

    FOREIGN KEY (provider_id) REFERENCES SubscriptionProvider(id),
    FOREIGN KEY (user_id) REFERENCES User(id)
);

CREATE TABLE EcoProject(
    id TEXT,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    organization_name TEXT NOT NULL,
    link TEXT NOT NULL
);

CREATE TABLE Donation(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id TEXT NOT NULL,
    project_id TEXT NOT NULL,
    amount REAL NOT NULL,
    donated_at INTEGER NOT NULL, -- Stored as UNIX timestamp
    FOREIGN KEY(user_id) REFERENCES User(id),
    FOREIGN KEY(project_id) REFERENCES EcoProject(id)
);