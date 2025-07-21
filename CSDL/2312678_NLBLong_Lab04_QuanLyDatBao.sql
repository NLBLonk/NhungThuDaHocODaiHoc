/*
	Học phần: Cơ sở dữ liệu 
	Bài thực hành: Lab04_QuanLyDatBao
	SV thực hiện: Nguyễn Lê Bảo Long
	MaSV: 2312678
	Thời gian: 11/03/2025 - 30/3/2025
*/
--------------------------------------------------------
--------- TẠO CƠ SỞ DỮ LIỆU
create database Lab04_QuanLyDatBao
go
use Lab04_QuanLyDatBao
------Tạo bảng báo, tạp chí------
Create Table BAO_TCHI
(
	MaBaoTC char(4) primary key,
	Ten nvarchar(30) not null,
	DinhKy nvarchar(30) not null,
	SoLuong int,
	GiaBan int
)
go

------Tạo bảng phát hành------
create table PHATHANH
(
	MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
	SoBaoTC char(5),
	NgayPH datetime,
	primary key (MaBaoTC, SoBaoTC)
)
go

------Tạo bảng khách hàng------
create table KHACHHANG
(
	MaKH char(4) primary key,
	TenKH nvarchar(10),
	DiaChi nvarchar(20)
)
go

------Tạo bảng đặt báo------
create table DATBAO
(
	MaKH char(4) references KHACHHANG(MaKH),
	MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
	SLMua int,
	NgayDM datetime,
	primary key (MaKH, MaBaoTC, NgayDM)
)
go

----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU-------------
--Thủ tục thêm dữ liệu vào bảng BAO_TCHI
create proc usp_ThemBAO_TCHI
	@Mabao_tchi varchar(4), @Ten nvarchar(30), @DinhKy nvarchar(30), @SoLuong int, @GiaBan int
As
	If exists(select * from BAO_TCHI where MaBaoTC = @Mabao_tchi)
		print N'Đã có mã báo chí ' + @Mabao_tchi + N' trong CSDL!'
	Else
		begin
			insert into BAO_TCHI values (@Mabao_tchi, @Ten, @DinhKy, @SoLuong, @GiaBan)
			print N'Thêm báo/tạp chí mới thành công.'
		end
go
--Gọi thực hiện thủ tục usp_ThemBAO_TCHI---
exec usp_ThemBAO_TCHI 'TT01',N'Tuổi trẻ',N'Nhật báo','1000','1500'
exec usp_ThemBAO_TCHI 'KT01',N'Kiến thức ngày nay',N'Bán nguyệt san','3000','6000'
exec usp_ThemBAO_TCHI 'TN01',N'Thanh niên',N'Nhật báo','1000','2000'
exec usp_ThemBAO_TCHI 'PN01',N'Phụ nữ',N'Tuần báo','2000','4000'
exec usp_ThemBAO_TCHI 'PN02',N'Phụ nữ',N'Nhật báo','1000','2000'

select * from BAO_TCHI
--drop proc usp_ThemBAO_TCHI

--Thủ tục thêm dữ liệu vào bảng PHATHANH
create proc usp_ThemPHATHANH
	@Mabao_tchi varchar(4), @SoBaoTC nvarchar(5), @NgayPH datetime
As
	If exists(select * from PHATHANH where MaBaoTC = @Mabao_tchi and SoBaoTC = @SoBaoTC)
			print N'Đã có báo/tạp chí ' + @Mabao_tchi + N' trong CSDL!'
	Else
		begin
			insert into PHATHANH values (@Mabao_tchi, @SoBaoTC, @NgayPH)
			print N'Thêm phát hành mới thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemPHATHANH---
set dateformat dmy
exec usp_ThemPHATHANH 'TT01','123','15/12/2005'
exec usp_ThemPHATHANH 'KT01','70','15/12/2005'
exec usp_ThemPHATHANH 'TT01','124','16/12/2005'
exec usp_ThemPHATHANH 'TN01','256','17/12/2005'
exec usp_ThemPHATHANH 'PN01','45','23/12/2005'
exec usp_ThemPHATHANH 'PN02','111','18/12/2005'
exec usp_ThemPHATHANH 'PN02','112','19/12/2005'
exec usp_ThemPHATHANH 'TT01','125','17/12/2005'
exec usp_ThemPHATHANH 'PN01','46','30/12/2005'

