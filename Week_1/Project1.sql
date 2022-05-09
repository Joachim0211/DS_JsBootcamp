#Course Section 11:Answer Business questions

USE magist;

#main concerns:

	#Is Magist is a good fit for high-end tech products?

	#Are orders delivered on time?




#In relation to the products:

	#What categories of tech products does Magist have?

/*Standard International Trade Classification (SITC — Rev. 4): 
	Aerospace
    computers and office machines
    electronics-telecommunications
    pharmacy
    scientific instruments
    electrical machinery
    chemistry
    non-electrical machinery and armament.
*/

SELECT *
FROM product_category_name_translation;

SELECT DISTINCT (product_category_name),
CASE
    WHEN product_category_name LIKE "%tele%" THEN "Tech"
    WHEN product_category_name LIKE "%pc%" THEN "Tech"
    WHEN product_category_name LIKE "%eletron%" THEN "Tech"
    WHEN product_category_name LIKE "%seguros%" THEN "Tech"
    WHEN product_category_name LIKE "%consoles_games%" THEN "Tech"
    WHEN product_category_name LIKE "%informatica%" THEN "Tech"
    WHEN product_category_name LIKE "%tablets%" THEN "Tech"
    WHEN product_category_name LIKE "%utilidades_domesticas%" THEN "Tech"
    END Tech
,product_id
FROM products
HAVING Tech = "Tech"
ORDER BY product_category_name;

##______________________________________________________________________________________________##
	#How many products of these tech categories have been sold (within the time window of the database snapshot)? 


SELECT 
    COUNT(orders.order_id)
FROM
    (SELECT DISTINCT
        (product_category_name),
            CASE
                WHEN product_category_name LIKE '%tele%' THEN 'Tech'
                WHEN product_category_name LIKE '%pc%' THEN 'Tech'
                WHEN product_category_name LIKE '%eletron%' THEN 'Tech'
                WHEN product_category_name LIKE '%seguros%' THEN 'Tech'
                WHEN product_category_name LIKE '%consoles_games%' THEN 'Tech'
                WHEN product_category_name LIKE '%informatica%' THEN 'Tech'
                WHEN product_category_name LIKE '%tablets%' THEN 'Tech'
                WHEN product_category_name LIKE '%utilidades_domesticas%' THEN 'Tech'
            END Tech,
            product_id
    FROM
        products
    HAVING Tech = 'Tech'
    ORDER BY product_category_name) high_tech
        LEFT JOIN
    order_items ON order_items.product_id = high_tech.product_id
        LEFT JOIN
    orders ON orders.order_id = order_items.order_id

;

##______________________________________________________________________________________________##

#What percentage does that represent from the overall number of products sold?

			#####FIRST#####  We have TOTAL TECH products sold = 23801. Now we need to Calculate the TOTAL items SOLD
SELECT 
    COUNT(orders.order_id)
FROM
	products
        LEFT JOIN
    order_items ON order_items.product_id = products.product_id
        LEFT JOIN
    orders ON orders.order_id = order_items.order_id

; 			##### TOTAL = 112650 ########## WE have considered that every ORDER (regardles the status) represents a SOLD product.  For that reason we have SELECT the TOTAL of Products available and join then with ORDERS SOLD! 


			#####SECOND##### Calculate the TECH product %

    SELECT round((23801*100)/112650,0) ; ####____ ANSWER_____### % TECH products Sold = 21%
    
##______________________________________________________________________________________________##

#What’s the average price of the products being sold?

SELECT 
    ROUND (AVG(order_items.price),0)
FROM
    (SELECT DISTINCT
        (product_category_name),
            CASE
                WHEN product_category_name LIKE '%tele%' THEN 'Tech'
                WHEN product_category_name LIKE '%pc%' THEN 'Tech'
                WHEN product_category_name LIKE '%eletron%' THEN 'Tech'
                WHEN product_category_name LIKE '%seguros%' THEN 'Tech'
                WHEN product_category_name LIKE '%consoles_games%' THEN 'Tech'
                WHEN product_category_name LIKE '%informatica%' THEN 'Tech'
                WHEN product_category_name LIKE '%tablets%' THEN 'Tech'
                WHEN product_category_name LIKE '%utilidades_domesticas%' THEN 'Tech'
            END Tech,
            product_id
    FROM
        products
    HAVING Tech = 'Tech'
    ORDER BY product_category_name) high_tech
        LEFT JOIN
    order_items ON order_items.product_id = high_tech.product_id
        LEFT JOIN
    orders ON orders.order_id = order_items.order_id

