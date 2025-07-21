/*
  Học phần: Cơ sở dữ liệu
  Lớp: CTK47A
  Lab 06: Quản lý học viên
  Sinh viên thực hiện: Nguyễn Lê Bảo Long
  Mã sinh: 2312678
  Thời gian: 14/03/2025 - 30/3/2025
*/

----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
create database Lab06_QLHocVien
go
use Lab06_QLHocVien
go

create table CaHoc
(Ca			tinyint primary key,
GioBatDau	Datetime,
GioKetThuc	Datetime
)
go

create table GiaoVien
(MSGV		char(4) primary key,
HoGV		nvarchar(20),
TenGV		nvarchar(10),
DienThoai	varchar(11)
)
go

create table Lop
(MaLop	char(4) primary key,
TenLop	nvarchar(30),
NgayKG	Datetime,
HocPhi	int,
Ca		tinyint references CaHoc(Ca),
SoTiet	int,
SoHV	int,
MSGV	char(4) references GiaoVien(MSGV)
)
go

create table HocVien
(MSHV		char(6) primary key,
Ho			nvarchar(20),
Ten			nvarchar(10),
NgaySinh	Datetime,
Phai		nvarchar(4),
MaLop		char(4) references Lop(MaLop)
)
go

create table HocPhi
(
SoBL	char(4) primary key,
MSHV	char(6) references HocVien(MSHV),
NgayThu Datetime,
SoTien	int,
NoiDung	nvarchar(50),
NguoiThu nvarchar(30)
)
go

-------------------
select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi
go

----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU (Câu 4a) -------------
CREATE PROC usp_ThemCaHoc
	@ca tinyint, @giobd Datetime, @giokt Datetime
As
	If exists(select * from CaHoc where Ca = @ca) --kiểm tra có trùng khóa chính (Ca) 
		print N'Đã có ca học ' +@ca+ N' trong CSDL!'
	Else
		begin
			insert into CaHoc values(@ca, @giobd, @giokt)
			print N'Thêm ca học thành công.'
		end
go
--goi thuc hien thu tuc usp_ThemCaHoc---
exec usp_ThemCaHoc 1,'7:30','10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc 3,'17:30','20:45'

select * from CaHoc
go

CREATE PROC usp_TheoGV	
	@msgv char(4), @hogv nvarchar(20), @tengv nvarchar(10), @dienthoai varchar(11)
As
	if exists(select * from GiaoVien where MSGV = @msgv)
		print N'Đã có giáo viên ' +@msgv+ N' trong CSDL !'
	Else
		Begin
			Insert Into GiaoVien values(@msgv, @hogv, @tengv, @dienthoai)
			print N'Thêm giáo viên thành công'
		end
go

drop PROC usp_TheoGV
go

exec usp_TheoGV 'G001', N'Lê Hoàng', N'Anh', '858936'
exec usp_TheoGV 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_TheoGV 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_TheoGV 'G004',N'Võ Thanh',N'Trung', '841256'

select * from GiaoVien
go
	
CREATE PROC usp_ThemLopHoc
	@malop char(4), @tenlop nvarchar(30),
	@ngaykg DateTime, @hocphi int, @ca tinyint, @sotiet int, @sohv int, @msgv char(4)
As
	If exists(select * from CaHoc where Ca = @ca) and exists(select * from GiaoVien where MSGV = @msgv)
		Begin 
			If exists(Select * from Lop where MaLop = @malop)
				print N'Đã có lớp ' +@malop+ ' trong CSDL !'
			else
				Begin 
					Insert Into Lop values(@malop, @tenlop, @ngaykg, @hocphi, @ca, @sotiet, @sohv, @msgv)
					print N'Thêm giáo viên thành công'
					end
			End
	Else
		if not exists(select * from CaHoc where Ca = @Ca)
				print N'Không có ca học '+@Ca+' trong CSDL.'
		if not exists(select * from GiaoVien where MSGV=@msgv)
				print N'Không có giáo viên '+@msgv+' trong CSDL.'
