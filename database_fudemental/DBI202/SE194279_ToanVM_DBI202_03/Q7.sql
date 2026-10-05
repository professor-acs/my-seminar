SELECT l.locationID, l.Name, p.ProductID, p.Name, SUM(pin.Quantity) AS 'TotalQuantity'
FROM Location l
LEFT JOIN ProductInventory pin ON pin.LocationID = l.LocationID
LEFT JOIN Product p ON p.ProductID = pin.ProductID

GROUP BY l.locationID, l.Name, p.ProductID, p.Name

HAVING SUM(pin.Quantity) = (
    SELECT MAX(maxQuan)
    FROM (
        SELECT SUM(pin2.Quantity) AS maxQuan
        FROM Location l2
        LEFT JOIN ProductInventory pin2 ON pin2.LocationID = l2.LocationID
        WHERE l2.LocationID = l.LocationID
        GROUP BY pin2.ProductID
    ) AS temp
)
order by l.Name asc, p.Name desc;



