/*
	Học phần: Cơ sở dữ liệu 
	Bài thực hành: Lab05_QuanLyTour
	SV thực hiện: Nguyễn Lê Bảo Long
	MaSV: 2312678
	Thời gian: 14/3/2025 - 30/3/2025
*/
--------TẠO CƠ SỞ DỮ LIỆU--------
create database Lab05_QuanLyTour
go
use Lab05_QuanLyTour
------TẠO BẢNG QUAN HỆ------
--Tạo bảng Tour
create table Tour
(
	MaTour char(4) primary key,
	TongNgay tinyint not null
)
go

--Tạo bảng thành phố
create table ThanhPho
(
	MaTP char(2) primary key,
	TenTP nvarchar(30) not null,
)
go

--Tạo bảng lịch tour di lịch
create table Lich_TourDL
(
	MaTour char(4) references Tour(MaTour),
	NgayKH datetime not null,
	TenHDV nvarchar(10) not null,
	SoNguoi tinyint not null,
	TenKH nvarchar(30) not null,
	primary key (MaTour, NgayKH, TenHDV)
)
go

--Tạo bảng tour_thành phố
create table Tour_TP
(
	MaTour char(4) references Tour(MaTour),
	MaTP char(2) references ThanhPho(MaTP),
	SoNgay tinyint,
	primary key (MaTour, MaTP)
)
go

----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU-------------
--Thủ tục thêm dữ liệu vào bảng Tour
create proc usp_ThemTour
	@MaTour varchar(4), @TongNgay tinyint
As
	If exists(select * from Tour where MaTour = @MaTour)
		print N'Đã có tour ' + @MaTour + N' trong CSDL!'
	Else
		begin
			insert into Tour values (@MaTour, @TongNgay)
			print N'Thêm tour mới thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemTour---
exec usp_ThemTour 'T001',3
exec usp_ThemTour 'T002',4
exec usp_ThemTour 'T003',5
exec usp_ThemTour 'T004',7

select * from Tour
--drop table Tour

--Thủ tục thêm dữ liệu vào bảng ThanhPho
create proc usp_ThemThanhPho
	@MaTP varchar(2), @TenTP varchar(30)
As
	If exists(select * from ThanhPho where MaTP = @MaTP)
		print N'Đã có thành phố ' + @MaTP + N' trong CSDL!'
	Else
		begin
			insert into ThanhPho values (@MaTP, @TenTP)
			print N'Thêm thành phố mới thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemTour---
exec usp_ThemThanhPho '01',N'Đà Lạt'
exec usp_ThemThanhPho '02',N'Nha Trang'
exec usp_ThemThanhPho '03',N'Phan Thiết'
exec usp_ThemThanhPho '04',N'Huế'
exec usp_ThemThanhPho '05',N'Đà Nẵng'

select * from ThanhPho

--Thủ tục thêm dữ liệu vào bảng Tour_TP
create proc usp_ThemTour_TP
	@MaTour char(4), @MaTP char(2), @SoNgay tinyint
As
	If exists(select * from Tour_TP where MaTP = @MaTP and MaTour = @MaTour)
		print N'Đã có thành phố của tour đi qua' + @MaTour + N' trong CSDL!'
	Else
		begin
			insert into Tour_TP values (@MaTour, @MaTP, @SoNgay)
			print N'Thêm thành phố của tour đi qua thành công.'
		end
go

--Gọi thực hiện thủ tục usp_ThemTour_TP---
exec usp_ThemTour_TP 'T001','01',2
exec usp_ThemTour_TP 'T001','03',1
exec usp_ThemTour_TP 'T002','01',2
exec usp_ThemTour_TP 'T002','02',2
exec usp_ThemTour_TP 'T003','02',2
exec usp_ThemTour_TP 'T003','01',1
exec usp_ThemTour_TP 'T003','04',2
exec usp_ThemTour_TP 'T004','02',2
exec usp_ThemTour_TP 'T004','05',2
exec usp_ThemTour_TP 'T004','04',3

select * from Tour_TP

--Thủ tục thêm dữ liệu vào bảng Lich_TourDL
create proc usp_ThemLich_TourDL
	@MaTour char(4), @NgayKH datetime, @TenHDV nvarchar(10), @SoNguoi tinyint, @TenKH nvarchar(30)
As
	If exists(select * from Lich_TourDL where MaTour = @MaTour)
		Begin
		  If exists(select * from Lich_TourDL where NgayKH = @NgayKH and TenHDV = @TenHDV)
			print N'Đã có lịch khởi hành của ngày ' + @NgayKH + N' trong CSDL!'
	Else
		begin
			insert into Lich_TourDL values (@MaTour, @NgayKH, @TenHDV, @SoNguoi, @TenKH)
			print N'Thêm lịch tour mới thành công.'
		end
	  End
	Else
		print N'Mã tour '+ @MaTour + N' không tồn tại trong CSDL nên không thể thêm thông tin vào mã tour này!'
