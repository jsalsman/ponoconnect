-- Enable PostGIS for geospatial support
CREATE EXTENSION IF NOT EXISTS postgis;

-- User Profile Table (with geospatial support)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,              -- Unique user identifier
    num_people INTEGER NOT NULL,             -- Number of people needing shelter
    has_pets BOOLEAN NOT NULL,               -- Does the user have pets?
    gender VARCHAR(20) CHECK (gender IN ('Male', 'Female', 'Non-Binary', 'Prefer not to say')) NOT NULL,
    special_needs TEXT,                      -- Special needs like wheelchair access
    location GEOGRAPHY(Point, 4326) NOT NULL, -- User's location as a Point (latitude, longitude)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Profile creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Profile update timestamp
);

-- Shelter Table
CREATE TABLE shelters (
    shelter_id SERIAL PRIMARY KEY,           -- Shelter unique identifier
    agency VARCHAR(255) NOT NULL,            -- Agency providing the shelter
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Shelter record creation timestamp
);

-- Shelter Availability Table (Unit Types & Vacancy Information)
CREATE TABLE shelter_availability (
    shelter_id INT REFERENCES shelters(shelter_id) ON DELETE CASCADE, -- FK to shelter
    unit_type VARCHAR(50) CHECK (unit_type IN ('Studio', 'One-Bedroom', 'Family Units')) NOT NULL,
    available INTEGER NOT NULL,             -- Number of available units
    eligibility TEXT,                       -- Eligibility requirements for the shelter
    special_conditions TEXT,                -- Special conditions like families only
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Last updated timestamp
    PRIMARY KEY (shelter_id, unit_type)     -- Unique constraint by shelter and unit type
);

-- Shelter Reservations Table
CREATE TABLE reservations (
    reservation_id SERIAL PRIMARY KEY,      -- Reservation unique identifier
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE, -- FK to users
    shelter_id INT REFERENCES shelters(shelter_id) ON DELETE CASCADE, -- FK to shelters
    reservation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp when the reservation was made
    unit_type VARCHAR(50) CHECK (unit_type IN ('Studio', 'One-Bedroom', 'Family Units')) NOT NULL, -- Unit type reserved
    start_date TIMESTAMP NOT NULL,          -- Reservation start date
    end_date TIMESTAMP NOT NULL,            -- Reservation end date
    confirmation_status VARCHAR(20) CHECK (confirmation_status IN ('Pending', 'Confirmed', 'Cancelled')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Record creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Record update timestamp
);

-- Advocacy Actions Table
CREATE TABLE advocacy_actions (
    action_id SERIAL PRIMARY KEY,           -- Action unique identifier
    advocate_id INT NOT NULL,               -- Advocate unique identifier (can be a user or external)
    goal VARCHAR(255) NOT NULL,             -- Advocacy goal (e.g., expand Housing First)
    actions_taken TEXT[],                   -- List of actions taken (e.g., meetings, petitions)
    local_challenges TEXT,                  -- Challenges faced by the advocate
    status VARCHAR(50) CHECK (status IN ('In Progress', 'Completed', 'Pending')) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Action record creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Last updated timestamp
);

-- Notifications Table
CREATE TABLE notifications (
    notification_id SERIAL PRIMARY KEY,     -- Notification unique identifier
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE, -- FK to users
    message TEXT NOT NULL,                  -- Notification message
    notification_type VARCHAR(50) CHECK (notification_type IN ('Shelter Availability', 'Reservation Confirmed', 'Advocacy Update')) NOT NULL, -- Type of notification
    status VARCHAR(50) CHECK (status IN ('Sent', 'Pending', 'Failed')) DEFAULT 'Pending', -- Notification status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Record creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Last updated timestamp
);

-- Indexes for Optimization
-- Geospatial Index for users (location column)
CREATE INDEX idx_users_location ON users USING GIST (location);

-- General indexes for fast lookups
CREATE INDEX idx_shelter_availability_shelter_id ON shelter_availability (shelter_id);
CREATE INDEX idx_reservations_user_id ON reservations (user_id);
CREATE INDEX idx_reservations_shelter_id ON reservations (shelter_id);
CREATE INDEX idx_advocacy_actions_advocate_id ON advocacy_actions (advocate_id);
CREATE INDEX idx_notifications_user_id ON notifications (user_id);
