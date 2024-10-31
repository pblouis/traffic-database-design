-- Final Project All Queries
---------------------------------------------
-- Query 1: simple query that only displays the tickets that have not been paid (req. A, B) 
SELECT ticket_number, current_amount_due, violation_code,
ticket_queue, ticket_queue_date, notice_number, notice_level
FROM `ticket table`
JOIN `ticket status` USING(ticket_number)
JOIN `notice table` USING(ticket_number)
WHERE NOT ticket_queue = 'Paid'
ORDER BY ticket_number;
-- Query 2: simple query that lists tickets involving Ford or Nissan cars and thier violations (req. A, B)
SELECT ticket_number, violation_description, unit_description,
vehicle_make, license_plate_type
FROM `ticket table`
JOIN `violation table` USING(ticket_number)
JOIN `violator table` USING(ticket_number)
WHERE vehicle_make = 'FORD' OR vehicle_make = 'NISS'
ORDER BY ticket_number;
-- Query 3: query that lists the most common violation types (req. A, C)
SELECT violation_description, COUNT(violation_code) AS 'Number of
Violations'
FROM `violation table`
JOIN `ticket table` USING(ticket_number)
GROUP BY violation_description
ORDER BY COUNT(violation_code) DESC;
-- Query 4: join/linking table (req. A, B, D) to display location + violation for non-OTHR car makes (req. A, B, D)
SELECT ticket_number, vehicle_make, violation_code,
violation_description, violation_location, zip_code, issue_date_time
FROM `violation table`
JOIN `violation location` USING(violation_id)
JOIN `location table` USING(location_id)
WHERE NOT vehicle_make = 'OTHR'
ORDER BY ticket_number;
-- Query 5: query that lists locations with most amount of violations (req. A, C, E)
SELECT violation_location, violation_description, count AS 'Number of
Violations'
FROM (
SELECT violation_location, violation_description,
COUNT(violation_code) AS count
FROM `location table`
JOIN `violation location` USING (location_id)
JOIN `violation table` USING (violation_id)
GROUP BY violation_location, violation_description
) subquery
ORDER BY count DESC, violation_description