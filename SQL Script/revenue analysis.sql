-- fact_orders

CREATE VIEW fact_orders AS
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date
FROM orders o
WHERE o.order_purchase_timestamp < '2018-08-01';
select* from fact_orders;

-- fact_order_items
CREATE VIEW fact_order_items AS
SELECT
    oi.order_id,
    oi.product_id,
    oi.seller_id,
    oi.price,
    oi.freight_value,
    oi.order_item_id
FROM order_items oi
JOIN fact_orders fo 
    ON oi.order_id = fo.order_id;
  
  -- dim_customers
    CREATE VIEW dim_customers AS
SELECT
    customer_id,
    customer_unique_id,
    customer_city,
    customer_state
FROM customers;


-- fact payments
CREATE VIEW fact_payments AS
SELECT
    p.order_id,
    p.payment_type,
    p.payment_installments,
    p.payment_value
FROM payments p
JOIN fact_orders fo
    ON p.order_id = fo.order_id;
  
  -- fact reviews
    CREATE VIEW fact_reviews AS
SELECT
    r.review_id,
    r.order_id,
    r.review_score,
    r.review_creation_date
FROM reviews r
JOIN fact_orders fo
    ON r.order_id = fo.order_id;
 
 -- dim_date
    CREATE VIEW dim_date AS
SELECT DISTINCT
    DATE(order_purchase_timestamp) AS date,
    EXTRACT(YEAR FROM order_purchase_timestamp) AS year,
    EXTRACT(MONTH FROM order_purchase_timestamp) AS month,
    EXTRACT(DAY FROM order_purchase_timestamp) AS day
FROM fact_orders;


-- dim_products
CREATE VIEW dim_products AS
SELECT
    p.product_id,
    p.product_category_name,
    ct.product_category_name_english
FROM products p
LEFT JOIN category_translation ct
    ON p.product_category_name = ct.product_category_name;
  
  -- dim_sellers
    CREATE VIEW dim_sellers AS
SELECT
    seller_id,
    seller_city,
    seller_state
FROM sellers;

-- dim_geo
CREATE VIEW dim_geo AS
SELECT
    geolocation_zip_code_prefix,
    geolocation_city,
    geolocation_state
FROM geo;


      
      




