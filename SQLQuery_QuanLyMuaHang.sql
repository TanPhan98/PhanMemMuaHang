create database QuanLyBanHang

drop database QuanLyBanHang

use QuanLyBanHang

create table NhanVien --1
(
	MaNV CHAR(6) NOT NULL,
	TenNV NVARCHAR(30),
	NgaySinh DATE,
	Phai NVARCHAR(3),
	ChucVu NVARCHAR(30),
	DiaChi NVARCHAR(50),
	TP_Tinh NVARCHAR(50),
	SDT NVARCHAR(10),
	CONSTRAINT PK_NV_MaNV PRIMARY KEY(MaNV)
);

go
create table NhaCungCap --3
(
	MaNCC CHAR(6) NOT NULL,
	TenNCC NVARCHAR(30),
	DiaChiNCC NVARCHAR(50),
	TP_Tinh NVARCHAR(50),
	DienThoaiNCC NVARCHAR(10),
	MST NVARCHAR(13),
	Web	NVARCHAR(50),
	CONSTRAINT PK_NCC_MaNCC PRIMARY KEY(MaNCC)
);
go
create table HangHoa --4
(
	MaHang CHAR(6) NOT NULL,
	TenHang NVARCHAR(30),
	MaNCC CHAR(6),
	DVT NVARCHAR(20),
	SlTonDK INT,
	TGTonDK INT,
	CONSTRAINT PK_HH_MaHang PRIMARY KEY(MaHang),
	constraint FK_HH_MaNCC foreign key (MaNCC) references NhaCungCap(MaNCC)
);
go

create table HoaDonMH --5
(
	MaHDMH CHAR(6) NOT NULL,
	NgayNhap DATETIME,
	MaNV CHAR(6),
	MaNCC CHAR(6),
	CONSTRAINT PK_HDMH_MaHDMH PRIMARY KEY(MaHDMH),
	constraint FK_HDMH_MaNV foreign key (MaNV) references NhanVien(MaNV),
	constraint FK_HDMH_MaNCC foreign key (MaNCC) references NhaCungCap(MaNCC)
);
go
create table ChiTietMH --8
(
	MaHDMH CHAR(6) NOT NULL, --key
	MaHang CHAR(6) NOT NULL, --key
	SLNhap INT,
	DGNhap INT,
	CK INT,
	CP INT,
	CONSTRAINT PK_CTMH_MaHDMH_MaHang PRIMARY KEY(MaHDMH,MaHang),
	constraint FK_CTMH_MaHDMH foreign key (MaHDMH) references HoaDonMH(MaHDMH),
	constraint FK_CTMH_MaHang foreign key (MaHang) references HangHoa(MaHang)
);
go
create table PhieuChi --10
(
	MaPC CHAR(6) NOT NULL,
	MaNV CHAR(6),
	MaNCC CHAR(6),
	NgayChi DATETIME,
	SoTien MONEY,
	CONSTRAINT PK_PC_MaPC PRIMARY KEY(MaPC),
	constraint FK_PC_MaNV foreign key (MaNV) references NhanVien(MaNV),
	constraint FK_PC_MaNCC foreign key (MaNCC) references NhaCungCap(MaNCC)
);
go

create table TaiKhoanUser --10
(
	TenTK CHAR(30) NOT NULL,
	MatKhau CHAR(30),
);

insert into TaiKhoanUser values('admin','123')
--------------------------------------
go
create table KhachHang --2
(
	MaKH CHAR(6) NOT NULL,
	TenKH NVARCHAR(30),
	DiaChiKH NVARCHAR(50),
	TP_Tinh NVARCHAR(50),
	DienThoaiKH NVARCHAR(10),
	MST NVARCHAR(13),  -- Ma so thue
	CONSTRAINT PK_KH_MaKH PRIMARY KEY(MaKH)
);
create table HoaDonBH --6
(
	MaHDBH CHAR(6) NOT NULL,
	NgayLHD DATETIME,
	MaKH CHAR(6),
	MaNV CHAR(6),
	CONSTRAINT PK_HDBH_MaHDBH PRIMARY KEY(MaHDBH),
	constraint FK_HDBH_MaKH foreign key (MaKH) references KhachHang(MaKH),
	constraint FK_HDBH_MaNV foreign key (MaNV) references NhanVien(MaNV)
);
go
create table ChiTietBH --7
(
	MaHDBH CHAR(6) NOT NULL, --key
	MaHang CHAR(6) NOT NULL, --key
	SLBan INT,
	DGBan INT,
	CK INT,
	CP INT,
	CONSTRAINT PK_CTBH_MaHDBH_MaHang PRIMARY KEY(MaHDBH,MaHang),
	constraint FK_CTBH_MaHDMH foreign key (MaHDBH) references HoaDonBH(MaHDBH),
	constraint FK_CTBH_MaHang foreign key (MaHang) references HangHoa(MaHang)
);
go
create table PhieuThu --9
(
	MaPTT CHAR(6) NOT NULL,
	MaKH CHAR(6),
	NgayTT DATETIME,
	SoTienTT MONEY,
	MaNV CHAR(6),
	CONSTRAINT PK_PT_MaPTT PRIMARY KEY(MaPTT),
	constraint FK_PT_MaKH foreign key (MaKH) references KhachHang(MaKH),
	constraint FK_PT_MaNV foreign key (MaNV) references NhanVien(MaNV)
);

