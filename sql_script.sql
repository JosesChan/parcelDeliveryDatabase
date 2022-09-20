CREATE DATABASE parcel_delivery_service;


#creates the tables and their fields
CREATE table shift_types(
					shift_type VARCHAR(50) PRIMARY KEY NOT NULL, 
                    start_shift_time TIME NOT NULL, 
                    end_shift_time TIME NOT NULL
                    );

CREATE table weekly_shifts(
					weekly_shift_id INTEGER(20) PRIMARY KEY NOT NULL, 
                    calendar_dates DATE NOT NULL, 
                    shift_type VARCHAR(50),
                    FOREIGN KEY (shift_type) REFERENCES shift_types(shift_type)
                    );

CREATE table drivers(
			driver_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT, 
			driver_first_name VARCHAR(50) NOT NULL, 
			driver_last_name VARCHAR(50) NOT NULL, 
			telephone_driver INTEGER (15) NOT NULL UNIQUE
            );

CREATE table vehicles(
			vehicle_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
			registration_plate VARCHAR(7) NOT NULL, 
			last_Maintenance_date DATE NOT NULL
            );

CREATE table parcels(
			parcel_id INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT, 
			delivery_address VARCHAR(95) NOT NULL, 
			first_name_recipient VARCHAR(50) NOT NULL, 
			last_name_recipient VARCHAR(50) NOT NULL, 
			telephone_recipient INTEGER(15) NOT NULL
            );


#creates junction table where certain tables are connected through
CREATE table daily_shifts_junction(
			driver_id INTEGER,
			vehicle_id INTEGER,
			weekly_shift_id INTEGER(20) NOT NULL,		
            PRIMARY KEY(driver_id, weekly_shift_id),
            FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
			FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE SET NULL,
            FOREIGN KEY (weekly_shift_id) REFERENCES weekly_shifts(weekly_shift_id),
            CONSTRAINT asynchronousVehicles UNIQUE (vehicle_id,weekly_shift_id)
			);

CREATE table delivery_information_junction(
			last_contact_date DATE,
            last_contact_time TIME,
			vehicle_id INTEGER,
            parcel_id INTEGER,
			current_city VARCHAR(50), 
			parcel_status BIT DEFAULT NULL, 
			PRIMARY KEY (last_contact_date, last_contact_time, vehicle_id),
			FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE CASCADE, 
			FOREIGN KEY (parcel_id) REFERENCES parcels(parcel_id) ON DELETE SET NULL
            );
			
			
#populate tables

INSERT INTO shift_types(shift_type, start_shift_time, end_shift_time) VALUES
('Morning', '08:00:00', '11:55:00'),
('Afternoon', '12:00:00', '16:00:00');

#Link the shift period and shift date to shift id
INSERT INTO weekly_shifts(weekly_shift_id, calendar_dates, shift_type) VALUES
('111', '2021-01-11', 'Morning'),
('112', '2021-01-11', 'Afternoon'),
('121', '2021-01-12', 'Morning'),
('122', '2021-01-12', 'Afternoon'),
('131', '2021-01-13', 'Morning'),
('132', '2021-01-13', 'Afternoon'),
('141', '2021-01-14', 'Morning'),
('142', '2021-01-14', 'Afternoon'),
('151', '2021-01-15', 'Morning'),
('152', '2021-01-15', 'Afternoon'),
('161', '2021-01-16', 'Morning'),
('162', '2021-01-16', 'Afternoon');


#populate driver table
INSERT INTO drivers(driver_first_name, driver_last_name, telephone_driver) VALUES
('Sergio', 'Perez', '01632960004'),
('Max', 'Verstappen', '01632960077'),
('Pierre', 'Gasly', '01632960024'),
('Alex', 'Albon', '01632965123'),
('Esteban', 'Ocon', '01632960311'),
('George', 'Russell', '01632960531'),
('Sebbastian', 'Vettel', '01632960631'),
('Lance', 'Stroll', '01632966032'),
('Phillipe', 'Badeux', '01632960042'),
('Enrique', 'Gonzales', '01632960333');

