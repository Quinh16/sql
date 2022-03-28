CREATE DATABASE QL_VE_XEM_PHIM
USE QL_VE_XEM_PHIM
GO
--Tạo table 
CREATE TABLE LOAIPHIM( MaLoai char(10) primary key not null, TenLoaiPhim nvarchar(100));

INSERT INTO LOAIPHIM VALUES('ML01',N'Hành động');
INSERT INTO LOAIPHIM VALUES('ML02',N'Hoạt hình');
INSERT INTO LOAIPHIM VALUES('ML03',N'Tình cảm');
INSERT INTO LOAIPHIM VALUES('ML04',N'Kinh dị');
INSERT INTO LOAIPHIM VALUES('ML05',N'Hài');
INSERT INTO LOAIPHIM VALUES('ML06',N'Khoa học viễn tưởng');

SELECT * FROM LOAIPHIM
CREATE TABLE PHIM(MaPhim char(10) primary key not null, MaLoai char(10) references LOAIPHIM(Maloai), TenPhim nvarchar(100));

INSERT INTO PHIM VALUES('MP01', 'ML01', N'Người nhện');
INSERT INTO PHIM VALUES('MP02', 'ML02', N'Turning red');
INSERT INTO PHIM VALUES('MP03', 'ML02', N'Encanto: Vùng đất thần kỳ');
INSERT INTO PHIM VALUES('MP04', 'ML03', N'Titanic');
INSERT INTO PHIM VALUES('MP05', 'ML03', N'Love, Roise');
INSERT INTO PHIM VALUES('MP06', 'ML04', N'Bẫy linh hồn');
INSERT INTO PHIM VALUES('MP07', 'ML05', N'Zombieland');

SELECT * FROM PHIM
-- Tạo thủ tục thêm trong bảng LOAIPHIM
CREATE PROC sp_ThemLoaiPhim @MaLoai char(10), @TenLoaiPhim nvarchar(100)
AS
BEGIN
	IF(EXISTS(SELECT MaLoai FROM LOAIPHIM WHERE MaLoai = @MaLoai))
		PRINT N'Mã loại phim này đã tồn tại, vui lòng nhập lại!'
	IF(EXISTS(SELECT TenLoaiPhim FROM LOAIPHIM WHERE TenLoaiPhim = @TenLoaiPhim))
		PRINT N'Tên loại phim này đã tồn tại, vui lòng nhập lại!'
	ELSE
		INSERT INTO LOAIPHIM VALUES( @MaLoai, @TenLoaiPhim)
END
-- Tạo thủ tục: xóa trong LOAIPHIM
CREATE PROC sp_XoaLoaiPhim @MaLoai char(10)
AS
BEGIN
	IF(EXISTS(SELECT MaLoai FROM PHIM WHERE Maloai = @MaLoai))
		PRINT N'Mã loại này đang được sử dụng trong bảng khác, không thể xóa được!'
	ELSE 
		DELETE FROM LOAIPHIM WHERE MaLoai = @MaLoai 
END
--Tạo thủ tục thêm phim vào bảng PHIM
CREATE PROC sp_ThemPhim @MaPhim char(10), @MaLoai char(10), @TenPhim nvarchar(100)
AS
BEGIN
	IF(EXISTS(SELECT MaPhim FROM PHIM WHERE MaPhim = @MaPhim))
		PRINT N'Mã phim này đã tồn tại, vui lòng nhập lại!'
	ELSE IF(NOT EXISTS(SELECT MaLoai FROM LOAIPHIM WHERE MaLoai = @MaLoai))
		PRINT N'Mã loại này không tồn tại, vui lòng nhập lại!'
	ELSE 
		INSERT INTO PHIM VALUES(@MaPhim, @MaLoai, @TenPhim)
END

EXEC sp_ThemPhim 'MP01', 'ML01', N'Train to Busan 2'
EXEC sp_ThemPhim 'MP08', 'ML06', N'Godzilla'

--Tạo thủ tục: xóa trong bảng PHIM
CREATE PROC sp_XoaPhim @MaPhim char(10)
AS
BEGIN
	IF(NOT EXISTS(SELECT MaPhim FROM PHIM WHERE MaPhim = @MaPhim))
		PRINT N'Mã phim này không tồn tại, vui lòng nhập lại!'
	ELSE 
		DELETE FROM PHIM WHERE MaPhim = @MaPhim 
END

-- Tạo view xem thông tin phim
CREATE VIEW V_TTPHIM 
AS
(SELECT MaPhim, TenPhim, TenLoaiPhim
FROM PHIM, LOAIPHIM
WHERE PHIM.MaLoai = LOAIPHIM.MaLoai)

SELECT * FROM V_TTPHIM

-- Phần Diễn làm
create table KHACHHANG(
makh char(10) primary key not null,
tenkh nvarchar(30), diachi nvarchar(30),
sdt char(10),
gioitinh nchar(5), ngaysinh date);


create table NHANVIEN(
manv char(10) primary key not null,
tennv nvarchar(30), diachi nvarchar(30),
sdt char(10),
gioitinh nchar(5), ngaysinh date);

