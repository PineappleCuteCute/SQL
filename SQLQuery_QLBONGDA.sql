use QLBongDa
go
---a)
select * from CAUTHU
--------------
select MACT, HOTEN, SO, VITRI, NGAYSINH, DIACHI
from CAUTHU
--------------
select *
from CAUTHU
where SO = 7 and VITRI = N'Tiền vệ'
--------------
select TENHLV, NGAYSINH, DIACHI, DIENTHOAI
from HUANLUYENVIEN
--------------
select *
from CAUTHU
where MAQG = 'VN' and MACLB = 'BBD'
--------------
select MACT, HOTEN, DIACHI, VITRI
from CAUTHU
