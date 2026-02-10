-- Drop Customer table if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Customer CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Drop sequence if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE customer_seq';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Create Customer table
CREATE TABLE Customer (
    customer_id NUMBER PRIMARY KEY, -- Primary Key
    name VARCHAR2(255) NOT NULL, -- Required
    address VARCHAR2(255) NOT NULL, -- Required
    email VARCHAR2(100) UNIQUE NOT NULL, -- Must be unique and not null
    customer_type VARCHAR2(50) NOT NULL CHECK (customer_type IN ('Individual', 'Corporate', 'Regional')), -- Only valid types
    insurance_type VARCHAR2(100) DEFAULT 'Standard', -- Optional with default
    discount_provided NUMBER DEFAULT 0 CHECK (discount_provided >= 0), -- Default 0, must be non-negative
    customer_image_url BLOB
);

-- Create customer sequence starting from 101
CREATE SEQUENCE customer_seq
    START WITH 101
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
/

-- Insert sample customer records
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'John Doe', '123 Elm Street, NY, USA', 'john.doe@email.com', 'Individual', 'Full Coverage', 10,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Jane Smith', '456 Maple Ave, LA, USA', 'jane.smith@email.com', 'Corporate', 'Liability Only', 15,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Michael Johnson', '789 Oak Lane, TX, USA', 'michael.j@email.com', 'Regional', 'Comprehensive', 5,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Emily Davis', '101 Pine Road, FL, USA', 'emily.d@email.com', 'Individual', 'Third-Party', 8,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Robert Wilson', '202 Birch Blvd, WA, USA', 'robert.w@email.com', 'Corporate', 'Full Coverage', 12,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Alice Johnson', '123 Elm St, Leeds', 'alice.johnson@email.com', 'Individual', 'Standard', 0,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'BT Corporate HQ', '456 High St, London', 'hq@btcorporate.com', 'Corporate', 'Premium', 10,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'John Smith', '789 Maple Rd, Manchester', 'john.smith@email.com', 'Individual', 'Standard', 0,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Tesco Regional Leeds', '1 Supermarket Way, Leeds', 'leeds@tesco.com', 'Regional', 'Enterprise', 5,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Maria Gonzalez', '321 Oak Ave, Bristol', 'maria.gonzalez@email.com', 'Individual', 'Standard', 2,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Vodafone HQ', '100 City Centre, London', 'corp@vodafone.com', 'Corporate', 'Premium', 15,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'James Bond', 'MI6 HQ, London', '007@mi6.gov.uk', 'Individual', 'Elite', 0,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Sainsbury Regional York', '85 Retail Park, York', 'york@sainsbury.com', 'Regional', 'Enterprise', 3,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Emma Brown', '654 Cherry Ln, Liverpool', 'emma.brown@email.com', 'Individual', 'Standard', 1,NULL);
INSERT INTO Customer VALUES (customer_seq.NEXTVAL, 'Amazon UK Corporate', 'Amazon HQ, London', 'corp@amazon.co.uk', 'Corporate', 'Global', 20,NULL);

-- Commit changes
COMMIT;




BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Hire_Arrangement CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE hire_arrangement_seq';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/


BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Hire_Arrangement CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE hire_arrangement_seq';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE Hire_Arrangement (
    hire_id NUMBER PRIMARY KEY,
    customer_id NUMBER NOT NULL,
    no_of_cars NUMBER NOT NULL CHECK (no_of_cars > 0),
    start_date DATE NOT NULL,
    hire_time VARCHAR2(50),
    hire_duration NUMBER NOT NULL CHECK (hire_duration > 0),
    no_of_drivers NUMBER NOT NULL CHECK (no_of_drivers >= 0),
    payment_mode VARCHAR2(50) NOT NULL CHECK (payment_mode IN (
        'Credit Card', 'Cash', 'Debit Card', 'Online Banking', 'Corporate Account'
    )),
    account_reference VARCHAR2(100), -- For corporate/regional use
    end_date DATE NOT NULL,
    hire_type VARCHAR2(50) NOT NULL CHECK (hire_type IN ('INDIVIDUAL', 'FLEET')),
    new_vehicle_provided VARCHAR2(5) DEFAULT 'No' CHECK (new_vehicle_provided IN ('Yes', 'No')),
    breakdown_reported VARCHAR2(5) DEFAULT 'No' CHECK (breakdown_reported IN ('Yes', 'No')),
    mileage_type VARCHAR2(50) NOT NULL CHECK (mileage_type IN ('Mileage Dependent', 'Mileage Independent')),
    vehicle_specification_name VARCHAR2(100), -- New column: descriptive name like "Toyota Corolla"
    vehicle_code VARCHAR2(20), -- Used when hire_type = 'Individual'
    fleet_code VARCHAR2(20),  -- Used when hire_type = 'Fleet'

    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);


