USE QLBONGDA
GO
create table QUOCGIA(
	MAQG varchar(5) not null primary key,
	TENQG nvarchar(60) not null,
);


create table TINH(
	MATINH varchar(5) not null primary key,
	TENTINH nvarchar(100) not null,
);


create table SANVD(
	MASAN varchar(5) not null primary key,
	TENSAN nvarchar(100) not null,
	DIACHI nvarchar(200)
);


create table CAULACBO(
	MACLB varchar(5) not null primary key,
	TENCLB nvarchar(100) not null,
	MASAN varchar(5) not null,
	MATINH varchar(5) not null,

	foreign key (MASAN) references SANVD(MASAN),
	foreign key (MATINH) references TINH(MATINH),
);


create table CAUTHU(
	MACT numeric not null identity(1,1) primary key,
	HOTEN nvarchar(100) not null,
	VITRI nvarchar(20) not null,
	NGAYSINH datetime,
	DIACHI nvarchar(200),
	MACLB varchar(5) not null,
	MAQG varchar(5) not null,
	SO int not null,

	foreign key (MACLB) references CAULACBO(MACLB),
	foreign key (MAQG) references QUOCGIA(MAQG),
);


create table HUANLUYENVIEN(
	MAHLV varchar(5) not null primary key, 
	TENHLV nvarchar(100) not null,
	NGAYSINH datetime, 
	DIACHI nvarchar(100), 
	DIENTHOAI nvarchar(20), 
	MAQG varchar(5) not null,

	foreign key (MAQG) references QUOCGIA(MAQG),
);


create table HLV_CLB(
	MAHLV varchar(5) not null, 
	MACLB varchar(5) not null, 
	VAITRO nvarchar(100) not null,

	primary key(MAHLV, MACLB),
	foreign key (MAHLV) references HUANLUYENVIEN(MAHLV),
	foreign key (MACLB) references CAULACBO(MACLB),
);


create table TRANDAU(
	MATRAN numeric not null identity(1,1) primary key, 
	NAM int not null, 
	VONG int not null,  
	NGAYTD datetime not null, 
	MACLB1 varchar(5) not null, 
	MACLB2 varchar(5) not null,  
	MASAN varchar(5) not null, 
	KETQUA varchar(5) not null, 

	foreign key (MACLB1) references CAULACBO(MACLB),
	foreign key (MACLB2) references CAULACBO(MACLB),
	foreign key (MASAN) references SANVD(MASAN),
);


create table BANGXH(
	MACLB varchar(5) not null, 
	NAM int not null,  
	VONG int not null,  
	SOTRAN int not null,  
	THANG int not null,  
	HOA int not null,  
	THUA int not null, 
	HIEUSO varchar(5) not null,  
	DIEM int not null,  
	HANG int not null, 

	primary key(MACLB, NAM, VONG),
	foreign key (MACLB) references CAULACBO(MACLB),
);

---------------------------------------------------- DATA ----------------------------------------------------
-- Quốc gia
insert into QUOCGIA
	(MAQG, TENQG)
values
	('VN', N'Việt Nam'),
	('ANH', N'Anh Quốc'),
	('TBN', N'Tây Ban Nha'),
	('BDN', N'Bồ Đào Nha'),
	('BRA', N'Bra-xin'),
	('ITA', N'Ý'),
	('THA', N'Thái Lan')
select * from QUOCGIA

-- Tỉnh
insert into TINH
	(MATINH, TENTINH)
values
	('BD', N'Bình Dương'),
	('GL', N'Gia Lai'),
	('DN', N'Đà Nẵng'),
	('KH', N'Khánh Hòa'),
	('PY', N'Phú Yên'),
	('LA', N'Long An')
select * from TINH

-- SVĐ
insert into SANVD
	(MASAN, TENSAN, DIACHI)
values
	('GD', N'Gò Đậu', N'123 QL1, TX Thủ Dầu Một, Bình Dương'),
	('PL', N'Pleiku', N'22 Hồ Tùng Mậu, Thống Nhất, Thị xã Pleiku, Gia Lai'),
	('CL', N'Chi Lăng', N'127 Võ Văn Tần, Đà Nẵng'),
	('NT', N'Nha Trang', N'128 Phan Chu Trinh, Nha Trang, Khánh Hoà'),
	('TH', N'Tuy Hòa', N'57 Trường Chinh, Tuy Hòa, Phú Yên'),
	('LA', N'Long An', N'102 Hùng Vương, Tp Tân An, Long An')
select * from SANVD

-- CLB
insert into CAULACBO
	(MACLB, TENCLB, MASAN, MATINH)
values
	('BBD', N'BECAMEX BÌNH DƯƠNG', N'GD', N'BD'),
	('HAGL', N'HOÀNG ANH GIA LAI', N'PL', N'GL'),
	('SDN', N'SHB ĐÀ NẴNG', N'CL', N'DN'),
	('KKH', N'KHATOCO KHÁNH HÒA', N'NT', N'KH'),
	('TPY', N'THÉP PHÚ YÊN', N'TH', N'PY'),
	('GDT', N'GẠCH ĐỒNG TÂM LONG AN', N'LA', N'LA')
select * from CAULACBO

-- Cầu thủ
set identity_insert CAUTHU on
set dateformat dmy
insert into CAUTHU
	(MACT, HOTEN, VITRI, NGAYSINH, DIACHI, MACLB, MAQG, SO)
