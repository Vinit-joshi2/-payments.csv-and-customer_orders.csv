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
<h4>
	
Results:
</h4>

- Pending: 5,069

- Delivered: 5,057

- Shipped: 4,874

<h4>
	
 Insight:
</h4>

- The number of pending orders (5,069) slightly exceeds delivered orders (5,057), suggesting a minor processing backlog.

- Shipped orders (4,874) are the lowest, indicating many orders are still awaiting shipment or delivery.

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

<h4>
	
Results:
</h4>

- Pending: 252.20

- Delivered: 254.03

- Shipped: 255.62
<h4>
	
 Insight:
</h4>

- The average order amount is quite similar across all status, with shipped orders having the highest average value at 255.62.

- Pending orders have a slightly lower average order amount at 252.20, which may indicate that orders in the "pending" status are often smaller in size or are more recent.


<hr/> <h3>📅 Monthly Trends</h3> <h4>🗓️ Total Number of Orders Per Month</h4>

```sql
select monthname(order_date)  as month , count(*) as Number_of_order
from company.customer_orders
group by monthname(order_date)
order by monthname(order_date);
```

<h4>
	
Results:
</h4>

- April: 1,334

- August: 1,199

December: 1,149

- February: 1,331

- January: 1,469

- July: 1,215

- June: 1,181

- March: 1,407

- May: 1,209

- November: 1,164

- October: 1,193

- September: 1,149

<h4>
	
 Insight:
</h4>

- January saw the highest order volume (1,469 orders), indicating strong demand at the start of the year.

- December and September recorded the lowest order counts (1,149 each), suggesting seasonal slowdowns 

- Months like March (1,407) and April (1,334) also performed well, while mid-year months like June (1,181) and August (1,199) were comparatively quieter.



<h4>📈 Total Sales Over Time (Monthly)</h4>

```sql
use company;
select monthname(order_date)  as month , round(sum(order_amount),2) 
from company.customer_orders
group by monthname(order_date)
order by 2
;
```

<h4>
	
Monthly Revenue :
</h4>


- December: 290,955.89

- September: 294,622.98

- November: 296,068.76

- October: 298,741.37

- July: 302,465.68

- June: 303,485.24

- May: 305,350.52

- August: 307,292.11

- February: 339,657.57

- April: 341,095.06

- March: 360,870.01

- January: 368,294.00

<h4>
	
 Insights:
</h4>


- January had the highest revenue with 368,294, showing strong customer spending at the beginning of the year.

- March and April also performed well, maintaining consistent revenue trends.

- The lowest revenue was recorded in December (290,955.89), potentially indicating reduced year-end activity 

- Mid-year months like June, July, and August had steady but moderate contributions to overall revenue.


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

<h4>
	
Highest Average Order Value:
</h4>

- February (Pending): 269.17 — Possibly due to high-value orders awaiting processing.

- December (Delivered): 265.08 — Strong end-of-year fulfillment performance.

- November (Shipped): 264.55 — Indicates good order processing ahead of delivery.

<h4>
	
Consistent Ranges:
</h4>


- Most months have average order values between 240–260, suggesting pricing consistency.

- Pending orders tend to have slightly higher average values in months like June, February, and November

<h4>
	
Lowest Average Order Value:
</h4>


- February (Delivered): 237.13

- October (Pending): 239.07




<h4>🧾 Monthly Orders Based on Order Status</h4>

```sql
select monthname(order_date)  as month , count(*)  as monthly_revenue , 
	order_status
from company.customer_orders
group by monthname(order_date) , order_status
order by 1,3;

```



<h4>
	
Key Insights:
</h4>

<h5>
	
 January recorded the highest order volume overall, with:
</h5>


- 516 Delivered

- 468 Pending

- 485 Shipped

<h5>
	
 November and September had comparatively lower activity:
</h5>

- November: 423 Delivered, 373 Pending, 368 Shipped

- September: 399 Delivered, 364 Pending, 386 Shipped

<h5>
	
 Shipped vs Delivered Trends:
</h5>

- In most months, the number of Shipped orders closely follows Delivered, indicating a smooth transition in the order

- Example: April – 437 Delivered vs. 444 Shipped

<h5>
	
 Pending Order Peaks:
</h5>


- February had the highest Pending orders (488), suggesting either delays or seasonal spikes in order placement


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