go

set dateformat dmy
go

exec usp_ThemLopHoc 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003' 
exec usp_ThemLopHoc 'A075',N'Accesss 2-4-6','18/12/2008', 150000,3,60,3,'G005'
exec usp_ThemLopHoc 'A076',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003' 

exec usp_ThemLopHoc 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLopHoc 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLopHoc 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLopHoc 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'

Select * from Lop
go

CREATE PROC usp_ThemHocVien
	@mshv char(6), @ho nvarchar(20), @ten nvarchar(10), @ngaysinh DateTime, @phai nvarchar(4), @malop char(4)
As
	If Exists(select * from Lop where MaLop = @malop)
		Begin
			If exists(Select * from HocVien where MSHV = @mshv)
				Print N'Đã có học viên ' +@mshv+ ' trong cơ sở dữ liệu !'
			Else
				Begin
					Insert Into HocVien values(@mshv, @ho, @ten, @ngaysinh, @phai, @malop)
					Print N'Thêm học viên thành công'
				end
			End
	Else
		print N'Lớp '+ @MaLop + N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'

set dateformat dmy
go

exec usp_ThemHocVien 'A07501',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien 'A07501',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien 'A07501',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A022'

exec usp_ThemHocVien 'A07501',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien 'A07503',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien 'E11401',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien 'E11402',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien 'E11403',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien 'W12301',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'

Select * from HocVien
go

CREATE PROC usp_ThemHocPhi
	@sobl char(4), @mshv char(6), @ngaythu DateTime, @sotien int, @noidung nvarchar(50), @nguoithu nvarchar (30)
As
	If exists(select * from HocVien where MSHV = @mshv)
		Begin
			If exists(select * from HocPhi where SoBL = @sobl)
				Print N'Đã có số biên lai học phí này trong CSDL !'
			Else
				Begin
				Insert Into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
				print N'Thêm biên lai học phí thành công'
			end
		End
	Else
		Print N'Học viên ' +@mshv+ N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này !'
go

set dateformat dmy
go

exec usp_ThemHocPhi '0005','A07501','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0005','A07501','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0001','E11401','02/01/2008',120000,'HP Access 3-5-7', N'Vân'

exec usp_ThemHocPhi '0002','E11402','02/01/2008',120000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0003','E11403','02/01/2008',80000,'HP Access 3-5-7', N'Vân'
exec usp_ThemHocPhi '0004','W12301','18/02/2008',100000,'HP Word 2-4-6', N'Lan'
exec usp_ThemHocPhi '0005','A07501','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0006','A07502','16/12/2008',100000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi '0007','A07503','18/12/2008',150000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi '0008','A07504','15/01/2009',50000,'HP Access 2-4-6', N'Vân'


Select * from HocPhi
go
------------------XÂY DỰNG CÁC THỦ TỤC SỬA DỮ LIỆU----------



------------------XÂY DỰNG CÁC THỦ TỤC XÓA DỮ LIỆU----------

-------------------------------------------------------------------------------
--5f)  Thủ tục lập danh sách học viên của một lớp cho trước. 
Create Proc InDSLop @malop char(4)
As
If exists (Select * from Lop where Malop=@malop)
	Select * From HocVien Where Malop = @malop
Else 
	print N'Không có lớp ' + @malop +' trong CSDL.'
Go

--Gọi thực hiện thủ tục 
exec InDSLop 'E114'
go

----5f)  Hàm lập danh sách học viên của một lớp cho trước. 
Create Function fn_InDSLop (@malop char(4)) returns Table
As
return (
		Select * 
		From HocVien 
		Where Malop = @malop
		)
go
--Gọi thực hiện hàm
Select * From fn_InDSLop('E114')