-- Sequence
CREATE SEQUENCE hire_arrangement_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE;


INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 101, 1, DATE '2024-04-01', 'Morning', 3, 1,
    'Credit Card', NULL, DATE '2024-04-04', 'INDIVIDUAL', 'No', 'No', 'Mileage Dependent',
    'Toyota',2001,NULL
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 102, 10, DATE '2024-04-02', 'Afternoon', 7, 2,
    'Corporate Account', 'BT-HQ-ACC123', DATE '2024-04-09', 'FLEET', 'Yes', 'No', 'Mileage Dependent',
    'Toyota',NULL,101
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 103, 13, DATE '2024-04-03', 'Evening', 2, 0,
    'Online Banking', 'TESCO-REG-LEEDS', DATE '2024-04-05', 'FLEET', 'No', 'No', 'Mileage Dependent',
    'Ford',NULL,102
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 104, 1, DATE '2024-04-04', 'Morning', 4, 1,
    'Cash', NULL, DATE '2024-04-08', 'INDIVIDUAL', 'Yes', 'No', 'Mileage Dependent',
    'Ford',2002,NULL
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 105, 15, DATE '2024-04-05', 'Night', 5, 2,
    'Corporate Account', 'ROBERT-WILSON-CORP', DATE '2024-04-10', 'FLEET', 'No', 'Yes', 'Mileage Independent',
    'BMW',NULL,102
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 106, 10, DATE '2024-04-06', 'Afternoon', 3, 1,
    'Debit Card', NULL, DATE '2024-04-09', 'FLEET', 'No', 'No', 'Mileage Independent',
    'Isuzu',NULL,103
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 107, 1, DATE '2024-04-07', 'Morning', 10, 3,
    'Corporate Account', 'BT-HQ-LON', DATE '2024-04-17', 'INDIVIDUAL', 'Yes', 'No', 'Mileage Independent',
    'Isuzu',2004,NULL
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 108, 10, DATE '2024-04-08', 'Evening', 2, 0,
    'Cash', NULL, DATE '2024-04-10', 'FLEET', 'No', 'Yes', 'Mileage Dependent',
    'Honda',NULL,104
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 109, 19, DATE '2024-04-09', 'Morning', 6, 1,
    'Corporate Account', 'TESCO-LEEDS-ACC', DATE '2024-04-15', 'FLEET', 'Yes', 'No', 'Mileage Dependent',
    'Hyundai',NULL,105
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 110, 1, DATE '2024-04-10', 'Afternoon', 4, 1,
    'Debit Card', NULL, DATE '2024-04-14', 'INDIVIDUAL', 'No', 'No', 'Mileage Independent',
    'Hyundai',2005,NULL
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 111, 11, DATE '2024-04-11', 'Night', 14, 4,
    'Corporate Account', 'VODAFONE-HQ', DATE '2024-04-25', 'FLEET', 'Yes', 'Yes', 'Mileage Dependent',
    'Tesla',NULL,106
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 112, 12, DATE '2024-04-12', 'Morning', 2, 0,
    'Credit Card', NULL, DATE '2024-04-14', 'FLEET', 'No', 'No', 'Mileage Dependent',
   'Tesla',NULL,107
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 113, 1, DATE '2024-04-13', 'Morning', 3, 1,
    'Corporate Account', 'SAINSBURY-YORK', DATE '2024-04-16', 'INDIVIDUAL', 'No', 'No','Mileage Independent',
    'Tesla',2006,NULL
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 114, 14, DATE '2024-04-14', 'Evening', 2, 0,
    'Online Banking', NULL, DATE '2024-04-16', 'FLEET', 'Yes', 'No', 'Mileage Dependent',
    'Audi',NULL,108
);
INSERT INTO Hire_Arrangement VALUES (
    hire_arrangement_seq.NEXTVAL, 115, 15, DATE '2024-04-15', 'Afternoon', 12, 3,
    'Corporate Account', 'AMAZON-CORP-UK', DATE '2024-04-27', 'FLEET', 'Yes', 'No', 'Mileage Dependent',
    'Audi',NULL,109
);




BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Vehicle CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vehicle_seq';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- 1. Create the Vehicle Table
CREATE TABLE Vehicle (
    vehicle_code NUMBER PRIMARY KEY,
    vehicle_name VARCHAR2(100), 
    registration_no VARCHAR2(50) UNIQUE NOT NULL,
    vehicle_identification_number VARCHAR2(100) UNIQUE NOT NULL,
    fuel_type VARCHAR2(50) NOT NULL,
    mileage_km NUMBER NOT NULL,
    last_serviced_date DATE NOT NULL,
    insurance_expiry_date DATE NOT NULL,
    warranty_expiry_date DATE NOT NULL,
    purchase_price NUMBER NOT NULL,
    purchase_date DATE NOT NULL,
    specification_id NUMBER NOT NULL,
    vehicle_class VARCHAR2(50) NOT NULL,
    vehicle_available VARCHAR2(5) DEFAULT 'Yes' CHECK (vehicle_available IN ('Yes', 'No')),
    vehicle_image_url BLOB,
    CONSTRAINT fk_vehicle_spec FOREIGN KEY (specification_id) REFERENCES Vehicle_Specification(specification_id)
);


-- 2. Create Sequence
CREATE SEQUENCE vehicle_seq
START WITH 2001
INCREMENT BY 1
NOMAXVALUE;
/


BEGIN 
	EXECUTE IMMEDIATE 'DROP TABLE Vehicle_Specification CASCADE CONSTRAINTS';
EXCEPTION
	WHEN OTHERS THEN
		NULL;
END;
/

BEGIN
	EXECUTE IMMEDIATE 'DROP SEQUENCE vehicle_specification_seq';
EXCEPTION
	WHEN OTHERS THEN
		NULL;
END;
/

CREATE TABLE Vehicle_Specification (
    specification_id NUMBER PRIMARY KEY,
    vehicle_class VARCHAR2(50) NOT NULL,
    make VARCHAR2(50) NOT NULL,
    model VARCHAR2(50) NOT NULL,
    engine_capacity VARCHAR2(50) NOT NULL,
    transmission_type VARCHAR2(50) NOT NULL,
    seating_capacity NUMBER NOT NULL,
    air_conditioning CHAR(3) NOT NULL
);

CREATE SEQUENCE vehicle_specification_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE;

-- Insert 15 sample rows
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Economy', 'Toyota', 'Corolla', '1.8L', 'Automatic', 5,'Yes');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'SUV', 'Ford', 'Explorer', '3.5L', 'Automatic', 7, 'Yes');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Luxury', 'BMW', '7 Series', '4.4L', 'Automatic', 5, 'Yes');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Convertible', 'Audi', 'A5', '2.0L', 'Automatic', 4, 'Yes');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Truck', 'Isuzu', 'D-Max', '3.0L', 'Manual', 2, 'No');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Compact', 'Honda', 'Civic', '1.5L', 'Manual', 5, 'Yes');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Sedan', 'Hyundai', 'Elantra', '2.0L', 'Automatic', 5, 'Yes');
INSERT INTO Vehicle_Specification VALUES (vehicle_specification_seq.NEXTVAL, 'Electric', 'Tesla', 'Model 3', 'Electric', 'Automatic', 5, 'Yes');




-- Drop Sequence if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE hire_charge_seq';
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/

-- Drop Table if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Hire_Charge CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/

-- Create Table with foreign key to VEHICLE_SPECIFICATION
CREATE TABLE Hire_Charge (
    charge_id NUMBER PRIMARY KEY,
    specification_id NUMBER NOT NULL,
    country_code VARCHAR2(10),
    daily_rate NUMBER,
    weekly_rate NUMBER,
    monthly_rate NUMBER,
    CONSTRAINT fk_specification
        FOREIGN KEY (specification_id)
        REFERENCES Vehicle_Specification(specification_id)
        ON DELETE CASCADE
);

-- Create Sequence
CREATE SEQUENCE hire_charge_seq START WITH 1 INCREMENT BY 1;

-- Insert 8 sample records (assuming specification_id 1–8 exist)
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 1, 'US', 50, 300, 1200);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 2, 'UK', 80, 500, 2000);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 3, 'AU', 150, 900, 3500);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 4, 'CA', 120, 700, 2800);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 5, 'IN', 100, 600, 2500);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 6, 'DE', 90, 550, 2200);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 7, 'FR', 70, 420, 1600);
INSERT INTO Hire_Charge VALUES (hire_charge_seq.NEXTVAL, 8, 'NZ', 85, 510, 2050);





-- Drop Sequence if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE fleet_hire_seq';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

-- Drop Table if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Fleet_Hire CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

-- Create Fleet_Hire Table
CREATE TABLE Fleet_Hire (
    fleet_code NUMBER PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_vehicles_hired NUMBER CHECK (total_vehicles_hired >= 1),
    vehicle_classification VARCHAR2(100) NOT NULL,
    daily_rate_per_vehicle NUMBER CHECK (daily_rate_per_vehicle > 0),
    fleet_delivery_location VARCHAR2(255) NOT NULL
);

-- Create Sequence
CREATE SEQUENCE fleet_hire_seq 
START WITH 101 
INCREMENT BY 1 
NOMAXVALUE;
/

