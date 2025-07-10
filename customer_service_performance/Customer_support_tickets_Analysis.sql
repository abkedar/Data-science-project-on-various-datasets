use customer_tickets;

drop table support_tickets;

CREATE TABLE support_tickets (
    Ticket_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Customer_Email VARCHAR(150),
    Customer_Age INT,
    Customer_Gender VARCHAR(10),
    Product_Purchased VARCHAR(100),
    Date_of_Purchase DATETIME,
    Ticket_Type VARCHAR(50),
    Ticket_Subject VARCHAR(255),
    Ticket_Description TEXT,
    Ticket_Status VARCHAR(50),
    Resolution TEXT,
    Ticket_Priority VARCHAR(20),
    Ticket_Channel VARCHAR(50),
    First_Response_Time DATETIME,
    Time_to_Resolution DATETIME,
    Customer_Satisfaction_Rating DECIMAL(2,1)
);

-- Use Command-Line Tool To Load Data.

select * from support_tickets;

describe support_tickets;

-- Ticket Volume by Priority
-- Shows which priority level gets the most tickets.
SELECT
	Ticket_Priority,
    COUNT(*) AS Ticket_Count
FROM support_tickets
GROUP BY Ticket_Priority
ORDER BY Ticket_Count DESC;

-- Average Satisfaction by Product
-- Helps identify which products lead to happier (or unhappier) customers.
SELECT 
	Product_Purchased,
    ROUND(AVG(Customer_Satisfaction_Rating), 2) AS Avg_Satisfaction
FROM support_tickets
WHERE Customer_Satisfaction_Rating IS NOT NULL
GROUP BY Product_Purchased
ORder BY Avg_Satisfaction DESC;

-- Tickets by Channel
-- Helps visualize where most tickets come from (Email, Phone, etc.).
SELECT 
	Ticket_Channel,
	COUNT(*) AS Ticket_Count
FROM support_tickets
GROUP BY Ticket_Channel
ORDER BY Ticket_Count;

-- Average Resolution Time by Ticket Type
-- Shows which ticket types take the most time to resolve.
SELECT
	Ticket_Type,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, Date_of_Purchase, Time_to_Resolution)), 2) AS Avg_Resolution_Minutes
FROM support_tickets
WHERE Time_to_Resolution IS NOT NULL
GROUP BY Ticket_Type
ORDER BY Avg_Resolution_Minutes DESC;

-- Resolution Rate by Priority
-- See which priority levels are closed successfully.
SELECT 
	Ticket_Priority,
    COUNT(*) AS Total_Tickets,
    SUM(CASE WHEN Resolution IS NOT NULL THEN 1 ELSE 0 END) AS Resolved_Tickets,
    ROUND(100.0 * SUM(CASE WHEN Resolution is not null then 1 else 0 End) / COUNT(*), 2) AS Resolution_Rate
FROM support_tickets
Group BY Ticket_Priority
Order by Resolution_Rate DESC;

-- Customer Gender vs Satisfaction
-- Explore if satisfaction varies by gender.
SELECT 
	CASE
		WHEN Customer_Age < 25 then '<25'
        WHEN Customer_Age Between 25 and 35 then '25-35'
        WHEN Customer_Age Between 36 and 50 then '36-50'
        else '50+'
	End As Age_Group,
    ROUND(AVG(Customer_Satisfaction_Rating), 2) AS Avg_Satisfaction
FROM support_tickets
WHERE Customer_Satisfaction_Rating IS NOT NULL
GROUP BY Age_Group
Order BY Age_Group;


-- Customer Age Group vs Rating
-- Insight into which age group is more satisfied.