#populate vehicles table
INSERT INTO vehicles(registration_plate, last_Maintenance_date) VALUES 
('YD11 LBP', '2021-01-01'),
('YD12 LBP', '2021-01-15'),
('YD13 LBP',  '2020-12-15'),
('YD14 LBP', '2020-12-28'),
('YD15 LBP', '2021-12-29');

#populate parcels table
INSERT INTO parcels (delivery_address, first_name_recipient, last_name_recipient, telephone_recipient) VALUES 
('06 Homewood Hill', 'James', 'Wilson', '01632970004'),
('810 Banding Avenue', 'John', 'Potter', '01632970521'),
('9 Banding Trail', 'Jackson', 'Oats', '01632975122'),
('8 Armistice Park', 'Jonathan', 'Sloan', '01632976321'),
('12787 Springs Avenue', 'Jack', 'Shaw', '01632976346'),
('44 Pennsylvania Alley', 'Jameson', 'Brown', '01632977547'),
('7202 Cottonwood Avenue', 'Jeff', 'Smith', '01632976436'),
('88767 Annamark Road', 'Jefferson', 'Willson', '01632971253'),
('69372 Jay Street', 'Johnny', 'Williamson', '01632975321'),
('8453 Manufacturers Lane', 'Alex', 'Smith', '01632976936'),
('384 Roth Plaza', 'Samantha', 'Ruff', '01632976943'),
('54392 Union Place', 'Sandra', 'Hutchley', '01632976432'),
('0607 Reindahl Court', 'Cassie', 'Montgomery', '01632976473'),
('89048 Anthes Road', 'Jackie', 'Lee', '01632979743'),
('8490 Harbort Junction', 'George', 'Patterson', '01632979748'),
('8490 Harriet Junction', 'Ben', 'Finegold', '01632970010');

#populate daily shifts junction table, assign multiple drivers to multiple shifts along with their vehicles (Their actual shifts)
INSERT INTO daily_shifts_junction (driver_id, vehicle_id ,weekly_shift_id) VALUES 
(1,1,111),
(1,2,112),
(2,3,112),
(2,4,121),
(2,5,122),
(3,4,122),
(3,2,131),
(3,1,132),
(4,5,141),
(1,3,142),
(6,2,142),
(8,3,151),
(9,2,151),
(1,4,152),
(2,5,152),
(6,5,161),
(7,4,161),
(1,3,161),
(2,1,161),
(2,2,162);

INSERT INTO delivery_information_junction (last_contact_date, last_contact_time, current_city, vehicle_id, parcel_id, parcel_status) VALUES
('2021-01-11', '9:00:00', 'Rochester', 2, 1, 0),
('2021-01-11', '11:00:00', 'Lincoln', 2, 2, 1),
('2021-01-11', '15:00:00', 'Glasgow', 2, 3, 1),
('2021-01-12', '10:25:00', 'Arizona', 5, 4, 1),
('2021-01-12', '14:00:00', 'San Diego', 5, 5, 1),
('2021-01-12', '15:00:00', 'Los Angeles', 5, 6, 1),
('2021-01-13', '10:30:00', 'Hong Kong', 1, 7, 0),
('2021-01-13', '13:00:00', 'Shenzhen', 1, 8, 1),
('2021-01-13', '14:30:00', 'Hong Kong', 1, 9, 1),
('2021-01-14', '10:00:00', 'Bangkok', 3, 10, 0),
('2021-01-14', '14:00:00', 'Pattaya', 3, 11, 1),
('2021-01-15', '08:30:00', 'Edmonton', 4, 12, 1),
('2021-01-15', '11:00:00', 'Calgary', 4, 13, 1),
('2021-01-15', '15:00:00', 'Regina', 4, 14, 1),
('2021-01-16', '09:00:00', 'Seattle', 2, 7, 1),
('2021-01-16', '15:30:00', 'Portland', 2, 10, 1),
('2021-01-07', '09:00:00', 'Fargo', 1, 15, 1),
('2021-01-07', '14:30:00', 'Jamestown', 1, 16, 1);


