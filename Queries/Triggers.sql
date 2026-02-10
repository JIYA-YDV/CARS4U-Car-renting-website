--Customer:
ALTER TRIGGER trg_customer_id ENABLE;
CREATE OR REPLACE TRIGGER trg_customer_id
BEFORE INSERT ON Customer
FOR EACH ROW
WHEN (NEW.customer_id IS NULL)
BEGIN
    SELECT customer_seq.NEXTVAL
    INTO :NEW.customer_id
    FROM dual;
END;
/

ALTER TRIGGER trg_hire_arrangement_id ENABLE;

CREATE OR REPLACE TRIGGER trg_hire_arrangement_id
BEFORE INSERT ON Hire_Arrangement
FOR EACH ROW
BEGIN
  -- Auto-generate hire_id using the sequence
  IF :NEW.hire_id IS NULL THEN
    SELECT hire_arrangement_seq.NEXTVAL INTO :NEW.hire_id FROM dual;
  END IF;

  -- Set hire_time to the current system time (12-hour format with AM/PM)
  IF :NEW.hire_time IS NULL THEN
    :NEW.hire_time := TO_CHAR(SYSDATE, 'HH:MI AM');
  END IF;
END;
/

-- Trigger to ensure EMAIL is stored in lowercase (optional but recommended for uniqueness consistency)
CREATE OR REPLACE TRIGGER trg_customer_email_lower
BEFORE INSERT OR UPDATE ON Customer
FOR EACH ROW
BEGIN
    :NEW.email := LOWER(:NEW.email);
END;
/
-- Trigger to validate DISCOUNT_PROVIDED is not negative (additional safeguard beyond CHECK constraint)
CREATE OR REPLACE TRIGGER trg_customer_discount_check
BEFORE INSERT OR UPDATE ON Customer
FOR EACH ROW
BEGIN
    IF :NEW.discount_provided < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Discount provided cannot be negative.');
    END IF;
END;

/
--Hire arrangement

CREATE OR REPLACE TRIGGER trg_hire_id
BEFORE INSERT ON Hire_Arrangement
FOR EACH ROW
BEGIN
  IF :NEW.hire_id IS NULL THEN
    SELECT hire_arrangement_seq.NEXTVAL
    INTO :NEW.hire_id
    FROM dual;
  END IF;
END;
/



-- Trigger to set NEW_VEHICLE_PROVIDED to 'No' if NULL
CREATE OR REPLACE TRIGGER trg_hire_arrangement_new_vehicle_default
BEFORE INSERT ON HIRE_ARRANGEMENT
FOR EACH ROW
BEGIN
    IF :NEW.new_vehicle_provided IS NULL THEN
        :NEW.new_vehicle_provided := 'No';
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_hire_arrangement_end_date_check
BEFORE INSERT OR UPDATE ON HIRE_ARRANGEMENT
FOR EACH ROW
BEGIN
    IF :NEW.end_date < :NEW.start_date THEN
        RAISE_APPLICATION_ERROR(-20002, 'End date cannot be earlier than start date.');
    END IF;
END;
/
-- Trigger to set BREAKDOWN_REPORTED to 'No' if NULL
CREATE OR REPLACE TRIGGER trg_hire_arrangement_breakdown_default
BEFORE INSERT ON HIRE_ARRANGEMENT
FOR EACH ROW
BEGIN
    IF :NEW.breakdown_reported IS NULL THEN
        :NEW.breakdown_reported := 'No';
    END IF;
END;
/



CREATE OR REPLACE TRIGGER trg_vehicle_code
BEFORE INSERT ON Vehicle
FOR EACH ROW
BEGIN
  IF :NEW.vehicle_code IS NULL THEN
    SELECT vehicle_seq.NEXTVAL
    INTO :NEW.vehicle_code
    FROM dual;
  END IF;
END;
/

