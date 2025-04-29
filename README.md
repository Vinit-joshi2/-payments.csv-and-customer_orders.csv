# -payments.csv-and-customer_orders.csv

<h1>📦 Order and Sales Analysis</h1>

<p>This analysis focuses on exploring order status and sales performance using SQL queries.  
We aim to uncover key metrics, revenue patterns, and ordering trends over time to support better business decisions.</p>

<hr />

<h2>🗂️ Dataset Overview</h2>

<p>The data is sourced from the <code>company.customer_orders</code> table, containing:</p>

<ul>
  <li><code>order_date</code> - Date when the order was placed</li>
  <li><code>order_status</code> - Status of the order (Completed, Pending, Cancelled, etc.)</li>
  <li><code>order_amount</code> - Total monetary value of the order</li>
</ul>

<hr />

<h2>📊 SQL Analysis</h2>

<h3>✅ Order Status Analysis</h3>

<h4>🔢 Count of Orders by Order Status</h4>

```sql
SELECT order_status, COUNT(*) AS Total_No_of_orders
FROM company.customer_orders
GROUP BY order_status;
```

<h4>💰 Total Order Amount by Order Status</h4>

```sql
SELECT order_status, ROUND(SUM(order_amount), 2) AS Total_Order_Amount
FROM company.customer_orders
GROUP BY order_status;
```

<h4>📉 Average Order Amount by Order Status</h4>

```sql
SELECT order_status, ROUND(AVG(order_amount), 2) AS Total_Order_Amount
FROM company.customer_orders
GROUP BY order_status;
```


<hr/> <h3>📅 Monthly Trends</h3> <h4>🗓️ Total Number of Orders Per Month</h4>

```sql
SELECT MONTHNAME(order_date) AS month, COUNT(*) AS Number_of_order
FROM company.customer_orders
GROUP BY MONTHNAME(order_date)
ORDER BY MONTHNAME(order_date);
```

<h4>📈 Total Sales Over Time (Monthly)</h4>

```sql
USE company;

SELECT MONTHNAME(order_date) AS month, ROUND(SUM(order_amount), 2)
FROM company.customer_orders
GROUP BY MONTHNAME(order_date)
ORDER BY 2;
```

<h4>📊 Average Sales Over Time (Monthly)</h4>

```sql
SELECT MONTHNAME(order_date) AS month, ROUND(AVG(order_amount), 2) AS monthly_revenue
FROM company.customer_orders
GROUP BY MONTHNAME(order_date)
ORDER BY 2;

```

<hr /> <h3>📌 Monthly and Status Insights</h3> <h4>💵 Monthly Revenue Based on Order Status</h4>

```sql
SELECT MONTHNAME(order_date) AS month, ROUND(AVG(order_amount), 2) AS monthly_revenue, order_status
FROM company.customer_orders
GROUP BY MONTHNAME(order_date), order_status
ORDER BY 1, 3;
```


<h4>🧾 Monthly Orders Based on Order Status</h4>

```sql
SELECT MONTHNAME(order_date) AS month, COUNT(*) AS monthly_revenue, order_status
FROM company.customer_orders
GROUP BY MONTHNAME(order_date), order_status
ORDER BY 1, 3;
```


<hr /> <h3>💰 Overall Revenue Summary</h3> <h4>🔢 Total Revenue</h4>

```sql
SELECT SUM(order_amount) AS total_revenue
FROM customer_orders;
```
