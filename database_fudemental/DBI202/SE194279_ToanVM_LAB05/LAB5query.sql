use ABCCompany

/* 1 */
create function StudenID_Func1( @mavt varchar(10))
returns int 
as 
begin
	declare @Total int;
	select @Total = sum(c.SL * c.GiaBan)
	from CHITIETHOADON c
	where @mavt = c.MaVT;
	return ISNULL(@Total, 0);
end
	
/* 2 */
CREATE FUNCTION dbo.CalculateTotalAmount(@MahD nvarchar(10))
RETURNS int
AS
BEGIN
    DECLARE @TotalAmount int;

    SELECT @TotalAmount = SUM(SL * GiaBan) 
    FROM CHITIETHOADON 
    WHERE MaHD = @MahD;

    RETURN ISNULL(@TotalAmount, 0); 
END
/* 3 */

CREATE PROCEDURE StudenId_Proc1
    @makh NVARCHAR(5), -- Customer ID
    @diachi NVARCHAR(50) -- New Address
AS
BEGIN
    -- Update the address for the specified customer
    UPDATE KHACHHANG
    SET DiaChi = @diachi
    WHERE MaKH = @makh;

    -- Optional: Check if the update was successful
    IF @@ROWCOUNT = 0
    BEGIN
        PRINT 'No customer found with the specified ID.';
    END
    ELSE
    BEGIN
        PRINT 'Address updated successfully.';
    END
END;

/* 4 */

CREATE PROCEDURE AddItemToHoadon
    @mahd NVARCHAR(10),   -- Invoice ID
    @mavt NVARCHAR(5),    -- Item ID
    @sl INT,              -- Quantity
    @khuyenmai INT,       -- Discount
    @giaban INT           -- Selling Price
AS
BEGIN
    -- Check if the invoice exists
    IF NOT EXISTS (SELECT 1 FROM HOADON WHERE MaHD = @mahd)
    BEGIN
        PRINT 'Invoice ID does not exist.';
        RETURN; -- Exit the procedure
    END

    -- Check if the item exists
    IF NOT EXISTS (SELECT 1 FROM VATTU WHERE MaVT = @mavt)
    BEGIN
        PRINT 'Item ID does not exist.';
        RETURN; -- Exit the procedure
    END

    -- Insert the new item into the CHITIETHOADON table
    INSERT INTO CHITIETHOADON (MaHD, MaVT, SL, KhuyenMai, GiaBan)
    VALUES (@mahd, @mavt, @sl, @khuyenmai, @giaban);

    PRINT 'Item added to invoice successfully.';
END;



/* 5 */



CREATE TRIGGER StudenId_Trig1
ON CHITIETHOADON
AFTER INSERT
AS
BEGIN
    -- Update the total amount (TongTG) in the HOADON table
    UPDATE HOADON
    SET TongTG = (
        SELECT SUM(SL * GiaBan)
        FROM CHITIETHOADON
        WHERE MaHD = HOADON.MaHD
        GROUP BY MaHD
    )
    WHERE MaHD IN (SELECT MaHD FROM inserted);
END;

/* 6 */

CREATE VIEW StudentID_View1 AS
SELECT 
    k.MaKH AS CustomerID,
    k.TenKH AS CustomerName,
    k.DiaChi AS Address,
    h.MaHD AS InvoiceID,
    h.Ngay AS InvoiceDate,
    ct.SL AS Quantity,
    ct.GiaBan AS SellingPrice
FROM 
    KHACHHANG k
JOIN 
    HOADON h ON k.MaKH = h.MaKH
JOIN 
    CHITIETHOADON ct ON h.MaHD = ct.MaHD
JOIN 
    VATTU v ON ct.MaVT = v.MaVT
WHERE 
    v.TenVT = 'GACH ONG';

