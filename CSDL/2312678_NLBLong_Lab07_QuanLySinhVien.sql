/* 
	Học phần: Cơ sở dữ liệu 
	Bài thực hành: Lab07_QuanLySinhVien
	SV thực hiện: Nguyễn Lê Bảo Long
	MaSV: 2312678
	Thời gian: 18/03/2025 - 30/3/2025
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab07_QuanLySinhVien
go
use Lab07_QuanLySinhVien
go

-- Tạo bảng tỉnh
create table Tinh
(
	MSTinh	char(2) primary key,
	TenTinh	nvarchar(25) not null,
)
go

-- Tạo bảng khoa
create table Khoa
(
	MSKhoa	char(2) primary key,
	TenKhoa	nvarchar(30) not null,
	TenTat	varchar(5)
)
go

-- Tạo bảng lớp
create table Lop
(
	MSLop		char(4) primary key,
	TenLop		nvarchar(25) not null,
	MSKhoa		char(2) references Khoa(MSKhoa),
	NienKhoa	datetime
)
go

-- Tạo bảng sinh viên
create table SinhVien
(
	MSSV		char(7) primary key,
	Ho			nvarchar(30) not null,
	Ten			nvarchar(10) not null,
	NgaySinh	datetime,
	MSTinh		char(2) references Tinh(MSTinh),
	NgayNhapHoc	datetime not null,
	MSLop		char(4) references Lop(MSLop),
	Phai		varchar(3),
	DiaChi		nvarchar(50),
	DienThoai	varchar(10) 
)
go

-- Tạo bảng môn học
create table MonHoc
(
	MSMH	char(4) primary key,
	TenMH	nvarchar(30) not null,
	HeSo	real,
)
go

-- Tạo bảng bảng điểm
create table BangDiem
(
	MSSV	char(7) references SinhVien(MSSV),
	MSMH	char(4) references MonHoc(MSMH),
	LanThi	tinyint,
	Diem	real,
	primary key	(MSSV, MSMH, LanThi)
)
go

-- NHẬP BẢNG
-- Nhập bảng Tinh
insert into Tinh values ('01', N'An Giang')
insert into Tinh values ('02', N'TPHCM')
insert into Tinh values ('03', N'Dong Nai')
insert into Tinh values ('04', N'Long An')
insert into Tinh values ('05', N'Hue')
insert into Tinh values ('06', N'Cà Mau')

-- Nhập bảng Khoa
insert into Khoa values ('01', N'Công nghệ thông tin','CNTT')
insert into Khoa values ('02', N'Điện tử viễn thông','DTVT')
insert into Khoa values ('03', N'Quản trị kinh doanh','QTKD')
insert into Khoa values ('04', N'Công nghệ sinh học','CNSN')

-- Nhập bảng Lop
set dateformat ydm
go
insert into Lop values ('98TH', N'Tin hoc khoa 1998', '01', '1998')
insert into Lop values ('98VT', N'Vien thong khoa 1998', '02', '1998')
insert into Lop values ('99TH', N'Tin hoc khoa 1999', '01', '1999')
insert into Lop values ('99VT', N'Vien thong khoa 1999', '02', '1999')
insert into Lop values ('99QT', N'Quan tri khoa 1999', '03', '1999')

-- Nhập bảng SinhVien
set dateformat dmy
go
insert into SinhVien values ('98TH001',N'Nguyen Van',N'An','06/08/80','01','03/09/98','98TH','Yes',N'12 Tran Hung Dao,Q.1','8234512')
insert into SinhVien values ('98TH002',N'Le Thi',N'An','17/10/79','01','03/09/98','98TH','No',N'23 CMT8, Q. Tan Binh','0303234342')
insert into SinhVien values ('98VT001',N'Nguyen Duc',N'Binh','25/11/81','02','03/09/98','98VT','Yes',N'245 Lac Long Quan,Q.11','8654323')
insert into SinhVien values ('98VT002',N'Tran Ngoc',N'Anh','19/08/80','02','03/09/98','98VT','No',N'242 Tran Hung Dao,Q.1',' ')
insert into SinhVien values ('99TH001',N'Ly Van Hung',N'Dung','27/09/81','03','05/10/99','99TH','Yes',N'178 CMT8, Q. Tan Binh','7563213')
insert into SinhVien values ('99TH002',N'Van Minh',N'Hoang','01/01/81','04','05/10/99','99TH','Yes',N'272 Ly Thuong Kiet, Q.10','8341234')
insert into SinhVien values ('99TH003',N'Nguyen',N'Tuan','12/01/80','03','05/10/99','99TH','Yes',N'162 Tran Hung Dao, Q.5',' ')
insert into SinhVien values ('99TH004',N'Tran Van',N'Minh','25/06/81','04','05/10/99','99TH','Yes',N'147 Dien Bien Phu, Q.3','7236754')
insert into SinhVien values ('99TH005',N'Nguyen Thai',N'Minh','01/01/80','04','05/10/99','99TH','Yes',N'345 Le Dai Hanh, Q.11',' ')
insert into SinhVien values ('99VT001',N'Le Ngoc',N'Mai','21/06/82','01','05/10/99','99VT','No',N'129 Tran Hung Dao, Q.1','0903124534')
insert into SinhVien values ('99QT001',N'Nguyen Thi',N'Oanh','19/08/73','04','05/10/99','99QT','No',N'76 Hung Vuong, Q.5','0901656324')
insert into SinhVien values ('99QT002',N'Le My',N'Hanh','20/05/76','04','05/10/99','99QT','No',N'12 Pham Ngoc Thach, Q.3',' ')

-- Nhập bảng MonHoc
insert into MonHoc values ('TA01', N'Nhap mon tin hoc',2)
insert into MonHoc values ('TA02', N'Lap trinh cơ ban',3)
insert into MonHoc values ('TB01', N'Cau truc du lieu',2)
insert into MonHoc values ('TB02', N'Co so du lieu',2)
insert into MonHoc values ('QA01', N'Kinh te vi mo',2)
insert into MonHoc values ('QA02', N'Quan tri chat luong',3)
insert into MonHoc values ('VA01', N'Dien tu co ban',2)
insert into MonHoc values ('VA02', N'Mach so',3)
insert into MonHoc values ('VB01', N'Truyen so lieu',3)
insert into MonHoc values ('VB02', N'Vat ly dai cuong',2)

-- Nhập bảng BangDiem
insert into BangDiem values ('98TH001','TA01',1,8.5)
insert into BangDiem values ('98TH001','TA02',1,8)
insert into BangDiem values ('98TH002','TA01',1,4)
insert into BangDiem values ('98TH002','TA01',2,5.5)
insert into BangDiem values ('98TH001','TB01',1,7.5)
insert into BangDiem values ('98TH002','TB01',1,8)
insert into BangDiem values ('98VT001','VA01',1,4)
insert into BangDiem values ('98VT001','VA01',2,5)
insert into BangDiem values ('98VT002','VA02',1,7.5)
insert into BangDiem values ('99TH001','TA01',1,4)
insert into BangDiem values ('99TH001','TA01',2,6)
insert into BangDiem values ('99TH001','TB01',1,6.5)
insert into BangDiem values ('99TH002','TB01',1,10)
insert into BangDiem values ('99TH002','TB02',1,9)
insert into BangDiem values ('99TH003','TA02',1,7.5)
insert into BangDiem values ('99TH003','TB01',1,3)
insert into BangDiem values ('99TH003','TB01',2,6)
insert into BangDiem values ('99TH003','TB02',1,8)
insert into BangDiem values ('99TH004','TB02',1,2)
insert into BangDiem values ('99TH004','TB02',2,4)
insert into BangDiem values ('99TH004','TB02',3,3)
insert into BangDiem values ('99QT001','QA01',1,7)
insert into BangDiem values ('99QT001','QA02',1,6.5)
insert into BangDiem values ('99QT002','QA01',1,8.5)
insert into BangDiem values ('99QT002','QA02',1,9)

-- Xem bảng dữ liệu
select * from Tinh
select * from Khoa
select * from Lop
select * from SinhVien
select * from MonHoc
select * from BangDiem

----------------TRUY VẤN DỮ LIỆU-------------
--1. 
Select	MSSV, Ho, Ten, DiaChi
From	SinhVien

--2.
Select		MSSV, Ho, Ten, MSTinh
From		SinhVien
Order by	MSTinh, Ho, ten asc

--3.
Select	MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien sv, Tinh t
Where	sv.MSTinh = t. MSTinh and Phai = 'No' and TenTinh = N'Long An'

--4.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, NgaySinh
From	SinhVien
Where	MONTH(NgaySinh) = 1

--5.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, NgaySinh
From	SinhVien
Where	DAY(NgaySinh) = 1 and MONTH(NgaySinh) = 1

--6.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DienThoai
From	SinhVien
Where	DienThoai != ' '

--7.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DienThoai
From	SinhVien
Where	LEN(DienThoai) = 10

--8.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, MSLop
From	SinhVien
Where	Ten = N'Minh' and MSLop = N'99TH'

--9.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DiaChi
From	SinhVien
Where	SUBSTRING(DiaChi, 5, 13) = N'Tran Hung Dao' or SUBSTRING(DiaChi, 4, 13) = N'Tran Hung Dao'

--10.
Select	MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien
Where	RIGHT(Ho, 3) = N'Van'

--11.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv, Tinh t
Where	sv.MSTinh = t. MSTinh and TenTinh = N'Long An'

--12.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv
Where	Phai = 'Yes' and DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) between 23 and 28

--13.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv
Where	(Phai = 'Yes' and DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) >= 32)
		or (Phai = 'No' and DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) >= 27)

--14.
Select	MSSV, Ho + ' ' + Ten as HoVaTen, DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) as Tuoi
From	SinhVien sv
Where	DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) <= 18 or DATEDIFF(dd,YEAR(NgaySinh),YEAR(NgayNhapHoc)) >= 25

--15.
Select	MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien 
Where	LEFT(MSSV, 2) = '99'

--16.
Select	sv.MSSV, Diem
From	SinhVien sv, MonHoc mh, BangDiem bd
Where	sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH and LanThi = 1 and TenMH = N'Co so du lieu' and MSLop = '99TH'

--17.
Select	sv.MSSV, Ho + ' ' + Ten as HoVaTen
From	SinhVien sv, MonHoc mh, BangDiem bd
Where	sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH and LanThi = 1 and TenMH = N'Co so du lieu' and MSLop = '99TH' and Diem < 5

--18.
Select	mh.MSMH, TenMH, LanThi, Diem
From	MonHoc mh, BangDiem bd
Where	mh.MSMH = bd.MSMH and MSSV = '99TH001'

--19.
Select	*
From	SinhVien sv, MonHoc mh, BangDiem bd
Where	sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH and LanThi = 1 and TenMH = N'Co so du lieu' and Diem >=8

--20.
Select	*
From	Tinh t
Where	MSTinh Not In (
							Select	sv.MSTinh
							From	SinhVien sv
							Where	t.MSTinh = sv.MSTinh
						)

--21.
Select	MSSV, Ho, Ten
From	SinhVien sv
Where	MSSV Not In (
						Select	sv.MSSV
						From	BangDiem bd
						where	sv.MSSV = bd.MSSV
					)

------------------- TRUY VẤN GOM NHOM -------------------
--22. 
Select		l.MSLop, TenLop, COUNT(sv.MSLop) as SoLuongSV
From		Lop l, SinhVien sv
Where		l.MSLop = sv.MSLop
Group by	l.MSLop, TenLop

--23.
Select		t.MSTinh, TenTinh, 
			SUM (CASE WHEN sv.Phai = 'Yes' then 1 else 0 end) as SoSVNam, 
			SUM (CASE WHEN sv.Phai = 'No' then 1 else 0 end) as SoSVNu ,
			COUNT(sv.MSTinh) as TongCong 
From		Tinh t, SinhVien sv
Where		t.MSTinh = sv.MSTinh
Group by	t.MSTinh, TenTinh

--24.
Select		l.MSLop, TenLop,
			SUM (CASE WHEN	bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem >= 5 then 1 else 0 end) as SoSVDat,
			ROUND(SUM (CASE WHEN bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem >= 5 then 1 else 0 end)*100/COUNT(sv.MSSV),2) 
			as TiLeDat,
			SUM (CASE WHEN bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem < 5 then 1 else 0 end) as SoSVKhongDat,
			ROUND(SUM (CASE WHEN bd.LanThi = 1 and mh.TenMH = N'Co so du lieu' and bd.Diem < 5 then 1 else 0 end)*100/COUNT(sv.MSSV),2) 
			as TiLeKhongDat
From		Lop l, BangDiem bd, SinhVien sv, MonHoc mh
Where		sv.MSLop = l.MSLop and sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH
Group by	l.MSLop, TenLop

--25.
Select  sv.MSSV, bd.MSMH, mh.TenMH, mh.HeSo, MAX(bd.Diem) * mh.HeSo as Diemxheso
From	SinhVien sv, BangDiem bd, MonHoc mh
Where	sv.MSSV = bd.MSSV and bd.MSMH = mh.MSMH
Group by sv.MSSV, bd.MSMH, mh.TenMH, mh.HeSo

--26.
Select		sv.MSSV, Ho, Ten, ROUND(SUM(Diem * HeSo)/SUM(HeSo),2) as DTB
From		SinhVien sv, BangDiem bd, MonHoc mh
Where		sv.MSSV = bd.MSSV and mh.MSMH = bd.MSMH
Group by	sv.MSSV, Ho, Ten

--27.
Select		YEAR(NgayNhapHoc) as NamHoc, k.MSKhoa, TenKhoa, COUNT(sv.MSLop) as SoLuongSV
From		Tinh t, SinhVien sv, Lop l, Khoa k
Where		t.MSTinh = sv.MSTinh and sv.MSLop = l.MSLop and l.MSKhoa = k.MSKhoa and TenTinh = N'Long An'
Group by	k.MSKhoa, TenKhoa, NgayNhapHoc

----Hàm & Thủ tục-------
---28.
Go
Create Function GetBangDiemSinhVien(@MSSV char(10))
Returns table
As
Return
(
    Select B.MSMH, MH.TenMH, MH.HeSo, MAX(B.Diem) AS Diem
    From BANGDIEM B
    Join MonHoc MH on B.MSMH = MH.MSMH
    Where B.MSSV = @MSSV
    Group By B.MSMH, MH.TenMH, MH.HeSo
);
Go
--Gọi sử dụng hàm
Select * 
From GetBangDiemSinhVien('98TH001');

--29.

Go
Create Procedure GetBangTongKetLop
    @MSLop char(10)
As
Begin
    Select S.MSSV, S.Ho, S.Ten, 
        Round(sum(B.Diem * MH.HeSo) * 1.0 / sum(MH.HeSo), 2) as DTB,
        Case 
            When Round(sum(B.Diem * MH.HeSo) * 1.0 / sum(MH.HeSo), 2) >= 9 then 'Xuat sac'
            When Round(sum(B.Diem * MH.HeSo) * 1.0 / sum(MH.HeSo), 2) >= 8 then 'Gioi'
            When Round(sum(B.Diem * MH.HeSo) * 1.0 / sum(MH.HeSo), 2) >= 6.5 then 'Kha'
            When Round(sum(B.Diem * MH.HeSo) * 1.0 / sum(MH.HeSo), 2) >= 5 then 'Trung binh'
            else 'Yeu'
        End as XepLoai
    From SinhVien S
    Join BangDiem B on S.MSSV = B.MSSV
    Join MonHoc MH on B.MSMH = MH.MSMH
    Where S.MSLop = @MSLop
    Group By S.MSSV, S.Ho, S.Ten;
End;
Go
--Gọi sử dụng thủ tục
Exec GetBangTongKetLop '99TH';

------Cập Nhật Dữ Liệu --------
--30.
create table SinhVienTinh
(
	MSSV		char(7) primary key,
	Ho			nvarchar(30) not null,
	Ten			nvarchar(10) not null,
	NgaySinh	datetime,
	MSTinh		char(2) references Tinh(MSTinh),
	NgayNhapHoc	datetime not null,
	MSLop		char(4) references Lop(MSLop),
	Phai		varchar(3),
	DiaChi		nvarchar(50),
	DienThoai	varchar(10), 
	HBong		int default 0 --đặt học bổng mặc định là 0
)
go

 -- Sao chép dữ liệu từ bảng SinhVien sang bảng SinhVienTinh
insert into SinhVienTinh (MSSV, Ho, Ten, NgaySinh, sv.MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai)
select	MSSV, Ho, Ten, NgaySinh, sv.MSTinh, NgayNhapHoc, MSLop, Phai, DiaChi, DienThoai
from	SinhVien sv, Tinh t
where	sv.MSTinh = t.MSTinh and TenTinh <> 'TPHCM'

select * from SinhVienTinh
--31.
Update SinhVienTinh
Set HBONG = '10000';

Select * from SinhVienTinh
--32.
Update SinhVienTinh
Set HBONG = HBONG * 1.1 -- Tăng HBONG lên 10%
Where Phai = 'No';

Select * from SinhVienTinh
--33.
Delete From SinhVienTinh
Where MSTinh = '04';
Select * from SinhVienTinh