-------------------------------------------------------------------------------
--------------------HÀM CẤP MÃ TỰ ĐỘNG & CÁCH SỬ DỤNG----------------
/*1. Viết hàm cấp mã cho giáo viên mới theo quy tắc lấy mã lớn nhất hiện có 
sau đó tăng thêm 1 đơn vị*/
create function CapMaGV() returns char(4)
As
Begin
	declare @MaxMaGV char(4)
	declare @NewMaGV varchar(4)
	declare @stt	int
	declare @i	int	
	declare @sokyso	int

	if exists(select * from GiaoVien)---Nếu bảng giáo viên có dữ liệu
	 begin
		--Lấy mã giáo viên lớn nhất hiện có
		select @MaxMaGV = max(MSGV) 
		from GiaoVien

		--Trích phần ký số của mã lớn nhất và chuyển thành số 
		set @stt=convert(int, right(@MaxMaGV,3)) + 1 --Số thứ tự của giáo viên mới
	 end
	else--Nếu bảng giáo viên đang rỗng (nghĩa là chưa có giáo viên nào được lưu trữ trong CSDL).
	 set @stt= 1 -- Số thứ tự của giáo viên trong trường hợp chưa có gv nào trong CSDL
	
	--Kiểm tra và bổ sung chữ số 0 để đủ 3 ký số trong mã gv.
	set @sokyso = len(convert(varchar(3), @stt))
	set @NewMaGV='G'
	set @i = 0
	while @i < 3 -@sokyso
		begin
			set @NewMaGV = @NewMaGV + '0'
			set @i = @i + 1
		end	
	set @NewMaGV = @NewMaGV + convert(varchar(3), @stt) --Mã GV mới cộng stt sang dạng chuỗi

return @NewMaGV	
End
--Thử hàm sinh mã
select * from GiaoVien
print dbo.CapMaGV()

----2. Thủ  tục thêm giáo viên với mã giáo viên được cấp tự động----
CREATE PROC usp_ThemGiaoVien2
@hogv nvarchar(20), @tengv nvarchar(10), @dthoai varchar(10)
As
	declare @Magv char(4)
	
 if not exists(select * from GiaoVien 
				where HoGV = @hogv and TenGV = @tengv and DienThoai = @dthoai) --Kt giáo viên đó có cùng mã, cùng tên, cùng sdt, 
																			   --nếu có thì gv đã đc lưu nên ko cần thêm vô nữa
	Begin
		
		--sinh mã cho giáo viên mới
		set @Magv = dbo.CapMaGV()
		insert into GiaoVien values(@Magv, @hogv, @tengv,@dthoai)
		print N'Đã thêm giáo viên thành công'
	End
else
	print N'Đã có giáo viên ' + @hogv +' ' + @tengv + ' trong CSDL'
Go
---Sử dụng thủ tục thêm giáo viên
exec usp_ThemGiaoVien2 N'Trần Ngọc Bảo', N'Hân', '0123456789'
exec usp_ThemGiaoVien2 N'Vũ Minh', N'Triết', '0123456788'
select * from GiaoVien


------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN----------------
/*4a) Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó 
(RBTV liên thuộc tính)*/
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc<i.GioBatDau)	
	      begin
	    	 raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)--Thông báo lỗi cho người dùng, 15 và 1 là mức độ cảnh báo (raiserror hàm thông báo lỗi)
		     rollback tran	--Hũy thao tác gây ra vi phạm ràng buộc toàn vẹn & đưa CSDL về tình trạng cũ trước khi thao tác
	      end
go	

-----thử nghiệm hoạt động của trigger tr_CaHoc_ins_upd_GioBD_GioKT----
insert into CaHoc values(4,'16:40','20:00')
insert into CaHoc values(4,'22:40','20:00')

Update CaHoc set GioKetThuc = '5:45' where ca = 1
select * from CaHoc
go