go
--drop proc usp_ThemLich_TourDL
--Gọi thực hiện thủ tục usp_ThemLich_TourDL---
set dateformat dmy
go
exec usp_ThemLich_TourDL 'T001','14/02/2017',N'Vân',20,N'Nguyễn Hoàng'
exec usp_ThemLich_TourDL 'T002','14/02/2017',N'Nam',30,N'Lê Ngọc'
exec usp_ThemLich_TourDL 'T002','06/03/2017',N'Hùng',20,N'Lý Dũng'
exec usp_ThemLich_TourDL 'T003','18/02/2017',N'Dũng',20,N'Lý Dũng'
exec usp_ThemLich_TourDL 'T004','18/02/2017',N'Hùng',30,N'Dũng Nam'
exec usp_ThemLich_TourDL 'T003','10/03/2017',N'Nam',45,N'Nguyễn An'
exec usp_ThemLich_TourDL 'T002','28/04/2017',N'Vân',25,N'Ngọc Dung'
exec usp_ThemLich_TourDL 'T004','29/04/2017',N'Dũng',35,N'Lê Ngọc'
exec usp_ThemLich_TourDL 'T001','30/04/2017',N'Nam',25,N'Trần Nam'
exec usp_ThemLich_TourDL 'T003','15/06/2017',N'Vân',20,N'Trịnh Bá'

select * from Lich_TourDL
--drop table Lich_TourDL
------Nhập dữ liệu cho bảng quan hệ------
--Nhập bảng Tour
insert into Tour values ('T001',3)
insert into Tour values ('T002',4)
insert into Tour values ('T003',5)
insert into Tour values ('T004',7)

-- Nhập bảng ThanhPho
insert into ThanhPho values ('01',N'Đà Lạt')
insert into ThanhPho values ('02',N'Nha Trang')
insert into ThanhPho values ('03',N'Phan Thiết')
insert into ThanhPho values ('04',N'Huế')
insert into ThanhPho values ('05',N'Đà Nẵng')

-- Nhập bảng Tour_TP
insert into Tour_TP values ('T001','01',2)
insert into Tour_TP values ('T001','03',1)
insert into Tour_TP values ('T002','01',2)
insert into Tour_TP values ('T002','02',2)
insert into Tour_TP values ('T003','02',2)
insert into Tour_TP values ('T003','01',1)
insert into Tour_TP values ('T003','04',2)
insert into Tour_TP values ('T004','02',2)
insert into Tour_TP values ('T004','05',2)
insert into Tour_TP values ('T004','04',3)

--Nhập bảng Lich_TourDL
set dateformat dmy
go

insert into Lich_TourDL values ('T001','14/02/2017',N'Vân',20,N'Nguyễn Hoàng')
insert into Lich_TourDL values ('T002','14/02/2017',N'Nam',30,N'Lê Ngọc')
insert into Lich_TourDL values ('T002','06/03/2017',N'Hùng',20,N'Lý Dũng')
insert into Lich_TourDL values ('T003','18/02/2017',N'Dũng',20,N'Lý Dũng')
insert into Lich_TourDL values ('T004','18/02/2017',N'Hùng',30,N'Dũng Nam')
insert into Lich_TourDL values ('T003','10/03/2017',N'Nam',45,N'Nguyễn An')
insert into Lich_TourDL values ('T002','28/04/2017',N'Vân',25,N'Ngọc Dung')
insert into Lich_TourDL values ('T004','29/04/2017',N'Dũng',35,N'Lê Ngọc')
insert into Lich_TourDL values ('T001','30/04/2017',N'Nam',25,N'Trần Nam')
insert into Lich_TourDL values ('T003','15/06/2017',N'Vân',20,N'Trịnh Bá')
----------------------------------------

-- Xem bảng 
select * from Tour
select * from ThanhPho
select * from Tour_TP
select * from Lich_TourDL

--------------TRUY VẤN------------------
--1. (a)
Select *
From Tour
Where TongNgay >= 3 and TongNgay <= 5

--2. (b)
Select *
From Lich_TourDL 
Where MONTH(NgayKH) = 2 and YEAR(NgayKH) = 2017

--3. (c)
Select*
From Tour_TP tourtp
Where tourtp.MaTour not in (Select tourtp1.MaTour
                           From Tour_TP tourtp1, ThanhPho tp
                           Where tourtp1.MaTP = tp.MaTP and tp.TenTP = N'Nha Trang' )

--4. (d)
Select tourtp.MaTour, COUNT(tp.MaTP) as SoLuongThanhPho
From ThanhPho tp, Tour_TP tourtp
Where tp.MaTP = tourtp.MaTP
Group by tourtp.MaTour

--5. (e)
Select MaTour, COUNT(TenHDV) as SoLuongHDVHuongDan
From Lich_TourDL 
Group by MaTour

--6. (f)
Select tp.TenTP, COUNT(tp.MaTP) as SoLuongTourDiQua
From ThanhPho tp, Tour_TP tourtp
Where tp.MaTP = tourtp.MaTP
Group by TenTP

--7. (g)
Select tourtp.MaTour, COUNT(tp.TenTP) as SoLuongTP
From ThanhPho tp, Tour_TP tourtp
Where tp.MaTP = tourtp.MaTP
Group by tourtp.MaTour 
Having COUNT(tp.TenTP) = (Select COUNT(tp2.TenTP)
						 From ThanhPho tp2)

--8. (h)
Select tourtp.MaTour, tourtp.SoNgay
From ThanhPho tp, Tour_TP tourtp
Where tp.MaTP = tourtp.MaTP and tp.TenTP = N'Đà Lạt'

--9. (i)
Select MaTour,SUM(SoNguoi) as tongsonguoithamgiatour
From Lich_TourDL 
Group by MaTour
Having sum(SoNguoi) >= all( Select sum(SoNguoi)
						    From Lich_TourDL
						    Group by MaTour)

--10. (j)
Select tp.TenTP, COUNT(tourtp.MaTour) as sotour
From Tour_TP tourtp, ThanhPho tp
Where tourtp.MaTP = tp.MaTP 
Group by TenTP
Having COUNT(tourtp.MaTour) = all(Select COUNT(MaTour)
							 From Tour_TP
							 Group by MaTour)