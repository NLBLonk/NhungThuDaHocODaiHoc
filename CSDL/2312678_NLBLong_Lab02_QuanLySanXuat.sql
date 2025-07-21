/*	Học phần: Cơ sở dữ liệu
	Lab2:	Quản lý Sản Xuất
	SV thực hiện:	Nguyễn Lễ Bảo Long
	Mã SV:			2312678
	Lớp:			CTK47A
	Thời gian:		18/2/2025 - 29/3/2025
*/
Create database	Lab2_QLSX	--Lệnh tạo CSDL 
go
Use	Lab2_QLSX	--Lệnh gọi sử dụng CSDL
go
---Tạo bảng ToSanXuat
Create table ToSanXuat
(MaTSX	char(4) primary key, ---khai báo khóa chính
TenTSX	nvarchar(10) not null unique,
)
go
---Tạo bảng CongNhan
Create table CongNhan
(MaCN	char(5) primary key,
Ho	nvarchar(20) not null,
Ten	nvarchar(10) not null,
Phai nvarchar(3) not null check (Phai in(N'Nam' , N'Nữ')),
NgaySinh DateTime null,
MaTSX char(4) references ToSanXuat(MaTSX) 
)
go

Create table SanPham
(MaSP char(5) primary key,
TenSP nvarchar(20) not null unique,
DVT varchar(10) not null,
TienCong float not null check (TienCong > 0),
)
go

Create table ThanhPham
(MaCN char(5) references CongNhan(MaCN),
MaSP	char(5) references SanPham(MaSP),
Ngay DateTime not null,
SoLuong int not null check (SoLuong > 0),
Primary key(MaCN, MaSP, Ngay)
)
go


----------------NHẬP DỮ LIỆU CHO CÁC BẢNG-------
--Nhập bảng 
insert into ToSanXuat values('TS01', N'Tổ 1')
insert into ToSanXuat values('TS02', N'Tổ 2')
--Xem bảng 
Select * from ToSanXuat

Set Dateformat dmy --khai báo với SQL nhập ngày tháng theo dạng ngày/tháng/năm
go
insert into CongNhan values('CN001',N'Nguyễn Trường', N'An',N'Nam','12/05/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng', N'Gấm',N'Nữ','04/06/1980','TS01')
insert into CongNhan values('CN003',N'Nguyễn Công', N'Thành',N'Nam','04/05/1981','TS02')
insert into CongNhan values('CN004',N'Võ Hữu', N'Hạnh',N'Nam','15/02/1980','TS02')
insert into CongNhan values('CN005',N'Lý Thanh', N'Hân',N'Nữ','03/12/1981','TS01')

--Xem bảng CongNhan
Select * from CongNhan

go
insert into SanPham values('SP001',N'Nồi Đất', N'Cái',10000)
insert into SanPham values('SP002',N'Chén', N'Cái',2000)
insert into SanPham values('SP003',N'Bình Gốm Nhỏ', N'Cái',20000)
insert into SanPham values('SP004',N'Bình Gốm Lớn', N'Cái',25000)

--Xem bảng SanPham
Select * from SanPham

go
insert into ThanhPham values('CN001','SP001', '01/02/2007',10)
insert into ThanhPham values('CN002','SP001', '01/02/2007',5)
insert into ThanhPham values('CN003','SP002', '10/01/2007',50)
insert into ThanhPham values('CN004','SP003', '12/01/2007',10)
insert into ThanhPham values('CN005','SP002', '12/01/2007',100)
insert into ThanhPham values('CN002','SP004', '13/02/2007',10)
insert into ThanhPham values('CN001','SP003', '14/02/2007',15)
insert into ThanhPham values('CN003','SP001', '15/01/2007',20)
insert into ThanhPham values('CN003','SP004', '14/02/2007',15)
insert into ThanhPham values('CN004','SP002', '30/01/2007',100)
insert into ThanhPham values('CN005','SP003', '01/02/2007',50)
insert into ThanhPham values('CN001','SP001', '20/02/2007',30)

Select * from ThanhPham

-----------------Truy Vấn--------------
---1.
Select TSX.TenTSX, CN.Ho + '  ' + CN.Ten as HoTen, CN.NgaySinh, CN.Phai
From ToSanXuat TSX, CongNhan CN
Where TSX.MaTSX = CN.MaTSX
Order By TenTSX, Ten, Ho 
---2.
Select SP.TenSP, TP.Ngay, TP.SoLuong, TP.SoLuong * SP.TienCong as ThanhTien
From ThanhPham TP, SanPham SP, CongNhan CN
Where SP.MaSP=TP.MaSP and CN.MaCN=TP.MaCN and CN.Ho = N'Nguyễn Trường' and CN.Ten = N'An'
Order by Ngay