-- Insert 15 records
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-03-01','YYYY-MM-DD'), TO_DATE('2024-06-30','YYYY-MM-DD'), 10, 'SUV', 50, 'Los Angeles, CA');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-04-15','YYYY-MM-DD'), TO_DATE('2024-08-20','YYYY-MM-DD'), 20, 'Sedan', 40, 'New York, NY');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-05-10','YYYY-MM-DD'), TO_DATE('2024-09-30','YYYY-MM-DD'), 15, 'Truck', 80, 'Chicago, IL');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-06-01','YYYY-MM-DD'), TO_DATE('2024-12-15','YYYY-MM-DD'), 5, 'Van', 60, 'Houston, TX');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-07-20','YYYY-MM-DD'), TO_DATE('2025-01-10','YYYY-MM-DD'), 25, 'Luxury', 100, 'San Francisco, CA');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-08-05','YYYY-MM-DD'), TO_DATE('2024-10-05','YYYY-MM-DD'), 8, 'Economy', 30, 'Miami, FL');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-09-01','YYYY-MM-DD'), TO_DATE('2024-12-01','YYYY-MM-DD'), 12, 'Compact', 35, 'Seattle, WA');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-10-15','YYYY-MM-DD'), TO_DATE('2025-02-15','YYYY-MM-DD'), 7, 'Electric', 70, 'Denver, CO');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-11-01','YYYY-MM-DD'), TO_DATE('2025-01-30','YYYY-MM-DD'), 10, 'Convertible', 90, 'San Diego, CA');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2024-12-05','YYYY-MM-DD'), TO_DATE('2025-03-05','YYYY-MM-DD'), 6, 'Pickup', 75, 'Dallas, TX');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2025-01-01','YYYY-MM-DD'), TO_DATE('2025-04-01','YYYY-MM-DD'), 9, 'Crossover', 55, 'Atlanta, GA');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2025-02-10','YYYY-MM-DD'), TO_DATE('2025-05-10','YYYY-MM-DD'), 13, 'Mini Van', 60, 'Boston, MA');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2025-03-20','YYYY-MM-DD'), TO_DATE('2025-06-20','YYYY-MM-DD'), 18, 'Hybrid', 65, 'Phoenix, AZ');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2025-04-05','YYYY-MM-DD'), TO_DATE('2025-08-05','YYYY-MM-DD'), 14, 'Off-Road', 85, 'Portland, OR');
INSERT INTO Fleet_Hire VALUES (fleet_hire_seq.NEXTVAL, TO_DATE('2025-05-01','YYYY-MM-DD'), TO_DATE('2025-09-01','YYYY-MM-DD'), 11, 'Luxury', 105, 'Las Vegas, NV');

COMMIT;

-- Drop Sequence if exists 
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE fleet_vehicle_seq';
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/

-- Drop Table if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Fleet_Vehicle CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/

-- Create Table
CREATE TABLE Fleet_Vehicle (
    fleet_vehicle_id NUMBER PRIMARY KEY,
    assigned_date DATE,
    status VARCHAR2(50),
    fleet_code NUMBER,
    vehicle_code NUMBER,
    FOREIGN KEY (fleet_code) REFERENCES Fleet_Hire(fleet_code),
    FOREIGN KEY (vehicle_code) REFERENCES Vehicle(vehicle_code)
);

-- Create Sequence
CREATE SEQUENCE fleet_vehicle_seq START WITH 1001 INCREMENT BY 1;
/

-- Insert 15 records
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-01-01', 'YYYY-MM-DD'), 'Assigned', 101, 2001);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-02-15', 'YYYY-MM-DD'), 'Available', 102, 2002);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 'Assigned', 103, 2003);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-04-12', 'YYYY-MM-DD'), 'Under Repair', 104, 2004);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-05-08', 'YYYY-MM-DD'), 'Assigned', 105, 2005);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-06-02', 'YYYY-MM-DD'), 'Available', 106, 2006);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-06-15', 'YYYY-MM-DD'), 'Assigned', 107, 2007);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-07-01', 'YYYY-MM-DD'), 'Available', 108, 2008);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-07-10', 'YYYY-MM-DD'), 'Under Repair', 109, 2009);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-08-01', 'YYYY-MM-DD'), 'Assigned', 110, 2010);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-08-20', 'YYYY-MM-DD'), 'Available', 111, 2011);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-09-05', 'YYYY-MM-DD'), 'Assigned', 112, 2012);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-10-01', 'YYYY-MM-DD'), 'Available', 113, 2013);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'Assigned', 114, 2014);
INSERT INTO Fleet_Vehicle VALUES (fleet_vehicle_seq.NEXTVAL, TO_DATE('2024-11-01', 'YYYY-MM-DD'), 'Under Repair', 115, 2015);

