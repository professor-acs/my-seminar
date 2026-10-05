delete pi from ProductInventory pi
join Location l on l.LocationID = pi.LocationID
where l.Name = 'Tool Crib';
