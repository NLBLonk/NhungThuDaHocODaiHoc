--Học phần: Cơ sở dữ liệu
--Lớp: CTK47A
--Lab03: Quản lý nhập xuất hàng hóa
--Sinh viên thực hiện: Nguyễn Lê Bảo Long
--Mã sinh: 2312678
--Thời gian: 19/03/2025 - 30/3/2025

---------------------KHAI BÁO CẤU TRÚC CƠ SỞ DỮ LIỆU----------
create database Lab03_QuanLyNhapXuatHangHoa
go

use Lab03_QuanLyNhapXuatHangHoa
go 

create table HANGHOA(
MAHH char(5) primary key,
TENHH nvarchar(30) not null,
DVT nchar(3) not null,
SOLUONGTON int not null)
go 

create table DOITAC(
MADT char(5) primary key,
TENDT nvarchar(20) not null,
DIACHI nvarchar(50) not null,
DIENTHOAI char(15) not null
)
go 
create table KHANANGCC(
MADT char(5) references DOITAC(MADT),
MAHH char(5) references HANGHOA(MAHH)
primary key(MADT,MAHH)
)
go

create table HOADON(
SOHD char(5) primary key,
NGAYLAPHD date not null,
MADT char(5) references DOITAC(MADT),
TONGTG char(5)
)
go

create table CT_HOADON(
SOHD char(5) references HOADON(SOHD),
MAHH char(5) references HANGHOA(MAHH),
DONGIA int not null,
SOLUONG int not null

)
go

------tùy chỉnh bảng------
alter table HANGHOA
add unique(TENHH)
go

alter table DOITAC
add unique (TENDT,DIACHI)
go

alter table HOADON
add unique (SOHD)
go

------insert information---------

insert into HANGHOA values('CPU01','CPU INTEL,CELERON 600 BOX','CÁI',5)
Insert into HANGHOA values('CPU02','CPU INTEL,PIII 700','CÁI',10)
Insert into HANGHOA values('CPU03','CPU AMD K7 ATHL,ON 600','CÁI',8)
Insert into HANGHOA values('HDD01','HDD 10.2 GB QUANTUM','CÁI',10)
Insert into HANGHOA values('HDD02','HDD 13.6 GB SEAGATE','CÁI',15)
Insert into HANGHOA values('HDD03','HDD 20 GB QUANTUM','CÁI',6)
Insert into HANGHOA values('KB01','KB GENISU','CÁI',12)
Insert into HANGHOA values('KB02','KB MITSUMIMI','CÁI',5)
Insert into HANGHOA values('MB01','GIAGBYTE CHIPSET INTEL','CÁI',10)
Insert into HANGHOA values('MB02','ACORP BX CHIPSET VIA','CÁI',10)
Insert into HANGHOA values('MB03','ITEL PHI CHIPSET INTEL','CÁI',10)
Insert into HANGHOA values('MB04','ECS CHIPSET SIS','CÁI',10)
Insert into HANGHOA values('MB05','ECS CHIPSET VIA','CÁI',10)
Insert into HANGHOA values('MNT01','SAMSUNG 14" SYNCMASTER','CÁI',5)
Insert into HANGHOA values('MNT02','LG14"','CÁI',5)
Insert into HANGHOA values('MNT03','ACER 14"','CÁI',8)
Insert into HANGHOA values('MNT04','PHILIPS 14"','CÁI',6)
Insert into HANGHOA values('MNT05','VIEWSONIC 14"','CÁI',7)
SELECT * FROM HANGHOA

go

