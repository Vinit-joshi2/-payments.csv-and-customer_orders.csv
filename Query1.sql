--  Order and Sales Analysis:

 -- Analyze order status and sales data to provide insights into order 
-- fulfillment and revenue trends. Identify key metrics and trends related to 
-- order status and sales.



-- Count of orders by order_status
SELECT order_status , count(*) as Total_No_of_orders  FROM company.customer_orders
group by  order_status
;



--  Total order amount by order_status
SELECT order_status , round(sum(order_amount),2) as Total_Order_Amount FROM company.customer_orders
group by  order_status
;

-- Avg order amount by order_status
SELECT order_status , round(avg(order_amount),2) as Total_Order_Amount FROM company.customer_orders
group by  order_status
;




-- Total  Nuber of orders per month

select monthname(order_date)  as month , count(*) as Number_of_order
from company.customer_orders
group by monthname(order_date)
order by monthname(order_date);



-- Total Sales over time(Month)
use company;
select monthname(order_date)  as month , round(sum(order_amount),2) 
from company.customer_orders
group by monthname(order_date)
order by 2
;

-- Average sales over time(month)

select monthname(order_date)  as month , round(avg(order_amount),2)  as monthly_revenue
from company.customer_orders
group by monthname(order_date)
order by 2;


-- monthly revenue on the basis on order_status
select monthname(order_date)  as month , round(avg(order_amount),2)  as monthly_revenue , 
	order_status
from company.customer_orders
group by monthname(order_date) , order_status
order by 1,3;


-- Monthly orders by order_status
select monthname(order_date)  as month , count(*)  as monthly_revenue , 
	order_status
from company.customer_orders
group by monthname(order_date) , order_status
order by 1,3;





-- Total revenue
select sum(order_amount) as total_revenue  from customer_orders;