-- Trigger to ensure INSURANCE_EXPIRY_DATE is after PURCHASE_DATE
CREATE OR REPLACE TRIGGER trg_vehicle_insurance_expiry_check
BEFORE INSERT OR UPDATE ON Vehicle
FOR EACH ROW
BEGIN
    IF :NEW.insurance_expiry_date <= :NEW.purchase_date THEN
        RAISE_APPLICATION_ERROR(-20003, 'Insurance expiry date must be after purchase date.');
    END IF;
END;
/

-- Trigger to ensure WARRANTY_EXPIRY_DATE is after PURCHASE_DATE
CREATE OR REPLACE TRIGGER trg_vehicle_warranty_expiry_check
BEFORE INSERT OR UPDATE ON Vehicle
FOR EACH ROW
BEGIN
    IF :NEW.warranty_expiry_date <= :NEW.purchase_date THEN
        RAISE_APPLICATION_ERROR(-20004, 'Warranty expiry date must be after purchase date.');
    END IF;
END;
/

-- Trigger to ensure LAST_SERVICED_DATE is not before PURCHASE_DATE
CREATE OR REPLACE TRIGGER trg_vehicle_service_date_check
BEFORE INSERT OR UPDATE ON Vehicle
FOR EACH ROW
BEGIN
    IF :NEW.last_serviced_date < :NEW.purchase_date THEN
        RAISE_APPLICATION_ERROR(-20005, 'Last serviced date cannot be before purchase date.');
    END IF;
END;
/
CREATE OR REPLACE TRIGGER trg_vehicle_specification_id
BEFORE INSERT ON Vehicle_Specification
FOR EACH ROW
WHEN (NEW.specification_id IS NULL)
BEGIN
    SELECT vehicle_specification_seq.NEXTVAL
    INTO :NEW.specification_id
    FROM dual;
END;
/