;					####____ ANSWER_____### % Average PRICE for the TECH products Sold = 104

##______________________________________________________________________________________________##

#Are expensive tech products popular?

SELECT 
    COUNT(order_items.price),
		CASE
		WHEN order_items.price >= 2*104 THEN 'Expensive'
		WHEN order_items.price >= 75 THEN 'Average'
        ELSE 'Cheap'
        END price_def
FROM
    (SELECT DISTINCT
        (product_category_name),
            CASE
                WHEN product_category_name LIKE '%tele%' THEN 'Tech'
                WHEN product_category_name LIKE '%pc%' THEN 'Tech'
                WHEN product_category_name LIKE '%eletron%' THEN 'Tech'
                WHEN product_category_name LIKE '%seguros%' THEN 'Tech'
                WHEN product_category_name LIKE '%consoles_games%' THEN 'Tech'
                WHEN product_category_name LIKE '%informatica%' THEN 'Tech'
                WHEN product_category_name LIKE '%tablets%' THEN 'Tech'
                WHEN product_category_name LIKE '%utilidades_domesticas%' THEN 'Tech'
            END Tech,
            product_id
    FROM
        products
    HAVING Tech = 'Tech'
    ORDER BY product_category_name) high_tech
        LEFT JOIN
    order_items ON order_items.product_id = high_tech.product_id
        LEFT JOIN
    orders ON orders.order_id = order_items.order_id
    GROUP BY price_def
    ;
    
        SELECT round(2123*100/(14472+2123+7206),2) ; ####____ ANSWER_____### % TECH products Sold = 8,92%

##______________________________________________________________________________________________##        
##How many sellers are there?
SELECT COUNT(distinct(seller_id)) AS 'Number of Sellers'
FROM sellers;
####____ ANSWER_____### % TOTAL of Sellers = 3095

##______________________________________________________________________________________________##  

#What’s the average monthly revenue of Magist’s sellers?


			# This next code is to see the SUM of revenue / months / year
SELECT  
	YEAR(orders.order_purchase_timestamp) AS year_,
    MONTH(orders.order_purchase_timestamp) AS month_, 
    COUNT(orders.order_id),
    SUM(order_items.price)
FROM orders
LEFT JOIN  order_items ON orders.order_id = order_items.order_id
GROUP BY year_ , month_
ORDER BY year_ , month_;




SELECT round(AVG(sum_),0)

FROM 

(
SELECT  
	YEAR(orders.order_purchase_timestamp) AS year_,
    MONTH(orders.order_purchase_timestamp) AS month_, 
    COUNT(orders.order_id),
    SUM(order_items.price) AS sum_
FROM orders
LEFT JOIN  order_items ON orders.order_id = order_items.order_id
GROUP BY year_ , month_
ORDER BY year_ , month_
) orders_sum
;

####____ ANSWER_____### % AVERAGE Sales / Month, of Magist Sellers = 566318


##______________________________________________________________________________________________##  
#What’s the average revenue of sellers that sell tech products?


SELECT 
    seller_id,SUM(order_items.price) AS sellers_revenue
FROM
    (SELECT DISTINCT
        (product_category_name),
            CASE
                WHEN product_category_name LIKE '%tele%' THEN 'Tech'
                WHEN product_category_name LIKE '%pc%' THEN 'Tech'
                WHEN product_category_name LIKE '%eletron%' THEN 'Tech'
                WHEN product_category_name LIKE '%seguros%' THEN 'Tech'
                WHEN product_category_name LIKE '%consoles_games%' THEN 'Tech'
                WHEN product_category_name LIKE '%informatica%' THEN 'Tech'
                WHEN product_category_name LIKE '%tablets%' THEN 'Tech'
                WHEN product_category_name LIKE '%utilidades_domesticas%' THEN 'Tech'
            END Tech,
            product_id
    FROM
        products
    HAVING Tech = 'Tech'
    ORDER BY product_category_name) high_tech
        LEFT JOIN
    order_items ON order_items.product_id = high_tech.product_id
    GROUP BY seller_id;




