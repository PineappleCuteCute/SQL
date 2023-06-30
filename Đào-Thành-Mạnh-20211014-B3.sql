USE QLBongDa
SELECT *FROM BANGXH

SELECT *FROM CAUTHU
SELECT *FROM HUANLUYENVIEN
SELECT *FROM HLV_CLB
SELECT *FROM TRANDAU
SELECT *FROM CAULACBO
SELECT *FROM TINH
--a. Xử lý chuỗi, ngày giờ
--1. Cho biết NGAYTD, TENCLB1, TENCLB2, KETQUA các trận đấu diễn ra vào tháng 3 trên sân nhà mà không bị thủng lưới.
--C1
SELECT NGAYTD, CLB1.TENCLB AS TENCLB1,  CLB2.TENCLB AS TENCLB2, KETQUA 
FROM TRANDAU, SANVD, CAULACBO CLB1, CAULACBO CLB2
WHERE  TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND SANVD.MASAN = TRANDAU.MASAN 
AND MONTH(TRANDAU.NGAYTD) = 3
AND ( (TRANDAU.MASAN = CLB1.MASAN AND SUBSTRING(KETQUA, 1, 1) = 0 )
	 OR 
	 (TRANDAU.MASAN = CLB2.MASAN AND SUBSTRING(KETQUA, 3, 1) = 0)
	 );
--C2
SELECT NGAYTD, clb1.TENCLB AS [TENCLB1], clb2.TENCLB AS [TENCLB2], KETQUA
FROM TRANDAU td INNER JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
				INNER JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE MONTH(NGAYTD) = 3
AND (td.MASAN = clb1.MASAN AND SUBSTRING(KETQUA, 1, 1) = 0 )
	 OR (td.MASAN = clb2.MASAN AND SUBSTRING(KETQUA, 3, 1) = 0);
	
	
