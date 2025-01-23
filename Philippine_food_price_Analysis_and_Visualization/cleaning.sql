SELECT COUNT(*) 
FROM portfolio_projects.global_food_prices;

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'global_food_prices'
AND TABLE_SCHEMA = 'portfolio_projects'; 

SHOW FIELDS 
FROM global_food_prices;

SELECT *
FROM global_food_prices
LIMIT 5;

/*
The following queries counts the number of nulls and empty strings in the table
*/

SELECT 
	SUM(CASE WHEN adm0_id IS NULL THEN 1 ELSE 0 END) AS adm0_id_nulls,
    SUM(CASE WHEN adm0_name IS NULL THEN 1 ELSE 0 END) AS adm0_name_nulls,
    SUM(CASE WHEN adm1_id IS NULL THEN 1 ELSE 0 END) AS adm1_id_nulls,
    SUM(CASE WHEN adm1_name IS NULL THEN 1 ELSE 0 END) AS adm1_name_nulls,
    SUM(CASE WHEN mkt_id IS NULL THEN 1 ELSE 0 END) AS mkt_id_nulls,
    SUM(CASE WHEN mkt_name IS NULL THEN 1 ELSE 0 END) AS mkt_name_nulls,
    SUM(CASE WHEN cm_id IS NULL THEN 1 ELSE 0 END) AS cm_id_nulls,
    SUM(CASE WHEN cm_name IS NULL THEN 1 ELSE 0 END) AS cm_name_nulls,
    SUM(CASE WHEN cur_id IS NULL THEN 1 ELSE 0 END) AS cur_id_nulls,
    SUM(CASE WHEN cur_name IS NULL THEN 1 ELSE 0 END) AS cur_name_nulls,
    SUM(CASE WHEN pt_id IS NULL THEN 1 ELSE 0 END) AS pt_id_nulls,
    SUM(CASE WHEN pt_name IS NULL THEN 1 ELSE 0 END) AS pt_name_nulls,
    SUM(CASE WHEN um_id IS NULL THEN 1 ELSE 0 END) AS um_id_nulls,
    SUM(CASE WHEN um_name IS NULL THEN 1 ELSE 0 END) AS um_name_nulls,
    SUM(CASE WHEN mp_month IS NULL THEN 1 ELSE 0 END) AS mp_month_nulls,
    SUM(CASE WHEN mp_year IS NULL THEN 1 ELSE 0 END) AS mp_year_nulls,
    SUM(CASE WHEN mp_price IS NULL THEN 1 ELSE 0 END) AS mp_price_nulls,
    SUM(CASE WHEN mp_commoditysource IS NULL THEN 1 ELSE 0 END) AS mp_commoditysource_nulls
FROM global_food_prices;

SELECT 
	SUM(CASE WHEN adm0_id = '' IS NULL THEN 1 ELSE 0 END) AS adm0_id_nulls,
    SUM(CASE WHEN adm0_name = '' IS NULL THEN 1 ELSE 0 END) AS adm0_name_nulls,
    SUM(CASE WHEN adm1_id = '' IS NULL THEN 1 ELSE 0 END) AS adm1_id_nulls,
    SUM(CASE WHEN adm1_name = '' IS NULL THEN 1 ELSE 0 END) AS adm1_name_nulls,
    SUM(CASE WHEN mkt_id = '' IS NULL THEN 1 ELSE 0 END) AS mkt_id_nulls,
    SUM(CASE WHEN mkt_name = '' IS NULL THEN 1 ELSE 0 END) AS mkt_name_nulls,
    SUM(CASE WHEN cm_id = '' IS NULL THEN 1 ELSE 0 END) AS cm_id_nulls,
    SUM(CASE WHEN cm_name = '' IS NULL THEN 1 ELSE 0 END) AS cm_name_nulls,
    SUM(CASE WHEN cur_id = '' IS NULL THEN 1 ELSE 0 END) AS cur_id_nulls,
    SUM(CASE WHEN cur_name = '' IS NULL THEN 1 ELSE 0 END) AS cur_name_nulls,
    SUM(CASE WHEN pt_id = '' IS NULL THEN 1 ELSE 0 END) AS pt_id_nulls,
    SUM(CASE WHEN pt_name = '' IS NULL THEN 1 ELSE 0 END) AS pt_name_nulls,
    SUM(CASE WHEN um_id = '' IS NULL THEN 1 ELSE 0 END) AS um_id_nulls,
    SUM(CASE WHEN um_name = '' IS NULL THEN 1 ELSE 0 END) AS um_name_nulls,
    SUM(CASE WHEN mp_month = '' IS NULL THEN 1 ELSE 0 END) AS mp_month_nulls,
    SUM(CASE WHEN mp_year = '' IS NULL THEN 1 ELSE 0 END) AS mp_year_nulls,
    SUM(CASE WHEN mp_price = '' IS NULL THEN 1 ELSE 0 END) AS mp_price_nulls,
    SUM(CASE WHEN mp_commoditysource = '' IS NULL THEN 1 ELSE 0 END) AS mp_commoditysource_nulls
