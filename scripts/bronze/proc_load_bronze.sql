/*
==========================================
USE DataWarehouse
GO
Usage Example:
  EXEC bronze.load_bronze
=========================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=================================================';

		PRINT '-------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '-------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT '>> Inseting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL\dwh_project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT '>> Inseting Data into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL\dwh_project\datasets\source_crm\pdr_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT '>> Inseting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL\dwh_project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------';

		PRINT '-------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '-------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: dbo.bronze_erp_cust_az12';
		TRUNCATE TABLE dbo.bronze_erp_cust_az12;
		PRINT '>> Inseting Data into: dbo.bronze_erp_cust_az12';
		BULK INSERT dbo.bronze_erp_cust_az12
		FROM 'D:\SQL\dwh_project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: dbo.bronze_erp_loc_a101';
		TRUNCATE TABLE dbo.bronze_erp_loc_a101;
		PRINT '>> Inseting Data into: dbo.bronze_erp_loc_a101';
		BULK INSERT dbo.bronze_erp_loc_a101
		FROM 'D:\SQL\dwh_project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: dbo.bronze_erp_px_cat_g1v2';
		TRUNCATE TABLE dbo.bronze_erp_px_cat_g1v2;
		PRINT '>> Inseting Data into: dbo.bronze_erp_px_cat_g1v2';
		BULK INSERT dbo.bronze_erp_px_cat_g1v2
		FROM 'D:\SQL\dwh_project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT 'Total Loading Duration ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================';

	END TRY
	BEGIN CATCH
		PRINT '============================================='
		PRINT 'ERROR OCCUR DURING LOADING BRONZE LAYER'
		PRINT 'Error message: ' + ERROR_MESSAGE();
		PRINT 'Error message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error message: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '============================================='
	END CATCH
END