-- Trigger to ensure AIR_CONDITIONING field is either 'Yes' or 'No'
CREATE OR REPLACE TRIGGER trg_vehicle_specification_air_conditioning_check
BEFORE INSERT OR UPDATE ON Vehicle_Specification
FOR EACH ROW
BEGIN
    IF UPPER(:NEW.air_conditioning) NOT IN ('YES', 'NO') THEN
        RAISE_APPLICATION_ERROR(-20006, 'Air Conditioning must be ''Yes'' or ''No''.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_hire_charge_id
BEFORE INSERT ON Hire_Charge
FOR EACH ROW
WHEN (NEW.charge_id IS NULL)
BEGIN
    SELECT hire_charge_seq.NEXTVAL
    INTO :NEW.charge_id
    FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_fleet_hire_code
BEFORE INSERT ON Fleet_Hire
FOR EACH ROW
WHEN (NEW.fleet_code IS NULL)
BEGIN
    SELECT fleet_hire_seq.NEXTVAL
    INTO :NEW.fleet_code
    FROM dual;
END;
/

CREATE OR REPLACE TRIGGER trg_fleet_hire_date_check
BEFORE INSERT OR UPDATE ON Fleet_Hire
FOR EACH ROW
BEGIN
    IF :NEW.end_date <= :NEW.start_date THEN
        RAISE_APPLICATION_ERROR(-20010, 'End date must be after start date.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_fleet_hire_total_vehicles_check
BEFORE INSERT OR UPDATE ON Fleet_Hire
FOR EACH ROW
BEGIN
    IF :NEW.total_vehicles_hired IS NULL OR :NEW.total_vehicles_hired < 1 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Total vehicles hired must be at least 1.');
    END IF;
END;
/

-- Trigger to ensure DAILY_RATE_PER_VEHICLE is positive
CREATE OR REPLACE TRIGGER trg_fleet_hire_daily_rate_check
BEFORE INSERT OR UPDATE ON Fleet_Hire
FOR EACH ROW
BEGIN
    IF :NEW.daily_rate_per_vehicle <= 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'Daily rate per vehicle must be greater than 0.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_country_code
BEFORE INSERT ON Country
FOR EACH ROW
WHEN (NEW.country_code IS NULL)
BEGIN
    -- Auto-generate a numeric country code prefixed with 'C'
    SELECT 'C' || TO_CHAR(country_seq.NEXTVAL)
    INTO :NEW.country_code
    FROM dual;
END;
/

ALTER TRIGGER trg_employee_empno ENABLE;

CREATE OR REPLACE TRIGGER trg_employee_empno
BEFORE INSERT ON Employee
FOR EACH ROW
WHEN (NEW.emp_no IS NULL)
BEGIN
    SELECT employee_seq.NEXTVAL
    INTO :NEW.emp_no
    FROM dual;
END;
/
-- Trigger to validate SALARY is positive
CREATE OR REPLACE TRIGGER trg_employee_salary_check
BEFORE INSERT OR UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF :NEW.salary <= 0 THEN
        RAISE_APPLICATION_ERROR(-20015, 'Salary must be greater than 0.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_national_office_id
BEFORE INSERT ON National_Office
FOR EACH ROW
WHEN (NEW.office_id IS NULL)
BEGIN
    SELECT national_office_seq.NEXTVAL
    INTO :NEW.office_id
    FROM dual;
END;
/

-- Trigger to validate NO_OF_EMPLOYEE is positive
CREATE OR REPLACE TRIGGER trg_national_office_employee_check
BEFORE INSERT OR UPDATE ON National_Office
FOR EACH ROW
BEGIN
    IF :NEW.no_of_employee <= 0 THEN
        RAISE_APPLICATION_ERROR(-20019, 'Number of employees must be greater than 0.');
    END IF;
END;
/

-- Trigger to validate LONGITUDE and LATITUDE are within valid ranges
CREATE OR REPLACE TRIGGER trg_national_office_coordinates_check
BEFORE INSERT OR UPDATE ON National_Office
FOR EACH ROW
BEGIN
    IF :NEW.longitude < -180 OR :NEW.longitude > 180 THEN
        RAISE_APPLICATION_ERROR(-20020, 'Longitude must be between -180 and 180.');
    END IF;

    IF :NEW.latitude < -90 OR :NEW.latitude > 90 THEN
        RAISE_APPLICATION_ERROR(-20021, 'Latitude must be between -90 and 90.');
    END IF;
END;
/
-- Trigger to ensure ESTABLISHED_DATE is not in the future
CREATE OR REPLACE TRIGGER trg_national_office_established_date_check
BEFORE INSERT OR UPDATE ON National_Office
FOR EACH ROW
BEGIN
    IF :NEW.established_date > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20022, 'Established date cannot be in the future.');
    END IF;
END;
/

-- Trigger to auto-generate H_CENTER_ID
CREATE OR REPLACE TRIGGER trg_hire_center_id
BEFORE INSERT ON Hire_Center
FOR EACH ROW
WHEN (NEW.h_center_id IS NULL)
BEGIN
    SELECT hire_center_seq.NEXTVAL
    INTO :NEW.h_center_id
    FROM dual;
END;
/

-- Trigger to validate NO_OF_EMPLOYEE is non-negative
CREATE OR REPLACE TRIGGER trg_hire_center_employee_check
BEFORE INSERT OR UPDATE ON Hire_Center
FOR EACH ROW
BEGIN
    IF :NEW.no_of_employee < 0 THEN
        RAISE_APPLICATION_ERROR(-20030, 'Number of employees cannot be negative.');
    END IF;
END;
/

-- Trigger to validate NO_OF_CARS is non-negative
CREATE OR REPLACE TRIGGER trg_hire_center_cars_check
BEFORE INSERT OR UPDATE ON Hire_Center
FOR EACH ROW
BEGIN
    IF :NEW.no_of_cars < 0 THEN
        RAISE_APPLICATION_ERROR(-20031, 'Number of cars cannot be negative.');
    END IF;
END;
/

-- Trigger to validate NO_OF_DRIVER is non-negative
CREATE OR REPLACE TRIGGER trg_hire_center_driver_check
BEFORE INSERT OR UPDATE ON Hire_Center
FOR EACH ROW
BEGIN
    IF :NEW.no_of_driver < 0 THEN
        RAISE_APPLICATION_ERROR(-20032, 'Number of drivers cannot be negative.');
    END IF;
END;
/
