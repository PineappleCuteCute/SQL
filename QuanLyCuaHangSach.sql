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


-- Chèn dữ liệu vào bảng Sách
INSERT INTO Sach (MaSach, TenSach, NamXuatBan, DonGia, TheLoai, SoLuong)
VALUES
    (1, 'Sách thiếu nhi A', 2020, 10.99, 'Thiếu nhi', 15),
    (2, 'Sách giáo khoa B', 2019, 12.99, 'Giáo khoa', 20),
    (3, 'Sách kinh tế C', 2018, 19.99, 'Kinh tế', 8),
    (4, 'Sách kĩ thuật D', 2021, 25.99, 'Kĩ thuật', 5),
    (5, 'Sách tâm lý E', 2022, 14.99, 'Tâm lý', 12);

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
