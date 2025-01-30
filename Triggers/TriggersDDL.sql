use userDB;

-- Creating a Table to Log DDL Changes
create table ddlLog(
	logID int identity(1,1),
	eventType nvarchar(50),
	objectName nvarchar(255),
	schemaName nvarchar(100),
	commandText nvarchar(max),
	dateOfOperation datetime default getDate()
);

-- Creating a DDL Trigger for CREATE, ALTER, DROP Commands
create trigger tgr_DDL_Changes
on database
for create_table, alter_table, drop_table
as
begin
	insert into ddlLog(eventType, objectName, schemaName, commandText)
	select 
		eventdata().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(50)'),
		eventdata().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(255)'),
		eventdata().value('(/EVENT_INSTANCE/SchemaName)[1]', 'nvarchar(100)'),
		eventdata().value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)')
end;

-- Creating a DDL Trigger for CREATE, ALTER, DROP Commands On Any Database
create trigger tgr_DDL_Changes
on ALL SERVER
for create_table, alter_table, drop_table
as
begin
	insert into ddlLog(eventType, objectName, schemaName, commandText)
	select 
		eventdata().value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(50)'),
		eventdata().value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(255)'),
		eventdata().value('(/EVENT_INSTANCE/SchemaName)[1]', 'nvarchar(100)'),
		eventdata().value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)')
end;

-- Testing CREATE TABLE Trigger
create table testTable(
	id int primary key,
	name nvarchar(100)
);

-- Testing ALTER TABLE Trigger
alter table testTable add email nvarchar(255);

-- Testing DROP TABLE Trigger
drop table testTable;

-- View DDL Changes Logged
select * from ddlLog;

-- Preventing a Table from Being Dropped using ROLLBACK
create trigger tgr_PreventDropTable
on database
for drop_table
as
begin
	print 'Dropping tables is not allowed in this database!';
	rollback; 
end;

-- Attempt to Drop a Table (This will be blocked)
drop table testTable;

-- Preventing Schema Changes
create trigger tgr_PreventSchemaChange
on database
for alter_schema
as
begin
	print 'Schema modifications are restricted!';
	rollback;
end;

-- Attempting Schema Change (This will be blocked)
alter schema dbo transfer testTable;

-- Listing All DDL Triggers
select name from sys.triggers where parent_class = 0;

-- Dropping a Specific DDL Trigger
drop trigger tgr_PreventDropTable on database;

-- Disabling All DDL Triggers on database
DISABLE TRIGGER ALL ON DATABASE;

-- Disabling all DDL Triggers on Server
DISABLE TRIGGER ALL ON ALL SERVER


