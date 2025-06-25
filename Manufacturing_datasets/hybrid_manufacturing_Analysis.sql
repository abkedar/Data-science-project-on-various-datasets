create database manufacturing_system;

use manufacturing_system;

describe hybrid_system;

select * from hybrid_system;

-- **************** Step-by-Step: Convert TEXT to DATETIME ****************
SELECT DISTINCT Scheduled_Start FROM hybrid_system LIMIT 10;

-- Add Temporary Columns
ALTER TABLE hybrid_system 
ADD COLUMN Temp_Scheduled_Start DATETIME,
ADD COLUMN Temp_Scheduled_End DATETIME,
ADD COLUMN Temp_Actual_Start DATETIME,
ADD COLUMN Temp_Actual_End DATETIME;

-- Disable Safe Update Mode Temporarily
SET SQL_SAFE_UPDATES = 0;

-- Convert Text to DATETIME Using STR_TO_DATE()
UPDATE hybrid_system
SET Temp_Scheduled_Start = STR_TO_DATE(Scheduled_Start, '%Y-%m-%d %H:%i:%s'),
    Temp_Scheduled_End   = STR_TO_DATE(Scheduled_End, '%Y-%m-%d %H:%i:%s'),
    Temp_Actual_Start    = STR_TO_DATE(Actual_Start, '%Y-%m-%d %H:%i:%s'),
    Temp_Actual_End      = STR_TO_DATE(Actual_End, '%Y-%m-%d %H:%i:%s')
WHERE Scheduled_Start <> '' AND Scheduled_End <> ''
  AND Actual_Start <> '' AND Actual_End <> ''
  AND Scheduled_Start IS NOT NULL AND Scheduled_End IS NOT NULL
  AND Actual_Start IS NOT NULL AND Actual_End IS NOT NULL;
    
-- Check Converted Data
SELECT Scheduled_Start, Temp_Scheduled_Start FROM hybrid_system LIMIT 10;

-- Drop Old Columns and Rename New Ones
ALTER TABLE hybrid_system 
DROP COLUMN Scheduled_Start,
DROP COLUMN Scheduled_End,
DROP COLUMN Actual_Start,
DROP COLUMN Actual_End;

ALTER TABLE hybrid_system
CHANGE Temp_Scheduled_Start Scheduled_Start DATETIME,
CHANGE Temp_Scheduled_End Scheduled_End DATETIME,
CHANGE Temp_Actual_Start Actual_Start DATETIME,
CHANGE Temp_Actual_End Actual_End DATETIME;

select * from hybrid_system;

-- **************** Summary KPIs ****************
-- Total number of jobs
SELECT COUNT(*) AS Total_Jobs FROM hybrid_system;

-- Completed jobs
SELECT COUNT(*) AS Completed_Jobs FROM hybrid_system WHERE Job_Status = 'Completed';

-- Average processing time
SELECT AVG(Processing_Time) AS Avg_Processing_Time FROM hybrid_system;

-- Average machine availability
SELECT AVG(Machine_Availability) AS Avg_Machine_Availability FROM hybrid_system;

-- **************** Jobs by Operation Type ****************
SELECT Operation_Type, Count(*) AS Job_Count
from hybrid_system
GROUP BY Operation_Type
ORDER BY Job_Count DESC;

-- **************** Machine Performance ****************
-- Average energy consumption per machine
SELECT Machine_ID, AVG(Energy_Consumption) AS Avg_Energy
FROM hybrid_system
GROUP BY Machine_ID;

-- Total processing time per machine
SELECT MACHINE_ID, SUM(Processing_Time) AS Total_Processing_Time
FROM hybrid_system
GROUP BY Machine_ID;

-- **************** Delay and Schedule Efficiency ****************
-- Jobs with delay (Actual_End > Scheduled_End)
SELECT Job_ID, Scheduled_End, Actual_End, TIMESTAMPDIFF(MINUTE, Scheduled_End, Actual_End) AS Delay_Minutes
FROM hybrid_system
WHERE Actual_End > Scheduled_End;

