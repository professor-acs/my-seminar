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


-- test