COMMIT;


-- Drop table if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Country CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/

-- Drop sequence if exists
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE country_seq';
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;
/

-- Create table
CREATE TABLE Country (
    country_id NUMBER PRIMARY KEY,
    country_code VARCHAR2(10) UNIQUE NOT NULL,
    country_name VARCHAR2(100) NOT NULL,
    currency VARCHAR2(50) NOT NULL,
    longitude NUMBER(9,4),
    latitude NUMBER(9,4)
);
/

-- Create sequence
CREATE SEQUENCE country_seq
START WITH 101
INCREMENT BY 1
NOMAXVALUE;
/

-- Create trigger for auto-inserting country_id
CREATE OR REPLACE TRIGGER trg_country_id
BEFORE INSERT ON Country
FOR EACH ROW
WHEN (NEW.country_id IS NULL)
BEGIN
   SELECT country_seq.NEXTVAL INTO :NEW.country_id FROM dual;
END;
/

-- Insert sample data
INSERT INTO Country (country_code, country_name, currency, longitude, latitude) 
VALUES ('USA', 'United States', 'USD', -98.3500, 39.5000);

INSERT INTO Country (country_code, country_name, currency, longitude, latitude) 
VALUES ('UK', 'United Kingdom', 'GBP', -0.1278, 51.5074);

INSERT INTO Country (country_code, country_name, currency, longitude, latitude) 
VALUES ('IND', 'India', 'INR', 78.9629, 20.5937);

INSERT INTO Country (country_code, country_name, currency, longitude, latitude) 
VALUES ('JPN', 'Japan', 'JPY', 138.2529, 36.2048);

INSERT INTO Country (country_code, country_name, currency, longitude, latitude) 
VALUES ('AUS', 'Australia', 'AUD', 133.7751, -25.2744);

COMMIT;
/

-- Step 1: Drop the Employee table if it exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employee CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Step 2: Drop the sequence if it exists
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE employee_seq';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Step 3: Create the Employee table with an added password column
CREATE TABLE Employee (
    emp_no NUMBER PRIMARY KEY,
    emp_name VARCHAR2(255) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    company_type VARCHAR2(100) NOT NULL,
    office_name VARCHAR2(100),
    date_of_hire DATE,
    email VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL, -- ✅ Added for login/authentication use
    date_of_birth DATE NOT NULL,
    salary NUMBER NOT NULL,
    position VARCHAR2(100) NOT NULL
);

-- Step 4: Create the employee sequence
CREATE SEQUENCE employee_seq
START WITH 601
INCREMENT BY 1
NOMAXVALUE;

-- Insert Data with Password
INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position) 
VALUES (employee_seq.NEXTVAL, 'John Doe', '123 Main St, NY', 'hire_center', 'NY Office', TO_DATE('2020-06-15', 'YYYY-MM-DD'), 'john.doe@example.com', 'pass@123', TO_DATE('1990-04-12', 'YYYY-MM-DD'), 60000, 'Software Engineer');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position) 
VALUES (employee_seq.NEXTVAL, 'Jane Smith', '456 Maple St, LA', 'hire_center', 'LA Office', TO_DATE('2018-03-22', 'YYYY-MM-DD'), 'jane.smith@example.com', 'pass@123', TO_DATE('1985-07-19', 'YYYY-MM-DD'), 75000, 'Financial Analyst');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position) 
VALUES (employee_seq.NEXTVAL, 'Robert Johnson', '789 Pine St, SF', 'hire_center', 'SF Office', TO_DATE('2019-08-10', 'YYYY-MM-DD'), 'robert.johnson@example.com', 'pass@123', TO_DATE('1992-01-25', 'YYYY-MM-DD'), 55000, 'Marketing Manager');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position) 
VALUES (employee_seq.NEXTVAL, 'Emily Brown', '101 Oak St, Chicago', 'national_office', 'Chicago Office', TO_DATE('2021-01-05', 'YYYY-MM-DD'), 'emily.brown@example.com', 'pass@123', TO_DATE('1994-06-30', 'YYYY-MM-DD'), 62000, 'UI/UX Designer');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position) 
VALUES (employee_seq.NEXTVAL, 'Michael Davis', '202 Birch St, Miami', 'national_office', 'Miami Office', TO_DATE('2017-09-18', 'YYYY-MM-DD'), 'michael.davis@example.com', 'pass@123', TO_DATE('1987-11-14', 'YYYY-MM-DD'), 70000, 'HR Manager');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position) 
VALUES (employee_seq.NEXTVAL, 'Sophia Wilson', '303 Cedar St, Seattle', 'national_office', 'Seattle Office', TO_DATE('2023-02-11', 'YYYY-MM-DD'), 'sophia.wilson@example.com', 'pass@123', TO_DATE('1998-03-27', 'YYYY-MM-DD'), 50000, 'Software Developer');

