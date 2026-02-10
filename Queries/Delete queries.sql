CREATE OR REPLACE TRIGGER trg_delete_vehicles
BEFORE DELETE ON Vehicle_Specification
FOR EACH ROW
BEGIN
  DELETE FROM Vehicle
  WHERE specification_id = :OLD.specification_id;
END;
/

CREATE OR REPLACE TRIGGER trg_delete_hire_arrangement
BEFORE DELETE ON Customer
FOR EACH ROW
BEGIN
  DELETE FROM Hire_Arrangement
  WHERE customer_id = :OLD.customer_id;
END;
/

CREATE OR REPLACE TRIGGER trg_delete_fleet_vehicle
BEFORE DELETE ON Vehicle
FOR EACH ROW
BEGIN
  DELETE FROM Fleet_Vehicle
  WHERE vehicle_code = :OLD.vehicle_code;
END;
/

CREATE OR REPLACE TRIGGER trg_delete_fleet_vehicle_from_fleet
BEFORE DELETE ON Fleet_Hire
FOR EACH ROW
BEGIN
  DELETE FROM Fleet_Vehicle
  WHERE fleet_code = :OLD.fleet_code;
END;
/

CREATE OR REPLACE TRIGGER trg_delete_country_dependents
BEFORE DELETE ON Country
FOR EACH ROW
BEGIN
  DELETE FROM Hire_Charge
  WHERE country_code = :OLD.country_code;
END;
/