--3.
Select *
From CongNhan
Where MaCN Not In (Select TP.MaCN
From ThanhPham TP, SanPham SP
Where TP.MaSP=SP.MaSP and TenSP = N'Bình gốm lớn')

--4.
Select distinct CN.MaCN, Ho, Ten, MaTSX
From CongNhan CN, ThanhPham TP, SanPham SP
Where CN.MaCN = TP.MaCN and TP.MaSP = SP.MaSP and TenSP= N'Nồi đất' and CN.MaCN in (Select TP2.MaCN
From ThanhPham TP2, SanPham SP2
Where TP2.MaSP = SP2.MaSP and TenSP = N'Bình gốm nhỏ')

--5.
Select TSX.TenTSX, count(MaCN) as SoCN
From ToSanXuat TSX, CongNhan CN
Where TSX.MaTSX = CN.MaTSX
Group By TenTSX

--6. 
Select CN.Ho, CN.Ten, sum(TP.SoLuong) as TongSLSP, sum(TP.SoLuong * SP.TienCong) as TongThanhTien
From CongNhan CN, ThanhPham TP, SanPham SP
Where CN.MaCN = TP.MaCN and TP.MaSP=SP.MaSP
Group By CN.Ho, CN.Ten, TenSP

--7.
Select CN.MaCN, CN.Ho, CN.Ten, sum(TP.SoLuong*SP.TienCong) as ThanhTien
From CongNhan CN, ThanhPham TP, SanPham SP
Where CN.MaCN = TP.MaCN and TP.MaSP=SP.MaSP and MONTH(Ngay) = 2 and YEAR(Ngay)= 2007
Group By CN.MaCN, CN.Ho, CN.Ten

--8.
Select SP.TenSP, SP.DVT, sum(TP.SoLuong) as SoLuongT2_2007
From ThanhPham TP, SanPham SP
Where TP.MaSP = SP.MaSP and MONTH(Ngay)=2 and year(Ngay)=2007
Group By SP.TenSP, SP.DVT
Having sum(TP.SoLuong) >= all ( Select sum(TP2.SoLuong)
From ThanhPham TP2
Where MONTH(TP2.Ngay) = 2 and YEAR(TP2.Ngay) = 2007 
Group By TP2.MaSP)
--9.
Select CN.MACN, CN.Ho +' '+ CN.Ten as HoTen, CN.MaTSX , sum(TP.SoLuong) as SoLuong_Chen
From CongNhan CN, ThanhPham TP, SanPham SP
Where CN.MACN = TP.MACN and TP.MaSP = SP.MaSP and TenSP = N'Chén'
Group By CN.MACN, Ho, Ten, MaTSX
Having sum(TP.SoLuong) >=all (Select sum(TP2.SoLuong)
From ThanhPham TP2, SanPham SP2
Where TP2.MaSP = SP2.MaSP and TenSP = N'Chén'
Group By TP2.MACN)

--10.
Select sum(TP.SoLuong * SP.TienCong) as TienCongCN
From ThanhPham TP, SanPham SP
Where TP.MaSP=SP.MaSP and TP.MaCN = 'CN002' and MONTH(Ngay) = 2 and YEAR(Ngay) = 2007

--11.
Select CN.MACN, Ho, Ten, MaTSX, count(distinct MaSP) as SoLoaiSPLamDuoc
From CongNhan CN, ThanhPham TP
Where CN.MACN = TP.MACN
Group By CN.MACN, Ho, Ten, MaTSX
Having count(distinct MaSP)>=3

--12.
Update SanPham
Set TienCong = TienCong + 1000
Where TenSP in (N'Bình gốm nhỏ',N'Bình gốm lớn')
Select * from SanPham

--13. 
insert into CongNhan values ('CN006',N'Lê Thị',N'Lan', N'Nữ', ' ' , 'TS02')
Select * from CongNhan


------Thủ tục hàm ------
----A. Viết các hàm sau -----
--a.
Go
Create Function TongSoCongNhan(@MaTSX char(4))
Returns int
As
Begin
Return (Select Count(*) From CongNhan Where MaTSX = @MaTSX);
End;
Go
--Gọi sử dụng hàm
Select dbo. TongSoCongNhan('TS01') as N'Số công nhân';
Print N'Số công nhân của tổ 1 là: ' + convert(varchar(10), dbo.TongSoCongNhan('TS01'));

Select dbo.TongSoCongNhan('TS02') as N'Số công nhân';
Print N'Số công nhân của tổ 2 là: ' + convert(varchar(10), dbo.TongSoCongNhan('TS02'));

