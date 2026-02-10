--view
CREATE OR REPLACE VIEW customer_hire_summary AS
SELECT 
    c.customer_id,
    c.name AS customer_name,
    c.email,
    c.customer_type,
    c.insurance_type,
    c.discount_provided,
    COUNT(h.hire_id) AS total_hires,
    SUM(h.no_of_cars) AS total_cars_hired,
    SUM(h.hire_duration) AS total_hire_days,
    MAX(h.start_date) AS latest_hire_date,
    MIN(h.start_date) AS first_hire_date
FROM 
    Customer c
LEFT JOIN 
    Hire_Arrangement h ON c.customer_id = h.customer_id
GROUP BY 
    c.customer_id, c.name, c.email, c.customer_type, 
    c.insurance_type, c.discount_provided;

    -- 1. Verify all customers appear (even those without hires)
SELECT * FROM customer_hire_summary ORDER BY customer_id;

-- 2. Check counts match base tables
SELECT 
    (SELECT COUNT(*) FROM Customer) AS total_customers,
    (SELECT COUNT(*) FROM customer_hire_summary) AS view_customers
FROM dual;



CREATE OR REPLACE VIEW corporate_fleet_analysis AS
SELECT 
    c.customer_id,
    c.name AS company_name,
    c.email,
    COUNT(h.hire_id) AS total_fleet_hires,
    SUM(h.no_of_cars) AS total_vehicles,
    AVG(h.hire_duration) AS avg_hire_duration,
    MAX(h.no_of_drivers) AS max_drivers_used,
    ROUND(SUM(h.hire_duration * h.no_of_cars)) AS total_vehicle_days,
    h.payment_mode,
    COUNT(DISTINCT h.vehicle_specification_name) AS distinct_vehicle_types
FROM 
    Customer c
JOIN 
    Hire_Arrangement h ON c.customer_id = h.customer_id
WHERE 
    c.customer_type = 'Corporate'
    AND h.hire_type = 'FLEET'
GROUP BY 
    c.customer_id, c.name, c.email, h.payment_mode;

-- 1. Verify only corporate customers with fleet hires appear
SELECT * FROM corporate_fleet_analysis;




CREATE OR REPLACE VIEW vehicle_inventory_summary AS
SELECT 
    v.vehicle_code,
    v.registration_no,
    vs.make,
    vs.model,
    vs.vehicle_class,
    v.fuel_type,
    v.mileage_km,
    v.vehicle_available,
    v.last_serviced_date,
    v.insurance_expiry_date,
    v.warranty_expiry_date,
    CASE 
        WHEN v.insurance_expiry_date < SYSDATE THEN 'Expired'
        WHEN v.insurance_expiry_date < ADD_MONTHS(SYSDATE, 1) THEN 'Expiring Soon'
        ELSE 'Valid'
    END AS insurance_status,
    CASE 
        WHEN v.warranty_expiry_date < SYSDATE THEN 'Expired'
        WHEN v.warranty_expiry_date < ADD_MONTHS(SYSDATE, 3) THEN 'Expiring Soon'
        ELSE 'Valid'
    END AS warranty_status,
    TRUNC(MONTHS_BETWEEN(SYSDATE, v.purchase_date)/12) AS vehicle_age_years,
    v.purchase_price,
    vs.seating_capacity,
    vs.air_conditioning
FROM 
    Vehicle v
JOIN 
    Vehicle_Specification vs ON v.specification_id = vs.specification_id;

    -- 1. Verify all vehicles appear in inventory summary
SELECT 
    (SELECT COUNT(*) FROM Vehicle) AS total_vehicles,
    (SELECT COUNT(*) FROM vehicle_inventory_summary) AS view_vehicles
FROM dual;


CREATE OR REPLACE VIEW maintenance_due_view AS
SELECT 
    v.vehicle_code,
    v.registration_no,
    vs.make,
    vs.model,
    v.last_serviced_date,
    v.mileage_km,
    CASE 
        WHEN MONTHS_BETWEEN(SYSDATE, v.last_serviced_date) > 6 THEN 'Time Overdue'
        WHEN MONTHS_BETWEEN(SYSDATE, v.last_serviced_date) > 4 THEN 'Time Due Soon'
        WHEN v.mileage_km > 100000 THEN 'High Mileage Vehicle'
        ELSE 'Within Maintenance Limits'
    END AS maintenance_status,
    v.vehicle_available,
    TRUNC(SYSDATE) - v.last_serviced_date AS days_since_last_service
FROM 
    Vehicle v
JOIN 
    Vehicle_Specification vs ON v.specification_id = vs.specification_id
WHERE 
    v.vehicle_available = 'Yes';



    -- Analyze maintenance status distribution
SELECT maintenance_status, COUNT(*) 
FROM maintenance_due_view
GROUP BY maintenance_status
ORDER BY COUNT(*) DESC;