SELECT
ROUND(AVG(sellers_revenue))
FROM
(
SELECT 
    seller_id,SUM(order_items.price) AS sellers_revenue
FROM
    (SELECT DISTINCT
        (product_category_name),
            CASE
                WHEN product_category_name LIKE '%tele%' THEN 'Tech'
                WHEN product_category_name LIKE '%pc%' THEN 'Tech'
                WHEN product_category_name LIKE '%eletron%' THEN 'Tech'
                WHEN product_category_name LIKE '%seguros%' THEN 'Tech'
                WHEN product_category_name LIKE '%consoles_games%' THEN 'Tech'
                WHEN product_category_name LIKE '%informatica%' THEN 'Tech'
                WHEN product_category_name LIKE '%tablets%' THEN 'Tech'
                WHEN product_category_name LIKE '%utilidades_domesticas%' THEN 'Tech'
            END Tech,
            product_id
    FROM
        products
    HAVING Tech = 'Tech'
    ORDER BY product_category_name) high_tech
        LEFT JOIN
    order_items ON order_items.product_id = high_tech.product_id
    GROUP BY seller_id
    )seller_rev
    ;
    
    ####____ ANSWER_____### % AVERAGE revenue for TECH Sellers = 2815
    
    SELECT (2815*100/566318);
    
    ##______________________________________________________________________________________________##  
	##______________________________________________________________________________________________## 
   
   
   /*
    In relation to the delivery time:

What’s the average time between the order being placed and the product being delivered?
How many orders are delivered on time vs orders delivered with a delay?
Is there any pattern for delayed orders, e.g. big products being delayed more often?
    */
    
    
    USE magist;
SELECT Count(*) AS orders_count 
FROM orders;
SELECT * FROM orders;
SELECT order_status, COUNT(*) AS orders
FROM orders
GROUP BY order_status;
SELECT 
	YEAR(order_purchase_timestamp) AS year_,
	Month(order_purchase_timestamp) AS month_,
    COUNT(customer_id)
FROM
	orders
GROUP BY year_, month_
ORDER BY year_, month_;
SELECT DISTINCT COUNT(*) AS products
FROM products;
SELECT Count(DISTINCT product_id) AS products
FROM products;
SELECT product_category_name, count(DISTINCT product_id) AS cat_product_count
FROM products
GROUP BY product_category_name
ORDER BY COUNT(product_id) DESC;
SELECT
count(DISTINCT product_id) AS sold_products
FROM order_items;
SELECT product_id, price
FROM order_items
ORDER BY price DESC;
SELECT 
    MIN(price) AS cheapest, 
    MAX(price) AS most_expensive
FROM 
	order_items;
    SELECT 
    MIN(payment_value) AS highest, 
    MAX(payment_value) AS lowest
FROM 
	order_payments;


SELECT *
FROM
(
SELECT DISTINCT product_category_name, product_id, count(product_id),
CASE
    WHEN product_category_name LIKE "%auto%" THEN "Tech"
    WHEN product_category_name LIKE "%tele%" THEN "Tech"
    WHEN product_category_name LIKE "%pc%" THEN "Tech"
    WHEN product_category_name LIKE "%eletron%" THEN "Tech"
    WHEN product_category_name LIKE "%inform%" THEN "Tech"
    WHEN product_category_name LIKE "%audio%" THEN "Tech"
    WHEN product_category_name LIKE "%consoles_games%" THEN "Tech"
    WHEN product_category_name LIKE "dvds%" THEN "Tech"
    WHEN product_category_name LIKE "%informatica%" THEN "Tech"
    WHEN product_category_name LIKE "%tablets%" THEN "Tech"
    END Tech
FROM products
GROUP BY product_category_name
HAVING Tech = "Tech"
ORDER BY product_category_name) Tech_table
LEFT JOIN
order_items ON order_items.product_id = Tech_table.product_id
GROUP BY product_category_name;


