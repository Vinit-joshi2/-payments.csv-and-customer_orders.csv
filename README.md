# -payments-and-customer_orders.

<h1>📦 Order and Sales Analysis</h1>


<hr/>

<h2>📊 SQL Analysis</h2>

<h1> Order Sales Analysis</h1>

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


<h3>📌 Monthly and Status Insights</h3> <h4>💵 Monthly Revenue Based on Order Status</h4>

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


 <h3>💰 Overall Revenue Summary</h3> <h4>🔢 Total Revenue</h4>

```sql
select sum(order_amount) as total_revenue  from customer_orders;

```



<h1> Customer Analysis</h1>


<h4> Count of Customers Placing More Than One Order</h4>

```sql
select customer_id ,  count(*) as total_order from customer_orders
group by customer_id
having count(*) > 1;
````

<p>This query helps us identify repeat customers who placed more than one order, which is a key indicator of customer retention.</p> 

<h4>Segment customer by order frequency</h4>

```sql
select customer_id , 
	count(*) as total_orders,
    case
		when count(*) = 1 then 'One_time'
        when count(*) between 2 and 4 then 'Occasional'
        else 'Onece_in_time'
        end as customer_segment
from customer_orders
group by customer_id;
```
<p>This analysis classifies customers into segments based on how frequently they place orders</p>


<h4>How many unqiue customer are ordering per month</h4>

```sql
select 
	monthname(order_date) as month , 
    count(distinct customer_id) as unique_customers
 from customer_orders
 group by monthname(order_date)
 order by count(distinct customer_id) desc
;
```
<p>This query reveals how many unique customers placed orders each month, helping us understand customer engagement over time.</p>

<h4> Insight:</h4> <ul> <li> <strong>January</strong> recorded the highest number of unique customers, with approximately <strong>1,359</strong> customers placing orders.</li> <li> In contrast, <strong>November</strong> had the lowest unique customer count, with around <strong>1,073</strong> customers.</li> <li> This variation may indicate seasonal trends, marketing impact, or customer retention dynamics during the year.</li> </ul>


<h4>
	 Total spend per customer
	-- customer_orders --> customer_id , order_id
	-- payments --> payment_id , order_id
</h4>

```sql
select 
	o.customer_id , 
    sum(p.payment_amount) as total_spent,
    case 
		when  sum(p.payment_amount) > 500 then 'High spent'
        when sum(p.payment_amount) between 200 and 400 then  'Medium spent'
        else 'Low spent'
        end as value_segment
        
 from  customer_orders o
join payments p on o.order_id = p.order_id
group by o.customer_id
```
<p>This query joins orders and payments data to calculate how much each customer has spent in total, and segments them based on their spending behavior.</p>



<h1> Payment Sales Analysis</h1>

<p>This section investigates payment success and failure trends using SQL queries. The goal is to understand the effectiveness of payment processing, success rates, failure patterns, and the impact across different payment methods.</p>

<hr />

<h3> Overall Payment Status</h3>

<h4> Total Number of Successful and Failed Payments</h4>

```sql
select payment_status , count(*) as total_payments from payments
group by payment_status;
```

<h4> Insight:</h4> <ul> <li> <strong>Completed:</strong> 4,991 payments were successfully processed.</li> <li> <strong>Failed:</strong> 5,003 transactions failed to complete.</li> <li> <strong>Pending:</strong> 5,006 payments remained in a pending state.</li> </ul> <p>This distribution shows a relatively even spread among all payment statuses. The slightly higher number of failed and pending transactions may indicate technical issues, payment gateway problems, or user-related errors that require further investigation.</p>


<h4>How many percentage of payments successed or failed</h4>

```sql
select payment_status , round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments from payments
group by payment_status;

```
<h4>Payment Amount by sales</h4>

```sql
select payment_status , sum(payment_amount) as total_payments from payments
group by payment_status;
```

<h4>Trck sucess or failue rates monthly</h4>

```sql
SELECT 
	monthname(payment_date) as month,
    payment_status,
    count(*) as total_transaction,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments,
    sum(payment_amount) as total_amount

FROM company.payments
group by monthname(payment_date) , payment_status
order by 1;
```

<h4>Hom many payments done by differnt differnt paymnet platform by paymnet_status</h4>

```sql
select 
	payment_method,
    payment_status,
    count(*) as total_transaction,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments
from payments
group by payment_method,
			payment_status
order by 1;

```

<h4>Total revenue by payment method</h4>

```sql

select payment_method,
		sum(payment_amount) as total_revenue,
        payment_status
from payments
where payment_status = 'completed'
group by payment_method , payment_status;

```

<h4>Percent method Failure rate </h4>

```sql
select 
	payment_method ,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments_failure,
    payment_status
    
from payments
where payment_status = 'failed'
group by payment_method , payment_status
```


<h4>Percent method Completed rate </h4>

```sql
select 
	payment_method ,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments_failure,
    payment_status
    
from payments
where payment_status = 'completed'
group by payment_method , payment_status


```

<h1> Order Details Report</h1>

<p>This report provides a detailed overview of each customer's order and payment information.  
 order metrics, payment status, and purchasing behavior to help uncover high-value customers and their payment preferences.</p>


<hr />



<h3>🧾 Comprehensive Order Details per Customer</h3>

```sql
select 
	o.customer_id,
    count(distinct o.order_id) as total_order,
    sum(o.order_amount) as total_order_value,
    sum(case when p.payment_status = 'completed' then p.payment_amount else 0  end) as total_paid,
    round(avg(o.order_amount),2) as avg_order_value,
    count( distinct p.payment_method) as  payment_method
  from customer_orders o
join payments p on o.order_id = p.order_id
group by o.customer_id
```

<h2>📌 Insights</h2> <ul> <li> Tracks each customer's total number of orders .</li> <li> Differentiates total order value from actual paid amounts by filtering completed payments only.</li> <li> Measures the variety of payment methods used by each customer.</li> <li> Calculates the average order value per customer – useful for identifying high-ticket buyers.</li> </ul>



<hr>



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