--1. Vehicle Pricing Catalog View
CREATE OR REPLACE VIEW vehicle_pricing_catalog AS
SELECT 
    vs.specification_id,
    vs.vehicle_class,
    vs.make,
    vs.model,
    vs.engine_capacity,
    vs.seating_capacity,
    hc.daily_rate,
    hc.weekly_rate,
    hc.monthly_rate,
    hc.country_code,
    ROUND(hc.weekly_rate/7, 2) AS effective_daily_from_weekly,
    ROUND(hc.monthly_rate/30, 2) AS effective_daily_from_monthly,
    CASE 
        WHEN hc.weekly_rate/7 < hc.daily_rate THEN 'Weekly discount'
        WHEN hc.monthly_rate/30 < hc.daily_rate THEN 'Monthly discount'
        ELSE 'No volume discount'
    END AS pricing_strategy
FROM 
    Vehicle_Specification vs
JOIN 
    Hire_Charge hc ON vs.specification_id = hc.specification_id;

-- 1. Verify all specifications appear in the catalog
SELECT 
    (SELECT COUNT(*) FROM Vehicle_Specification) AS total_specs,
    (SELECT COUNT(DISTINCT specification_id) FROM vehicle_pricing_catalog) AS specs_in_catalog
FROM dual;



CREATE OR REPLACE VIEW pricing_by_vehicle_class AS
SELECT 
    vehicle_class,
    COUNT(*) AS vehicle_count,
    ROUND(MIN(daily_rate), 2) AS min_daily_rate,
    ROUND(AVG(daily_rate), 2) AS avg_daily_rate,
    ROUND(MAX(daily_rate), 2) AS max_daily_rate,
    ROUND(MIN(weekly_rate), 2) AS min_weekly_rate,
    ROUND(AVG(weekly_rate), 2) AS avg_weekly_rate,
    ROUND(MAX(weekly_rate), 2) AS max_weekly_rate,
    ROUND(MIN(monthly_rate), 2) AS min_monthly_rate,
    ROUND(AVG(monthly_rate), 2) AS avg_monthly_rate,
    ROUND(MAX(monthly_rate), 2) AS max_monthly_rate
FROM 
    vehicle_pricing_catalog
GROUP BY 
    vehicle_class;


-- 1. Verify class aggregation
SELECT * FROM pricing_by_vehicle_class
ORDER BY avg_daily_rate DESC;


CREATE OR REPLACE VIEW center_capacity_analysis AS
SELECT 
    hc.h_center_id,
    hc.center_name,
    hc.city,
    hc.country,
    hc.no_of_cars,
    hc.no_of_driver,
    hc.no_of_employee,
    no.office_name,
    ROUND(hc.no_of_driver/NULLIF(hc.no_of_cars, 0), 2) AS driver_to_car_ratio,
    ROUND(hc.no_of_employee/NULLIF(hc.no_of_cars, 0), 2) AS employee_to_car_ratio,
    CASE 
        WHEN hc.no_of_driver < hc.no_of_cars THEN 'Driver Shortage'
        WHEN hc.no_of_driver > hc.no_of_cars * 1.2 THEN 'Excess Drivers'
        ELSE 'Balanced'
    END AS driver_status,
    CASE 
        WHEN hc.no_of_employee < hc.no_of_cars * 0.5 THEN 'Understaffed'
        WHEN hc.no_of_employee > hc.no_of_cars * 0.8 THEN 'Overstaffed'
        ELSE 'Adequate Staffing'
    END AS staffing_status
FROM 
    Hire_Center hc
LEFT JOIN 
    National_Office no ON hc.office_id = no.office_id;

-- 1. Verify hierarchy completeness
SELECT 
    (SELECT COUNT(*) FROM National_Office) AS total_offices,
    (SELECT COUNT(*) FROM office_center_hierarchy) AS offices_in_view,
    (SELECT COUNT(*) FROM Hire_Center) AS total_centers,
    (SELECT SUM(number_of_centers) FROM office_center_hierarchy) AS centers_in_view
FROM dual;


CREATE OR REPLACE VIEW national_office_performance AS
SELECT 
    no.office_id,
    no.office_name,
    no.city,
    no.country,
    no.established_date,
    TRUNC(MONTHS_BETWEEN(SYSDATE, no.established_date)/12) AS years_established,
    no.no_of_regionaloffice,
    COUNT(hc.h_center_id) AS actual_centers_managed,
    SUM(hc.no_of_cars) AS total_vehicles_managed,
    SUM(hc.no_of_driver) AS total_drivers_managed,
    SUM(hc.no_of_employee) AS total_employees_managed,
    ROUND(SUM(hc.no_of_cars)/NULLIF(no.no_of_regionaloffice, 0), 2) AS cars_per_regional_office,
    ROUND(SUM(hc.no_of_employee)/NULLIF(COUNT(hc.h_center_id), 0), 2) AS avg_employees_per_center
FROM 
    National_Office no
LEFT JOIN 
    Hire_Center hc ON no.office_id = hc.office_id
GROUP BY 
    no.office_id, no.office_name, no.city, no.country, 
    no.established_date, no.no_of_regionaloffice;


--Verify office performance calculations
SELECT 
    office_id, 
    no_of_regionaloffice, 
    actual_centers_managed,
    cars_per_regional_office
FROM national_office_performance
WHERE cars_per_regional_office > 50;