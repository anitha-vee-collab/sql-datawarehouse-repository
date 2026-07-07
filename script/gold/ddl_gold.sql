
CREATE VIEW gold.dim_customers AS 
  	SELECT
  	ROW_NUMBER() OVER(ORDER BY cst_id) AS customer_key,
  	ci.cst_id AS customer_id,
  	ci.cst_key AS customer_number,
  	ci.cst_firstname AS first_name,
  	ci.cst_lastname AS last_name,
  	cl.cntry AS country,
  	ci.cst_marital_status AS cst_marital_status,
  	CASE WHEN ci.cst_gndr != 'Unknown' THEN ci.cst_gndr
  		 ELSE COALESCE(cd.gen,'n/a')
  	END AS gender,
  	cd.bdate AS birth_date,
  	ci.cst_create_date AS create_date
  	FROM silver.crm_cust_info ci
  	LEFT JOIN silver.erp_cust_az12 cd
  	ON ci.cst_key = cd.cid
  	LEFT JOIN silver.erp_loc_a101 cl
  	ON ci.cst_key = cl.cid 


CREATE VIEW gold.dim_products AS
  	SELECT
  	ROW_NUMBER() OVER(ORDER BY p.prd_key,p.prd_start_dt) AS product_key,
  	p.prd_id AS product_id,
  	p.prd_nm AS product_name,
  	p.prd_key AS product_num,
  	p.cat_id AS category_id,
  	pd.cat AS category,
  	pd.subcat AS subcategory,
  	p.prd_line AS product_line,
  	p.prd_cost AS product_cost,
  	pd.maintenance AS maintenance,
  	p.prd_start_dt AS prod_start_date
  	FROM silver.crm_prod_info p
  	LEFT JOIN silver.erp_px_cat_g1v2 pd
  	ON p.cat_id = pd.id
  	WHERE prd_end_dt IS NULL;

CREATE VIEW gold.fact_sales AS
  	SELECT
  	s.sls_ord_num AS order_number,
  	p.product_key,
  	c.customer_key,
  	s.sls_order_dt AS order_date,
  	s.sls_ship_dt AS ship_date,
  	s.sls_due_dt AS due_date,
  	s.sls_sales AS sales_amount,
  	s.sls_quantity AS quantity,
  	s.sls_price AS price
  	FROM silver.crm_sales_details s
  	LEFT JOIN gold.dim_customers c
  	ON s.sls_cust_id = c.customer_id
  	LEFT JOIN gold.dim_products p
  	ON s.sls_prd_key = p.product_num;
