CREATE OR REPLACE VIEW sales_dashboard AS
SELECT 
    s.order_id,
    s.order_date,
    s.ship_date,
    s.ship_mode,
    s.sales,
    s.quantity,
    s.discount,
    s.profit,
    s.payment_mode,
    
    c.customer_id,
    c.customer_name,
    c.segment,
    c.age,
    c.region,
    c.state,
    
    p.product_id,
    p.category,
    p.sub_category,
    p.product_name
FROM 
    sales_data s
JOIN customer_data c ON s.customer_id = c.customer_id
JOIN product_data p ON s.product_id = p.product_id;



SELECT 
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    
    SUM(quantity) AS total_quantity
FROM sales_dashboard;



SELECT 
  ROUND(AVG(TIMESTAMPDIFF(
      DAY, 
      STR_TO_DATE(Order_Date, '%m/%d/%Y'), 
      STR_TO_DATE(Ship_Date, '%m/%d/%Y')
  )), 2) AS avg_shipping_days
FROM 
  project.sales_data
WHERE 
  Order_Date IS NOT NULL 
  AND Ship_Date IS NOT NULL;


SELECT 
   ship_mode,
   ROUND(SUM(sales), 2) AS total_sales
FROM sales_dashboard
GROUP BY ship_mode
ORDER BY total_sales DESC;


SELECT 
   category,
   ROUND(SUM(sales), 2) AS total_sales
FROM sales_dashboard
GROUP BY category
ORDER BY total_sales DESC;


SELECT 
   sub_category,
   ROUND(SUM(sales), 2) AS total_sales
FROM sales_dashboard
GROUP BY sub_category
ORDER BY total_sales DESC;


SELECT 
   region,
   state,
   ROUND(SUM(sales), 2) AS total_sales
FROM sales_dashboard
GROUP BY region, state
ORDER BY region, total_sales DESC;

SELECT 
   category,
   region,
   ROUND(SUM(sales), 2) AS total_sales
FROM sales_dashboard
GROUP BY category, region
ORDER BY category, region;


SELECT
   YEAR(STR_TO_DATE(order_date,'%m/%d/%Y')) AS year,
   ROUND(SUM(sales), 2)  AS total_sales,
   ROUND(SUM(profit), 2) AS total_profit
FROM sales_dashboard
GROUP BY YEAR(STR_TO_DATE(order_date,'%m/%d/%Y'))
ORDER BY year;



