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
SELECT order_status , count(*) as Total_No_of_orders  FROM company.customer_orders
group by  order_status
;
```

<h4>💰 Total Order Amount by Order Status</h4>

```sql
SELECT order_status , round(sum(order_amount),2) as Total_Order_Amount FROM company.customer_orders
group by  order_status
;
```

<h4>📉 Average Order Amount by Order Status</h4>

```sql
SELECT order_status , round(avg(order_amount),2) as Total_Order_Amount FROM company.customer_orders
group by  order_status
;
```


<hr/> <h3>📅 Monthly Trends</h3> <h4>🗓️ Total Number of Orders Per Month</h4>

```sql
select monthname(order_date)  as month , count(*) as Number_of_order
from company.customer_orders
group by monthname(order_date)
order by monthname(order_date);
```

<h4>📈 Total Sales Over Time (Monthly)</h4>

```sql
use company;
select monthname(order_date)  as month , round(sum(order_amount),2) 
from company.customer_orders
group by monthname(order_date)
order by 2
;
```

<h4>📊 Average Sales Over Time (Monthly)</h4>

```sql
select monthname(order_date)  as month , round(avg(order_amount),2)  as monthly_revenue
from company.customer_orders
group by monthname(order_date)
order by 2;

```

<hr /> <h3>📌 Monthly and Status Insights</h3> <h4>💵 Monthly Revenue Based on Order Status</h4>

```sql
select monthname(order_date)  as month , round(avg(order_amount),2)  as monthly_revenue , 
	order_status
from company.customer_orders
group by monthname(order_date) , order_status
order by 1,3;
```


<h4>🧾 Monthly Orders Based on Order Status</h4>

```sql
select monthname(order_date)  as month , count(*)  as monthly_revenue , 
	order_status
from company.customer_orders
group by monthname(order_date) , order_status
order by 1,3;

```


<hr /> <h3>💰 Overall Revenue Summary</h3> <h4>🔢 Total Revenue</h4>

```sql
select sum(order_amount) as total_revenue  from customer_orders;

```

<h1> VISUALIZATION TASK <h1/>
 <h2> Customer Retention Analysis:</h2>
<ul>
	<li>Visualize customer retention by showing how many customers from a 
specific cohort made repeat purchases in subsequent months.</li>
	<li>Use a suitable BI visualization tool to present your findings.</li>
	<li> Clearly explain how the visualization tracks customer retention.</li>
</ul>
<h2>📊 Customer Retention Heatmap – Insight</h2>
<p>The customer retention heatmap visualizes how many customers from each cohort (grouped by their first purchase month) return and make repeat purchases in the following months.</p>

<p>Each row represents a cohort (e.g., customers who joined in January), and each column represents the number of months since their first purchase (Month 0, 1, 2, etc.). The cell values show how many customers from the cohort returned in that month, with color intensity indicating retention strength — darker cells reflect higher retention.</p>

<h2>📊 Month 1 Retention Heatmap Analysis</h2>
<p>
	
In the Month 1 row of the customer retention heatmap, we observe how many customers from each monthly cohort returned in the month following their first purchase.
</p>
<ul>
<li>
	
July shows the highest Month 1 retention, with 22 returning customers, suggesting strong engagement or follow-up strategy during that period.
</li>	

<li>
	
March has the lowest return rate (5), indicating a potential churn issue or seasonal factor that needs further investigation.
</li>


<li>
	
Overall, retention fluctuates across the year, with moderate returns in most months (14–20), and noticeable drops in February (11) and November (9).
</li>
</ul>

<h2>📊 Month 2 Customer Retention Analysis</h2>

<p>
	
Month 2 heatmap values show how many users returned two months after their initial purchase, providing valuable insight into long-term customer engagement:
</p>
<ul>
<li>
	
The February cohort had the highest retention (21), signaling effective re-engagement.
</li>

<li>
	
The September cohort showed the lowest retention (8), highlighting potential drop-off points.
</li>
<li>
	
April to June cohorts demonstrated healthy repeat behavior with 16–19 users returning, which might reflect successful onboarding or post-purchase strategies during that time.
</li>

</ul>

