CREATE DATABASE QuanLyCuaHangSach

USE QuanLyCuaHangSach
GO

DROP TABLE Sach
DROP TABLE DonHang
DROP TABLE KhachHang

CREATE TABLE Sach (
    MaSach INT PRIMARY KEY,
    TenSach NVARCHAR(255),
    NamXuatBan INT,
    DonGia FLOAT,
    TheLoai NVARCHAR(255),
    SoLuong INT
);
SELECT * FROM Sach

CREATE TABLE DonHang (
    MaDonHang INT PRIMARY KEY,
    MaKhachHang INT,
    NgayMuaHang DATE,
    FOREIGN KEY (MaKhachHang) REFERENCES KhachHang(MaKhachHang)
);
SELECT * FROM DonHang

CREATE TABLE KhachHang (
    MaKhachHang INT PRIMARY KEY,
    TenKhachHang NVARCHAR(255),
    DienThoai VARCHAR(20),
    DiaChi NVARCHAR(255),
    Email VARCHAR(255),
    MaSoThue VARCHAR(20)
);
SELECT * FROM KhachHang

CREATE TABLE ChiTietDonHang (
    MaDonHang INT,
    MaSach INT,
    SoLuong INT,
    FOREIGN KEY (MaDonHang) REFERENCES DonHang(MaDonHang),
    FOREIGN KEY (MaSach) REFERENCES Sach(MaSach)
);
SELECT * FROM ChiTietDonHang


-- Chèn dữ liệu vào bảng Sách
INSERT INTO Sach (MaSach, TenSach, NamXuatBan, DonGia, TheLoai, SoLuong)
VALUES
    (1, 'Sách thiếu nhi A', 2020, 10.99, 'Thiếu nhi', 15),
    (2, 'Sách giáo khoa B', 2019, 12.99, 'Giáo khoa', 20),
    (3, 'Sách kinh tế C', 2018, 19.99, 'Kinh tế', 8),
    (4, 'Sách kĩ thuật D', 2021, 25.99, 'Kĩ thuật', 5),
    (5, 'Sách tâm lý E', 2022, 14.99, 'Tâm lý', 12);

INSERT INTO Sach (MaSach, TenSach, NamXuatBan, DonGia, TheLoai, SoLuong)
VALUES (6, 'Tâm lý dân tộc An Nam', 2023, 29.99, 'Tâm lý', 20);


-- Chèn dữ liệu vào bảng Khách hàng
INSERT INTO KhachHang (MaKhachHang, TenKhachHang, DienThoai, DiaChi, Email, MaSoThue)
VALUES
    (1, 'Nguyễn Văn A', '0123456789', '123 Đường ABC, Quận XYZ', 'abc@example.com', '12345'),
    (2, 'Trần Thị B', '0987654321', '456 Đường XYZ, Quận ABC', 'xyz@example.com', '54321'),
    (3, 'Lê Văn C', '0123412341', '789 Đường XYZ, Quận ABC', 'c@example.com', '67890');

-- Chèn dữ liệu vào bảng Đơn hàng
INSERT INTO DonHang (MaDonHang, MaKhachHang, NgayMuaHang)
VALUES
    (1, 1, '2023-07-10'),
    (2, 2, '2023-07-11'),
    (3, 1, '2023-07-12');

-- Chèn dữ liệu vào bảng Chi tiết đơn hàng
INSERT INTO ChiTietDonHang (MaDonHang, MaSach, SoLuong)
VALUES
    (1, 1, 2),
    (1, 2, 3),
    (2, 3, 1),
    (3, 4, 2),
    (3, 5, 1);



--C/ Các yêu cầu trong ngôn ngữ SQL:
--1. Đưa ra thông tin những quyển sách mà số lượng còn lại nhỏ hơn 10 cuốn:
SELECT * FROM Sach WHERE SoLuong < 10;

--2. Cho biết sách có tên 'Tâm lý dân tộc An Nam' đã bán được bao nhiêu cuốn?
SELECT SUM(SoLuong) AS TongSoLuong FROM Sach WHERE TenSach = 'Tâm lý dân tộc An Nam';

--3. Cho biết tổng giá trị tất cả các đơn hàng mà khách có mã '01231' đã mua từ trước đến ngày hiện tại?
SELECT SUM(DonGia * SoLuong) AS TongGiaTri
FROM Sach
JOIN DonHang ON Sach.MaSach = DonHang.MaSach
WHERE DonHang.MaKhachHang = '01231' AND DonHang.NgayMuaHang <= CURDATE();

--4. Tạo một thủ tục lưu trữ nhận tham số đầu vào là mã sách, 
--hiển thị thông tin số lượng cuốn sách đã bán, và số lượng còn lại trong cửa hàng.
CREATE PROCEDURE GetBookInfo(IN MaSach INT)
BEGIN
    SELECT SUM(SoLuong) AS SoLuongDaBan, SoLuong AS SoLuongConLai
    FROM Sach
    JOIN DonHang ON Sach.MaSach = DonHang.MaSach
    WHERE Sach.MaSach = MaSach;
END;

--5. Xoá toàn bộ thông tin liên quan đến các đơn hàng trong ngày '25/06/2023':
DELETE FROM DonHang WHERE NgayMuaHang = '2023-06-25';



