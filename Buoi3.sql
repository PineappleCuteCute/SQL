--BÀI THỰC HÀNH SỐ 3
--Thao tác Cơ sở dữ liệu sử dụng T–SQL nâng cao
--a. Xử lý chuỗi, ngày giờ
--1. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân nhà mà không bị thủng lưới.
SELECT NGAYTD, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU
JOIN CAULACBO AS CLB1 ON TRANDAU.MACLB1=CLB1.MACLB
JOIN CAULACBO AS CLB2 ON TRANDAU.MACLB2=CLB2.MACLB
WHERE MONTH(NGAYTD) = 3 AND LEFT(KETQUA, 1) = 0
--Goi y thay so 1 bang GETINDEX-- 
--2. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là “Công”
SELECT MACT, HOTEN, NGAYSINH
FROM CAUTHU
WHERE HOTEN LIKE N'%Công%'


--3. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ “Nguyễn “.
SELECT MACT, HOTEN, NGAYSINH
FROM CAUTHU
WHERE HOTEN NOT LIKE N'Nguyễn%'

--4. Cho biết mã huấn luyện viên, họ tên, ngày sinh, đ ịa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35-40.
SELECT MAHLV, TENHLV, NGAYSINH, DIACHI
FROM HUANLUYENVIEN
JOIN QUOCGIA ON QUOCGIA.MAQG = HUANLUYENVIEN.MAQG
WHERE TENQG = N'Việt Nam'
AND DATEDIFF(YEAR, NGAYSINH, GETDATE()) BETWEEN 35 AND 40

--5. Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 8 năm 2019.
SELECT TENCLB
FROM CAULACBO
JOIN HLV_CLB ON CAULACBO.MACLB=HLV_CLB.MACLB
WHERE VAITRO = N'HLV Chính'

--6. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến hết vòng 3 năm 2009.
SELECT TOP 1 TENCLB, TENTINH
FROM CAULACBO
JOIN TINH ON CAULACBO.MATINH = TINH.MATINH
JOIN BANGXH ON CAULACBO.MACLB=BANGXH.MACLB
WHERE NAM=2009 AND VONG = 3
ORDER BY LEFT(HIEUSO, 1) DESC 


--b. Truy vấn con

--1. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước
--ngoài (Có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu
--thủ nước ngoài.
SELECT MACLB, TENCLB, , DIACHI, COUNT(*) AS SoLuongCauThuNuocNgoai
FROM CAULACBO
JOIN CAUTHU ON CAULACBO.MACLB = CAUTHU.MACLB
WHERE CAUTHU.MAQG <> 'VN'
GROUP BY , TENCLB, SANVD, DIACHI
HAVING COUNT(*) > 2;



--2. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009


--3. Cho biết danh sách các trận đấu ( NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của 
--câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.
SELECT NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU
    JOIN CAULACBO CLB1 ON CLB.MACLB = TRANDAU.MACLB
    JOIN CAULACBO CLB2 ON CLB.MACLB = TRANDAU.MACLB
    JOIN SANVD ON TRANDAU.MASAN = SANVD.MASAN
    WHERE MACLB = (SELECT TOP 1 MACLB)

 