-- 10 More Employees
INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Olivia Martin', '404 Elm St, Boston', 'checkin_center', 'Boston Office', TO_DATE('2022-07-01', 'YYYY-MM-DD'), 'olivia.martin@example.com', 'pass@123', TO_DATE('1995-09-10', 'YYYY-MM-DD'), 58000, 'Accountant');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'William Garcia', '505 Ash St, Denver', 'specialcheck_in_center', 'Denver Office', TO_DATE('2020-05-15', 'YYYY-MM-DD'), 'william.garcia@example.com', 'pass@123', TO_DATE('1991-02-28', 'YYYY-MM-DD'), 67000, 'Business Analyst');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Isabella Martinez', '606 Walnut St, Austin', 'hire_center', 'Austin Office', TO_DATE('2019-11-30', 'YYYY-MM-DD'), 'isabella.martinez@example.com', 'pass@123', TO_DATE('1993-08-15', 'YYYY-MM-DD'), 63000, 'Network Engineer');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'James Anderson', '707 Spruce St, Portland', 'checkin_center', 'Portland Office', TO_DATE('2016-12-20', 'YYYY-MM-DD'), 'james.anderson@example.com', 'pass@123', TO_DATE('1989-05-23', 'YYYY-MM-DD'), 72000, 'Operations Manager');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Mia Thomas', '808 Willow St, Orlando', 'specialcheck_in_center', 'Orlando Office', TO_DATE('2021-04-08', 'YYYY-MM-DD'), 'mia.thomas@example.com', 'pass@123', TO_DATE('1997-12-05', 'YYYY-MM-DD'), 51000, 'Content Writer');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Alexander Moore', '909 Fir St, Las Vegas', 'hire_center', 'Vegas Office', TO_DATE('2018-10-12', 'YYYY-MM-DD'), 'alexander.moore@example.com', 'pass@123', TO_DATE('1986-10-19', 'YYYY-MM-DD'), 69000, 'Systems Administrator');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Charlotte Taylor', '111 Redwood St, San Diego', 'national_office', 'San Diego Office', TO_DATE('2023-03-18', 'YYYY-MM-DD'), 'charlotte.taylor@example.com', 'pass@123', TO_DATE('1999-01-30', 'YYYY-MM-DD'), 54000, 'Graphic Designer');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Benjamin Lee', '121 Pinecone St, Detroit', 'hire_center', 'Detroit Office', TO_DATE('2015-06-25', 'YYYY-MM-DD'), 'benjamin.lee@example.com', 'pass@123', TO_DATE('1984-04-02', 'YYYY-MM-DD'), 78000, 'Senior Consultant');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Amelia Perez', '131 Sycamore St, Houston', 'specialcheck_in_center', 'Houston Office', TO_DATE('2022-10-10', 'YYYY-MM-DD'), 'amelia.perez@example.com', 'pass@123', TO_DATE('1996-05-07', 'YYYY-MM-DD'), 61000, 'Project Coordinator');

INSERT INTO Employee (emp_no, emp_name, address, company_type, office_name, date_of_hire, email, password, date_of_birth, salary, position)
VALUES (employee_seq.NEXTVAL, 'Daniel White', '141 Chestnut St, Atlanta', 'checkin_center', 'Atlanta Office', TO_DATE('2017-11-11', 'YYYY-MM-DD'), 'daniel.white@example.com', 'pass@123', TO_DATE('1990-03-18', 'YYYY-MM-DD'), 74000, 'Quality Assurance Engineer');

-- Manager
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'John Smith', '123 Manager St, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'john.smith@urbandrive.com', 'pass123', TO_DATE('1980-05-20', 'YYYY-MM-DD'), 80000, 'Manager'
);

-- Customer Service Representative
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Emma Johnson', '456 Customer St, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'emma.johnson@urbandrive.com', 'pass123', TO_DATE('1988-08-15', 'YYYY-MM-DD'), 50000, 'Customer Service'
);

-- Client Service Representative
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Daniel Lee', '789 Client St, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'daniel.lee@urbandrive.com', 'pass123', TO_DATE('1985-03-10', 'YYYY-MM-DD'), 52000, 'Client Service Representative'
);

