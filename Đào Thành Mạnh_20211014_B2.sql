SELECT *FROM BANGXH
--
SELECT *FROM CAULACBO
--
SELECT *FROM CAUTHU
--
SELECT *FROM HLV_CLB
--
SELECT *FROM HUANLUYENVIEN
--
SELECT *FROM QUOCGIA
--
SELECT *FROM SANVD
--
SELECT *FROM TINH
--
SELECT *FROM TRANDAU
---
USE QLbongda
--A. Truy vấn cơ bản
--1 Cho biết thông tin (mã cầu thủ, họ tên, số áo, vị trí, ngày sinh, địa chỉ) của tất cả các cầu thủ’.
SELECT MACT,HOTEN,SO,VITRI,NGAYSINH,DIACHI 
FROM CAUTHU
--2 Hiển thị thông tin tất cả các cầu thủ có số áo là 7 chơi ở vị trí Tiền vệ.
SELECT MACT,HOTEN,SO,VITRI,NGAYSINH,DIACHI
FROM CAUTHU
WHERE (SO =7)  AND (VITRI=N'Tiền vệ')
--3 Cho biết tên, ngày sinh, địa chỉ, điện thoại của tất cả các huấn luyện viên.
SELECT TENHLV, NGAYSINH, DIACHI, DIENTHOAI 
FROM HUANLUYENVIEN
--4 Hiển thi thông tin tất cả các cầu thủ có quốc tịch Việt Nam thuộc câu lạc bộ Becamex Bình Dương.
SELECT MACT,HOTEN,SO,VITRI,NGAYSINH,DIACHI
FROM CAUTHU
INNER JOIN QUOCGIA ON CAUTHU.MAQG=QUOCGIA.MAQG
INNER JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
WHERE QUOCGIA.TENQG=N'Việt Nam' AND CAULACBO.TENCLB=N'BECAMEX BÌNH DƯƠNG'
--5 Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bóng ‘SHB Đà Nẵng’ có quốc tịch Bra-xin
SELECT MACT,HOTEN,NGAYSINH,DIACHI,VITRI
FROM CAUTHU
INNER JOIN QUOCGIA ON CAUTHU.MAQG=QUOCGIA.MAQG
INNER JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
WHERE QUOCGIA.TENQG=N'Bra-xin' AND CAULACBO.TENCLB=N'SHB Đà Nẵng'
--6. Hiển thị thông tin tất cả các cầu thủ đang thi đấu trong câu lạc bộ có sân nhà là “Long An”.
SELECT MACT,HOTEN,NGAYSINH,CAUTHU.DIACHI,VITRI
FROM CAUTHU
JOIN CAULACBO ON CAUTHU.MACLB = CAULACBO.MACLB
JOIN SANVD ON CAULACBO.MASAN=SANVD.MASAN
WHERE SANVD.TENSAN=N'Long An'
-- 7. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 2 của mùa bóng năm 2009.
SELECT MATRAN, NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1 , CLB2.TENCLB AS TENCLB2 , KETQUA
FROM TRANDAU, SANVD, CAULACBO CLB1, CAULACBO CLB2
WHERE TRANDAU.VONG = 2 AND TRANDAU.NAM = 2009
AND TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND SANVD.MASAN = TRANDAU.MASAN;

-- 8. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc của các huấn luyện viên có quốc tịch “ViệtNam”.
SELECT HUANLUYENVIEN.MAHLV,TENHLV, NGAYSINH,DIACHI,HLV_CLB.VAITRO,TENCLB
FROM HUANLUYENVIEN
JOIN HLV_CLB ON HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
JOIN QUOCGIA ON HUANLUYENVIEN.MAQG = QUOCGIA.MAQG
JOIN CAULACBO ON HLV_CLB.MACLB = CAULACBO.MACLB
WHERE QUOCGIA.TENQG=N'Việt Nam'

-- 9. Lấy tên 3 câu lạc bộ có điểm cao nhất sau vòng 3 năm 2009.
SELECT TOP 3 TENCLB 
FROM CAULACBO,BANGXH
WHERE CAULACBO.MACLB=BANGXH.MACLB AND VONG=3 AND NAM=2009
ORDER BY BANGXH.DIEM DESC;

-- 10. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc mà câu lạc bộ đó đóng ở tỉnh Binh Dương.
SELECT HUANLUYENVIEN.MAHLV,TENHLV, NGAYSINH, DIACHI,HLV_CLB.VAITRO,CAULACBO.TENCLB
FROM HUANLUYENVIEN,HLV_CLB,CAULACBO,TINH
WHERE HUANLUYENVIEN.MAHLV = HLV_CLB.MAHLV
AND HLV_CLB.MACLB = CAULACBO.MACLB
AND CAULACBO.MATINH=TINH.MATINH
AND TINH.TENTINH=N'Bình Dương'


