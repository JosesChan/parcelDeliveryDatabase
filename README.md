# SQL Parcel Deliver Service

This project is a SQL script for a module in the University of Lincoln on scalable database systems. The script creates tables and procedures for a delivery and tracking system based on the schema below.


The schema was made to satisfy the following conditions.
* Create the appropriate tables that most accurately model the scenario. Normalised to at least 2NF.
* Populate tables.
* Create the following SQL queries

SQL queries:
4.1. The location of any vehicle and its driver at any hour during the working day. 

4.2. Number of parcels delivered by any specific driver during a day’s work. 

4.3. A listing of all drivers.

4.4. A listing of drivers who have driven only during morning hours shifts. 

Each table makes use of primary keys as well as possible use of foreign keys and composite primary keys. In the case of "daily_shifts_junction" the id of drivers and the shift timings are combined to uniquely identify the row. This also ensures no overbook of a driver on a shift, however to ensure no overbooking of vehicles a unique constraint was made to keep only unique combinations of vehicles and shift timings.


The table "shift_types" contain the different shifts available for delivery drivers, at the moment there are two shifts for the morning and afternoon along with ids to represent them.

The table "weekly_shifts" assigns the morning and afternoon ids to actual dates in the calendar. Currently, there is a weeks worth of shifts assigned. Each type of shift for the day is represented by the weekly_shift_id.

The table "daily_shifts_junction" takes the weekly_shift_id and assigns shifts to the drivers through the driver id that comes from the "drivers" table as a foreign key. Allowing drivers to be assigned for a certain morning or afternoon shift for a certain day using the relevant id. It also allocates vehicles for the shift in the same manner.

The table "vehicles" stores the vehicle information and is represented elsewhere as a vehicle id which is used as a foreign key in "daily_shifts_junction" and "delivery_information_junction".

The table "delivery_information_junction" connects the parcels and vehicles together. Storing the timing and date of the last known contact from the parcel.

The table "parcels" stores general information of the parcel such as recipient information and delivery information.

#4.1. The location of any vehicle and its driver at any hour during the working day. 

Using the JOIN command, the following tables "daily_shifts_junction", "delivery_information_junction", "drivers" and "shift_types" were connected to get date/time information to correlate with vehicle id and return the relevant information on the vehicle and driver.

Values you can use to test: 2021-01-07, 14:30:00, 1

#4.2. Number of parcels delivered by any specific driver during a day’s work. 

To get the following information, the following tables were connected using the JOIN command: the tables with shift information, "drivers" table and the general "delivery_information_junction". Then using the WHERE command, it looks for the corresponding input information(date and driver id) to get the relevant rows.

Values you can use to test: 2021-01-11, 1

#4.3. A listing of all drivers.

The driver names were coalesced from selection and sorting of the first and last names column.

#4.4. A listing of drivers who have driven only during morning hours shifts. 

To single out morning shift drivers, the table for identifying the shift type were needed. "Weekly_shift" was joined with "daily_shift_junction" to determine which driver is on morning shift using the weekly_shift_id as an identifier.



