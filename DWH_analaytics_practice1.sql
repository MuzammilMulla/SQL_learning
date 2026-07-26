--find the youngest and oldest customers in the dim_customers table

select min(birthdate) as oldest_cust ,
max(birthdate) as youngest_cust,
getdate() as todays_date,
datediff(year, min(birthdate), getdate()) as oldest_cust_age,
datediff(year, max(birthdate), getdate()) as youngest_cust_age
from [gold].[dim_customers]




select max(birthdate) as youngest_cust from [gold].[dim_customers]

--oldest age of customer in years
select datediff(year, min(birthdate), getdate()) as oldest_cust_age from [gold].[dim_customers]
--youngest age of customer in years
select datediff(year, max(birthdate), getdate()) as oldest_cust_age from [gold].[dim_customers]



--find the total sales
select sum([sales_amount]) from [gold].[fact_sales]

--find how many items are sold  per product_key
select product_key, count([quantity]) as quantity_sold
from [gold].[fact_sales]
group by product_key
order by count([quantity]) desc

--find the average selling price per product_key
select product_key, avg(price) as avg_price
from [gold].[fact_sales]
group by product_key
order by avg(price)  desc

--find the total no. of orders
select count(distinct(order_number)) as total_no_orders 
from [gold].[fact_sales]

----find the total no. of products
select count(distinct(product_id)) as total_no_products
from [gold].[dim_products]


----find the total no. of customers
select count([customer_id]) as total_no_cust
from [gold].[dim_customers]


--find the total no of customers that has placed an order

select count(distinct(customer_id)) as 'customers that has placed order'
from [gold].[dim_customers] as dc
 join [gold].[fact_sales] as fs
on dc.[customer_key] = fs.[customer_key]