select * from PHATHANH
--drop proc usp_ThemPHATHANH
--drop table PHATHANH

--Thủ tục thêm dữ liệu vào bảng KHACHHANG
create proc usp_ThemKHACHHANG
	@MaKH varchar(4), @TenKH nvarchar(10), @DiaChi nvarchar(20)
As
	If exists(select * from KHACHHANG where MaKH = @MaKH)
		print N'Đã có mã khách hàng ' + @MaKH + N' trong CSDL!'
	Else
		begin
			insert into KHACHHANG values (@MaKH, @TenKH, @DiaChi)
			print N'Thêm khách hàng mới thành công.'
		end
go
--Gọi thực hiện thủ tục usp_ThemKHACHHANG---
exec usp_ThemKHACHHANG 'KH01',N'LAN',N'2 NCT'
exec usp_ThemKHACHHANG 'KH02',N'NAM',N'32 THĐ'
exec usp_ThemKHACHHANG 'KH03',N'NGỌC',N'16 LHP'

select * from KHACHHANG

--Thủ tục thêm dữ liệu vào bảng DATBAO
create proc usp_ThemDATBAO
	@MaKH varchar(4), @MaBaoTC nvarchar(4), @SLMua int, @NgayDM datetime
As
	If exists(select * from DATBAO where MaKH = @MaKH and MaBaoTC = @MaBaoTC and NgayDM = @NgayDM)
		print N'Đã có khách đặt báo ' + @MaKH + N' trong CSDL!'
	Else
		begin
			insert into DATBAO values (@MaKH, @MaBaoTC, @SLMua, @NgayDM)
			print N'Thêm khách đặt báo mới thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemDATBAO---
exec usp_ThemDATBAO 'KH01', 'TT01', 100, '12/01/2000'
exec usp_ThemDATBAO 'KH02', 'TN01', 150, '01/05/2001'
exec usp_ThemDATBAO 'KH01', 'PN01', 200, '25/06/2001'
exec usp_ThemDATBAO 'KH03', 'KT01', 50, '17/03/2002'
exec usp_ThemDATBAO 'KH03', 'PN02', 200, '26/08/2003'
exec usp_ThemDATBAO 'KH02', 'TT01', 250, '15/01/2004'
exec usp_ThemDATBAO 'KH01', 'KT01', 300, '14/10/2004'

select * from DATBAO
--drop proc usp_ThemDATBAO