SELECT *
FROM product_category_name_translation;
# here starts the query for the last block of questions

SELECT *
FROM orders;

# question: Whats the average time between the order being placed and the product being delivered

## takes from orders the two according timestamps, calculates the difference with the method datediff -> this is averaged -> and round with 0 digits after the decimal
## note that datediff seems to take the starting date as second argument!
SELECT round(avg(datediff(order_delivered_customer_date, order_purchase_timestamp)), 0) AS avaerage_days_to_deliver
	FROM orders
	WHERE order_status = 'delivered';
    

    
SELECT DISTINCT order_status
FROM orders;
#WHERE order_status = 'shipped';

### the average number of days to deliver for the company is 13!
# How many orders are delivered on time vs orders delivered with a delay?
## This block first calculates the datediff from the according timestamps in orders as 'del' when the delivery actually occurred (otherwise Null)
## Then the cases were the datediff is positive or 0 are counted using sum() and CASE (something like if/else, if true = 1 else 0) as onTime or when below 0 -> offTime.  
SELECT SUM(CASE
  WHEN del >= 0 THEN 1
  ELSE 0
  END) AS onTime,
  SUM(CASE
  WHEN del < 0 THEN 1
  ELSE 0
  END) AS offTime
FROM
(
SELECT datediff(order_estimated_delivery_date, order_delivered_customer_date) AS del 	
	FROM orders
	WHERE order_status = 'delivered'
    ) del;
    
Select count(*)
From orders
Where order_status = 'delivered';

    
    ## calculate the % of offTime deliveries
    SELECT (6665*100/(89805+6665));
    SELECT (89805+6665);
    
    ### There were 89805 deliveries on Time, 6665 were offTime what is 6.9%.
    
    # Is there any pattern for delayed orders, f.e. big products being delayed more often?
    #Size and weight?
SELECT count(del)
FROM
(
SELECT product_id, del
FROM
(
SELECT order_id, datediff(order_estimated_delivery_date, order_delivered_customer_date) AS del 	
	FROM orders
	WHERE order_status = 'delivered'
    ) deli
LEFT JOIN order_items ON order_items.order_id = deli.order_id
WHERE del > 0
) deliv
LEFT JOIN products ON products.product_id = deliv.product_id
WHERE (product_length_cm*product_height_cm*product_width_cm) > 16564;

#2175 offTime deliveries were above the average weight of all products, these are about 32% of the offTime deliv

# 1100 offTime deliveries were above two-times the average weight of all products, these are about 17% of the offTime deliv 
# 1737 offTime deliveries were above the average weight of all products, these are about 26% of the offTime deliv

# 12988 onTime deliveries were above two-times the average weight of all products, these are about 14% of the offTime deliv, thus no big difference to the late deliveries
# 20964 onTime deliveries were above the average weight of all products, these are about 23% of the offTime deliv, again no big diff to late deliveries

#City
SELECT city, del 
FROM
(
	SELECT customer_zip_code_prefix, del
	FROM
	(
		SELECT customer_id, datediff(order_estimated_delivery_date, order_delivered_customer_date) AS del 	
		FROM orders
		WHERE order_status = 'delivered'
    ) deli
	LEFT JOIN customers ON customers.customer_id = deli.customer_id
	WHERE del < 0
) deliv
LEFT JOIN geo ON geo.zip_code_prefix = deliv.customer_zip_code_prefix;
#WHERE (product_length_cm*product_height_cm*product_width_cm) > 16564;



SELECT avg(product_weight_g) AS aWeight
FROM products;

SELECT avg(product_length_cm*product_height_cm*product_width_cm) AS aSize
FROM products;

#average weight is 2276g

SELECT (2175*100/(6665));
SELECT (20964*100/(89805));
    