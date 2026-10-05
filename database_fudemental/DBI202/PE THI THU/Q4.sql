
select p.ProductID, p.Name as 'ProductName', color, cost, price, l.LocationID, l.Name as 'LocationName', Shelf, Bin, Quantity
from Product p
left join ProductInventory pIn on pIn.ProductID = p.ProductID
left join Location l on l.LocationID = pIn.LocationID

group by  p.ProductID, p.Name, color, cost, price, l.LocationID, l.Name, Shelf, Bin, Quantity
having Cost < 400 and color = 'Yellow'