--------NHẬP DỮ LIỆU VÀO CÁC QUAN HỆ---------
--Nhập bảng BAO_TCHI
insert into BAO_TCHI values ('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
insert into BAO_TCHI values ('KT01',N'Kiến thức ngày nay',N'Báo nguyệt san',3000,6000)
insert into BAO_TCHI values ('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert into BAO_TCHI values ('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert into BAO_TCHI values ('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)

Update BAO_TCHI set DinhKy = N'Bán nguyệt san'
Where MaBaoTC = 'KT01'
-- Nhập bảng PHATHANH
set dateformat dmy
go
insert into PHATHANH values ('TT01','123','15/12/2005')
insert into PHATHANH values ('KT01','70','15/12/2005')
insert into PHATHANH values ('TT01','124','16/12/2005')
insert into PHATHANH values ('TN01','256','17/12/2005')
insert into PHATHANH values ('PN01','45','23/12/2005')
insert into PHATHANH values ('PN02','111','18/12/2005')
insert into PHATHANH values ('PN02','112','19/12/2005')
insert into PHATHANH values ('TT01','125','17/12/2005')
insert into PHATHANH values ('PN01','46','30/12/2005')

--Nhập bảng KHACHHANG
insert into KHACHHANG values ('KH01',N'LAN',N'2 NCT')
insert into KHACHHANG values ('KH02',N'NAM',N'32 THĐ')
insert into KHACHHANG values ('KH03',N'NGỌC',N'16 LHP')

--Nhập bảng DATBAO
set dateformat dmy
go
insert into DATBAO values ('KH01', 'TT01', 100, '12/01/2000')
insert into DATBAO values ('KH02', 'TN01', 150, '01/05/2001')
insert into DATBAO values ('KH01', 'PN01', 200, '25/06/2001')
insert into DATBAO values ('KH03', 'KT01', 50, '17/03/2002')
insert into DATBAO values ('KH03', 'PN02', 200, '26/08/2003')
insert into DATBAO values ('KH02', 'TT01', 250, '15/01/2004')
insert into DATBAO values ('KH01', 'KT01', 300, '14/10/2004')
----------------------------------------

--Xem các bảng
select * from BAO_TCHI
select * from PHATHANH
select * from KHACHHANG
select * from DATBAO

--------------Truy vấn---------------
--1.
Select MaBaoTC, Ten, GiaBan
From Bao_Tchi
Where DinhKy = N'Tuần báo'
--2.
Select MaBaoTC, Ten, DinhKy, SoLuong, GiaBan
From Bao_Tchi
Where Left(MaBaoTC, 2) = 'PN'
--3.
Select Distinct TenKH as [Tên khách hàng có đặt mua báo phụ nữ]
From KhachHang KH, DatBao DB
Where KH.MaKH = DB.MaKH and MaBaoTC like 'PN%'
--4.
Select	TenKH
From	KhachHang KH, DatBao DB
Where	KH.MaKH = DB.MaKH and MaBaoTC = 'KH01' and MaBaoTC = 'PN02'
--5.
Select TenKH as [Tên các khách hàng không đặt mua báo thanh niên]
From Bao_Tchi BT, DatBao DB, KhachHang KH
Where DB.MaKH = KH.MaKH 
Group By TenKH
Having KH.TenKH Not In ( Select TenKH
					    From KhachHang KH2, DatBao DB2
					    Where KH2.MaKH = DB2.MaKH and MaBaoTC like 'TN%') 
--6.
Select KH.MaKH, TenKH, Count(SLMua) as [Số tờ báo đã đặt]
From KhachHang KH, DatBao DB
Where KH.MaKH = DB.MaKH 
Group By KH.MaKH, TenKH
--7.
Select Count(MaKH) as SoKhachHang
From DatBao 
Where Year(NgayDM) = 2004
--8.
Select KH.TenKH, Ten, DinhKy, SLMua, Sum(SLMua*GiaBan) as SoTien
From KhachHang KH, Bao_Tchi BT, DatBao DB
Where KH.MaKH = DB.MaKH and DB.MaBaoTC = BT.MaBaoTC
Group By KH.TenKH, Ten, DinhKy, SLMua
--9.
Select Ten, DinhKy, Sum(SLMua) As TongSoLuongDatMua
From Bao_Tchi BT, DatBao DB
Where BT.MaBaoTC = DB.MaBaoTC 
Group By Ten, DinhKy
--10.
Select Ten
From Bao_Tchi
Where MaBaoTC Like 'HS%'
--11.
Select *
From Bao_Tchi
Where MaBaoTC Not In (Select BT.MaBaoTC
					  From Bao_Tchi BT, DatBao DB
					  Where BT.MaBaoTC = DB.MaBaoTC
					  Group By BT.MaBaoTC)

SELECT Bao_Tchi.Ten, Bao_Tchi.DinhKy, COUNT(DatBao.MaKH) AS SoNguoiDatMua
FROM Bao_Tchi
LEFT JOIN DatBao ON Bao_Tchi.MaBaoTC = DatBao.MaBaoTC
GROUP BY Bao_Tchi.Ten, Bao_Tchi.DinhKy
ORDER BY COUNT(DatBao.MaKH) DESC;
--12.
Select Ten, DinhKy
From Bao_Tchi BT, DatBao DB
Where BT.MaBaoTC = DB.MaBaoTC
Group By Ten, DinhKy
Having Count(MaKH) >= All (Select Count(DB2.MaKH)
						   From Bao_Tchi BT2, DatBao DB2
						   Where BT2.MaBaoTC = DB2.MaBaoTC
						   Group By BT2.MaBaoTC)
--13.
Select KH.MaKH, KH.TenKH, Sum(SLMua) as SoLuongMua
From KhachHang KH, Bao_Tchi BT, DatBao DB
Where KH.MaKH = DB.MaKH and DB.MaBaoTC = BT.MaBaoTC
Group By KH.MaKH, KH.TenKH
Having Sum(DB.SLMua) >= All (Select Sum(SLMua)
						   From	KhachHang KH2, DatBao DB2
						   Where KH2.MaKH = DB2.MaKH
						   Group By KH2.MaKH)

SELECT TOP 1 KhachHang.MaKH, KhachHang.TenKH, COUNT(DatBao.MaBaoTC) AS SoLuongDatMua
FROM KhachHang
JOIN DatBao ON KhachHang.MaKH = DatBao.MaKH
GROUP BY KhachHang.MaKH, KhachHang.TenKH
ORDER BY COUNT(DatBao.MaBaoTC) DESC;
--14.
SELECT 
    DISTINCT Bao_Tchi.MaBaoTC,
    Bao_Tchi.Ten,
    Bao_Tchi.DinhKy
FROM 
    Bao_Tchi
INNER JOIN 
    PHATHANH ON Bao_Tchi.MaBaoTC = PHATHANH.MaBaoTC
WHERE 
    MONTH(PHATHANH.NgayPH) IN (2, 8)
GROUP BY 
    Bao_Tchi.MaBaoTC, Bao_Tchi.Ten, Bao_Tchi.DinhKy
HAVING 
    COUNT(*) = 2;


--15.
Select BT.MaBaoTC, Ten, Count(DB.MaKH) as SoKhachHangMua
From Bao_Tchi BT, DatBao DB
Where BT.MaBaoTC = DB.MaBaoTC
Group By BT.MaBaoTC, Ten
Having Count(DB.MaKH) >= 3

---------Hàm & Thủ tục----------
----A.Viết các hàm:
--a.
Go
Create Function TinhTongTienKhachHang (@MaKH char(5))
Returns int
As
Begin
    Return (
        Select sum(DATBAO.SLMua * BAO_TCHI.GiaBan) 
        From DATBAO 
        Join BAO_TCHI on DATBAO.MaBaoTC = BAO_TCHI.MaBaoTC 
        Where DATBAO.MaKH = @MaKH
    );
End;
Go
--Gọi sử dụng hàm
-- Tính tổng tiền của khách hàng KH01
Select dbo.TinhTongTienKhachHang('KH01') as [Tổng số tiền];
Print N'Tổng số tiền của khách hàng KH01 là: ' + convert(varchar(10), dbo.TinhTongTienKhachHang('KH01'));

--b.
Go
Create Function TinhTongTienBao (@MaBaoTC char(5))
Returns int
As
Begin
    Return (
        Select sum(DATBAO.SLMua * BAO_TCHI.GiaBan)
        From DATBAO
        Join BAO_TCHI on DATBAO.MaBaoTC = BAO_TCHI.MaBaoTC
        WHERE DATBAO.MaBaoTC = @MaBaoTC
    );
End;
Go

--Gọi sử dụng hàm
-- Tính tổng tiền thu được từ tờ báo TT01
Select dbo.TinhTongTienBao('TT01') AS [Tổng số tiền];
Print N'Tổng số tiền thu được từ tờ báo TT01 là: ' + convert(varchar(10), dbo.TinhTongTienBao('TT01'));

----B. Viết các thủ tục:
--a.
Go
Create Procedure InDanhMucBaoCuaKhachHang (@MaKH char(5))
As
Begin
    Select BAO_TCHI.Ten, DATBAO.SLMua
    From BAO_TCHI
    Join DATBAO on BAO_TCHI.MaBaoTC = DATBAO.MaBaoTC
    Where DATBAO.MaKH = @MaKH;
End;
Go
--Gọi sử dụng thủ tục
-- Gọi thủ tục và hiển thị kết quả
Exec InDanhMucBaoCuaKhachHang 'KH01';
Print N'Danh mục báo, tạp chí của khách hàng KH01 đã được in bên dưới.';

--b.
Go
Create Procedure InDanhSachKhachHangCuaBao (@MaBaoTC char(5))
As
Begin
    Select KHACHHANG.TenKH, KHACHHANG.DiaChi
    From KHACHHANG
    Join DATBAO on KHACHHANG.MaKH = DATBAO.MaKH
    Where DATBAO.MaBaoTC = @MaBaoTC;
End;
Go
--Gọi sử dụng thủ tục
-- Gọi thủ tục và hiển thị kết quả
Exec InDanhSachKhachHangCuaBao 'TT01';
Print N'Danh sách khách hàng đặt mua báo TT01 đã được in bên dưới.';