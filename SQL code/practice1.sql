-- Table Creation

CREATE TABLE online_retail_data (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description TEXT,
    Quantity INT,
    InvoiceDate TIMESTAMP,
    UnitPrice NUMERIC(10,2),
    CustomerID INT,
    Country VARCHAR(100)
);


select * from online_retail_data;

-- Query --

-- Fetch the overall dataset.

select * from online_retail_data;

-- Necessary columns. RFM Segmentation
WITH cte1 AS (
    SELECT 
        InvoiceNo, 
        CustomerID AS customer_id, 
        InvoiceDate, 
        Quantity, 
        UnitPrice
    FROM online_retail_data
    WHERE InvoiceNo IS NOT NULL 
      AND CustomerID IS NOT NULL 
      AND InvoiceDate IS NOT NULL
      AND Quantity > 0
),

-- SELECT * FROM cte1;

cte2 AS (
    SELECT 
        customer_id, 
        MAX(InvoiceDate) AS last_purchase_date,
        (SELECT MAX(InvoiceDate) FROM cte1) AS max_date,  -- ✅ smart improvement
        ROUND(SUM(UnitPrice * Quantity), 0) AS monetary,
        COUNT(DISTINCT InvoiceNo) AS frequency
    FROM cte1
    GROUP BY customer_id
),

-- SELECT * FROM cte2;

cte3 AS (
    SELECT
        customer_id,
        (max_date::date - last_purchase_date::date) AS recency,
        frequency,
        monetary
    FROM cte2
),

-- SELECT * FROM cte3;

cte4 AS (    
    SELECT 
        *,
        NTILE(4) OVER (ORDER BY recency DESC) AS r,
        NTILE(4) OVER (ORDER BY frequency) AS f,
        NTILE(4) OVER (ORDER BY monetary) AS m
    FROM cte3
),

-- SELECT * FROM cte4;

cte5 AS (
    SELECT 
        *,
        (r::text || f::text || m::text) AS rfm_score
    FROM cte4
),

-- SELECT * FROM cte5;

cte6 AS (
    SELECT 
        *, 
        CASE 
            WHEN rfm_score IN ('111','112','121','113','114','131','141') THEN 'Churned_Customer'
            WHEN rfm_score IN ('123','124','122','133','134','144','334') THEN 'Sleeping_Away'
            WHEN rfm_score IN ('311','411','331','321') THEN 'Lost_Customer'
            WHEN rfm_score IN ('211','222','232','233','234','244') THEN 'Potential_Customer'
            WHEN rfm_score IN ('322','323','333','324','344','334') THEN 'Active_Customer'
            WHEN rfm_score IN ('421','422','423','434','444','433') THEN 'Loyal_Customer'
            ELSE 'Others' 
        END AS rfm_segment
    FROM cte5
)

-- SELECT * FROM cte6;

SELECT 
    rfm_segment, 
    COUNT(*)::decimal / (SELECT COUNT(*) FROM cte6) * 100 AS percent_count
FROM cte6 
GROUP BY rfm_segment 
ORDER BY percent_count DESC;