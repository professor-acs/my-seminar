Use FUH_Company
/* if else in TSql */
Declare @workHours decimal, @bonus decimal
select @workHours  = sum(workHours)
from tblWorksOn
WHERE empSSN=30121050027
group by empSSN
IF (@workHours> 300)
	SET @bonus=1000
ELSE
	SET @bonus=500
PRINT @bonus
/* Switch case */
declare @depNum decimal, @str nvarchar(30)
set @str=
	case @depNum
		when 1 then N'Phòng ban số 1'
		when 2 then N'Phòng ban số 2'
		else N'Phòng ban khác'
	end
print @str			

declare @womandayBonus decimal
select @womandayBonus =
	case empSex
		when 'F' then 500
		when 'M' then 0
	end
from tblEmployee
print @womandayBonus

/* Loop */
declare @factorial int, @n int
set @n = 10
set @factorial = 1
while (@n > 1)
	begin 
		set @factorial = @factorial*@n
		set @n = @n - 1
	end
print @factorial

/* error handling */
begin transaction
begin try 
	insert into tblDepartment(depNum, depName)
	values(6, N'Phòng Kế Toán');

	insert into tblDepartment(depNum, depName)
	values(6, N'Phòng Kế Toán');
	commit transaction
end try
begin catch
	ROLLBACK TRANSACTION--rollback transaction
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
end catch

/* procedures */
create procedure getAllProjects 
as select * from tblProject;
go 
exec getAllProjects

create procedure changeNameOfProject
	@pNumber int,
	@pNewName nvarchar(50)
as
	update tblProject
	set proName = @pNewName
	where proNum = @pNumber
go
	exec changeNameOfProject 1, N'ProjectA updated'