--B.Các phép toán trên nhóm

-- 1. Thống kê số lượng cầu thủ của mỗi câu lạc bộ.
SELECT TENCLB, COUNT(CAUTHU.MACLB) AS SOLUONG
FROM CAULACBO
INNER JOIN CAUTHU ON CAULACBO.MACLB=CAUTHU.MACLB
GROUP BY TENCLB
-- 2. Thống kê số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) của mỗi câu lạc bộ
SELECT COUNT(CAUTHU.MAQG) AS SOLUONG
FROM CAUTHU
WHERE MAQG <> 'VN'
-- 3. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác Việt Nam) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.
SELECT CAULACBO.MACLB,CAULACBO.TENCLB,SANVD.TENSAN,SANVD.DIACHI,COUNT(CAUTHU.MAQG) AS SL_CT_NUOCNGOAI
FROM CAULACBO
INNER JOIN SANVD ON CAULACBO.MASAN=SANVD.MASAN
INNER JOIN CAUTHU ON CAULACBO.MACLB=CAUTHU.MACLB
WHERE CAUTHU.MAQG <> 'VN'
GROUP BY CAULACBO.MACLB,CAULACBO.TENCLB,SANVD.TENSAN,SANVD.DIACHI
HAVING COUNT(CAUTHU.MAQG)  >= 2

-- 4. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc bộ thuộc địa bàn tỉnh đó quản lý.
SELECT TINH.TENTINH,COUNT(CAUTHU.VITRI) AS SOLUONG
FROM TINH
INNER JOIN CAULACBO ON TINH.MATINH=CAULACBO.MATINH
INNER JOIN CAUTHU ON CAULACBO.MACLB=CAUTHU.MACLB
WHERE CAUTHU.VITRI=N'Tiền đạo'
GROUP BY TINH.TENTINH


-- 5. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất của bảng xếp hạng vòng 3, năm 2009.
SELECT  CAULACBO.TENCLB,TINH.TENTINH
FROM TINH
JOIN CAULACBO ON TINH.MATINH=CAULACBO.MATINH
JOIN BANGXH ON CAULACBO.MACLB = BANGXH.MACLB
WHERE BANGXH.VONG=3 AND BANGXH.NAM=2009
GROUP BY CAULACBO.TENCLB,TINH.TENTINH,BANGXH.HANG 
HAVING BANGXH.HANG =1

--C.Các toán tử nâng cao
-- 1. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong một câu lạc bộ mà chưa có số điện thoại.
SELECT TENHLV
FROM HUANLUYENVIEN HLV, HLV_CLB
WHERE HLV_CLB.VAITRO IS NOT NULL AND HLV.DIENTHOAI IS  NULL 
AND HLV.MAHLV = HLV_CLB.MAHLV;

-- 2. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ nào.

SELECT TENHLV FROM HUANLUYENVIEN HLV
WHERE HLV.MAHLV NOT IN(SELECT MAHLV FROM HLV_CLB) AND HLV.MAQG = 'VN';
-- 3. Liệt kê các cầu thủ đang thi đấu trong các câu lạc bộ có thứ hạng ở vòng 3 năm 2009 lớn hơn 6 hoặc nhỏ hơn 3.
SELECT HOTEN 
FROM CAUTHU
INNER JOIN CAULACBO ON CAUTHU.MACLB=CAULACBO.MACLB
INNER JOIN BANGXH ON CAULACBO.MACLB = BANGXH.MACLB
WHERE BANGXH.VONG=3 AND BANGXH.NAM=2009 AND (BANGXH.HANG>6 OR BANGXH.HANG<3)
GROUP BY HOTEN


-- 4. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ (CLB) đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009.
SELECT  NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1 , CLB2.TENCLB AS TENCLB2 , KETQUA
FROM TRANDAU, SANVD, CAULACBO CLB1, CAULACBO CLB2
WHERE  TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND SANVD.MASAN = TRANDAU.MASAN 
AND (
CLB1.MACLB IN (SELECT MACLB FROM BANGXH WHERE VONG = 3 AND NAM = 2009 AND HANG =1)
OR
CLB2.MACLB IN (SELECT MACLB FROM BANGXH WHERE VONG = 3 AND NAM = 2009 AND HANG =1)

)
