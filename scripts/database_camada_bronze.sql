CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME, 
	@batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT('---------------------------');
		PRINT 'CARREGANDO A CAMADA BRONZE';
		PRINT('---------------------------');

		PRINT('---------------------------');
		PRINT('--- CARREGANDO TABELAS CRM ----');
		PRINT('---------------------------');

		SET @start_time = GETDATE();
		PRINT('>> Truncating table: bronze.crm_cust_info')
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT('>> Inserting data into: bronze.crm_cust_info')
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\kelly\Documents\pjdw\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		) 
		SET @end_time = GETDATE();
		PRINT '>> Duração do carregamento: ' + CAST(DATEDIFF(second, @start_time, @end_time)	AS NVARCHAR) + ' segundos';
		PRINT '>> ------------------------'

		SET @start_time = GETDATE();
		PRINT('>> Truncating table: bronze.crm_prod_info')
		TRUNCATE TABLE bronze.crm_prod_info;
		PRINT('>> Inserting data into:  bronze.crm_prod_info')
		BULK INSERT bronze.crm_prod_info
		FROM 'C:\Users\kelly\Documents\pjdw\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		) 
		SET @end_time = GETDATE();
		PRINT '>> Duração do carregamento: ' + CAST(DATEDIFF(second, @start_time, @end_time)	AS NVARCHAR) + ' segundos';
		PRINT '>> ------------------------'

		SET @start_time = GETDATE();
		PRINT('>> Truncating table: bronze.crm_sales_details')
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT('>> Inserting data into:  bronze.crm_sales_details')
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\kelly\Documents\pjdw\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		) 
		SET @end_time = GETDATE();
		PRINT '>> Duração do carregamento: ' + CAST(DATEDIFF(second, @start_time, @end_time)	AS NVARCHAR) + ' segundos';
		PRINT '>> ------------------------'


		PRINT('---------------------------');
		PRINT('--- CARREGANDO TABELAS ERP ----');
		PRINT('---------------------------');

		SET @start_time = GETDATE();
		PRINT('>> Truncating table: bronze.erp_cust_az12');
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT('>> Inserting data into:  bronze.erp_cust_az12');
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\kelly\Documents\pjdw\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		) 
		SET @end_time = GETDATE();
		PRINT '>> Duração do carregamento: ' + CAST(DATEDIFF(second, @start_time, @end_time)	AS NVARCHAR) + ' segundos';
		PRINT '>> ------------------------'


		SET @start_time = GETDATE();
		PRINT('>> Truncating table: bronze.erp_loc_a101');
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT('>> Inserting data into:  bronze.erp_loc_a101');
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\kelly\Documents\pjdw\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		) 
		SET @end_time = GETDATE();
		PRINT '>> Duração do carregamento: ' + CAST(DATEDIFF(second, @start_time, @end_time)	AS NVARCHAR) + ' segundos';
		PRINT '>> ------------------------'

		SET @start_time = GETDATE();
		PRINT('>> Truncating table: bronze.erp_px_cat_g1v2');
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT('>> Inserting data into:  bronze.erp_px_cat_g1v2');
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\kelly\Documents\pjdw\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		) 
		SET @end_time = GETDATE();
		PRINT '>> Duração do carregamento: ' + CAST(DATEDIFF(second, @start_time, @end_time)	AS NVARCHAR) + ' segundos';
		PRINT '>> ------------------------'

		SET @batch_end_time = GETDATE();
		PRINT '-------------------------------------------';
		PRINT 'O carregamento da camada bronze foi concluído';
		PRINT 'Total da duração: ' + CAST( DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' segundos';
		PRINT '-------------------------------------------';
	END TRY
		BEGIN CATCH
		PRINT '----------------------------------------------------------';
		PRINT 'OCORREU UM ERRO DURANTE O CARREGAMENTO DA CAMADA BRONZE';
		PRINT 'MENSAGEM DE ERRO' + ERROR_MESSAGE();
		PRINT 'MENSAGEM DE ERRO' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'MENSAGEM DE ERRO' + CAST (ERROR_STATE() AS NVARCHAR);


		PRINT '----------------------------------------------------------';
		END CATCH
END;