SELECT * FROM dbo.['2020$']
ALTER TABLE dbo.['2020$'] DROP COLUMN is_repeated_guest
ALTER TABLE dbo.['2020$'] DROP COLUMN previous_cancellations, previous_bookings_not_canceled, booking_changes, days_in_waiting_list, company, required_car_parking_spaces
ALTER TABLE dbo.['2020$'] DROP COLUMN children, babies
SELECT * FROM dbo.['2020$']
SELECT CONVERT(VARCHAR(10), reservation_status_date, 120) AS Reservation_Date
FROM dbo.['2020$']
ALTER TABLE dbo.['2020$']
ADD Reservation_Date VARCHAR(10)
UPDATE dbo.['2020$'] 
SET Reservation_Date = CONVERT(VARCHAR(10), reservation_status_date, 120)
ALTER TABLE dbo.['2020$'] DROP COLUMN reservation_status_date  
SELECT * FROM dbo.['2020$']

----- 2nd Table to check columnNULL Valuess with 0 or NULL Values
SELECT * FROM dbo.['2019$']
ALTER TABLE dbo.['2019$'] DROP COLUMN is_repeated_guest
ALTER TABLE dbo.['2019$'] DROP COLUMN previous_cancellations, previous_bookings_not_canceled, booking_changes, days_in_waiting_list, company, required_car_parking_spaces
ALTER TABLE dbo.['2019$'] DROP COLUMN children, babies
SELECT * FROM dbo.['2019$']
SELECT CONVERT(VARCHAR(10), reservation_status_date, 120) AS Reservation_Date
FROM dbo.['2019$']
ALTER TABLE dbo.['2019$']
ADD Reservation_Date VARCHAR(10)
UPDATE dbo.['2019$'] 
SET Reservation_Date = CONVERT(VARCHAR(10), reservation_status_date, 120)
ALTER TABLE dbo.['2019$'] DROP COLUMN reservation_status_date  
SELECT * FROM dbo.['2019$']
------- 3rd Table to check columnNULL Valuess with 0 or NULL Values
SELECT * FROM dbo.['2018$']
ALTER TABLE dbo.['2018$'] DROP COLUMN is_repeated_guest
ALTER TABLE dbo.['2018$'] DROP COLUMN previous_cancellations, previous_bookings_not_canceled, booking_changes, days_in_waiting_list, company, required_car_parking_spaces
ALTER TABLE dbo.['2018$'] DROP COLUMN children, babies
SELECT * FROM dbo.['2018$']
SELECT CONVERT(VARCHAR(10), reservation_status_date, 120) AS Reservation_Date
FROM dbo.['2018$']
ALTER TABLE dbo.['2018$']
ADD Reservation_Date VARCHAR(10)
UPDATE dbo.['2018$'] 
SET Reservation_Date = CONVERT(VARCHAR(10), reservation_status_date, 120)
ALTER TABLE dbo.['2018$'] DROP COLUMN reservation_status_date  
SELECT * FROM dbo.['2018$']
----- 
SELECT * FROM dbo.market_segment$
ALTER TABLE dbo.market_segment$
ADD [Discount] VARCHAR(10) 

UPDATE dbo.market_segment$
SET [Percentage] = CAST(CASE 
                            WHEN discount=0 THEN '0%'
                            WHEN discount=0.1 THEN '10%'
                            WHEN discount=0.15 THEN '15%'
                            WHEN discount=0.2 THEN '20%'
                            WHEN discount=0.3 THEN '30%'
                            WHEN discount=1 THEN '100%'
                       END AS VARCHAR(10)) 
SELECT * FROM dbo.market_segment$

DELETE FROM dbo.market_segment$
WHERE discount = 0 AND [Percentage] = '0%'
SELECT * FROM dbo.market_segment$
-----
SELECT * FROM dbo.meal_cost$
DELETE FROM dbo.meal_cost$
WHERE Cost = 0 AND [meal] = 'Undefined'
SELECT * FROM dbo.meal_cost$
---- 
UPDATE dbo.['2020$']
SET agent = 0
WHERE agent IS NULL;
SELECT * FROM dbo.['2020$']
UPDATE dbo.['2019$']
SET agent = 0
WHERE agent IS NULL;
SELECT * FROM dbo.['2019$']
UPDATE dbo.['2018$']
SET agent = 0
WHERE agent IS NULL;
SELECT * FROM dbo.['2018$']
------
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT 
arrival_date_year,
hotel,
arrival_date_month, 
SUM((stays_in_week_nights + stays_in_weekend_nights)*adr) AS Revenue
FROM Locations
GROUP BY arrival_date_year, arrival_date_month, hotel
-----
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT 
hotel,
arrival_date_year, 
SUM((stays_in_week_nights + stays_in_weekend_nights)*adr) AS Revenue
FROM Locations
GROUP BY hotel, arrival_date_year
--------
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT 
hotel,
stays_in_week_nights, 
stays_in_weekend_nights,
(stays_in_week_nights + stays_in_weekend_nights) AS total_days_per_week
FROM Locations
GROUP BY hotel, stays_in_week_nights, stays_in_weekend_nights
---
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT 
hotel,
market_segment,
distribution_channel, 
reserved_room_type
FROM Locations
GROUP BY hotel, market_segment, distribution_channel, reserved_room_type
-----
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT 
hotel,
distribution_channel, 
COUNT(distribution_channel) AS Total_Distribution_By_Channel
FROM Locations
GROUP BY hotel, distribution_channel
---------------
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT 
hotel,
reserved_room_type, 
COUNT(reserved_room_type) AS Total_reservation_room_types
FROM Locations
GROUP BY hotel, reserved_room_type
-------
with Locations as (
SELECT * FROM dbo.['2018$']
UNION
SELECT * FROM dbo.['2019$']
UNION
SELECT * FROM dbo.['2020$'])

SELECT * FROM Locations
Left join dbo.market_segment$
on Locations.market_segment = market_segment$.market_segment
Left join dbo.meal_cost$
on meal_cost$.meal = Locations.meal