--2. Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ lót là “Công”.
SELECT MACT,HOTEN,NGAYSINH
FROM CAUTHU
WHERE HOTEN LIKE N'%Công%'
--3 Cho biết mã số, họ tên, ngày sinh của những cầu thủ có họ không phải là họ “Nguyễn “.
SELECT MACT,HOTEN,NGAYSINH
FROM CAUTHU
WHERE HOTEN NOT LIKE N'%Nguyễn%'
--4. Cho biết mã huấn luyện viên, họ tên, ngày sinh, đ ịa chỉ của những huấn luyện viên Việt Nam có tuổi nằm trong khoảng 35-40.
--C1
SELECT MAHLV,TENHLV,NGAYSINH,DIACHI
FROM HUANLUYENVIEN
WHERE MAQG='VN'
AND DATEDIFF(YEAR,NGAYSINH, GETDATE()) BETWEEN 35 AND 40;
--C2
SELECT MAHLV,TENHLV,NGAYSINH,DIACHI
FROM HUANLUYENVIEN
WHERE MAQG='VN'
AND DATEPART(YEAR, GETDATE()) - DATEPART(YEAR, NGAYSINH) BETWEEN 35 AND 40;
--5. Cho biết tên câu lạc bộ có huấn luyện viên trưởng sinh vào ngày 20 tháng 8 năm 2019.
SELECT TENHLV
FROM HUANLUYENVIEN HLV
JOIN HLV_CLB ON HLV.MAHLV=HLV_CLB.MAHLV
WHERE VAITRO=N'HLV Chính'
AND NGAYSINH='2019-8-20'
--6. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có số bàn thắng nhiều nhất tính đến hết vòng 3 năm 2009.
SELECT  TENCLB, TENTINH 
FROM  CAULACBO CLB
JOIN TINH ON CLB.MATINH=TINH.MATINH
WHERE CLB.TENCLB IN (
	SELECT TOP 1 TENCLB 
	FROM CAULACBO CLB, BANGXH 
	WHERE CLB.MACLB=BANGXH.MACLB AND BANGXH.NAM=2009 AND VONG <=3
	GROUP BY TENCLB
	ORDER BY SUM(CONVERT(INT, SUBSTRING(HIEUSO, 1, 1))) DESC
)

			
--b. Truy vấn con
--1. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (Có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ có nhiều hơn 2 cầu thủ nước ngoài.
SELECT CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI, COUNT(MACT) AS [Số lượng cầu thủ nước ngoài]
FROM CAULACBO CLB, SANVD SVD, CAUTHU CT, QUOCGIA QG
WHERE CLB.MASAN = SVD.MASAN
AND CLB.MACLB = CT.MACLB
AND CT.MAQG = QG.MAQG
AND TENQG  !=  N'Việt Nam'
GROUP BY CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI
HAVING COUNT(MACT) > 2;


--2. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng có hiệu số bàn thắng bại cao nhất năm 2009.
SELECT DISTINCT TENCLB, TENTINH
FROM CAULACBO CLB INNER JOIN TINH ON CLB .MATINH = TINH.MATINH
				  INNER JOIN BANGXH BXH ON clb.MACLB = BXH.MACLB
WHERE CLB.MACLB = (SELECT TOP 1 MACLB FROM BANGXH WHERE NAM = 2009
				   ORDER BY (
					   CONVERT(INT, SUBSTRING(HIEUSO, 1, 1)) - CONVERT(INT, SUBSTRING(HIEUSO, 3, 1))) DESC
					   );

 --3. Cho biết danh sách các trận đấu ( NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009.

SELECT  NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1 , CLB2.TENCLB AS TENCLB2 , KETQUA
FROM TRANDAU, SANVD, CAULACBO CLB1, CAULACBO CLB2
WHERE  TRANDAU.MACLB1 = CLB1.MACLB
AND TRANDAU.MACLB2 = CLB2.MACLB
AND SANVD.MASAN = TRANDAU.MASAN 
AND (
CLB1.MACLB IN (SELECT TOP 1 MACLB FROM BANGXH WHERE VONG = 3 AND NAM = 2009 
ORDER BY  HANG DESC )
OR
CLB2.MACLB IN (SELECT TOP 1 MACLB FROM BANGXH WHERE VONG = 3 AND NAM = 2009 
ORDER BY  HANG DESC 
)
)
--4. Cho biế tmã câulạcbộ,têncâulạcbộ đã tham gia thi đấu với tất cả các câu lạc bộ cònlại (kể cả sân nhà và sân khách) trong mùa giải năm 2009.
SELECT  MACLB, TENCLB
FROM CAULACBO C 
WHERE NOT EXISTS (
	            SELECT MACLB FROM CAULACBO  WHERE MACLB <> C.MACLB 

				  EXCEPT 
				  (
					   (SELECT MACLB1 FROM TRANDAU T1 WHERE T1.MACLB2=C.MACLB)				
					UNION 
					   (SELECT MACLB2 FROM TRANDAU T2 WHERE T2.MACLB1=C.MACLB)		
       )
);
--C2
SELECT  MACLB, TENCLB
FROM CAULACBO C 
WHERE (SELECT COUNT(*)-1 FROM CAULACBO)= (SELECT COUNT (*) FROM

		   (SELECT MACLB1 FROM TRANDAU T1 WHERE T1.MACLB2=C.MACLB				
					UNION 
			SELECT MACLB2 FROM TRANDAU T2 WHERE T2.MACLB1=C.MACLB) 
TMP );

--5. Cho biết mã câu lạc bộ,tên câu lạc bộ đã tham gia thi đấu với tất cả các câu lạc bộ còn lại ( chỉ tính sân nhà) trong mùa giải năm 2009.

SELECT DISTINCT MACLB1 AS [Mã câu lạc bộ], TENCLB AS [Tên câu lạc bộ]
FROM TRANDAU TD1 
INNER JOIN CAULACBO CLB ON TD1.MACLB1 = CLB.MACLB
WHERE TD1.NAM=2009 
AND NOT EXISTS (
	SELECT MACLB FROM CAULACBO CLB WHERE CLB.MACLB <> TD1.MACLB1
		EXCEPT 
				
		(SELECT MACLB2 FROM TRANDAU TD2 WHERE TD1.MACLB1 = TD2.MACLB1)
		
);



--c. Bài tập về Rule
--1. Khi thêm cầu thủ mới, kiểm tra vị trí trên sân của cầu thủ chỉ thuộc một trong các vị trí sau: Thủ môn, tiền đạo, tiền vệ, trung vệ, hậu vệ.

ALTER TABLE CAUTHU
ADD CONSTRAINT CHK_VITRI CHECK(VITRI IN (N'Thủ môn', N'Tiền đạo', N'Tiền vệ', N'Trung vệ', N'Hậu vệ'));
GO
--
ALTER TABLE CAUTHU 
DROP CONSTRAINT CHK_VITRI
GO
--2. Khi phân công huấn luyện viên, kiểm tra vai trò của huấn luyện vi ên chỉ thuộc một trong các vai trò sau: HLV chính, HLV phụ, HLV thể lực, HLV thủ môn.
ALTER TABLE HLV_CLB
ADD CONSTRAINT CHK_VAITRO CHECK(VAITRO IN (N'HLV Chính',N'HLV phụ',N'HLV thể lực',N'HLV Thủ môn'));
GO
--3. Khi thêm cầu thủ mới, kiểm tra cầu thủ đó có tuổi phải đủ 18 trở lên (chỉ tính năm sinh)
ALTER TABLE CAUTHU 
ADD CONSTRAINT CHK_TUOI CHECK(YEAR(GETDATE()-YEAR(NGAYSINH) )>=18);
GO
-- 4. Kiểm tra kết quả trận đấu có dạng số_bàn_thắng - số_bàn_thua
ALTER TABLE TRANDAU
ADD CONSTRAINT CHK_KETQUA CHECK(KETQUA LIKE '%-%');
GO

--d. Bài tập về View
--1. Cho biết mã số, họ tên, ngày sinh, địa chỉ và vị trí của các cầu thủ thuộc đội bón g “SHB Đà Nẵng” có quốc tịch “Bra-xin”.
CREATE VIEW V1 
AS
SELECT MACT, HOTEN, NGAYSINH, DIACHI, VITRI
FROM CAUTHU CT, CAULACBO CLB, QUOCGIA QG
WHERE CT.MACLB = CLB.MACLB AND TENCLB = N'SHB Đà Nẵng'
AND CT.MAQG = QG.MAQG AND TENQG = N'Bra-xin';
--
SELECT *FROM V1
---- 2. Cho biết kết quả (MATRAN, NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) các trận đấu vòng 3 của mùa bóng năm 2009
CREATE VIEW V2
AS 
SELECT MATRAN, NGAYTD, TENSAN, CLB1.TENCLB AS TENCLB1, CLB2.TENCLB AS TENCLB2, KETQUA
FROM TRANDAU TD,CAULACBO CLB1, CAULACBO CLB2,SANVD
WHERE TD.MACLB1=CLB1.MACLB
AND TD.MACLB2=CLB2.MACLB
AND SANVD.MASAN=TD.MASAN
AND NAM=2009;
--
SELECT *FROM V2
--3. Cho biết mã huấn luyện viên, họ tên, ngày sinh, địa chỉ, vai trò và tên CLB đang làm việc  của các huấn luyện viên có quốc tịch “Việt Nam”
CREATE VIEW V3
AS 
SELECT HUANLUYENVIEN.MAHLV ,TENHLV, NGAYSINH,DIACHI, VAITRO,TENCLB
FROM HUANLUYENVIEN ,CAULACBO,HLV_CLB,QUOCGIA
WHERE HUANLUYENVIEN.MAHLV=HLV_CLB.MAHLV
AND CAULACBO.MACLB=HLV_CLB.MACLB
AND QUOCGIA.MAQG=HUANLUYENVIEN.MAQG
AND QUOCGIA.MAQG=N'VN'
--
SELECT *FROM V3
-- 4. Cho biết mã câu lạc bộ, tên câu lạc bộ, tên sân vận động, địa chỉ và số lượng cầu thủ nước ngoài (có quốc tịch khác “Việt Nam”) tương ứng của các câu lạc bộ nhiều hơn 2 cầu thủ nước ngoài
CREATE VIEW V4
AS
SELECT CLB.MACLB, TENCLB, TENSAN, svd.DIACHI, COUNT(MACT) AS [Số lượng cầu thủ nước ngoài]
FROM CAULACBO CLB, SANVD svd, CAUTHU CT, QUOCGIA QG
WHERE CLB.MASAN = SVD.MASAN
AND CLB.MACLB = CT.MACLB
AND CT.MAQG = QG.MAQG
AND TENQG <> N'Việt Nam'
GROUP BY CLB.MACLB, TENCLB, TENSAN, SVD.DIACHI
HAVING COUNT(MACT) > 2;

SELECT *FROM V4

-- 5. Cho biết tên tỉnh, số lượng cầu thủ đang thi đấu ở vị trí tiền đạo trong các câu lạc  bộ thuộc địa bàn tỉnh đó quản lý
CREATE VIEW V5
AS
SELECT TENTINH, COUNT(MACT) AS [Số lượng cầu thủ đang thi đấu ở vị trí tiền đạo]
FROM TINH, CAULACBO CLB, CAUTHU CT
WHERE TINH.MATINH = CLB.MATINH
AND CLB.MACLB = CT.MACLB
AND VITRI = N'Tiền đạo'
GROUP BY TENTINH;

SELECT * FROM V5;
-- 6. Cho biết tên câu lạc bộ, tên tỉnh mà CLB đang đóng nằm ở vị trí cao nhất 
-- của bảng xếp hạng của vòng 3 năm 2009
CREATE VIEW V6
AS
SELECT TOP 1 TENCLB, TENTINH
FROM CAULACBO CLB, TINH, BANGXH BXH
WHERE BXH.MACLB = CLB.MACLB
AND CLB.MATINH = TINH.MATINH
AND VONG = 3 AND NAM = 2009;

SELECT * FROM V6;

-- 7. Cho biết tên huấn luyện viên đang nắm giữ một vị trí trong 1 câu lạc bộ mà chưa có số điện thoại
CREATE VIEW V7
AS
SELECT TENHLV
FROM HUANLUYENVIEN HLV,HLV_CLB 
WHERE HLV.MAHLV = HLV_CLB.MAHLV
AND HLV_CLB.VAITRO IS NOT NULL
AND HLV.DIENTHOAI IS NULL;

SELECT * FROM V7;
-- 8. Liệt kê các huấn luyện viên thuộc quốc gia Việt Nam chưa làm công tác huấn luyện tại bất kỳ một câu lạc bộ
CREATE VIEW V8
AS
SELECT TENHLV
FROM HUANLUYENVIEN HLV, HLV_CLB, QUOCGIA QG
WHERE HLV.MAHLV = HLV_CLB.MACLB
AND HLV.MAQG = QG.MAQG
AND QG.TENQG = N'Việt Nam'
AND HLV_CLB.MACLB IS NULL
AND HLV_CLB.VAITRO IS NULL;

SELECT * FROM V8;
-- 9. Cho biết kết quả các trận đấu đã diễn ra (MACLB1, MACLB2, NAM, VONG, SOBANTHANG, SOBANTHUA)
CREATE VIEW V9
AS
SELECT MACLB1, MACLB2, NAM, VONG, 
	   SUBSTRING(KETQUA, 1, CHARINDEX('-',KETQUA,1)-1) AS [Số bàn thắng của CLB1],
	   SUBSTRING(KETQUA, CHARINDEX('-',KETQUA,1)+1, LEN(KETQUA)) AS [Số bàn thua của CLB1]
FROM TRANDAU;

SELECT * FROM V9;
-- 10. Cho biết kết quả các trận đấu trên sân nhà (MACLB, NAM, VONG, SOBANTHANG, SOBANTHUA)
CREATE VIEW V10
AS
SELECT MACLB1 AS [MA CLB], NAM, VONG,  
	   SUBSTRING(KETQUA, 1, CHARINDEX('-',KETQUA,1)-1) AS [SOBANTHANG], 
	   SUBSTRING(KETQUA, CHARINDEX('-', KETQUA,1) + 1, LEN(KETQUA)) AS [SOBANTHUA]
FROM TRANDAU,CAULACBO
WHERE TRANDAU.MACLB1=CAULACBO.MACLB;

SELECT * FROM V10;
-- 11. Cho biết kết quả các trận đấu trên sân khách (MACLB, NAM, VONG, SOBANTHANG, SOBANTHUA)
CREATE VIEW V11
AS
SELECT MACLB2 AS [MA CLB], NAM, VONG,  
	   SUBSTRING(KETQUA, CHARINDEX('-',KETQUA,1) + 1, LEN(KETQUA)) AS [SOBANTHANG],
	   SUBSTRING(KETQUA, 1, CHARINDEX('-',KETQUA,1)-1) AS [SOBANTHUA]
FROM TRANDAU,CAULACBO
WHERE TRANDAU.MACLB1=CAULACBO.MACLB

SELECT * FROM V11;
-- 12. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB đang xếp hạng cao nhất tính đến hết vòng 3 năm 2009
CREATE VIEW V12
AS
SELECT NGAYTD, TENSAN, CLB1.TENCLB AS [TENCLB1], CLB2.TENCLB AS [TENCLB2], KETQUA
FROM TRANDAU TD 
INNER JOIN SANVD SVD ON TD.MASAN = SVD.MASAN
INNER JOIN CAULACBO CLB1 ON TD.MACLB1 = CLB1.MACLB
INNER JOIN CAULACBO CLB2 ON TD.MACLB2 = CLB2.MACLB
WHERE TD.MACLB1 = (SELECT MACLB FROM BANGXH WHERE VONG=3 AND NAM=2009 AND HANG=1)

   OR 
      TD.MACLB2 = (SELECT TOP 1 MACLB FROM BANGXH WHERE VONG=3 AND NAM=2009 AND HANG =1)
	

SELECT * FROM V12;
-- 13. Cho biết danh sách các trận đấu (NGAYTD, TENSAN, TENCLB1, TENCLB2, KETQUA) của câu lạc bộ CLB có thứ hạng thấp nhất trong bảng xếp hạng vòng 3 năm 2009
CREATE VIEW V13
AS
SELECT NGAYTD, TENSAN, clb1.TENCLB AS [TENCLB1], clb2.TENCLB AS [TENCLB2], KETQUA
FROM TRANDAU td INNER JOIN SANVD svd ON td.MASAN = svd.MASAN
				INNER JOIN CAULACBO clb1 ON td.MACLB1 = clb1.MACLB
				INNER JOIN CAULACBO clb2 ON td.MACLB2 = clb2.MACLB
WHERE td.MACLB1 = (SELECT TOP 1 MACLB FROM BANGXH  WHERE VONG=3 AND NAM=2009 
				   ORDER BY HANG DESC)
   OR td.MACLB2 = (SELECT TOP 1 MACLB FROM BANGXH WHERE VONG=3 AND NAM=2009 
				   ORDER BY HANG DESC);

SELECT * FROM V13;
