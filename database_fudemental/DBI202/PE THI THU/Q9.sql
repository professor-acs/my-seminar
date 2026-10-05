CREATE TRIGGER tr_insert_Product
ON Product
AFTER INSERT
AS
BEGIN
    DECLARE @ProductID INT, @ProductName NVARCHAR(100), @ModelID INT, @ModelName NVARCHAR(100);

    -- Retrieve the inserted data and corresponding model names
    SELECT @ProductID = i.ProductID, 
           @ProductName = i.Name, 
           @ModelID = i.ModelID, 
           @ModelName = m.Name
    FROM INSERTED i
    LEFT JOIN ProductModel m ON i.ModelID = m.ModelID;

    -- Print the details
    PRINT 'ProductID: ' + CAST(@ProductID AS NVARCHAR) + 
          ', ProductName: ' + @ProductName + 
          ', ModelID: ' + CAST(@ModelID AS NVARCHAR) + 
          ', ModelName: ' + ISNULL(@ModelName, 'N/A');
END;
GO

Drop trigger tr_insert_Product
-- test
Insert into Product (ProductID, Name, Cost, Price, ModelID, SellStartDate)
Values (1000, 'Product Test', 12.5, 15.5, 1, '2021-10-25')