Insert into DOITAC values('CC001', N'Cty TNC',N'176 BTX Q1-TPHCM','08.8250259')  
Insert into DOITAC values('CC002', N'Cty Hoàng Long',N'15A TTT Q1-TP.HCM','08.8250898') 
Insert into DOITAC values('CC003', N'Cty Hợp Nhất',N'152 BTX Q1-TP.HCM','08.8252376') 
Insert into DOITAC values('K0001', N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.DL','063.831129') 
Insert into DOITAC values('K0002', N'Như Quỳnh',N'21 Điện Biên Phủ.N.Trang','058590270')
Insert into DOITAC values('K0003', N'Trần Nhật Duật',N'Lê Lợi TP.Huế','054.848376')
Insert into DOITAC values('K0004', N'Phan Nguyễn Hùng Anh',N'11 Nam Kì Khởi Nghĩa-Tp.Đà Lạt','063.823409')
SELECT * FROM KHANANGCC
go

set dateformat dmy
insert into HOADON values('N0001','25/01/2006','CC001',null )
insert into HOADON values('N0002','01/05/2006','CC002',null )
insert into HOADON values('X0001','12/05/2006','K0001',null )
insert into HOADON values('X0002','16/06/2006','K0002',null )
insert into HOADON values('X0003','20/04/2006','K0001',null )
go

insert into KHANANGCC VALUES('CC001','CPU01')
insert into KHANANGCC VALUES('CC001','HDD03')
insert into KHANANGCC VALUES('CC001','KB01')
insert into KHANANGCC VALUES('CC001','MB02')
insert into KHANANGCC VALUES('CC001','MB04')
insert into KHANANGCC VALUES('CC001','MNT01')
insert into KHANANGCC VALUES('CC002','CPU01')
insert into KHANANGCC VALUES('CC002','CPU02')
insert into KHANANGCC VALUES('CC002','CPU03')
insert into KHANANGCC VALUES('CC002','KB02')
insert into KHANANGCC VALUES('CC002','MB01')
insert into KHANANGCC VALUES('CC002','MB05')
insert into KHANANGCC VALUES('CC002','MNT03')
insert into KHANANGCC VALUES('CC003','HDD01')
insert into KHANANGCC VALUES('CC003','HDD02')
insert into KHANANGCC VALUES('CC003','HDD03')
insert into KHANANGCC VALUES('CC003','MB03')
go 

insert into CT_HOADON values('N0001','CPU01',63,10)
insert into CT_HOADON values('N0001','HDD03',97,7)
insert into CT_HOADON values('N0001','KB01',3,5)
insert into CT_HOADON values('N0001','MB02',57,5)
insert into CT_HOADON values('N0001','MNT01',112,3)
insert into CT_HOADON values('N0002','CPU02',115,3)
insert into CT_HOADON values('N0002','KB02',5,7)
insert into CT_HOADON values('N0002','MNT03',111,5)
insert into CT_HOADON values('X0001','CPU01',67,2)
insert into CT_HOADON values('X0001','HDD03',100,2)
insert into CT_HOADON values('X0001','KB01',5,2)
insert into CT_HOADON values('X0001','MB02',62,1)
insert into CT_HOADON values('X0002','CPU01',67,1)
insert into CT_HOADON values('X0002','KB02',7,3)
insert into CT_HOADON values('X0002','MNT01',115,2)
insert into CT_HOADON values('X0003','CPU01',67,1)
insert into CT_HOADON values('X0003','MNT03',115,2)
go
select * from CT_HOADON

-----Truy Vẫn Dữ Liệu-------
--1.
Select * from HANGHOA
Select *
From HANGHOA
Where MAHH like '%HDD%'

--2.

Select *
From HANGHOA
Where SOLUONGTON >=10

--3.

Select *
From DOITAC
Where DIACHI like '%HCM'

--4.

Select HD.SOHD, HD.NGAYLAPHD, DT.TENDT, DIACHI, DIENTHOAI, SOLUONG
From DOITAC DT, HOADON HD, CT_HOADON CTHD
Where DT.MADT=HD.MADT
	  and CTHD.SOHD=HD.SOHD
	  and month(NGAYLAPHD) like '5'
	  and year(NGAYLAPHD) like '2006'
	  and CTHD.SOHD like 'N%'

--5.

Select distinct DT.*
From DOITAC DT, KHANANGCC KN, HANGHOA HH
Where KN.MAHH= HH.MAHH
	  and DT.MADT=KN.MADT
	  and HH.MAHH like 'HDD%'

--6.

Select DT.TENDT
From DOITAC DT, KHANANGCC KN
Where DT.MADT=KN.MADT
	  and KN.MAHH like 'HDD%'
Group by DT.MADT,DT.TENDT	  
Having count(distinct KN.MAHH) = (Select count(*)
								  From HANGHOA 
								  Where MAHH like 'HDD%')
	
--7.

Select DOITAC.TENDT
From DOITAC, KHANANGCC
Where DOITAC.MADT=KHANANGCC.MADT
Group by KHANANGCC.MADT, DOITAC.TENDT
Having KHANANGCC.MADT not in (Select MADT
						      From KHANANGCC
							  Where MAHH like 'HDD%')

--8. 

Select *
From HANGHOA
Where MAHH not in (Select KHANANGCC.MAHH From HANGHOA, KHANANGCC)

--9.

Select TENHH, sum(SOLUONG) as [TongSoLuongBanCuaMatHangBanChayNhat]
From HANGHOA, CT_HOADON
Where HANGHOA.MAHH = CT_HOADON.MAHH
     and CT_HOADON.SOHD like 'X%'
Group by CT_HOADON.MAHH, TENHH
Having sum(SOLUONG) = (Select top 1 sum(SOLUONG)
					    From CT_HOADON
						Where SOHD like 'X%'
					    Group by MAHH
						Order by sum(SOLUONG) DESC)

--10.

Select A.MAHH, A.TENHH, sum(SOLUONG) as [TongSoLuongBanCuaMatHangNhapVeItNhat]
From HANGHOA A, CT_HOADON B
Where B.SOHD like 'N0%' and A.MAHH=B.MAHH
Group by A.MAHH, A.TENHH 
Having sum(SOLUONG) = (Select min(TongSoLuongNhap) 
					   From(Select sum(SOLUONG) as TongSoLuongNhap 
							From  CT_HOADON 
							Where SOHD like 'N0%' group by MAHH) as A )

--11.

Select top 1 SOHD, count(MAHH)
From CT_HOADON
Group by SOHD
Order by count(MAHH) desc

--12.

Select TENHH  
From HANGHOA A, CT_HOADON B
Where A.MAHH=B.MAHH 
	and SOHD like 'N0%' 
	and A.MAHH not in (
			Select B.MAHH 
			From HOADON A, CT_HOADON B 
			Where A.SOHD=B.SOHD and month(NGAYLAPHD)=1 
			Group by B.MAHH)
		
--13.

Select TENHH  
From HANGHOA A, CT_HOADON B
Where A.MAHH=B.MAHH 
	and SOHD like 'X0%' 
	and A.MAHH not in (
			Select B.MAHH 
			From HOADON A, CT_HOADON B 
			Where A.SOHD=B.SOHD and month(NGAYLAPHD)=6
			Group by B.MAHH )
	
--14.

Select count(MAHH) as [SoMatHangMaCuaHangBanDuoc] 
From CT_HOADON
Where SOHD like 'X0%'

--15.

Select TENDT, count(MAHH) as SoMatHang
From KHANANGCC, DOITAC 
Where KHANANGCC.MADT= DOITAC.MADT
Group by TENDT, KHANANGCC.MADT

--16.

Select top 1  TENDT, sum(SOLUONG*DONGIA) as GiaoDich
From DOITAC A,HOADON B, CT_HOADON C
Where A.MADT=B.MADT and B.SOHD=C.SOHD
Group by TENDT
Order by GiaoDich desc

--17.

Select sum(DONGIA*SOLUONG) as DoanhThu
From HOADON A, CT_HOADON B
Where A.SOHD= B.SOHD
	 and B.SOHD like 'X0%'

--18. 

Select top 1 TENHH, sum(SOLUONG)
From CT_HOADON B, HANGHOA A
Where A.MAHH= B.MAHH
and SOHD like 'X0%'
Group by TENHH, B.MAHH
Order by sum(SOLUONG) desc  

--19. 

Select hh.MAHH,hh.TENHH,hh.DVT,
		ct.SOLUONG + hh.SOLUONGTON as tong_so_luong,
		(ct.SOLUONG + hh.SOLUONGTON)*ct.DONGIA as thanh_tien
From HANGHOA HH,CT_HOADON CT,HOADON hd
Where HH.MAHH=ct.MAHH and hd.SOHD=ct.SOHD  
		and  MONTH(hd.NGAYLAPHD) = 5 
		AND YEAR(hd.NGAYLAPHD) = 2006


--20. 

Select * 
From HANGHOA
Where MAHH in (select top 1 A.MAHH
			   From CT_HOADON B, HANGHOA A
			   Where A.MAHH= B.MAHH
			   and SOHD like 'X0%'
				Group by A.MAHH
				Order by sum(SOLUONG) desc) 

--21. 

Update HOADON
Set TONGTG = (Select SUM(DONGIA * SOLUONG) 
              From CT_HOADON 
              Where CT_HOADON.SOHD = HOADON.SOHD);

select * from HOADON

------ Hàm & Thủ tục---------

--A Các hàm
--a)
Create or alter function func_SoLuongMatHangNhap(@NGAYBD datetime, @NGAYKT datetime, @MAHH varchar(5))
returns int
As
begin
    declare @SOLUONG int
	select @SOLUONG=sum(SOLUONG)
	from HOADON a, CT_HOADON b
	where a.SOHD=b.SOHD AND @MAHH = MAHH AND NGAYLAPHD between @NGAYBD AND @NGAYKT AND b.SOHD like 'N%'
	return @SOLUONG
