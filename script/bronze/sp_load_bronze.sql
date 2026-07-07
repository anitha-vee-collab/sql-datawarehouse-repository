CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME, @overall_start DATETIME,@overall_end DATETIME
	BEGIN TRY
		SET @overall_start = GETDATE()
		PRINT'========================================================================';
		PRINT'Loading Bronze Layer';
		PRINT'========================================================================';
		PRINT'------------------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'------------------------------------------------------------------------';

		SET @start_time = GETDATE()

		PRINT'>>>>>> Truncating Table : crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		
		PRINT'>>>>>> Inserting into table : crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Data Warehouse projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		SET @end_time = GETDATE()
		PRINT'Load duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'>>>>--------------';

		SET @start_time = GETDATE()	
		PRINT'>>>>>> Truncating Table: crm_prod_info';
		TRUNCATE TABLE bronze.crm_prod_info;
		
		PRINT'>>>>>> Inserting into table: crm_prod_info';
		BULK INSERT bronze.crm_prod_info
		FROM 'C:\Data Warehouse projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT'Load duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'>>>>--------------';
	
		SET @start_time = GETDATE()	
		PRINT'>>>>>> Truncating table crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		
		PRINT'>>>>>> Inserting table crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Data Warehouse projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT'Load duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'>>>>--------------';
	
		PRINT'------------------------------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'------------------------------------------------------------------------';

		SET @start_time = GETDATE()	
		PRINT'>>>>>> Truncating Table erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		
		PRINT'>>>>>> Inserting Table erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Data Warehouse projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT'Load duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'>>>>--------------';
		
		SET @start_time = GETDATE()	
		PRINT'>>>>>> Truncating Table erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		
		PRINT'>>>>>> Inserting Table erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Data Warehouse projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT'Load duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'>>>>--------------';
		
		SET @start_time = GETDATE()	
		PRINT'>>>>>> Truncating Table erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		
		PRINT'>>>>>> Inserting Table erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Data Warehouse projects\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT'Load duration: '+CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR)+' seconds';
		PRINT'>>>>--------------';
		SET @overall_end = GETDATE()
		PRINT'=================================================================';
		PRINT'Bronze layer loading is completed';
		PRINT'Bronze loading duration: '+CAST(DATEDIFF(second,@overall_start,@overall_end) AS NVARCHAR)+ ' seconds';
		PRINT'=================================================================';
	END TRY
	BEGIN CATCH
		PRINT'=================================================================';
		PRINT'Error Message'+ERROR_MESSAGE();
		PRINT'Error Message'+CAST(ERROR_NUMBER() AS VARCHAR(100));
		PRINT'Error Message'+CAST(ERROR_STATE() AS VARCHAR);
		PRINT'=================================================================';
	END CATCH
END
