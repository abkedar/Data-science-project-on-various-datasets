# 📦 Hybrid Manufacturing System (HMS) Data Analysis

This project analyzes production planning and optimization data from a **Hybrid Manufacturing System (HMS)**, which integrates both additive and subtractive manufacturing processes. The goal is to extract insights to improve **resource allocation**, **energy efficiency**, and **production scheduling** using **EDA, hypothesis testing**, and **statistical methods**.

---

## 📁 Dataset Overview

The dataset contains detailed records of each job, including:

- `Job_ID`, `Machine_ID`
- `Operation_Type`: Lathe, Grinding, Other
- `Material_Used`: Categories 1–5
- `Processing_Time`: In minutes
- `Energy_Consumption`: In kWh
- `Machine_Availability`: % available
- `Scheduled_Start`, `Scheduled_End`, `Actual_Start`, `Actual_End`: Timestamps
- `Job_Status`, `Optimization_Category`

---

## 🧠 Objectives

- Understand processing behavior and performance by machine and operation type
- Measure the impact of optimization categories on energy and time
- Evaluate scheduling accuracy and machine utilization
- Use hypothesis testing to validate statistical patterns
- Identify factors influencing delays and energy usage

---

## 📊 Exploratory Data Analysis (EDA)

- Converted datetime fields (`Scheduled_Start`, `Actual_End`, etc.)
- Handled missing and invalid values
- Created derived features:
  - `Delay_Minutes`
  - `Scheduled_Duration`
  - `Actual_Duration`
- Visualized:
  - Processing Time & Energy Distributions
  - Job frequency by Machine and Operation Type
  - Time series of scheduled jobs
  - Correlation heatmaps

---

## 🧪 Hypothesis Testing

### 1. **Optimization Category vs Energy Consumption**
- **Test**: ANOVA  
- **Result**: ✅ Significant (p < 0.001)  
- Optimization category has a measurable impact on energy usage.

### 2. **Lathe vs Grinding: Processing Time**
- **Test**: Independent t-test  
- **Result**: ✅ No significant difference (p = 0.439)  

### 3. **Machine ID vs Delay Frequency**
- **Test**: Chi-Square  
- **Result**: ✅ No significant association

### 4. **Processing Time vs Energy Consumption**
- **Test**: Pearson Correlation  
- **Result**: ✅ No linear correlation

---

## 📈 Statistical Analysis

- Descriptive stats for time, energy, delay
- Grouped stats by `Machine_ID`, `Operation_Type`, `Optimization_Category`
- Correlation matrix & normality checks (skewness, kurtosis)
- Bar charts, line graphs, and heatmaps for visual interpretation

---

## 🧮 Tools Used

- **Python** (pandas, seaborn, matplotlib, scipy)
- **Jupyter Notebook**
- **MySQL** (for initial queries and cleaning)

---

## 📌 Key Insights

- Optimization strategy directly affects energy consumption
- Operation type (Lathe vs Grinding) does not influence time significantly
- Machines are equally likely to experience job delays
- No correlation between processing time and energy, suggesting other factors are at play

---

## 🚀 Next Steps (Optional)

- Predictive modeling (regression/classification)
- Energy optimization suggestions
- Build Power BI or Excel dashboard for real-time insights

---

## 📁 Folder Structure

