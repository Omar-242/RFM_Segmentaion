# Customer Segmentation using RFM Analysis in PostgreSQL

## Project Overview

This project performs **RFM (Recency, Frequency, Monetary) Analysis** on an online retail dataset using **PostgreSQL** in **pgAdmin4**.

RFM analysis is a customer segmentation technique used in business analytics and marketing to understand customer purchasing behavior.

The project categorizes customers into segments such as:

- Loyal Customers
- Active Customers
- Potential Customers
- Sleeping Customers
- Churned Customers

The entire analysis is performed using **SQL queries only**.

---

# Dataset Information

The dataset contains online retail transaction records.

## Table Name

`online_retail_data`

## Dataset Columns

| Column Name | Description |
|---|---|
| InvoiceNo | Unique invoice number |
| StockCode | Product code |
| Description | Product description |
| Quantity | Quantity purchased |
| InvoiceDate | Date of purchase |
| UnitPrice | Price per product |
| CustomerID | Unique customer ID |
| Country | Customer country |

---

# Technologies Used

- PostgreSQL
- pgAdmin4
- SQL
- GitHub

---

# Project Structure

```text
rfm-segmentation-postgresql/
│
├── README.md
├── dataset/
│   └── online_retail_data.csv
│
├── sql/
│   └── rfm_segmentation.sql
│
├── output/
│   ├── dataset_preview.png
│   ├── rfm_output.png
│   ├── customer_segments.png
│   └── percentage_distribution.png
```

---

# What is RFM Analysis?

RFM stands for:

## 1. Recency (R)

Measures how recently a customer made a purchase.

- Lower recency value = more recent customer
- Higher recency value = inactive customer

---

## 2. Frequency (F)

Measures how often a customer makes purchases.

- Higher frequency = more engaged customer

---

## 3. Monetary (M)

Measures how much money a customer spends.

- Higher monetary value = high-value customer

---

# Project Workflow

## Step 1: Data Cleaning

The following records were removed:

- Null Invoice Numbers
- Null Customer IDs
- Null Invoice Dates
- Negative or zero quantity values

```sql
WHERE InvoiceNo IS NOT NULL
AND CustomerID IS NOT NULL
AND InvoiceDate IS NOT NULL
AND Quantity > 0
```

---

## Step 2: Calculate RFM Metrics

### Recency

Calculated using the difference between:

- Customer's last purchase date
- Latest purchase date in the dataset

### Frequency

Calculated using:

```sql
COUNT(DISTINCT InvoiceNo)
```

### Monetary

Calculated using:

```sql
SUM(UnitPrice * Quantity)
```

---

# SQL Concepts Used

This project demonstrates the use of:

- Common Table Expressions (CTEs)
- Aggregate Functions
- Window Functions
- NTILE()
- CASE Statements
- Customer Segmentation Logic
- Data Cleaning in SQL
- PostgreSQL Date Operations

---

# RFM Scoring

The project uses:

```sql
NTILE(4)
```

to divide customers into quartiles for:

- Recency
- Frequency
- Monetary

Example:

| R | F | M | RFM Score |
|---|---|---|---|
| 4 | 4 | 4 | 444 |
| 1 | 1 | 1 | 111 |

---

# Customer Segments

Customers are grouped into segments such as:

| Segment | Meaning |
|---|---|
| Loyal_Customer | Frequent and high-value customers |
| Active_Customer | Regular active buyers |
| Potential_Customer | Customers with growth potential |
| Sleeping_Away | Previously active but now inactive |
| Churned_Customer | Customers likely lost |

---

# Sample Output

The final query calculates the percentage distribution of customer segments.

Example output:

| rfm_segment | percent_count |
|---|---|
| Loyal_Customer | 32% |
| Active_Customer | 25% |
| Potential_Customer | 18% |
| Sleeping_Away | 15% |
| Churned_Customer | 10% |

---

# Screenshots

The `output/` folder contains screenshots of:

- Dataset preview
- SQL queries
- RFM calculation results
- Customer segmentation results
- Percentage distribution tables/charts

---

# Learning Outcomes

Through this project, I learned:

- Customer behavior analysis using SQL
- RFM segmentation technique
- PostgreSQL window functions
- Data aggregation and transformation
- Real-world business analytics workflow
- Writing optimized SQL using CTEs

---

# Future Improvements

Possible future improvements include:

- Creating interactive Power BI dashboards
- Visualizing customer segments
- Using Python for advanced analytics
- Applying machine learning clustering techniques
- Automating customer segmentation pipelines

---

# Author

Omar Chowdhury

---

# License

This project is for educational and learning purposes.