-- 5 Drivers
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Michael Green', '101 Driver Rd, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'michael.green1@urbandrive.com', 'pass123', TO_DATE('1990-07-22', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Sarah White', '102 Driver Rd, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'sarah.white@urbandrive.com', 'pass123', TO_DATE('1992-11-18', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Robert Black', '103 Driver Rd, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'robert.black@urbandrive.com', 'pass123', TO_DATE('1993-01-05', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Laura King', '104 Driver Rd, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'laura.king@urbandrive.com', 'pass123', TO_DATE('1989-09-30', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'James Bond', '105 Driver Rd, New York', 'hire_center',
    'UrbanDrive Central', SYSDATE, 'james.bond@urbandrive.com', 'pass123', TO_DATE('1991-12-12', 'YYYY-MM-DD'), 40000, 'Driver'
);


-- Manager
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Olivia Brown', '123 Manager St, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'olivia.brown@citywheels.com', 'pass123', TO_DATE('1981-04-12', 'YYYY-MM-DD'), 80000, 'Manager'
);

-- Customer Service Representative
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Ethan Wilson', '456 Customer St, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'ethan.wilson@citywheels.com', 'pass123', TO_DATE('1987-07-25', 'YYYY-MM-DD'), 50000, 'Customer Service'
);

-- Client Service Representative
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Sophia Martinez', '789 Client St, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'sophia.martinez@citywheels.com', 'pass123', TO_DATE('1986-02-14', 'YYYY-MM-DD'), 52000, 'Client Service Representative'
);

-- 5 Drivers
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Jackson Moore', '101 Driver Rd, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'jackson.moore@citywheels.com', 'pass123', TO_DATE('1990-06-20', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Lily Taylor', '102 Driver Rd, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'lily.taylor@citywheels.com', 'pass123', TO_DATE('1993-09-10', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Benjamin Anderson', '103 Driver Rd, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'benjamin.anderson@citywheels.com', 'pass123', TO_DATE('1992-03-18', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Chloe Thomas', '104 Driver Rd, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'chloe.thomas@citywheels.com', 'pass123', TO_DATE('1991-08-03', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Daniel Martin', '105 Driver Rd, Chicago', 'hire_center',
    'CityWheels Hub', SYSDATE, 'daniel.martin@citywheels.com', 'pass123', TO_DATE('1994-11-27', 'YYYY-MM-DD'), 40000, 'Driver'
);

-- Manager
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Emily Johnson', '123 Manager Ln, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'emily.johnson@primeride.com', 'pass123', TO_DATE('1982-03-08', 'YYYY-MM-DD'), 80000, 'Manager'
);

-- Customer Service Representative
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Logan Davis', '456 Customer Ave, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'logan.davis@primeride.com', 'pass123', TO_DATE('1988-10-19', 'YYYY-MM-DD'), 50000, 'Customer Service'
);

-- Client Service Representative
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Grace Hall', '789 Client Blvd, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'grace.hall@primeride.com', 'pass123', TO_DATE('1985-01-22', 'YYYY-MM-DD'), 52000, 'Client Service Representative'
);

