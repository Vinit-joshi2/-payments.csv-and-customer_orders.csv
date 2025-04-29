-- Payment Status Analysis:
-- Investigate payment status data to identify any potential issues or trends 
-- related to payment success and failure.


-- How many payments successed or failed
select payment_status , count(*) as total_payments from payments
group by payment_status;


-- How many percentage of payments successed or failed
select payment_status , round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments from payments
group by payment_status;

-- Payment Amount by sales
select payment_status , sum(payment_amount) as total_payments from payments
group by payment_status;


-- Trck sucess or failue rates monthly

SELECT 
	monthname(payment_date) as month,
    payment_status,
    count(*) as total_transaction,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments,
    sum(payment_amount) as total_amount

FROM company.payments
group by monthname(payment_date) , payment_status
order by 1;




-- Hom many payments done by differnt differnt paymnet platform by paymnet_status
select 
	payment_method,
    payment_status,
    count(*) as total_transaction,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments
from payments
group by payment_method,
			payment_status
order by 1;



-- Total revenue by payment method

select payment_method,
		sum(payment_amount) as total_revenue,
        payment_status
from payments
where payment_status = 'completed'
group by payment_method , payment_status;

-- Percent method Failure rate 

select 
	payment_method ,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments_failure,
    payment_status
    
from payments
where payment_status = 'failed'
group by payment_method , payment_status


;
-- Percent method Completed rate 

select 
	payment_method ,
    round(count(*) / (select count(*) from payments)*100,2) as total_percent_payments_failure,
    payment_status
    
from payments
where payment_status = 'completed'
group by payment_method , payment_status