<h4> Insight:</h4> <ul> <li> <strong>Completed:</strong> 4,991 payments (<strong>33.27%</strong>) were successfully processed.</li> <li> <strong>Failed:</strong> 5,003 transactions (<strong>33.35%</strong>) failed.</li> <li> <strong>Pending:</strong> 5,006 payments (<strong>33.37%</strong>) are still awaiting completion.</li> </ul> <p>This balanced distribution highlights that only about one-third of the total payments are successfully processed, with a similarly high rate of failures and pending transactions. This could be a potential red flag for the business, suggesting the need for improvement in the payment processing system.</p>

<h4>Payment Amount by sales</h4>

```sql
select payment_status , sum(payment_amount) as total_payments from payments
group by payment_status;
```
<h4> Insight:</h4> <ul> <li> <strong>Completed:</strong> 1,257,085.15 worth of payments were successfully processed.</li> <li> <strong>Failed:</strong> Transactions worth 1,273,618.69 failed to go through.</li> <li> <strong>Pending:</strong> 1,273,403.02 is still pending and yet to be confirmed.</li> </ul> <p>The high volume of failed and pending payments, the amount associated with completed transactions is slightly lower, indicating a significant portion of revenue is currently either lost or delayed. This insight is crucial for identifying revenue leakage and improving transaction success rates.</p>



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

<h4>
	
Key Insights:
</h4>

 <h5>
	 
Highest Transactions (March & January):
 </h5>

<ul>
<li>
	
 March had the highest total number of completed payments (500) with a total value of 125,965.84, followed by January (487) worth 120,101.16.
</li>

<li>
	
These months also had a significant number of failed and pending payments, indicating high transactional activity overall.
</li>

</ul>	

<h5>
	
Lowest Completed Revenue:
</h5>

<ul>

 <li>
	 
 November saw the lowest revenue from completed payments at just 89,252.88, suggesting decreased successful payment activity that month.
 </li>
</ul>

<h5>
	
Balanced Payment Distribution:
</h5>

<ul>
<li>
	
	
Each month had a fairly even split between completed, failed, and pending payments, each hovering around 2.5% to 3.3% of the total transaction volume.
</li>
</ul>

<h5>
	
Revenue Risks:
</h5>

<ul>

 <li>
	 
 In many months, the sum of failed and pending payments is either equal to or exceeds that of completed ones, highlighting a risk of revenue leakage or delayed cash flow.
 </li>

</ul>









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

<h4>
	
 Key Insights:
</h4>

 **Bank Transfer:**
- Completed: 1,635 transactions (10.90%)
- Failed: 1,758 transactions (11.72%)
- Pending: 1,712 transactions (11.41%)
-  Slightly higher failure and pending rates than completions indicate potential reliability issues.

 **Credit Card:**
- Completed: 1,663 transactions (11.09%)
- Failed: 1,666 transactions (11.11%)
- Pending: 1,647 transactions (10.98%)
-  Very balanced distribution across all statuses, but no clear advantage in performance.

 **PayPal:**
- Completed: 1,693 transactions (11.29%)
- Failed: 1,579 transactions (10.53%)
- Pending: 1,647 transactions (10.98%)
-  Slightly better success rate compared to the other methods, with fewer failures.





<h4>Total revenue by payment method</h4>

```sql

select payment_method,
		sum(payment_amount) as total_revenue,
        payment_status
from payments
where payment_status = 'completed'
group by payment_method , payment_status;

```

<h4>
	
Total Revenue by Payment Method (Completed Payments Only)
</h4>

- PayPal: 426,002.70

- Credit Card: 416,296.23

- Bank Transfer: 414,786.22

<h4>
	
 Insight:

</h4>

- PayPal generated the highest completed payment revenue, suggesting it is the most effective method for successful transactions.

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


<h4>
	
Payment Failure Rates by Payment Method
</h4>

- PayPal: 10.53% failed

- Bank Transfer: 11.72% failed

- Credit Card: 11.11% failed

<h4>
	
 Insight:
</h4>

- Bank Transfer has the highest failure rate among all payment methods

- PayPal has the lowest failure rate, indicating a relatively more stable payment process compared to others.


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
<h4>
	
Payment Completion Rates by Payment Method
</h4>
- PayPal: 11.29% completed

- Credit Card: 11.09% completed

- Bank Transfer: 10.90% completed

<h4>
	
 Insight:
</h4>

- PayPal leads in the completion rate, making it the most reliable payment method.

- Credit Card and Bank Transfer have very close completion rates, with PayPal slightly outperforming them.


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
	
The February cohort had the highest retention (21)
</li>

<li>
	
The September cohort showed the lowest retention (8), highlighting potential drop-off points.
</li>
<li>
	
April to June cohorts demonstrated healthy repeat behavior with 16–19 users returning
</li>

</ul>