/* 4b): Số học viên của 1 lớp không quá 30 và đúng bằng số học viên thuộc lớp đó. 
(RBTV do thuộc tính tổng hợp)*/
Create trigger tr_Lop_ins_upd
On Lop for insert, update
As
If update(MaLop) or update(SoHV)
Begin
		If exists(select * from inserted i where i.SoHV >30)  --Nếu số hv quá 30
		 Begin
			raiserror (N'Số học viên của một lớp không quá 30', 15,1)--Thông báo lỗi cho người dùng
			rollback tran --hủy bỏ thao tác thêm lớp học
		 end
		If exists (Select * from inserted l --Nếu số hv không quá 30 
						where l.SoHV <> (select count(MSHV)
										 from HocVien
										 where HocVien.MaLop = l.MaLop))
		begin
			raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)--Thông báo lỗi cho người dùng
			rollback tran --hủy bỏ thao tác thêm lớp học
		end
End
go

-- Thử nghiệm 
select * from Lop
--
Set dateformat dmy
go
insert into Lop values('P001',N'Photoshop','1/11/2018',250000,1,100,0,'G004')--Thử nghiệm thêm lớp

update Lop set SoHV = 5 where MaLop = 'P001'--Thử nghiệm sửa sĩ số của lớp

-- 4c): Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học
	CREATE TRIGGER tienthu_HV
		ON HocPhi
		AFTER INSERT, UPDATE
		AS
		BEGIN
			IF (SELECT SUM(SoTien) FROM inserted) > (SELECT HocPhi FROM Lop WHERE MaLop IN (SELECT MaLop FROM inserted))
			BEGIN
				RAISERROR(N'Số tiền thu không được vượt quá học phí của lớp', 16, 1)
				ROLLBACK TRANSACTION
			END
		END

---Tạo các thủ tục----
--a)Thêm dữ liệu vào các bảng
-- Thêm dl bảng GiaoVien
create proc pr_ThemDL_GiaoVien	@MSGV char(4), @HoGV nvarchar(20), @TenGV nvarchar(10), @DienThoai char(10)
AS
	if exists (select * from GiaoVien where MSGV = @MSGV)
		print N'Giáo viên có mã số '+ @MSGV + N' đãn tồn tại trong cơ sở dữ liệu'
	else
		begin
			insert into GiaoVien values (@MSGV, @HoGV, @TenGV, @DienThoai)
			print N'Thêm giáo viên thành công'
		end
GO

-- Thêm dl bảng CaHoc
create proc pr_ThemDL_CaHoc	@Ca char(2), @GioBatDau datetime, @GioKetThuc datetime
AS
	if exists (select * from CaHoc where Ca = @Ca)
		print N'Ca học có mã số '+ @Ca + N' đã tồn tại trong cơ sở dữu liệu'
	else
		begin
			insert into CaHoc values (@Ca, @GioBatDau, @GioKetThuc)
			print N'Ca học thêm thành công'
		end
GO

-- Thêm dl bảng Lop
create proc pr_ThemDL_Lop 
	@MaLop char(4), @TenLop nvarchar(30), @NgayKG datetime, @HocPhi int, @Ca char(2), @SoTiet tinyint, @SoHV tinyint, @MSGV char(4)
AS
	if exists (select * from Lop where MaLop = @MaLop)
		print N'Lớp có mã số ' + @MaLop + N' đã tồn tại trong cơ sở dữu liệu'
	if not exists (select * from CaHoc where Ca = @Ca)
		print N'Ca có mã số ' + @Ca + N' không tồn tại trong cơ sở dữu liệu'
	if not exists (select * from GiaoVien where MSGV = @MSGV)
		print N'Giáo viên có mã số ' + @MSGV + N' không tồn tại trong cơ sở dữu liệu'

	insert into Lop values (@MaLop, @TenLop, @NgayKG, @HocPhi, @Ca, @SoTiet, @SoHV, @MSGV)
	print N'Thêm lớp thành công'
GO

-- Thêm dl bảng HocVien
create proc pr_ThemDL_HocVien 
	@Ho nvarchar(20), @Ten nvarchar(10), @NgaySinh datetime, @Phai nvarchar(3), @MaLop char(4)
