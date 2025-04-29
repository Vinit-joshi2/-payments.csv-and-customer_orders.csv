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
