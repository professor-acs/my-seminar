create procedure proc_Staffs @StaffID int, @NewPhone varchar(15)
as 
	update Staffs
	set Phone = @NewPhone
	where @StaffID = staffID

go

