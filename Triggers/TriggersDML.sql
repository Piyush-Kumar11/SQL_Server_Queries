use userDB;

-- Creating Table to store logs
create table studentsLog(
	logID int identity(1,1),
	studentName nvarchar(100) not null
);

alter table studentsLog add operation nvarchar(20), dateOfOperation datetime;

-- Creating Trigger on Insert into Students
create trigger tgr_InsertStudents
on students
after insert
as
begin
	insert into studentsLog(studentName, operation, dateOfOperation)
	select studentName, 'Insert', getDate() from inserted;
end;

insert into students(studentName) values('Akash');

select * from students;
select * from studentsLog;

-- Creating Trigger on Delete from Students
create trigger tgr_DeleteStudents
on students
after delete
as
begin
	set nocount on -- Avoids printing affected rows message
	insert into studentsLog(studentName, operation, dateOfOperation)
	select studentName, 'Delete', getDate() from deleted;
end;

delete from students where studentID = 6;

-- Creating Trigger on Update for Students
create trigger tgr_UpdateStudents
on students
after update
as
begin
	insert into studentsLog(studentName, operation, dateOfOperation)
	select studentName, 'Update', getDate() from inserted;
end;

update students set studentName = 'Rahul' where studentID = 3;

-- Creating Instead of Insert Trigger (Prevent Insertions)
create trigger tgr_PreventInsertStudents
on students
instead of insert -- Custom logic when insert will be performed on Students
as
begin
	print 'Insert operation is not allowed!';
end;

insert into students(studentName) values('Rohit');

-- Creating Instead of Update Trigger (Prevent Updates)
create trigger tgr_PreventUpdateStudents
on students
instead of update
as
begin
	print 'Update operation is not allowed!';
end;

update students set studentName = 'Vikas' where studentID = 2;

-- Creating Instead of Delete Trigger (Prevent Deletions)
create trigger tgr_PreventDeleteStudents
on students
instead of delete
as
begin
	print 'Delete operation is not allowed!';
end;

delete from students where studentID = 4;

-- Listing All Triggers in the Database
select name from sys.triggers;

-- Dropping a Trigger
drop trigger tgr_PreventDeleteStudents;

-- Disabling Trigger
Disable Trigger tgr_PreventInsertStudents on Students;
-- ALL
Disable Trigger All on Students;

-- Enable Trigger
Enable Trigger tgr_PreventInsertStudents ON Students;
Enable Trigger all on Students;

--Viewing Definition
Select definition from sys.sql_modules Where object_id = OBJECT_ID('tgr_PreventInsertStudents');