AS
	declare	@MSHV char(6)
	if exists (select * from Lop where MaLop = @MaLop) 
		Begin
			set @MSHV = dbo.fn_SinhMa_HV(@MaLop)
			insert into HocVien values (@MSHV, @Ho, @Ten, @NgaySinh, @Phai, @MaLop)
			print N'Thêm học viên thành công'
		End
	else
		print N'Chưa tồn tại lớp ' + @MaLop + N' trong cơ sở dữu liệu'

GO

-- Thêm dl bảng HocPhi
create proc pr_ThemDL_HocPhi
	@SoBL char(4), @MSHV char(6), @NgayThu datetime, @SoTien int, @NoiDung varchar(30), @NguoiThu nvarchar(10)
AS
	if exists (select * from HocPhi where SoBL = @SoBL)
		print N'Biên lai có mã số ' + @SoBL + N' đã tồn tại trong cơ sở dữ liệu'
	if not exists (select * from HocVien where MSHV = @MSHV) 
		print N'Học viên có mã số ' + @MSHV + N' không có trong cơ sở dữ liệu'
	else
		begin
			insert into HocPhi values (@SoBL, @MSHV, @NgayThu, @SoTien, @NoiDung, @NguoiThu)
			print N'Đã thêm học phí thành công'
		end
GO

-- b) Cập nhật thông tin của một học viên cho trước
CREATE PROCEDURE usp_CapNhatThongTinHocVien
    @MSHV CHAR(6),
    @Ho NVARCHAR(20),
    @Ten NVARCHAR(10),
    @NgaySinh DATETIME,
    @Phai NVARCHAR(4),
    @MaLop CHAR(4)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM HocVien WHERE MSHV = @MSHV)
    BEGIN
        UPDATE HocVien
        SET Ho = @Ho, Ten = @Ten, NgaySinh = @NgaySinh, Phai = @Phai, MaLop = @MaLop
        WHERE MSHV = @MSHV
        PRINT 'Cập nhật thông tin học viên thành công.'
    END
    ELSE
    BEGIN
        PRINT 'Học viên có mã số ' + @MSHV + ' không tồn tại trong CSDL.'
    END
END
EXEC usp_CapNhatThongTinHocVien 'A07501', N'Lê Văn', N'Minh', '2004-01-01', N'Nam', 'E114'
select * from HocVien
--c)Xóa 1 học viên cho trước
CREATE PROCEDURE usp_XoaHocVien
    @MSHV CHAR(6)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM HocVien WHERE MSHV = @MSHV)
    BEGIN
        DELETE FROM HocPhi WHERE MSHV = @MSHV; 
        DELETE FROM HocVien WHERE MSHV = @MSHV; 
        PRINT 'Đã xóa học viên có mã số ' + @MSHV + ' thành công.'
    END
    ELSE
    BEGIN
        PRINT 'Không tìm thấy học viên có mã số ' + @MSHV + ' trong CSDL.'
    END
END

EXEC usp_XoaHocVien 'A07501';
select *from HocVien

--d)Cập nhật thông tin 1 lớp học cho trước
CREATE PROCEDURE usp_CapNhatThongTinLop
    @MaLop CHAR(4),
    @TenLop NVARCHAR(30),
    @NgayKG DATETIME,
    @HocPhi INT,
    @Ca TINYINT,
    @SoTiet TINYINT,
    @SoHV TINYINT,
    @MSGV CHAR(4)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Lop WHERE MaLop = @MaLop)
    BEGIN
        IF EXISTS (SELECT 1 FROM CaHoc WHERE Ca = @Ca)
        BEGIN
            IF EXISTS (SELECT 1 FROM GiaoVien WHERE MSGV = @MSGV)
            BEGIN
                UPDATE Lop
                SET TenLop = @TenLop,
                    NgayKG = @NgayKG,
                    HocPhi = @HocPhi,
                    Ca = @Ca,
                    SoTiet = @SoTiet,
                    SoHV = @SoHV,
                    MSGV = @MSGV
                WHERE MaLop = @MaLop;
                PRINT 'Cập nhật thông tin lớp học thành công.'
            END
            ELSE
            BEGIN
                PRINT 'Giáo viên có mã số ' + @MSGV + ' không tồn tại trong CSDL.'
            END
        END
        ELSE
        BEGIN
            PRINT 'Ca học có số ' + CONVERT(VARCHAR(3), @Ca) + ' không tồn tại trong CSDL.'
        END
    END
    ELSE
    BEGIN
        PRINT 'Lớp học có mã ' + @MaLop + ' không tồn tại trong CSDL.'
    END