-- Average delay per Operation Type
SELECT Operation_Type,
       AVG(TIMESTAMPDIFF(MINUTE, Scheduled_End, Actual_End)) AS Avg_Delay
FROM hybrid_system
WHERE Actual_End > Scheduled_End
GROUP BY Operation_Type;

-- **************** Optimization Category Analysis ****************
-- Count jobs in each optimization category
SELECT Optimization_Category, COUNT(*) AS Job_Count
FROM hybrid_system
GROUP BY Optimization_Category;

-- Average energy and time by optimization type
SELECT Optimization_Category,
       AVG(Energy_Consumption) AS Avg_Energy,
       AVG(Processing_Time) AS Avg_Time
FROM hybrid_system
GROUP BY Optimization_Category;

-- **************** Jobs Over Time (Daily or Weekly Trend) ****************
-- Jobs scheduled per day
SELECT DATE(Scheduled_Start) AS Job_Date, COUNT(*) AS Job_Count
FROM hybrid_system
group by Job_Date
Order by Job_Date;
-- ****************

SELECT * from hybrid_system;

-- Jobs started vs completed each day
SELECT 
    DATE(Actual_Start) AS Start_Date,
    COUNT(*) AS Jobs_Started,
    (SELECT COUNT(*) 
     FROM hybrid_system p2 
     WHERE DATE(p2.Actual_End) = DATE(p1.Actual_Start)) AS Jobs_Completed
FROM hybrid_system p1
GROUP BY Start_Date
ORDER BY Start_Date;

-- **************** Material Usage Distribution ****************
SELECT Material_Used, COUNT(*) AS Job_Count
FROM hybrid_system
GROUP BY Material_Used
ORDER BY Job_Count DESC;

-- **************** Complex SQL Queries ****************
-- Jobs with delay in minutes
SELECT Job_ID, TIMESTAMPDIFF(MINUTE, Scheduled_End, Actual_End) AS Delay_Minutes
FROM hybrid_system
WHERE Actual_End > Scheduled_End;

-- Compare scheduled and actual durations
SELECT Job_ID, TIMESTAMPDIFF(MINUTE, Scheduled_Start, Scheduled_End) AS Scheduled_Duration,
		TIMESTAMPDIFF(MINUTE, Actual_Start, Actual_End),
        TIMESTAMPDIFF(MINUTE, Scheduled_Start, Scheduled_End) - TIMESTAMPDIFF(MINUTE, Actual_Start, Actual_End) AS Duration_Variance
FROM hybrid_system;

-- Energy efficiency by Optimization Category
SELECT Optimization_Category,
       AVG(Energy_Consumption / Processing_Time) AS Energy_Per_Minute
FROM hybrid_system
GROUP BY Optimization_Category
ORDER BY Energy_Per_Minute DESC;

-- Energy efficiency by Optimization Category
SELECT Optimization_Category,
       SUM(Energy_Consumption / Processing_Time) AS Energy_Per_Minute
FROM hybrid_system
GROUP BY Optimization_Category
ORDER BY Energy_Per_Minute DESC;

-- Top 5 machines with highest total delay
SELECT Machine_ID, SUM(timestampdiff(MINUTE, Scheduled_End, Actual_End)) AS Today_Delay
FROM hybrid_system
Where Actual_End > Scheduled_End
group by Machine_ID
order by Today_Delay DESC
Limit 5;

-- Daily job start and completion count
SELECT 
    DATE(Actual_Start) AS Job_Date,
    COUNT(Job_ID) AS Jobs_Started,
    (SELECT COUNT(*) 
     FROM hybrid_system AS p2 
     WHERE DATE(p2.Actual_End) = DATE(p1.Actual_Start)) AS Jobs_Completed
FROM hybrid_system AS p1
GROUP BY Job_Date
ORDER BY Job_Date;