-- 5 Drivers
INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Henry Adams', '101 Driver Way, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'henry.adams@primeride.com', 'pass123', TO_DATE('1990-05-15', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Zoe Nelson', '102 Driver Way, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'zoe.nelson@primeride.com', 'pass123', TO_DATE('1993-07-30', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Nathan Clark', '103 Driver Way, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'nathan.clark@primeride.com', 'pass123', TO_DATE('1991-11-12', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Avery Lee', '104 Driver Way, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'avery.lee@primeride.com', 'pass123', TO_DATE('1992-09-25', 'YYYY-MM-DD'), 40000, 'Driver'
);

INSERT INTO Employee VALUES (
    employee_seq.NEXTVAL, 'Samuel Perez', '105 Driver Way, Boston', 'hire_center',
    'PrimeRide Station', SYSDATE, 'samuel.perez@primeride.com', 'pass123', TO_DATE('1994-02-06', 'YYYY-MM-DD'), 40000, 'Driver'
);

COMMIT;




BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE National_Office CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE national_office_seq';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

CREATE TABLE National_Office (
    office_id NUMBER PRIMARY KEY,
    location VARCHAR2(100) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    no_of_regionaloffice NUMBER NOT NULL,
    city VARCHAR2(100) NOT NULL,
    country VARCHAR2(100) NOT NULL,
    longitude NUMBER NOT NULL,
    latitude NUMBER NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    contact_no VARCHAR2(50) UNIQUE NOT NULL,
    no_of_employee NUMBER NOT NULL,
    established_date DATE NOT NULL,
    office_name VARCHAR2(100) NOT NULL
);

CREATE SEQUENCE national_office_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE;
/

-- Insert Sample Data
INSERT INTO National_Office VALUES (
    national_office_seq.NEXTVAL, 'New York', '123 Main St', 5, 'New York', 'USA', -74.006, 40.7128, 'ny_office@example.com', '+1-212-555-1234', 200, TO_DATE('1990-05-20', 'YYYY-MM-DD'), 'NYC National Office'
);

INSERT INTO National_Office VALUES (
    national_office_seq.NEXTVAL, 'London', '456 King Rd', 4, 'London', 'UK', -0.1278, 51.5074, 'ldn_office@example.com', '+44-20-7946-0958', 180, TO_DATE('1985-09-15', 'YYYY-MM-DD'), 'London National Office'
);

INSERT INTO National_Office VALUES (
    national_office_seq.NEXTVAL, 'Tokyo', '789 Sakura Blvd', 6, 'Tokyo', 'Japan', 139.6917, 35.6895, 'tokyo_office@example.com', '+81-3-1234-5678', 250, TO_DATE('2000-03-10', 'YYYY-MM-DD'), 'Tokyo National Office'
);

INSERT INTO National_Office VALUES (
    national_office_seq.NEXTVAL, 'Sydney', '321 Opera House Ln', 3, 'Sydney', 'Australia', 151.2093, -33.8688, 'syd_office@example.com', '+61-2-9999-1234', 150, TO_DATE('1995-11-25', 'YYYY-MM-DD'), 'Sydney National Office'
);

INSERT INTO National_Office VALUES (
    national_office_seq.NEXTVAL, 'Toronto', '654 Maple Ave', 2, 'Toronto', 'Canada', -79.3832, 43.6532, 'toronto_office@example.com', '+1-416-555-7890', 130, TO_DATE('1998-07-14', 'YYYY-MM-DD'), 'Toronto National Office'
);

COMMIT;

-- Drop Table if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Hire_Center CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Drop Sequence if exists
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE hire_center_seq';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

-- Create Table with latitude and longitude
CREATE TABLE Hire_Center (
    h_center_id NUMBER PRIMARY KEY,
    center_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(100) NOT NULL,
    country VARCHAR2(100) NOT NULL,
    address VARCHAR2(255) NOT NULL,
    contact_no VARCHAR2(50) UNIQUE NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    no_of_employee NUMBER DEFAULT 0 CHECK (no_of_employee >= 0),
    manager_name VARCHAR2(100) NOT NULL,
    no_of_cars NUMBER DEFAULT 0 CHECK (no_of_cars >= 0),
    no_of_driver NUMBER DEFAULT 0 CHECK (no_of_driver >= 0),
    office_id NUMBER,
    latitude NUMBER(9,6),
    longitude NUMBER(9,6),
    FOREIGN KEY (office_id) REFERENCES National_Office(office_id) ON DELETE SET NULL
);
/

-- Create Sequence
CREATE SEQUENCE hire_center_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE;
/

-- Insert updated records with lat/lng
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'UrbanDrive Central', 'New York', 'USA', '123 Main St', '123-456-7890', 'urbandrive.central@hire.com', 50, 'Ava Thompson', 30, 25, 1, 40.712776, -74.005974);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'CityWheels Hub', 'Chicago', 'USA', '456 Market St', '234-567-8901', 'citywheels.hub@hire.com', 40, 'Liam Carter', 25, 20, 1, 41.878113, -87.629799);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'MetroHire Express', 'Los Angeles', 'USA', '789 Sunset Blvd', '345-678-9012', 'metrohire.express@hire.com', 60, 'Sophia Bennett', 35, 30, 1, 34.052235, -118.243683);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'PrimeRide Station', 'Boston', 'USA', '159 Beacon St', '456-789-0123', 'primeride.station@hire.com', 55, 'Noah Walker', 28, 22, 1, 42.360081, -71.058884);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'SunState Rentals', 'Miami', 'USA', '753 Ocean Dr', '567-890-1234', 'sunstate.rentals@hire.com', 45, 'Isabella Wright', 32, 27, 1, 25.761681, -80.191788);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'DriveNation Depot', 'Dallas', 'USA', '100 Elm St', '678-901-2345', 'drivenation.depot@hire.com', 38, 'Elijah Turner', 26, 21, 1, 32.776665, -96.796989);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'AutoFleet HQ', 'Houston', 'USA', '200 Pine St', '789-012-3456', 'autofleet.hq@hire.com', 42, 'Mia Harris', 24, 20, 1, 29.760427, -95.369804);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'RapidWheels Center', 'San Francisco', 'USA', '300 Bay St', '890-123-4567', 'rapidwheels.center@hire.com', 48, 'William Scott', 33, 29, 1, 37.774929, -122.419418);
INSERT INTO Hire_Center VALUES (hire_center_seq.NEXTVAL, 'Evergreen Mobility', 'Seattle', 'USA', '400 Rainy St', '901-234-5678', 'evergreen.mobility@hire.com', 35, 'Amelia Parker', 22, 18, 1, 47.606209, -122.332069);

COMMIT;