--b.
Go
Create function TongSanLuongThang(@MaSP char(5), @Thang int, @Nam int)
Returns int
As
Begin
Return (Select sum(SoLuong)
From ThanhPham
Where MaSP = @MaSP and MONTH(Ngay) = @Thang and YEAR(Ngay) = @Nam);
End;
Go
--Gọi sử dụng hàm
Select dbo.TongSanLuongThang('SP001', 2, 2007) as N'Tổng sản lượng';
Print N'Tổng sản lượng của SP001 trong tháng 2 năm 2007 là: ' + convert(varchar(10), dbo.TongSanLuongThang('SP001', 2, 2007));

--c.
Go
Create Function TinhTongTienCongThang(
    @MACN char(5),
    @Thang int,
    @Nam int
)
Returns Decimal(18, 2)
As
Begin
    return (
        Select sum(TP.SoLuong * SP.TienCong)
        From ThanhPham TP
        Join SanPham SP on TP.MaSP = SP.MaSP
        Where TP.MACN = @MACN 
        and Month(TP.ngay) = @Thang 
        and Year(TP.ngay) = @Nam
    );
End;
Go
--Gọi sử dụng hàm
Select dbo.TinhTongTienCongThang('CN001', 2, 2007) as N'Tổng tiền công';
Print N'Tổng tiền công của CN001 trong tháng 2 năm 2007 là: ' + convert(varchar(20), dbo.TinhTongTienCongThang('CN001', 2, 2007));


--d.
Go
Create Function TinhTongThuNhapNam(
    @MaTSX CHAR(4),
    @Nam INT
) 
Returns Decimal(18, 2)
As
Begin
    Return (
        Select sum(TP.SoLuong * SP.TienCong)
        From ThanhPham TP
        Join CongNhan CN on TP.MACN = CN.MACN
        Join SanPham SP on TP.MaSP = SP.MaSP
        Where CN.MaTSX = @MaTSX
        And YEAR(TP.Ngay) = @Nam    
        );
End;
Go
--Gọi sử dụng hàm
Select dbo.TinhTongThuNhapNam('TS01', 2007) as N'Tổng thu nhập'; 
Print N'Tổng thu nhập của tổ sản xuất TS01 trong năm 2007 là: ' + convert(varchar(20), dbo.TinhTongThuNhapNam('TS01', 2007));

--e.
Go
Create function TinhTongSanLuongKhoangThoiGian(
    @MaSP char(5),
    @NgayBatDau date,
    @NgayKetThuc date
)
Returns int
As
Begin
    Return (
        Select sum(TP.SoLuong)
        From ThanhPham TP
        Where TP.MaSP = @MaSP 
        And TP.Ngay between @NgayBatDau and @NgayKetThuc
    );
End;
Go
--Gọi sử dụng hàm
Select dbo.TinhTongSanLuongKhoangThoiGian('SP001', '2007-02-01', '2007-02-28') AS N'Tổng sản lượng'; 
Print N'Tổng sản lượng của sp001 từ 01/02/2007 đến 28/02/2007 là: ' + convert(varchar(10), dbo.TinhTongSanLuongKhoangThoiGian('SP001', '2007-02-01', '2007-02-28'));

--------B. Viết các thủ tục---------
---a.
Go
Create Procedure DanhSachCongNhanTSX @MaTSX char(4)
As
Begin
    Select MACN, Ho, Ten, NgaySinh, Phai
    From CongNhan
    Where MaTSX = @MaTSX;
End;
Go
--Gọi sử dụng thủ tục
Declare @MaTSX char(4) = 'TS01';
Print N'Danh sách công nhân của tổ sản xuất ' + @MaTSX + N':';
Exec DanhSachCongNhanTSX @MaTSX;

---b.
Go
Create Procedure BangChamCong @MACN char(5), @Thang int, @Nam int
As
Begin
    Select SP.TenSP, SP.DVT, TP.SoLuong, SP.TienCong, (TP.SoLuong * SP.TienCong) as ThanhTien
    From ThanhPham TP
    Join SanPham SP on TP.MaSP = SP.MaSP
    Where TP.MACN = @MACN and MONTH(TP.Ngay) = @Thang and YEAR(TP.Ngay) = @Nam;
End;
Go
--Gọi sử dụng thủ tuc
Declare @MACN CHAR(5) = 'CN001';
Declare @Thang INT = 2;
Declare @Nam INT = 2007;

Print N'Bảng chấm công cho công nhân ' + @MACN + N' trong tháng ' + convert(varchar(2), @Thang) + N' năm ' + convert(varchar(4), @Nam) + N':';
Exec BangChamCong @MACN, @Thang, @Nam;