values
	(1, N'Nguyễn Vũ Phong', N'Tiền vệ', '20/02/1990', NULL, 'BBD', 'VN', 17),
	(2, N'Nguyễn Công Vinh', N'Tiền đạo', '10/03/1992', NULL, 'HAGL', 'VN', 9),
	(3, N'Trần Tấn Tài', N'Tiền vệ', '12/11/1989', NULL, 'BBD', 'VN', 8),
	(4, N'Phan Hồng Sơn', N'Thủ môn', '10/06/1991', NULL, 'HAGL', 'VN', 1),
	(5, N'Ronaldo', N'Tiền vệ', '12/12/1989', NULL, 'SDN', 'BRA', 7),
	(6, N'Robinho', N'Tiền vệ', '12/10/1989', NULL, 'SDN', 'BRA', 8),
	(7, N'Vidic', N'Hậu vệ', '15/10/1987', NULL, 'HAGL', 'ANH', 3),
	(8, N'Trần Văn Santos', N'Thủ môn', '21/10/1990', NULL, 'BBD', 'BRA', 1),
	(9, N'Nguyễn Trường Sơn', N'Hậu vệ', '26/08/1993', NULL, 'BBD', 'VN', 4)
set identity_insert CAUTHU off
select * from CAUTHU

-- HLV
set dateformat dmy
insert into HUANLUYENVIEN
	(MAHLV, TENHLV, NGAYSINH, DIACHI, DIENTHOAI, MAQG)
values
	('HLV01', N'Vital', '15/10/1955', NULL, '0918011075', 'BDN'),
	('HLV02', N'Lê Huỳnh Đức', '20/05/1972', NULL, '01223456789', 'VN'),
	('HLV03', N'Kiatisuk', '11/12/1970', NULL, '01223456789', 'THA'),
	('HLV04', N'Hoàng Anh Tuấn', '10/06/1970', NULL, '01223456789', 'VN'),
	('HLV05', N'Trần Công Minh', '07/07/1973', NULL, '01223456789', 'VN'),
	('HLV06', N'Trần Văn Phúc', '02/03/1965', NULL, '01223456789', 'VN')
select * from HUANLUYENVIEN

-- HLV_CLB
insert into HLV_CLB
	(MAHLV,MACLB,VAITRO)
values
	('HLV01', 'BBD', 'HLV Chính'),
	('HLV02', 'SDN', 'HLV Chính'),
	('HLV03', 'HAGL', 'HLV Chính'),
	('HLV04', 'KKH', 'HLV Chính'),
	('HLV05', 'GDT', 'HLV Chính'),
	('HLV06', 'BBD', N'HLV Thủ môn')
select * from HLV_CLB

-- TRẬN ĐẤU
set identity_insert TRANDAU on
insert into TRANDAU
	(MATRAN, NAM, VONG, NGAYTD, MACLB1, MACLB2, MASAN, KETQUA)
values
	(1, 2009, 1, '07/02/2009', 'BBD', 'SDN', 'GD', '3-0'),
	(2, 2009, 1, '07/02/2009', 'KKH', 'GDT', 'NT', '1-1'),
	(3, 2009, 2, '16/02/2009', 'SDN', 'KKH', 'CL', '2-2'),
	(4, 2009, 2, '16/02/2009', 'TPY', 'BBD', 'TH', '5-0'),
	(5, 2009, 3, '01/03/2009', 'TPY', 'GDT', 'TH', '0-2'),
	(6, 2009, 3, '01/03/2009', 'KKH', 'BBD', 'NT', '0-1'),
	(7, 2009, 4, '07/03/2009', 'KKH', 'TPY', 'NT', '1-0'),
	(8, 2009, 4, '07/03/2009', 'BBD', 'GDT', 'GD', '2-2')
set identity_insert TRANDAU off
select * from TRANDAU

-- BXH
insert into BANGXH
	(MACLB, NAM, VONG, SOTRAN, THANG, HOA, THUA, HIEUSO, DIEM, HANG)
values
	('BBD', 2009, 1, 1, 1, 0, 0 , '3-0', 3, 1),
	('KKH', 2009, 1, 1, 0, 1, 0 , '1-1', 1, 2),
	('GDT', 2009, 1, 1, 0, 1, 0 , '1-1', 1, 3),
	('TPY', 2009, 1, 0, 0, 0, 0 , '0-0', 0, 4),
	('SDN', 2009, 1, 1, 0, 0, 1 , '0-3', 0, 5),
	('TPY', 2009, 2, 1, 1, 0, 1 , '5-0', 3, 1),
	('BBD', 2009, 2, 2, 1, 0 ,1 , '3-5', 3, 2),
	('KKH', 2009, 2, 2, 0, 2 ,0 , '3-3' ,2, 3),
	('GDT', 2009, 2, 1, 0, 1 ,0 , '1-1' ,1, 4),
	('SDN', 2009, 2, 2, 1, 1 ,0 , '2-5' ,1, 5),
	('BBD', 2009, 3, 3, 2, 0 ,1 , '4-5' ,6, 1),
	('GDT', 2009, 3, 2, 1, 1 ,0 , '3-1' ,4, 2),
	('TPY', 2009, 3, 2, 1, 0 ,1 , '5-2' ,3, 3),
	('KKH', 2009, 3, 3, 0, 2 ,1 , '3-4' ,2, 4),
	('SDN', 2009, 3, 2, 1, 1 ,0 , '2-5' ,1, 5),
	('BBD', 2009, 4, 4, 2, 1 ,1 , '6-7' ,7, 1),
	('GDT', 2009, 4, 3, 1, 2 ,0 , '5-1' ,5, 2),
	('KKH', 2009, 4, 4, 1, 2 ,1 , '4-4' ,5, 3),
	('TPY', 2009, 4, 3, 1, 0 ,2 , '5-3' ,3, 4),
	('SDN', 2009, 4, 2, 1, 1 ,0 , '2-5' ,1, 5)
select * from BANGXH

DELETE FROM BANGXH;