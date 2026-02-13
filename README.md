CARS4U - Oracle APEX Car Rental Management System

A comprehensive car rental management system built with Oracle APEX 24.2.5, featuring modern UI/UX, interactive reports, maps integration, and role-based authentication.

🚗 Overview
CARS4U is a full-featured car rental management application designed for enterprise-level vehicle rental operations. The system provides complete lifecycle management for vehicle rentals, from customer onboarding and vehicle selection to hire arrangement processing and performance analytics.
✨ Features
Core Business Modules

| Module                  | Description                                                                               |
| ----------------------- | ----------------------------------------------------------------------------------------- |
| **Vehicle Management**  | Track vehicle specifications, daily charges, availability status, and maintenance records |
| **Customer Management** | Complete customer profiles with hire history, contact details, and preferences            |
| **Employee Management** | Staff management with role-based access (Admin/Manager)                                   |
| **Office Network**      | National offices and hire centers with geographic mapping                                 |
| **Hire Arrangements**   | End-to-end rental transaction processing with date validation                             |

UI/UX Highlights
🎨 Custom Home Page - HTML/CSS/JavaScript landing page with image slider and vehicle showcase
🗺️ Interactive Maps - Geographic visualization of office locations and hire centers
📊 Dashboard Analytics - Charts and KPIs for business intelligence
📅 Calendar View - Visual hire schedule management
🎴 Vehicle Cards - Rich card-based vehicle display with booking functionality
🔒 Secure Login - CAPTCHA-protected authentication

Database Features
📐 Entity Relationship Diagram - Normalized database design
🔐 Declarative Constraints - Primary Key, Foreign Key, NOT NULL, UNIQUE, CHECK, DEFAULT
👁️ Database Views - Pre-aggregated data for efficient reporting
⚡ Triggers - Auto-increment IDs and cascading delete operations
✅ Data Validation - Multi-level validation ensuring data integrity

Advanced Capabilities

| Feature             | Implementation                                                         |
| ------------------- | ---------------------------------------------------------------------- |
| Master-Detail Pages | Hierarchical data management (Office → Hire Centers, Customer → Hires) |
| Interactive Reports | Filterable, sortable, downloadable reports                             |
| Dynamic Actions     | Real-time form validation and field updates                            |
| Role-Based Security | Admin vs Manager access levels                                         |
| Static LOVs         | Predefined values for consistent data entry                            |

🛠️ Technology Stack

| Layer              | Technology                        |
| ------------------ | --------------------------------- |
| **Platform**       | Oracle APEX 24.2.5                |
| **Database**       | Oracle Database 19c+              |
| **Frontend**       | HTML5, CSS3, JavaScript           |
| **UI Framework**   | Oracle Universal Theme            |
| **Charts**         | Oracle JET Charts                 |
| **Maps**           | Oracle Maps / MapLibre 4.6.0      |
| **Icons**          | Font APEX 2.4                     |
| **Backend**        | PL/SQL                            |
| **Authentication** | Oracle APEX Authentication Scheme |

📦 Installation
Prerequisites
Oracle Database 19c or later
Oracle APEX 24.2.5 or compatible version
Database user with APEX_ADMINISTRATOR_ROLE or parsing schema privileges
Sufficient workspace storage quota

Installation Steps
1. Import the Application
-- Run as parsing schema owner or APEX_ADMINISTRATOR_ROLE
@f171461.sql

2. Verify Database Objects
Tables: customer, employee, vehicle, vehicle_specification, hire_charge, hire_arrangement, national_office, hire_center, location
Views: Reporting views for analytics
Triggers: Auto-increment and cascade triggers
Sequences: For primary key generation

3. Configure Static Files
Upload vehicle images to application static files
Configure logo and background images
Set up map API credentials if using external map services

📄 Page Structure

| Page | Name                           | Description                      | Authorization |
| ---- | ------------------------------ | -------------------------------- | ------------- |
| 1    | **Home**                       | Landing page with vehicle slider | Public        |
| 2    | Hire Center and Location       | Manage hire center locations     | Admin/Manager |
| 3    | Master Details Page            | Parent for master-detail views   | Admin/Manager |
| 4    | National Office                | Office management                | Admin/Manager |
| 11   | **Dashboard**                  | Analytics and charts             | Admin/Manager |
| 12   | Office Locations               | Map-based location view          | Admin/Manager |
| 13   | Hire Centers                   | Center listing                   | Admin/Manager |
| 17   | **Interactive Reports**        | Data analysis                    | Admin only    |
| 18   | Monthly Hire Summary           | Monthly statistics               | Admin/Manager |
| 19   | Reports                        | Standard reports                 | Admin/Manager |
| 32   | **Customer and Hire Details**  | Master-detail customers          | Admin/Manager |
| 41   | Office Details                 | Office information               | Admin/Manager |
| 47   | **Vehicles**                   | Vehicle cards display            | Admin/Manager |
| 53   | Customer                       | Customer CRUD                    | Admin/Manager |
| 61   | National Office                | Office operations                | Admin/Manager |
| 69   | Vehicle Details                | Vehicle information              | Admin/Manager |
| 70   | Forms                          | Form collection                  | Admin/Manager |
| 71   | Hire Arrangement               | Rental forms                     | Admin/Manager |
| 76   | **Vehicle with Specification** | Master-detail vehicles           | Admin/Manager |
| 91   | Corporate Customer Fleet       | Corporate analytics              | Admin only    |
| 94   | Vehicle Utilization            | Availability report              | Admin/Manager |
| 96   | **Calendar**                   | Hire schedule                    | Admin/Manager |
| 99   | Vehicle                        | Vehicle management               | Admin/Manager |
| 101  | **Add Employee**               | Employee creation                | Admin only    |
| 106  | **Add Customer**               | Customer creation                | Admin/Manager |
| 108  | Office Performance             | Performance analytics            | Admin/Manager |

🔒 Security

Authentication
Oracle APEX built-in authentication scheme
CAPTCHA verification on login page
Session timeout handling

Authorization
| Role        | Access Level                                                            |
| ----------- | ----------------------------------------------------------------------- |
| **Admin**   | Full access to all pages including Interactive Reports and Add Employee |
| **Manager** | Limited access - cannot view Interactive Reports or Add Employee page   |