END;
go
set dateformat dmy;
select dbo.func_SoLuongMatHangNhap('25/01/2006','26/01/2006','MNT01') as SoLuongNhap
go

--b) 
Create or alter function func_SoLuongMatHangXuat( @NGAYBD datetime, @NGAYKT datetime,@MAHH varchar(5))
returns int
As
begin
    declare @SOLUONG int
	select @SOLUONG=sum(SOLUONG)
	from HOADON a, CT_HOADON b
	where a.SOHD=b.SOHD AND @MAHH = MAHH AND NGAYLAPHD between @NGAYBD AND @NGAYKT AND b.SOHD like 'X%'
	return @SOLUONG
END;
go
set dateformat dmy;
select dbo.func_SoLuongMatHangXuat('20/04/2006', '16/06/2006', 'CPU01') as SoLuongXuat
go

--c)
Create function fn_TongDoanhThu(@month int, @year int) returns int
As
Begin
	declare @TongDoanhThu int
		Begin
		
		select @TongDoanhThu = sum(DONGIA*SOLUONG)
		from	HOADON A, CT_HOADON B
		where A.SOHD = B.SOHD and MONTH(A.NGAYLAPHD) = @month and YEAR(A.NGAYLAPHD) = @year
		End	
	 	
return @TongDoanhThu
End;
go
set dateformat dmy
select dbo.fn_TongDoanhThu(01, 2006) as TongDoanhThu
go

