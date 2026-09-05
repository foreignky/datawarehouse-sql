

DECLARE @start_time DATETIME, @end_time DATETIME;
SET @start_time = GETDATE()
INSERT INTO silver.crm_cust_info (
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)

SELECT cst_id, cst_key,
TRIM(cst_firstname) AS cst_firstname, 
TRIM(cst_lastname) AS cst_lastname, 
CASE 
	WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Solteiro'
	WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Casado'
	ELSE 'n/a'
END AS cst_marital_status,
CASE
	WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Feminino'
	WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Masculino'
	ELSE 'n/a'
END AS cst_gndr,
cst_create_date 
FROM(
	SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM bronze.crm_cust_info 
	WHERE cst_id IS NOT NULL
) t
WHERE flag_last = 1;