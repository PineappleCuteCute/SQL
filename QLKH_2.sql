
USE QLKH
GO


INSERT INTO DeTai
    (DT#,TenDT,Cap,KinhPhi)
VALUES 
    ('DT01', N'Tính toán lưới',N'Nhà Nước',700),
    ('DT02',N'Phát hiện tri thức',N'Bộ',300),
    ('DT03',N'Phân loại văn bản',N'Bộ',270),
    ('DT04', N'Dịch tự động Anh Việt',N'Trường',30)

SELECT *FROM DeTai

-----------------

INSERT INTO GiangVien
    (GV#,HoTen,DiaChi,NgaySinh)
VALUES 
    ('GV01', N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975-10-10'),
    ('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976-11-3'),
    ('GV03',N'Trần Đức Khánh',N'Đống Đa, Hà Nội','1977-06-04'),
    ('GV04', N'Nguyễn Hồng Phương',N'Tây Hồ, Hà Nội','1983-12-10'),
    ('GV05', N'Lê Thanh Hương',N'Hai Bà Trưng, Hà Nội','1976-10-10')

SELECT *FROM GiangVien


----------------------
INSERT INTO ThamGia
    (GV#,DT#,SoGio)
VALUES 
    ('GV01','DT01',100),
    ('GV01','DT02',80),
    ('GV01','DT03',80),
    ('GV02','DT01',120),
    ('GV02','DT03',140),
    ('GV03','DT03',150),
    ('GV04','DT04',180)
    

SELECT *FROM ThamGia
