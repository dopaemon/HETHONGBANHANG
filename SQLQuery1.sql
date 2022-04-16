CREATE DATABASE FAKESHOP
GO
USE FAKESHOP

GO
CREATE TABLE DB_QUYENACCOUNT
(
	MAQUYEN NVARCHAR(10),
	TENQUYEN NVARCHAR(50),
	CONSTRAINT PK_MAQUYEN PRIMARY KEY (MAQUYEN)
);

GO
CREATE TABLE DB_DANGKY
(
	USERNAME NVARCHAR(20),
	PASSWD NVARCHAR(20),
	EMAILDK NVARCHAR(50),
	DIACHIDK NVARCHAR(100),
	TENDAYDU NVARCHAR(50),
	CAUHOIBAOMAT NVARCHAR(50),
	NGAYSINH DATE,
	GIOITINHDK TINYINT,
	MAQUYEN NVARCHAR(10)
	CONSTRAINT PK_USERNAME PRIMARY KEY (USERNAME),
	CONSTRAINT FK_MAQUYEN FOREIGN KEY (MAQUYEN) REFERENCES DB_QUYENACCOUNT(MAQUYEN)
);

GO
CREATE TABLE DB_KHACHHANG
(
	MAKH NVARCHAR(10),
	TENKH NVARCHAR(50),
	NGAYSINH DATE,
	CAPDO INT,
	DIACHI NVARCHAR(20),
	SODIENTHOAI NVARCHAR(20),
	EMAIL NVARCHAR(50),
	CONSTRAINT PK_MAKH PRIMARY KEY (MAKH)
);

GO
CREATE TABLE DB_DANHMUC
(
	MADANHMUC NVARCHAR(10),
	TENDANHMUC NVARCHAR(50),
	AVARTARDANHMUC NVARCHAR(100),
	THUTU NVARCHAR(10),
	SANPHAMHIENTHI NVARCHAR(10),
	CONSTRAINT PK_MADANHMUC PRIMARY KEY (MADANHMUC)
);

GO
CREATE TABLE DB_MAUSAC
(
	MAMAUSAC INT,
	TENMAUSAC NVARCHAR(20),
	CONSTRAINT PK_MAMAUSAC PRIMARY KEY (MAMAUSAC)
);

