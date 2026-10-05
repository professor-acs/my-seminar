create procedure proc_product_quantity @productID int, @totalQuantity int output
as  
	set @totalQuantity = (
	select sum(Quantity) as 'TotalQuantity'
	from ProductInventory
	where ProductID = @productID
	)
	
go

	declare @x int
	exec proc_product_quantity 1, @x output
	select @x as TotalQuantity