--d).
Create or alter function func_TongDoanhThu_TheoMatHang(@NGAYBD datetime, @NGAYKT datetime,@MAHH varchar(5))
returns int
as
begin
	declare @TongDoanhThu int
	select @TongDoanhThu = sum(DONGIA*SOLUONG)
	from CT_HOADON a, HOADON b
	where a.SOHD=b.SOHD AND a.SOHD like 'X%' AND NGAYLAPHD between @NGAYBD AND @NGAYKT AND @MAHH=MAHH
	return @TongDoanhThu
END;
go 
set dateformat dmy;
select dbo.func_TongDoanhThu_TheoMatHang('12/05/2006','16/06/2006','CPU01') as TongDoanhThuCuaMatHang
go

--e)
Create function fn_TongSoTienNhapHang(@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongSoTien int
		Begin
		
		select @TongSoTien = sum(DONGIA*SOLUONG)
		from  HOADON A, CT_HOADON B
		where B.SOHD Like 'N%'and NGAYLAPHD between @bd and @kt
		End	
	 	
return @TongSoTien
End;
go
set dateformat dmy
print dbo.fn_TongSoTienNhapHang('25/01/2006', '01/05/2006')
go

--f)
Create or alter FUNCTIOn func_TongTien_HoaDon(@SOHD char(5))
returns int
as
begin
	declare @TongTien int
	select @TongTien = sum(DONGIA*SOLUONG)
	from CT_HOADON 
	where @SOHD=SOHD 
	return @TongTien
END;
go 
select dbo.func_TongTien_HoaDon('N0002') as TongTienNhap
go


--B: Thu tuc
--a).
Create or Alter proc usp_CapNhatSoLuongTon
@SoLuongTon tinyint, @ThaoTac char(1), @MAHH varchar(5)
As
	Begin
	if @ThaoTac='N'
		Begin
		Update HANGHOA
		set SoLuongTon=@SoLuongTon+SoLuongTon
		where @MAHH=MAHH
		END
	else
		if exists(Select * From HangHoa Where @SoLuongTon  > SoLuongTon)
		print N'Không đủ hàng tồn có mã '+ @MaHH
		else
			Begin
			Update HANGHOA
			set SoLuongTon=SoLuongTon-@SoLuongTon
			where @MAHH=MAHH
			print N'Cập nhật thành công hàng tồn'
			 
			End
	END
go

Exec usp_CapNhatSoLuongTon 3,'X','CPU01'
select * from HANGHOA
go

--b).
Create or alter proc usp_CapNhatTongTG
@SOLUONG tinyint, @DONGiA int, @SOHD char(5), @MAHH varchar(5)
as
	begin
	    declare @TONGTG int
		Update CT_HOADON
		set SOLUONG=@SOLUONG
		where @SOHD=SOHD AND @MAHH=MAHH

		Update CT_HOADON
		set DONGIA =@DONGIA
		where @SOHD=SOHD AND @MAHH=MAHH

		select @TONGTG=(DONGIA * SOLUONG)
		from HOADON a, CT_HOADON b
		where a.SOHD=b.SOHD AND @SOHD=b.SOHD
		
		Update HOADON
		set TONGTG=@TONGTG
		where @SOHD=SOHD
	END
go
Exec usp_CapNhatTongTG 13,50,'N0001','CPU01'
select * from HOADON
go

--c).
Create Proc usp_InHoaDon 
@SOHD char(5)
As
If exists (Select * from HOADON where SOHD=@SOHD)
	Select * 
	From HOADON a, CT_HOADON b 
	Where b.SOHD = @SOHD AND a.SOHD=b.SOHD
Else 
	print N'Không có hóa đơn ' + @SOHD +' trong CSDL.'
Go
Exec usp_InHoaDon 'N0001'