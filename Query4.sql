-- Order Details Report:
-- Create a comprehensive report that provides a detailed overview of order 
-- information, payment details, and key metrics


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