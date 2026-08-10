--CTE & Multiple CTEs

with CustomerSales AS (
	SELECT 
		c.customer_key,
		c.first_name,
		c.last_name,
		SUM(f.sales_amount) AS total_sales
	FROM 
		gold.dim_customers c
	JOIN 
		gold.fact_sales f ON c.customer_key = f.customer_key
	GROUP BY 
		c.customer_key, c.first_name, c.last_name
),CustomerRank AS
 (
	SELECT 
		customer_key,
		first_name,
		last_name,
		total_sales,
		RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
	FROM 
		CustomerSales
),
--last order date of customer
LastOrderDate AS(
	Select MAX(order_date) as last_order_date ,customer_key  from [gold].[fact_sales]
	Group by customer_key


)

--Main Query
select 
	cs.customer_key,
	cs.first_name,
	cs.last_name,
	cs.total_sales,
	cr.sales_rank,
	lod.last_order_date
	From CustomerSales as cs
	JOIN CustomerRank  as cr ON cs.customer_key = cr.customer_key
	JOIN LastOrderDate as lod ON cs.customer_key = lod.customer_key
	--WHERE sales_rank <= 10

