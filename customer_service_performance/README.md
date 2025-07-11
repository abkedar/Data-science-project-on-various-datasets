# Customer Support Ticket Data Analysis

## 📘 Project Description

This project analyzes a Customer Support Ticket dataset using Python (Jupyter Notebook), Excel (Pivot Tables), and MySQL (SQL queries).  
The focus is on understanding customer service performance by studying ticket resolution times, customer satisfaction ratings, and workload trends.  

We performed the same set of analyses using three tools to practice multi-tool data analysis workflows and verify consistency across platforms.

---

## ✅ What’s Covered in the Project

### 1️⃣ Python (Jupyter Notebook)

- Imported and cleaned customer support ticket data using pandas.
- Converted date columns to datetime format.
- Calculated:
  - First Response Time in minutes
  - Resolution Time in minutes
- Explored patterns using EDA:
  - Ticket volume trends
  - Resolution time distribution
  - Customer satisfaction score analysis
- Visualized key insights using matplotlib and seaborn.

### 2️⃣ Excel (Pivot Tables and Charts)

- Created 7 pivot tables analyzing:
  1. Ticket Volume by Priority
  2. Average Satisfaction by Product
  3. Tickets by Channel
  4. Average Resolution Time by Ticket Type
  5. Resolution Rate by Priority
  6. Customer Gender vs Satisfaction
  7. Age Group vs Customer Satisfaction
- Built visual charts to support the analysis.
- Applied formulas and conditional formatting where required.

### 3️⃣ MySQL (SQL Queries)

- Created a structured table in MySQL using a defined schema.
- Imported cleaned CSV data using `LOAD DATA LOCAL INFILE`.
- Recreated the same 7 analyses as SQL queries:
  - GROUP BY, CASE WHEN, TIMESTAMPDIFF used to calculate times and segment data.
- Created reusable SQL views for dashboard integration.

---

## 🎯 Project Objectives

- Identify customer service performance trends:
  - Resolution time efficiency
  - Customer satisfaction impact
  - Workload trends by month/year
- Practice replicating the same analysis across Python, Excel, and SQL.
- Build a structured workflow useful for real-world business reporting and dashboards.

---

## 📂 Project Structure

customer-support-ticket-analysis/
│
├── data/
│ └── customer_support_tickets.csv
│
├── notebooks/
│ └── customer_support_analysis.ipynb
│
├── mysql_scripts/
│ └── create_table_and_queries.sql
│
├── excel_files/
│ └── pivot_table_analysis.xlsx
│
├── README.md
