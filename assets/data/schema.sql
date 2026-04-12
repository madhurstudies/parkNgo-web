-- ============================================
-- parkNgo Database Schema
-- Owner Accounts & Parking Space Configuration
-- ============================================

-- Table: owners
-- Stores owner account credentials and setup status
CREATE TABLE IF NOT EXISTS owners (
    owner_id        INTEGER PRIMARY KEY AUTOINCREMENT,
    email           VARCHAR(255) NOT NULL UNIQUE,
    password_hash   VARCHAR(64)  NOT NULL,       -- SHA-256 hash (64 hex chars)
    created_at      DATETIME     DEFAULT CURRENT_TIMESTAMP,
    setup_complete  BOOLEAN      DEFAULT 0       -- 0 = first-time, 1 = setup done
);

-- Table: parking_settings
-- Stores the parking space configuration for each owner
CREATE TABLE IF NOT EXISTS parking_settings (
    setting_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    owner_id        INTEGER NOT NULL UNIQUE,
    parking_name    VARCHAR(255) NOT NULL,
    total_slots     INTEGER NOT NULL CHECK(total_slots > 0),

    -- Reserved slots: owner can enter as percentage or fixed amount
    reserved_mode   VARCHAR(10) NOT NULL CHECK(reserved_mode IN ('percentage', 'amount')),
    reserved_value  REAL    NOT NULL CHECK(reserved_value >= 0),  -- the raw value entered
    reserved_slots  INTEGER NOT NULL CHECK(reserved_slots >= 0),  -- computed slot count

    -- Pricing (per hour, in ₹)
    on_spot_price       REAL NOT NULL CHECK(on_spot_price >= 0),
    reserved_price      REAL NOT NULL CHECK(reserved_price >= 0),
    cab_driver_price    REAL NOT NULL CHECK(cab_driver_price >= 0),  -- auto: on_spot * 0.80

    updated_at      DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (owner_id) REFERENCES owners(owner_id) ON DELETE CASCADE
);

-- ============================================
-- Trigger: auto-calculate cab_driver_price
-- Sets cab driver price to 80% of on_spot_price (20% discount)
-- ============================================
CREATE TRIGGER IF NOT EXISTS calc_cab_price_insert
AFTER INSERT ON parking_settings
BEGIN
    UPDATE parking_settings
    SET cab_driver_price = ROUND(NEW.on_spot_price * 0.80, 2)
    WHERE setting_id = NEW.setting_id;
END;

CREATE TRIGGER IF NOT EXISTS calc_cab_price_update
AFTER UPDATE OF on_spot_price ON parking_settings
BEGIN
    UPDATE parking_settings
    SET cab_driver_price = ROUND(NEW.on_spot_price * 0.80, 2)
    WHERE setting_id = NEW.setting_id;
END;

-- ============================================
-- Sample Data (for testing / seeding)
-- ============================================
-- Password for demo: "12345678" → SHA-256 hash below
INSERT INTO owners (email, password_hash, setup_complete) VALUES
    ('johndoe@gmail.com', 'ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f', 1);

INSERT INTO parking_settings (owner_id, parking_name, total_slots, reserved_mode, reserved_value, reserved_slots, on_spot_price, reserved_price, cab_driver_price) VALUES
    (1, 'Downtown Parking Hub', 50, 'percentage', 20, 10, 40.00, 60.00, 32.00);
