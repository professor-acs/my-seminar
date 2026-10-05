
select p.ProductID, p.Name, sum(pin.Quantity) as 'TotalQuantity'
from Product p
left join ProductInventory pin on pin.ProductID = p.ProductID
group by p.ProductID, p.Name
having sum(pin.Quantity) = (
	select max(maxQuan)
	from 
	(
		select sum(Quantity) as maxQuan
		from Product p
		left join ProductInventory pin on pin.ProductID = p.ProductID
		group by p.ProductID, p.Name
	) as temp
);