#create queries

#4.1. The location of any vehicle and its driver at any hour during the working day. 
DELIMITER //
CREATE PROCEDURE get_Location_Vehicle_And_Driver(IN input_date date, input_time time, vehicle_id int)
BEGIN   
        SELECT delivery_information_junction.last_contact_date, delivery_information_junction.last_contact_time, delivery_information_junction.vehicle_id, 
        CONCAT (drivers.driver_first_name, ' ', drivers.driver_last_name) AS driver_name, 
        delivery_information_junction.current_city FROM weekly_shifts
		
        JOIN daily_shifts_junction
		ON weekly_shifts.weekly_shift_id = daily_shifts_junction.weekly_shift_id
		
        JOIN drivers
		ON drivers.driver_id = daily_shifts_junction.driver_id
		
        JOIN shift_types
		ON shift_types.shift_type = weekly_shifts.shift_type
		
        JOIN delivery_information_junction
		ON (delivery_information_junction.last_contact_date = weekly_shifts.calendar_dates) 
        AND (delivery_information_junction.vehicle_id = daily_shifts_junction.vehicle_id)
        
		WHERE delivery_information_junction.last_contact_date = last_contact_date 
        AND delivery_information_junction.last_contact_time = last_contact_time 
        AND delivery_information_junction.vehicle_id = vehicle_id AND delivery_information_junction.last_contact_time 
        BETWEEN shift_types.start_shift_time AND shift_types.end_shift_time
		ORDER BY delivery_information_junction.last_contact_date, delivery_information_junction.last_contact_time;
END//


#4.2. Number of parcels delivered by any specific driver during a day’s work. 
CREATE PROCEDURE get_Parcels_Delivered_Driver(IN input_date date, input_driver_id int)
BEGIN
        SELECT delivery_information_junction.last_contact_date, CONCAT (drivers.driver_first_name, ' ', drivers.driver_last_name) 
        AS driver_name, delivery_information_junction.parcel_status AS parcel_status
		FROM weekly_shifts
		JOIN daily_shifts_junction
		ON weekly_shifts.weekly_shift_id = daily_shifts_junction.weekly_shift_id
		JOIN drivers
		ON drivers.driver_id = daily_shifts_junction.driver_id
		JOIN shift_types
		ON shift_types.shift_type = weekly_shifts.shift_type
		JOIN delivery_information_junction
		ON (delivery_information_junction.last_contact_date = weekly_shifts.calendar_dates) AND (delivery_information_junction.vehicle_id = daily_shifts_junction.vehicle_id)
		WHERE delivery_information_junction.last_contact_date = input_date AND drivers.driver_id = input_driver_id AND delivery_information_junction.last_contact_time BETWEEN shift_types.start_shift_time AND shift_types.end_shift_time
		ORDER BY delivery_information_junction.last_contact_date, drivers.driver_first_name;
END//
DELIMITER ;

#4.3. A listing of all drivers.
DELIMITER //
SELECT CONCAT (driver_first_name, ' ', driver_last_name) AS NAME 
FROM drivers
ORDER BY driver_first_name, driver_last_name//
DELIMITER ;

#4.4. A listing of drivers who have driven only during morning hours shifts. 

DELIMITER //
SELECT CONCAT (drivers.driver_first_name, '', drivers.driver_last_name) AS NAME,
weekly_shifts.calendar_dates, weekly_shifts.shift_type FROM drivers
JOIN daily_shifts_junction
ON drivers.driver_id = daily_shifts_junction.driver_id
JOIN weekly_shifts
ON weekly_shifts.weekly_shift_id = daily_shifts_junction.weekly_shift_id
WHERE weekly_shifts.shift_type = 'Morning'
ORDER BY weekly_shifts.calendar_dates, drivers.driver_first_name, drivers.driver_last_name//
DELIMITER ;
