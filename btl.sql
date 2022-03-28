﻿CREATE DATABASE QL_VE_XEM_PHIM
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





