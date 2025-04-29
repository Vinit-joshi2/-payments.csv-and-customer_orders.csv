-- Customer Analysis:

-- Explore customer ordering behavior to identify patterns such as repeat 
-- ordering, customer segmentation, and trends over time

use company;

select * from customer_orders;

-- Hom many customer placed more than one order (Repeat customer)as

select customer_id ,  count(*) as total_order from customer_orders
group by customer_id
having count(*) > 1;

-- Segment customer by order frequency

select customer_id , 
	count(*) as total_orders,
    case
		when count(*) = 1 then 'One_time'
        when count(*) between 2 and 4 then 'Occasional'
        else 'Onece_in_time'
        end as customer_segment
from customer_orders
group by customer_id;



-- How many unqiue customer are ordering per month

select 
	monthname(order_date) as month , 
    count(distinct customer_id) as unique_customers
 from customer_orders
 group by monthname(order_date)
;


-- Total spend per customer
-- customer_orders --> customer_id , order_id
-- payments --> payment_id , order_id

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