GO
CREATE TABLE DB_SANPHAM
(
	MASANPHAM NVARCHAR(10),
	TENSANPHAM NVARCHAR(50),
	SOLUONG INT,
	NGAYNHAP DATE,
	NGAYHUY DATE,
	MAMAUSAC INT,
	AVARTARSP NVARCHAR(100),
	GIASP MONEY,
	MOTASP NVARCHAR(1000),
	MADANHMUC NVARCHAR(10),
	CONSTRAINT PK_MASANPHAM PRIMARY KEY (MASANPHAM),
	CONSTRAINT FK_MADANHMUC FOREIGN KEY (MADANHMUC) REFERENCES DB_DANHMUC(MADANHMUC),
	CONSTRAINT FK_MAMAUSAC FOREIGN KEY (MAMAUSAC) REFERENCES DB_MAUSAC(MAMAUSAC)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

GO
CREATE TABLE DB_DONHANG
(
	MADONHANG NVARCHAR(10),
	TENDONHANG NVARCHAR(50),
	NGAYTAO DATE,
	SOLUONG INT,
	THANHTIENDH MONEY,
	MAKH NVARCHAR(10),
	TENKH NVARCHAR(50),
	EMAIL NVARCHAR(50),
	CONSTRAINT PK_MADONHANG PRIMARY KEY (MADONHANG),
	CONSTRAINT FK_MAKH FOREIGN KEY (MAKH) REFERENCES DB_KHACHHANG(MAKH)
);

GO
CREATE TABLE DB_INFODONHANG
(
	MASANPHAM NVARCHAR(10),
	MADONHANG NVARCHAR(10),
	SOLUONG INT,
	DONGIA MONEY,
	CONSTRAINT PK_MASANPHAM_MADONHANG PRIMARY KEY (MASANPHAM, MADONHANG),
	CONSTRAINT FK_MASANPHAM FOREIGN KEY (MASANPHAM) REFERENCES DB_SANPHAM(MASANPHAM),
	CONSTRAINT FK_MADONHANG FOREIGN KEY (MADONHANG) REFERENCES DB_DONHANG(MADONHANG)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE DB_NHANVIEN
(
	MANV NVARCHAR(10),
	TENNV NVARCHAR(50),
	GIOITINH TINYINT,
	DIACHI NVARCHAR(50),
	SDT NVARCHAR(20),
	NGAYVAOLAM DATE,
	CONSTRAINT PK_MANV PRIMARY KEY (MANV)
);

CREATE TABLE DB_HOADON
(
	MAHD NVARCHAR(10),
	NGAYLAP DATE,
	THANHTIEN MONEY,
	MANV NVARCHAR(10),
	TENNV NVARCHAR(50),
	MAKH NVARCHAR(10),
	TENKH NVARCHAR(50),
	CONSTRAINT PK_MAHD PRIMARY KEY (MAHD),
	CONSTRAINT FK_MAKH_HD FOREIGN KEY (MAKH) REFERENCES DB_KHACHHANG(MAKH),
	CONSTRAINT FK_MANV FOREIGN KEY (MANV) REFERENCES DB_NHANVIEN(MANV)
);


GO
CREATE TABLE DB_INFOHOADON
(
	MAHD NVARCHAR(10),
	MASANPHAM NVARCHAR(10),
	SOLUONG INT,
	DONGIA MONEY,
	CONSTRAINT PK_MAHD_MASANPHAM PRIMARY KEY (MAHD, MASANPHAM),
	CONSTRAINT FK_MAHD FOREIGN KEY (MAHD) REFERENCES DB_HOADON(MAHD),
	CONSTRAINT FK_MASANPHAM_INFOHD FOREIGN KEY (MASANPHAM) REFERENCES DB_SANPHAM(MASANPHAM)
);

-- PROCEDURE --
-- CREATE --
-- Đăng Ký --
	CREATE PROC THEM_DANGKY
	@USERNAME NVARCHAR(20), -- Tài khoản
	@PASSWD NVARCHAR(20), -- Mật khẩu
	@EMAILDK NVARCHAR(50), -- Email
	@DIACHIDK NVARCHAR(100), -- Địa chỉ
	@TENDAYDU NVARCHAR(50), -- Họ và tên
	@CAUHOIBAOMAT NVARCHAR(50), -- Câu hỏi bắt buộc
	@NGAYSINH DATE, -- Ngày sinh
	@GIOITINHDK TINYINT, -- Giới tính
	@MAQUYEN NVARCHAR(10) -- Mã quyền
	AS
	BEGIN
		INSERT INTO DB_DANGKY(USERNAME, PASSWD, EMAILDK, DIACHIDK, TENDAYDU, CAUHOIBAOMAT, NGAYSINH, GIOITINHDK, MAQUYEN)
		VALUES (@USERNAME, @PASSWD, @EMAILDK, @DIACHIDK, @TENDAYDU, @CAUHOIBAOMAT, @NGAYSINH, @GIOITINHDK, @MAQUYEN)
	END
-- Quyền Tài Khoản --
	CREATE PROC THEM_QUYENACCOUNT
	@MAQUYEN NVARCHAR(10),
	@TENQUYEN NVARCHAR(50)
	AS
	BEGIN
		INSERT INTO DB_QUYENACCOUNT(MAQUYEN, TENQUYEN)
		VALUES (@MAQUYEN, @TENQUYEN)
	END
-- Danh Mục
	CREATE PROC THEM_DANHMUC
	@MADANHMUC NVARCHAR(10),
	@TENDANHMUC NVARCHAR(50),
	@AVARTARDANHMUC NVARCHAR(100),
	@THUTU NVARCHAR(10),
	@SANPHAMHIENTHI NVARCHAR(10)
	AS
	BEGIN
		INSERT INTO DB_DANHMUC(MADANHMUC, TENDANHMUC, AVARTARDANHMUC, THUTU, SANPHAMHIENTHI)
		VALUES (@MADANHMUC, @TENDANHMUC, @AVARTARDANHMUC, @THUTU, @SANPHAMHIENTHI)
	END
-- Màu Sắc
	CREATE PROC THEM_MAUSAC
	@MAMAUSAC INT,
	@TENMAUSAC NVARCHAR(20)
	AS
	BEGIN
		INSERT INTO DB_MAUSAC(MAMAUSAC, TENMAUSAC)
		VALUES (@MAMAUSAC, @TENMAUSAC)
	END
-- Sản Phẩm
	CREATE PROC THEM_SANPHAM
	@MASANPHAM NVARCHAR(10),
	@TENSANPHAM NVARCHAR(50),
	@SOLUONG INT,
	@NGAYNHAP DATE,
	@NGAYHUY DATE,
	@MAMAUSAC INT,
	@AVATARSP NVARCHAR(100),
	@GIASP MONEY,
	@MOTASP NVARCHAR(1000),
	@MADANHMUC NVARCHAR(10)
	AS
	BEGIN
		INSERT INTO DB_SANPHAM(MASANPHAM, TENSANPHAM, SOLUONG, NGAYNHAP, NGAYHUY, MAMAUSAC, AVARTARSP, GIASP, MOTASP, MADANHMUC)
		VALUES (@MASANPHAM, @TENSANPHAM, @SOLUONG, @NGAYNHAP, @NGAYHUY, @MAMAUSAC, @AVATARSP, @GIASP, @MOTASP, @MADANHMUC)
	END
-- Thông tin đơn hàng --
	CREATE PROC THEM_INFODONHANG
	@MASANPHAM NVARCHAR(10),
	@MADONHANG NVARCHAR(10),
	@SOLUONG INT,
	@DONGIA MONEY
	AS
	BEGIN
		INSERT INTO DB_INFODONHANG(MASANPHAM, MADONHANG, SOLUONG,DONGIA)
		VALUES (@MASANPHAM, @MADONHANG, @SOLUONG, @DONGIA)
	END
-- Đơn Hàng --
	CREATE PROC THEM_DONHANG
	@MADONHANG NVARCHAR(10),
	@TENDONHANG NVARCHAR(50),
	@NGAYTAO DATE,
	@SOLUONG INT,
	@THANHTIENDH MONEY,
	@MAKH NVARCHAR(10),
	@TENKH NVARCHAR(50),
	@EMAIL NVARCHAR(50)
	AS
	BEGIN
		INSERT INTO DB_DONHANG(MADONHANG, TENDONHANG, NGAYTAO, SOLUONG, THANHTIENDH, MAKH, TENKH, EMAIL)
		VALUES (@MADONHANG, @TENDONHANG, @NGAYTAO, @SOLUONG, @THANHTIENDH, @MAKH, @TENKH, @EMAIL)
	END
-- Khách hàng --
	CREATE PROC THEM_KHACHHANG
	@MAKH NVARCHAR(10),
	@TENKH NVARCHAR(50),
	@NGAYSINH DATE,
	@CAPDO INT,
	@DIACHI NVARCHAR(20),
	@SODIENTHOAI NVARCHAR(20),
	@EMAIL NVARCHAR(50)
	AS
	BEGIN
		INSERT INTO DB_KHACHHANG(MAKH, TENKH, NGAYSINH, CAPDO, DIACHI, SODIENTHOAI, EMAIL)
		VALUES (@MAKH, @TENKH, @NGAYSINH, @CAPDO, @DIACHI, @SODIENTHOAI, @EMAIL)
	END
-- Hoá Đơn --
	CREATE PROC THEM_HOADON
	@MAHD NVARCHAR(10),
	@NGAYLAP DATE,
	@THANHTIEN MONEY,
	@MANV NVARCHAR(10),
	@TENNV NVARCHAR(50),
	@MAKH NVARCHAR(10),
	@TENKH NVARCHAR(50)
	AS
	BEGIN
		INSERT INTO DB_HOADON(MAHD, NGAYLAP, THANHTIEN, MANV, TENNV, MAKH, TENKH)
		VALUES (@MAHD, @NGAYLAP, @THANHTIEN, @MANV, @TENNV, @MAKH, @TENKH)
	END
-- Nhân Viên --
	CREATE PROC THEM_NHANVIEN
	@MANV NVARCHAR(10),
	@TENNV NVARCHAR(50),
	@GIOITINH TINYINT,
	@DIACHI NVARCHAR(50),
	@SDT NVARCHAR(20),
	@NGAYVAOLAM DATE
	AS
	BEGIN
		INSERT INTO DB_NHANVIEN(MANV, TENNV, GIOITINH, DIACHI, SDT, NGAYVAOLAM)
		VALUES (@MANV, @TENNV, @GIOITINH, @DIACHI, @SDT, @NGAYVAOLAM)
	END
-- Thông Tin Hoá Đơn --
	CREATE PROC THEM_INFOHOADON
	@MAHD NVARCHAR(10),
	@MASANPHAM NVARCHAR(10),
	@SOLUONG INT,
	@DONGIA MONEY
	AS
	BEGIN
		INSERT INTO DB_INFOHOADON(MAHD, MASANPHAM, SOLUONG, DONGIA)
		VALUES (@MAHD, @MASANPHAM, @SOLUONG, @DONGIA)
	END

-- XEM
-- Đăng Ký --
	CREATE PROC XEM_DANGKY
	AS
	BEGIN
		SELECT *
		FROM DB_DANGKY
	END
-- Quyền Account --
	CREATE PROC XEM_QUYENACCOUNT
	AS
	BEGIN
		SELECT *
		FROM DB_QUYENACCOUNT
	END
-- Danh Mục --
	CREATE PROC XEM_DANHMUC
	AS
	BEGIN
		SELECT *
		FROM DB_DANHMUC
	END
-- Màu Sắc --
	CREATE PROC XEM_MAUSAC
	AS
	BEGIN
		SELECT *
		FROM DB_MAUSAC
	END
-- Sản Phẩm --
	CREATE PROC XEM_SANPHAM
	AS
	BEGIN
		SELECT *
		FROM DB_SANPHAM
	END
-- Thông tin đơn hàng --
	CREATE PROC XEM_INFODONHANG
	AS
	BEGIN
		SELECT *
		FROM DB_INFODONHANG
	END
-- Đơn Hàng --
	CREATE PROC XEM_DONHANG
	AS
	BEGIN
		SELECT *
		FROM DB_DONHANG
	END
-- Khách hàng --
	CREATE PROC XEM_KHACHHANG
	AS
	BEGIN
		SELECT *
		FROM DB_KHACHHANG
	END
-- Hoá Đơn --
	CREATE PROC XEM_HOADON
	AS
	BEGIN
		SELECT *
		FROM DB_HOADON
	END
-- Nhân Viên --
	CREATE PROC XEM_NHANVIEN
	AS
	BEGIN
		SELECT *
		FROM DB_NHANVIEN
	END
-- Thông tin hoá đơn --
	CREATE PROC XEM_INFOHOADON
	AS
	BEGIN
		SELECT *
		FROM DB_INFOHOADON
	END

-- XOÁ --
-- Đăng Ký --
	CREATE PROC XOA_DANGKY
	@USERNAME NVARCHAR(20)
	AS
	BEGIN
		DELETE
		FROM DB_DANGKY
		WHERE USERNAME = @USERNAME
	END
-- Quyền Account --
	CREATE PROC XOA_QUYENACCOUNT
	@MAQUYEN NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_QUYENACCOUNT
		WHERE MAQUYEN = @MAQUYEN
	END
-- Màu sắc --
	CREATE PROC XOA_MAUSAC
	@MAMAUSAC NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_MAUSAC
		WHERE MAMAUSAC = @MAMAUSAC
	END
-- Danh Mục --
	CREATE PROC XOA_DANHMUC
	@MADANHMUC NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_DANHMUC
		WHERE MADANHMUC = @MADANHMUC
	END
-- Sản Phẩm --
	CREATE PROC XOA_SANPHAM
	@MASANPHAM NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_SANPHAM
		WHERE MASANPHAM = @MASANPHAM
	END
-- Info Đơn Hàng --
	CREATE PROC XOA_INFODONHANG
	@MASANPHAM NVARCHAR(10),
	@MADONHANG NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_INFODONHANG
		WHERE MASANPHAM = @MASANPHAM
			AND MADONHANG = @MADONHANG
	END
-- Đơn Hàng --
	CREATE PROC XOA_DONHANG
	@MADONHANG NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_DONHANG
		WHERE MADONHANG = @MADONHANG
	END
-- Khách Hàng --
	CREATE PROC XOA_KHACHHANG
	@MAKH NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_KHACHHANG
		WHERE MAKH = @MAKH
	END
-- Hoá Đơn --
	 CREATE PROC XOA_HOADON
	 @MAHD NVARCHAR(10)
	 AS
	 BEGIN
		DELETE
		FROM DB_HOADON
		WHERE MAHD = @MAHD
	 END
-- Nhân Viên --
	CREATE PROC XOA_NHANVIEN
	@MANV NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_NHANVIEN
		WHERE MANV = @MANV
	END
-- Thông tin hoá đơn --
	CREATE PROC XOA_INFOHOADON
	@MAHD NVARCHAR(10),
	@MASANPHAM NVARCHAR(10)
	AS
	BEGIN
		DELETE
		FROM DB_INFOHOADON
		WHERE MAHD = @MAHD AND MASANPHAM = @MASANPHAM
	END

-- Cập Nhật --
-- Đăng Ký --
	CREATE PROC UPDATE_DANGKY
	@USERNAME NVARCHAR(20) = '',
	@PASSWDMOI NVARCHAR(20) = '',
	@EMAILDKMOI NVARCHAR(50) = '',
	@DIACHIDKMOI NVARCHAR(100) = '',
	@TENDAYDUMOI NVARCHAR(50) = '',
	@CAUHOIBAOMATMOI NVARCHAR(50) = '',
	@NGAYSINHMOI DATE = '',
	@GIOITINHDKMOI TINYINT = '',
	@MAQUYENMOI NVARCHAR(10) = ''
	AS
	BEGIN
		UPDATE DB_DANGKY
		SET USERNAME = @USERNAME,
			PASSWD = @PASSWDMOI,
			EMAILDK = @EMAILDKMOI,
			DIACHIDK = @DIACHIDKMOI,
			TENDAYDU = @TENDAYDUMOI,
			CAUHOIBAOMAT = @CAUHOIBAOMATMOI,
			NGAYSINH = @NGAYSINHMOI,
			GIOITINHDK = @GIOITINHDKMOI,
			MAQUYEN = @MAQUYENMOI
		WHERE USERNAME = @USERNAME
	END
-- Quyền Account --
	CREATE PROC UPDATE_QUYENACCOUNT
	@MAQUYEN NVARCHAR(10) = '',
	@TENQUYENMOI NVARCHAR(50) = ''
	AS
	BEGIN
		UPDATE DB_QUYENACCOUNT
		SET MAQUYEN = @MAQUYEN,
			TENQUYEN = @TENQUYENMOI
		WHERE MAQUYEN = @MAQUYEN
	END
-- Màu Sắc --
	CREATE PROC UPDATE_MAMAUSAC
	@MAMAUSAC NVARCHAR(10) = '',
	@TENMAUSACMOI NVARCHAR(20) = ''
	AS
	BEGIN
		UPDATE DB_MAUSAC
		SET MAMAUSAC = @MAMAUSAC,
			TENMAUSAC = @TENMAUSACMOI
		WHERE MAMAUSAC = @MAMAUSAC
	END
-- Danh Mục --
	CREATE PROC UPDATE_DANHMUC
	@MADANHMUC NVARCHAR(10),
	@TENDANHMUCMOI NVARCHAR(50),
	@AVATARDANHMUCMOI NVARCHAR(100),
	@THUTUMOI NVARCHAR(10),
	@SANPHAMMIENPHIMOI NVARCHAR(10)
	AS
	BEGIN
		UPDATE DB_DANHMUC
		SET MADANHMUC = @MADANHMUC,
			TENDANHMUC = @TENDANHMUCMOI,
			AVARTARDANHMUC = @AVATARDANHMUCMOI,
			THUTU = @THUTUMOI,
			SANPHAMHIENTHI = @SANPHAMMIENPHIMOI
		WHERE MADANHMUC = @MADANHMUC
	END
-- Sản Phẩm --
	CREATE PROC UPDATE_SANPHAM
	@MASANPHAM NVARCHAR(10),
	@TENSANPHAMMOI NVARCHAR(),
	@SOLUONGMOI
	@NGAYNHAPMOI
	@NGAYHUYMOI
	@MAMAUSACMOI
	@AVATARSPMOI
	@GIASP
	@MOTASP
	@MADANHMUC
-- Thông Tin Đơn Hàng --
-- Đơn Hàng --
-- Khách Hàng --
-- Hoá Đơn --
-- Nhân Viên --
-- Thông Tin hoá Đơn --

-- Tìm Kiếm --
-- Đăng Ký --
-- Quyền Account --
-- Màu Sắc --
-- Danh Mục --
-- Sản Phẩm --
-- Thông Tin Đơn Hàng --
-- Đơn Hàng --
-- Khách Hàng --
-- Hoá Đơn --
-- Nhân Viên --
-- Thông Tin hoá Đơn --

-- More --
-- Đăng Ký --
-- Quyền Account --
-- Màu Sắc --
-- Danh Mục --
-- Sản Phẩm --
-- Thông Tin Đơn Hàng --
-- Đơn Hàng --
-- Khách Hàng --
-- Hoá Đơn --
-- Nhân Viên --
-- Thông Tin hoá Đơn --