/*
Analyse the yearly performance of products by comparing their sales to 
	a. average sales performance of the product
	b. previous year's 
*/

WITH cte_performance_products AS
(
	select 
		[product_name],
		YEar([order_date]) as order_year, 
		sum([sales_amount]) as total_sales

	From [gold].[dim_products] dp
	Left JOIN [gold].[fact_sales] fs
	on dp.[product_key] = fs.[product_key]

	Where [order_date] is not null

	Group by [product_name], YEar([order_date]) 
)

--Main query

Select 
	[product_name],
	order_year,
	total_sales,


	LAG(total_sales) over(partition by [product_name] order by order_year) as Previous_YEar_Sales,
	total_sales - LAG(total_sales) over(partition by [product_name] order by order_year) as diff_between_prev_year,
	Avg(total_sales) over(partition by [product_name]) as avg_sales,
	total_sales - Avg(total_sales) over(partition by [product_name]) as diff_avg_sales

From cte_performance_products
	order by [product_name], order_year
	
