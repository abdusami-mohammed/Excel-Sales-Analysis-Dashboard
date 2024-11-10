CREATE TABLE Pizza_orders
(
	"pizza_id" INT PRIMARY KEY,
	order_id INT,
	pizza_name_id VARCHAR(100),
	quantity INT,
	order_date DATE,
	order_time TIME,
	unit_price float4,
	total_price FLOAT4,
	pizza_size VARCHAR(5),
	pizza_category VARCHAR(50),
	pizza_ingredients VARCHAR(200),
	pizza_name VARCHAR (50)
);

SELECT * FROM pizza_orders
LIMIT 10

SELECT SUM(total_price) AS "Total_Revenue" FROM pizza_order;

SELECT ROUND(CAST(SUM(total_price)/COUNT(DISTINCT order_id) AS NUMERIC),2) AS "AOV" FROM pizza_orders;

SELECT SUM(quantity) AS "Total_Pizzas_Sold" FROM pizza_orders;

SELECT COUNT(DISTINCT order_id) AS "Total_Orders" FROM pizza_orders;

SELECT ROUND(CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / COUNT(DISTINCT order_id) AS NUMERIC), 2) AS "APpO" FROM pizza_orders;


--DAILY TREND
SELECT TO_CHAR(order_date, 'Day') AS order_day, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_orders
GROUP BY 1

--HOURLY TREND
SELECT TO_CHAR(order_time, 'HH24') AS order_Hour, COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_orders
GROUP BY 1
ORDER BY 1

--Percentage of Sales by Pizza Category
SELECT pizza_category, ROUND(CAST(SUM(total_price) * 100 / (SELECT SUM(total_price)FROM pizza_orders) AS NUMERIC),2) AS PCT,
	SUM(total_price) AS Total_sales
FROM pizza_orders
GROUP BY 1

--Percentage of Sales by Pizza Size
SELECT pizza_size, ROUND(CAST(SUM(total_price) * 100 / (SELECT SUM(total_price)FROM pizza_orders) AS NUMERIC),2) AS PCT,
	SUM(total_price) AS Total_sales
FROM pizza_orders
GROUP BY 1

--Top 5 Best Seller Pizzas
SELECT pizza_name, ROUND(SUM(total_price)) AS Total_sales
FROM pizza_orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Bottom 5 Worst Seller Pizzas
SELECT pizza_name, ROUND(SUM(total_price)) AS Total_sales
FROM pizza_orders
GROUP BY 1
ORDER BY 2
LIMIT 5