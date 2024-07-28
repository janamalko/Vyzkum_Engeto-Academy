 
 -- Primary source table:

 
 CREATE OR REPLACE TABLE t_jana_malkova_project_SQL_primary_final AS 
 SELECT 
 	cpib.name AS industry,
	cpib.code AS branch_code,
	round (avg(cpay.value),2) AS avg_salary,
	cpay.payroll_year,
	cpc.name AS food_category, 
	round(avg(cp.value),2) AS avg_food_price, 
	YEAR (cp.date_from) AS price_year
FROM czechia_price AS cp
JOIN czechia_payroll AS cpay
	ON YEAR(cp.date_from) = cpay.payroll_year AND
	cpay.value_type_code = 5958 AND
	cpay.calculation_code = 200 AND 
	cpay.industry_branch_code IS NOT NULL
JOIN czechia_price_category cpc
	ON cp.category_code = cpc.code
JOIN czechia_payroll_industry_branch cpib
	ON cpay.industry_branch_code = cpib.code
GROUP BY branch_code, cpay.payroll_year, food_category, price_year
ORDER BY branch_code, cpay.payroll_year, food_category, price_year; 