END

EXEC usp_CapNhatThongTinLop 'A075', N'CSDL', '2024-05-05', 200000, 1, 45, 4, 'G001';
select *from Lop
--e)Xóa 1 lớp học cho trước nêu lớp này ko có học viên

CREATE PROCEDURE usp_XoaLopHoc
    @MaLop CHAR(4)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Lop WHERE MaLop = @MaLop)
    BEGIN
        IF (SELECT COUNT(*) FROM HocVien WHERE MaLop = @MaLop) = 0
        BEGIN
            DELETE FROM Lop WHERE MaLop = @MaLop;
            PRINT 'Đã xóa lớp học có mã ' + @MaLop + ' thành công.'
        END
        ELSE
        BEGIN
            PRINT 'Lớp học có mã ' + @MaLop + ' có học viên đang đăng ký, không thể xóa.'
        END
    END
    ELSE
    BEGIN
        PRINT 'Lớp học có mã ' + @MaLop + ' không tồn tại trong CSDL.'
    END
END

EXEC usp_XoaLopHoc 'E115';
SELECT *FROM Lop

	----5f)  Hàm lập danh sách học viên của một lớp cho trước. 
	Create Function fn_InDSLop (@malop char(4)) returns Table
	As
	return (
			Select * 
			From HocVien 
			Where Malop = @malop
			)
	Go
	--Gọi thực hiện hàm
	Select * From fn_InDSLop('E114')
--g)Danh Sach Học Viên chưa đóng đủ tiền học phí
	CREATE PROCEDURE pr_InDanhSachHocPhiChuaDu
