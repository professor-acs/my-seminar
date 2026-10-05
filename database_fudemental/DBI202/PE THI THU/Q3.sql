
select ProductID, LocationID, Quantity
from ProductInventory p
where LocationID = 7
and Quantity > 250
group by ProductID, LocationID, Quantity
order by p.Quantity desc 