set dateformat dmy;
--INSERT DATA

Insert into NhanVien values('NV001',N' Nguyễn Ngọc Hiếu','1/1/2000',N'Nam',N'Nhân Viên',N'351 Đại lộ 3','HCM','0933124456');
Insert into NhanVien values('NV002',N' Ngô Thanh Ngân','2/2/2000',N'Nữ',N'Nhân Viên',N'321 vườn chuối','HCM','0933121326');
Insert into NhanVien values('NV003',N' Trương Tuấn Kiệt','3/3/2000',N'Nam',N'Nhân Viên',N'111 Bùi Thị Xuân','HCM','0933121326');
Insert into NhanVien values('NV004',N' Trịnh Quý Dương','4/4/2000',N'Nam',N'Nhân Viên',N'241 Bùi Thị Xuân','HCM','0933121326');
Insert into NhanVien values('NV005',N' Phan Nhật Tân','5/5/2000',N'Nam',N'Nhân Viên',N'211 Điện Biên Phủ','HCM','0933112326');


Insert into KhachHang values('KH001',N' Nguyễn Thái Viễn',N'305 Đại lộ 3','HCM','0933124456','000000001');
Insert into KhachHang values('KH002',N' Nguyễn Kiên Hòa',N'30 vườn chuối','HCM','0933121326','000000002');
Insert into KhachHang values('KH003',N' Phạm Lan Ngọc',N'11 Bùi Thị Xuân','HCM','0933121326','000000003');
Insert into KhachHang values('KH004',N' Nguyễn Ngọc Thư',N'24 Bùi Thị Xuân','HCM','0933121326','000000004');
Insert into KhachHang values('KH005',N' Nguyễn Văn An',N'215 Điện Biên Phủ','HCM','0933112326','000000005');

Insert into NhaCungCap values('NCC001','Mercedes',N'3051 Đại lộ 3','HCM','0933124456','000000011','Mercedes.com');
Insert into NhaCungCap values('NCC002','BMW',N'3011 vườn chuối','HCM','0933121326','000000022','bmw.com');
Insert into NhaCungCap values('NCC003','Volswagen',N'1131 Bùi Thị Xuân','HCM','0933121326','000000033','volswagen.com');
Insert into NhaCungCap values('NCC004','Audi',N'2451 Bùi Thị Xuân','HCM','0933121326','000000044','audi.com');
Insert into NhaCungCap values('NCC005','Ford',N'2151 Điện Biên Phủ','HCM','0933112326','000000055','ford.com');


Insert into HangHoa values('MH001','hang1','NCC001','chiec',1,200);
Insert into HangHoa values('MH002','hang2','NCC001','chiec',2,200);
Insert into HangHoa values('MH003','hang2','NCC002','chiec',3,200);
Insert into HangHoa values('MH004','hang2','NCC003','chiec',4,200);

Insert into HoaDonMH values('HD001','2/1/2000','NV002','NCC001');
Insert into ChiTietMH values('HD001','MH001',20,20,1,1);
Insert into ChiTietMH values('HD001','MH002',20,20,1,1);


Insert into HoaDonMH values('HD002','2/1/2000','NV002','NCC001');
Insert into ChiTietMH values('HD002','MH003',20,20,1,1);

Insert into PhieuChi values('PC001','NV002','NCC001','2/1/2000',2000000);

Select * from Nhanvien where TenKH LIKE '%nguy%'

Select * from NhaCungCap

Select * from ChiTietMH,HoaDonMH where ChiTietMH.MaHDMH =,HoaDonMH.MaHDMH and ChiTietMH.MaHDMH like 'hd001'