AS
BEGIN
    DECLARE @MaHV CHAR(6)
    DECLARE @Result NVARCHAR(100)

    -- Tạo bảng tạm để lưu kết quả
    CREATE TABLE #DanhSachHocPhiChuaDu (
        MaHV CHAR(6),
        HoTen NVARCHAR(100),
        TinhTrangHocPhi NVARCHAR(100))
    

    -- Lặp qua danh sách học viên
    DECLARE hocvien_cursor CURSOR FOR
    SELECT MSHV FROM HocVien

    OPEN hocvien_cursor
    FETCH NEXT FROM hocvien_cursor INTO @MaHV

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Kiểm tra học phí của học viên
        SET @Result = dbo.fn_KiemTraHocPhi(@MaHV)

        -- Nếu học viên chưa đóng đủ học phí, thêm vào bảng tạm
        IF @Result = N'Chưa đóng đủ học phí'
        BEGIN
            INSERT INTO #DanhSachHocPhiChuaDu (MaHV, HoTen, TinhTrangHocPhi)
            SELECT MSHV, Ho + ' ' +Ten as HoTen, @Result
            FROM HocVien
            WHERE MSHV = @MaHV
        END

        FETCH NEXT FROM hocvien_cursor INTO @MaHV
    END

    CLOSE hocvien_cursor
    DEALLOCATE hocvien_cursor

    -- In danh sách học viên chưa đóng đủ học phí
    SELECT * FROM #DanhSachHocPhiChuaDu



	--6a) Hàm tính tổng số học phí đã thu được của một lớp khi biết mã lớp. 
	create function fn_TongHocPhi1Lop(@malop char(4)) returns int
	As
	Begin
		declare @TongTien int
		if exists (select * from Lop where MaLop = @MaLop) ---Nếu tồn tại lớp @malop trong CSDL
			Begin
			--Tính tổng số học phí thu được trên 1 lớp
			select @TongTien = sum(SoTien)
			from	HocPhi A, HocVien B	
			where	A.MSHV = B.MSHV and B.Malop = @malop
			End	
	 	
	return @TongTien
	End
	--- thử nghiệm hàm-------
	print dbo.fn_TongHocPhi1Lop('A075')
	--6b) Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước. 
	create function fn_TongHocPhi(@bd datetime,@kt datetime) returns int
	As
	Begin
		declare @TongTien int
		--Tính tổng số học phí thu được trong khoảng thời gian từ bắt đầu đến kết thúc
		select @TongTien = sum(SoTien)
		from	HocPhi 	
		where	NgayThu between @bd and @kt
	return @TongTien
	End
	--- thu nghiem ham-------
	set dateformat dmy
	print dbo.fn_TongHocPhi('1/1/2008','15/1/2008')
	--6c) Cho biết một học viên cho trước đã nộp đủ học phí hay chưa. 
			CREATE FUNCTION fn_KiemTraHocPhi
		(
			@MaHV CHAR(6)
		)
		RETURNS NVARCHAR(100)
		AS
		BEGIN
			DECLARE @Result NVARCHAR(100)

			IF EXISTS (SELECT 1 FROM HocVien WHERE MSHV = @MaHV)
			BEGIN
				IF EXISTS (SELECT 1 FROM HocPhi WHERE MSHV = @MaHV)
				BEGIN
					DECLARE @TongHocPhi DECIMAL(18, 2)
					SELECT @TongHocPhi = SUM(SoTien) FROM HocPhi WHERE MSHV = @MaHV

					IF @TongHocPhi >= (SELECT HocPhi FROM Lop WHERE Lop.MaLop = (SELECT MaLop FROM HocVien WHERE MSHV = @MaHV))
						SET @Result = N'Đã đóng đủ học phí'
					ELSE
						SET @Result = N'Chưa đóng đủ học phí'
				END
				ELSE
				BEGIN
					SET @Result = N'Học viên này chưa có học phí nào'
				END
			END
			ELSE
			BEGIN
				SET @Result = N'Không tồn tại mã học viên này'
			END

			RETURN @Result
		END

		
		print dbo.fn_KiemTraHocPhi('A07501')
	
	--6d) Hàm sinh mã số học viên theo quy tắc mã số học viên gồm mã lớp của học viên kết hợp với số thứ tự của học viên trong lớp đó. 
CREATE FUNCTION fn_CapMaHV(@MaLop CHAR(4)) 
	RETURNS CHAR(6)
		AS
		BEGIN
			DECLARE @MaxMaHV INT
			DECLARE @NewMaHV CHAR(6)
			DECLARE @stt INT
			DECLARE @sokyso INT

			-- Lấy số thứ tự lớn nhất trong mã học viên trong lớp đó
			IF EXISTS (SELECT 1 FROM HocVien WHERE MSHV LIKE @MaLop + '%') 
			BEGIN
				SELECT @MaxMaHV = MAX(CAST(RIGHT(MSHV, 2) AS INT)) FROM HocVien WHERE MSHV LIKE @MaLop + '%'
				SET @stt = @MaxMaHV + 1 -- Tăng số thứ tự lên 1
			END
			ELSE
			BEGIN
				SET @stt = 1 -- Nếu không có học viên trong lớp thì bắt đầu từ 1
			END

			-- Tạo mã số học viên mới
			SET @NewMaHV = @MaLop + RIGHT('00' + CAST(@stt AS VARCHAR(2)), 2)

			RETURN @NewMaHV	
		END


	--Thử hàm sinh mã
	drop function fn_CapMaHV
	select * from HocVien
	print dbo.fn_CapMaHV('E114')