FROM global_food_prices;

SELECT 
	SUM(CASE WHEN adm0_id = 0 IS NULL THEN 1 ELSE 0 END) AS adm0_id_nulls,
    SUM(CASE WHEN adm0_name = 0 IS NULL THEN 1 ELSE 0 END) AS adm0_name_nulls,
    SUM(CASE WHEN adm1_id = 0 IS NULL THEN 1 ELSE 0 END) AS adm1_id_nulls,
    SUM(CASE WHEN adm1_name = 0 IS NULL THEN 1 ELSE 0 END) AS adm1_name_nulls,
    SUM(CASE WHEN mkt_id = 0 IS NULL THEN 1 ELSE 0 END) AS mkt_id_nulls,
    SUM(CASE WHEN mkt_name = 0 IS NULL THEN 1 ELSE 0 END) AS mkt_name_nulls,
    SUM(CASE WHEN cm_id = 0 IS NULL THEN 1 ELSE 0 END) AS cm_id_nulls,
    SUM(CASE WHEN cm_name = 0 IS NULL THEN 1 ELSE 0 END) AS cm_name_nulls,
    SUM(CASE WHEN cur_id = 0 IS NULL THEN 1 ELSE 0 END) AS cur_id_nulls,
    SUM(CASE WHEN cur_name = 0 IS NULL THEN 1 ELSE 0 END) AS cur_name_nulls,
    SUM(CASE WHEN pt_id = 0 IS NULL THEN 1 ELSE 0 END) AS pt_id_nulls,
    SUM(CASE WHEN pt_name = 0 IS NULL THEN 1 ELSE 0 END) AS pt_name_nulls,
    SUM(CASE WHEN um_id = 0 IS NULL THEN 1 ELSE 0 END) AS um_id_nulls,
    SUM(CASE WHEN um_name = 0 IS NULL THEN 1 ELSE 0 END) AS um_name_nulls,
    SUM(CASE WHEN mp_month = 0 IS NULL THEN 1 ELSE 0 END) AS mp_month_nulls,
    SUM(CASE WHEN mp_year = 0 IS NULL THEN 1 ELSE 0 END) AS mp_year_nulls,
    SUM(CASE WHEN mp_price = 0 IS NULL THEN 1 ELSE 0 END) AS mp_price_nulls,
    SUM(CASE WHEN mp_commoditysource = 0 IS NULL THEN 1 ELSE 0 END) AS mp_commoditysource_nulls
FROM global_food_prices;

SELECT 
    COUNT(DISTINCT adm0_name) AS adm0_name_counts,
    COUNT(DISTINCT adm1_name) AS adm1_name_counts,
    COUNT(DISTINCT mkt_name) AS mkt_name_counts,
    COUNT(DISTINCT cm_name) AS cm_name_counts,
    COUNT(DISTINCT cur_name) AS cur_name_counts,
    COUNT(DISTINCT pt_name) AS pt_name_counts,
    COUNT(DISTINCT um_name) AS um_name_counts,
    COUNT(DISTINCT mp_month) AS mp_month_counts,
    COUNT(DISTINCT mp_year) AS mp_year_counts,
    COUNT(DISTINCT mp_price) AS mp_price_counts
FROM global_food_prices;

SELECT 
    adm0_name AS Countries,
    adm1_name AS Region,
    mkt_name AS City,
    cm_name AS Food_Products,
	cur_name AS Currency,
    pt_name AS Price_Structure,
    um_name Measurement_unit,
    mp_month AS Month,
    mp_year AS year,
    mp_price AS price
FROM global_food_prices;