select * from KHACHHANG
insert into KHACHHANG values('KH01',N'Nguyễn Văn Minh',N'Nam Từ Liêm, Hà Nội','0985171516',N'Nam','2002-02-01')
insert into KHACHHANG values('KH02',N'Trần Văn Chân',N'Cầu Giấy, Hà Nội','0985172916',N'Nam','2002-02-01')
insert into KHACHHANG values('KH03',N'Nguyễn Minh Hòa',N'Hai Bà Trưng, Hà Nội','0985271686',N'Nữ','2001-02-15')
insert into KHACHHANG values('KH04',N'Phạm Văn Minh',N'Nam Từ Liêm, Hà Nội','0985171516',N'Nam','1999-02-01')
insert into KHACHHANG values('KH05',N'Nguyễn Anh Khoa',N'Bắc Từ Liêm, Hà Nội','0985171517',N'Nam','2005-07-09')
insert into KHACHHANG values('KH06',N'Huỳnh Thị Anh Thư',N'Quận 1, TP.Hồ Chí Minh','0985171518',N'Nữ','2002-12-12')
insert into KHACHHANG values('KH07',N'Lê Thị Trung Anh',N'Đống Đa, Hà Nội','0985171519',N'Nữ','2002-06-13')
insert into KHACHHANG values('KH08',N'Lê Thị Thùy Linh',N'Thanh Xuân, Hà Nội','0985171510',N'Nữ','2002-05-29')
insert into KHACHHANG values('KH09',N'Nguyễn Văn Hà',N'Nam Từ Liêm, Hà Nội','0985171526',N'Nam','2002-02-01')
insert into KHACHHANG values('KH10',N'Dương Văn Linh',N'Quận 5, TP.Hồ Chí Minh','0885171536',N'Nam','1990-08-11')
insert into KHACHHANG values('KH18',N'Trần Anh Quân',N'Tây Hồ, Hà Nội','0995171829',N'Nam','2009-11-09')
insert into KHACHHANG values('KH20',N'Phạm Khánh Linh',N'Thanh Xuân, Hà Nội','0985272512',N'Nữ','2005-12-10')
insert into KHACHHANG values('KH25',N'Lê Hồng Hưng',N'Thanh Miện, Hải Dương','0985272512',N'Nam','1988-12-11')
insert into KHACHHANG values('KH15',N'Triệu Tuyết Vy',N'Hoàn Kiếm, Hà Nội','0985372589',N'Nữ','2004-01-10')
insert into KHACHHANG values('KH16',N'Phạm Anh Khoa',N'Thanh Xuân, Hà Nội','0985272513',N'Nam','1983-11-10')


select * from NHANVIEN
insert into NHANVIEN values('NV01',N'Nguyễn Văn Sơn',N'Kim Thành, Hải Dương','0986172526',N'Nam','1996-03-01')
insert into NHANVIEN values('NV02',N'Lê Thị Quỳnh',N'Triệu Sơn, Thanh Hóa','0986173526',N'Nữ','2000-03-12')
insert into NHANVIEN values('NV03',N'Mai Vĩnh Minh',N'Nam Từ Liêm, Hà Nội','0986173537',N'Nam','2002-02-02')

--Đưa ra khách hàng trên 18 tuổi và sắp xếp theo thứ tự giảm dần
select makh, tenkh, year(getdate())-year(ngaysinh) as 'Tuoi'
from KHACHHANG
where year(getdate())-year(ngaysinh)>18
order by Tuoi desc

--Đưa ra khách hàng dưới 18 tuổi và sắp xếp theo thứ tự giảm dần
select makh, tenkh, year(getdate())-year(ngaysinh) as 'Tuoi'
from KHACHHANG
where year(getdate())-year(ngaysinh)<18
order by Tuoi desc

--Thủ tục thêm khách hàng 
create proc sp_ThemKH @makh char(10), @tenkh nvarchar(30), @diachi nvarchar(30), @sdt char(10), @gioitinh nchar(10), @ngaysinh date
as
BEGIN
 if (exists (select makh from KHACHHANG where makh = @makh))
 print N'Khách hàng này đã tồn tại trong bảng';
	insert into KHACHHANG values (@makh, @tenkh, @diachi, @sdt, @gioitinh, @ngaysinh);
END;

EXEC sp_ThemKH 'KH01',N'Hoàng Thúy Hiền',N'Nam Từ Liêm, Hà Nội','0885271516',N'Nữ','2003-02-01'

--Thủ tục xóa khách hàng
create proc sp_XoaKH @makh char(10)
as
BEGIN
  if (not exists(select makh from KHACHHANG where makh = @makh))
  print N'Không có khách hàng này!';
  delete from KHACHHANG where makh = @makh
END;
EXEC sp_XoaKH 'KH30'

--Thủ tục thêm nhân viên
create proc sp_ThemNV @manv char(10), @tennv nvarchar(30), @diachi nvarchar(30), @sdt char(10), @gioitinh nchar(10), @ngaysinh date
as
BEGIN
 if (exists (select manv from NHANVIEN where manv = @manv))
 print N'Nhân viên này đã tồn tại trong bảng';
	insert into NHANVIEN values (@manv, @tennv, @diachi, @sdt, @gioitinh, @ngaysinh);
END;
EXEC sp_ThemNV 'NV01',N'Hoàng Thu Hiền',N'Nam Từ Liêm, Hà Nội','0885272516',N'Nữ','2003-02-02'

--Thủ tục xóa nhân viên
create proc sp_XoaNV @manv char(10)
as
BEGIN
  if (not exists(select manv from NHANVIEN where manv = @manv))
  print N'Không có nhân viên này!';
  delete from NHANVIEN where manv = @manv
END;
EXEC sp_XoaNV 'NV30'

