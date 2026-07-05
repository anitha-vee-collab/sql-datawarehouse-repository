/*
=================================================================================
Create database and schema
=================================================================================
*/
use master;
go

if exists(select 1 from sys.databases where name = 'datawarehouse')
begin
alter database datawarehouse set single_user with rollback immediate;
drop database datawarehouse;
end;
go

create database datawarehouse;
go

use datawarehouse;
go

create schema bronze;
go

create schema silver;
go

create schema gold;
go
