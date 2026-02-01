#Top 10 customers revenue wise
select 
	c.custId,
    c.companyName,
    sum(od.unitPrice * od.quantity) as total_revenue
from customer c
join salesorder o on c.custId = o.custId
join orderdetail od on o.orderId = od.orderId
group by c.custId, c.companyName
order by total_revenue desc
limit 10;

#Monthly sales trend
select 
	date_format(o.orderDate, '%Y-%m') as month,
    sum(od.unitPrice * od.quantity) as monthly_sales
from salesorder o
join orderdetail od on o.orderId = od.orderId
group by month
order by month;

#Best Selling Products

select
	p.productName,
    sum(od.quantity) as total_quantity_sold
from product p
join orderdetail od on p.productId = od.productId
group by p.productName
order by total_quantity_sold desc
limit 10;

#Repeat Customers

select
	custId,
    count(orderId) as total_orders
from salesorder
group by custId
having total_orders > 1
order by total_orders desc;

#Window Function Top selling products

select 
	productId,
    sum(quantity) as total_sales,
    rank() over ( order by sum(quantity) desc) as sales_rank
from orderdetail
group by productId;

#CTE Avg order value

with revenue_cte as (
select
	o.orderId,
    sum(od.unitPrice * od.quantity) as order_revenue
from salesorder o
join orderdetail od on o.orderId = od.orderId
group by o.orderId
)

select
	avg(order_revenue) as avg_order_value
from revenue_cte;
