USE [master]
GO
/****** Object:  Database [DATN]    Script Date: 24/11/2024 7:20:33 PM ******/
CREATE DATABASE [DATN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DATN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DATN.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DATN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\DATN_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DATN] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DATN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DATN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DATN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DATN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DATN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DATN] SET ARITHABORT OFF 
GO
ALTER DATABASE [DATN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DATN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DATN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DATN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DATN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DATN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DATN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DATN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DATN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DATN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DATN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DATN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DATN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DATN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DATN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DATN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DATN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DATN] SET RECOVERY FULL 
GO
ALTER DATABASE [DATN] SET  MULTI_USER 
GO
ALTER DATABASE [DATN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DATN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DATN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DATN] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DATN] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DATN] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DATN', N'ON'
GO
ALTER DATABASE [DATN] SET QUERY_STORE = OFF
GO
USE [DATN]
GO
/****** Object:  Table [dbo].[chat_lieu]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chat_lieu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_chat_lieu] [nvarchar](50) NULL,
	[mo_ta] [nvarchar](225) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_chatLieu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[danh_gia]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[danh_gia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[so_sao] [int] NULL,
	[nhan_xet] [nvarchar](50) NULL,
	[ngay_danh_gia] [date] NULL,
 CONSTRAINT [PK_danhGoa] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[danh_muc]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[danh_muc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_danh_muc] [nvarchar](50) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_danh_muc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dia_chi]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dia_chi](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[so_nha] [int] NULL,
	[ten_duong] [nvarchar](50) NULL,
	[phuong] [nvarchar](50) NULL,
	[huyen] [nvarchar](50) NULL,
	[thanh_pho] [nvarchar](50) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_dia_chi] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hoa_don]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hoa_don](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_khuyen_mai] [int] NULL,
	[id_khach_hang] [int] NULL,
	[id_nhan_vien] [int] NULL,
	[ngay_tao] [date] NULL,
	[ngay_sua] [date] NULL,
	[id_phuong_thuc_thanh_toan] [int] NULL,
	[tong_tien] [float] NULL,
	[ghi_chu] [nvarchar](225) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_hoa_don] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[hoa_don_chi_tiet]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hoa_don_chi_tiet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_hoa_don] [int] NULL,
	[id_san_pham_chi_tiet] [int] NULL,
	[so_luong] [int] NULL,
	[gia] [float] NULL,
	[ngay_tao] [date] NULL,
	[ngay_sua] [date] NULL,
	[chi_phi_van_chuyen] [float] NULL,
 CONSTRAINT [PK_hoa_don_chi_tiet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[khach_hang]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[khach_hang](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ho_ten] [nvarchar](50) NULL,
	[email] [varchar](50) NULL,
	[mat_khau] [varchar](50) NULL,
	[ngay_sinh] [date] NULL,
	[id_danh_gia] [int] NULL,
	[ngay_sua] [date] NULL,
	[ngay_tao] [date] NULL,
	[id_dia_chi] [int] NULL,
	[vai_tro] [varchar](50) NULL,
	[trang_thai] [varchar](50) NULL,
	[gioi_tinh] [bit] NULL,
	[hinh_anh] [nvarchar](225) NULL,
 CONSTRAINT [PK_khach_hang] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[khuyen_mai]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[khuyen_mai](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_chuong_trinh] [nvarchar](50) NULL,
	[mo_ta] [nvarchar](225) NULL,
	[gia_tri] [float] NULL,
	[dieu_kien] [float] NULL,
	[ngay_tao] [date] NULL,
	[ngay_sua] [date] NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_khuyen_mai] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kich_thuoc]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kich_thuoc](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_kich_thuoc] [nvarchar](50) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_kich_thuoc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[lich_su_thanh_toan]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[lich_su_thanh_toan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_hoa_don] [int] NULL,
	[ngay_thanh_toan] [date] NULL,
	[phuong_thuc_thanh_toan] [nvarchar](50) NULL,
	[so_tien_da_thanh_toan] [float] NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_history_thanh_toan] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ma_giam_gia]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ma_giam_gia](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ma_giam_gia] [nchar](10) NULL,
	[gia_tri] [float] NULL,
	[ngay_bat_dau] [date] NULL,
	[ngay_ket_thuc] [date] NULL,
	[ngay_tao] [date] NULL,
	[ngay_sua] [date] NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_ma_giam_gia] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mau_sac]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mau_sac](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_mau_sac] [nvarchar](50) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_mau_sac] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nhan_vien]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nhan_vien](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ho_ten] [nvarchar](50) NULL,
	[email] [varchar](50) NULL,
	[mat_khau] [varchar](50) NULL,
	[ngay_sinh] [date] NULL,
	[id_dia_chi] [int] NULL,
	[ngay_sua] [date] NULL,
	[ngay_tao] [date] NULL,
	[trang_thai] [nvarchar](50) NULL,
	[hinh_anh] [nvarchar](225) NULL,
 CONSTRAINT [PK_nhan_vien] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[phuong_thuc_thanh_toan]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phuong_thuc_thanh_toan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_phuong_thuc] [nvarchar](50) NULL,
	[ngay_tao] [datetime] NULL,
	[ngay_sua] [datetime] NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_phuong_thuc] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[san_pham]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[san_pham](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_san_pham] [nvarchar](50) NULL,
	[id_danh_muc] [int] NULL,
	[ngay_tao] [datetime] NULL,
	[ngay_sua] [datetime] NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_san_pham] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[san_pham_chi_tiet]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[san_pham_chi_tiet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[hinh_anh] [nvarchar](225) NULL,
	[id_ma_giam_gia] [int] NULL,
	[id_kich_thuoc] [int] NULL,
	[gia_ban] [float] NULL,
	[so_luong] [int] NULL,
	[ngay_tao] [date] NULL,
	[ngay_sua] [date] NULL,
	[id_san_pham] [int] NULL,
	[id_mau_sac] [int] NULL,
	[id_chat_lieu] [int] NULL,
	[id_thuong_hieu] [int] NULL,
	[id_xuat_su] [int] NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_san_pham_chi_tiet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[thuong_hieu]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[thuong_hieu](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_thuong_hieu] [nvarchar](50) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_thuong_hieu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[xuat_su]    Script Date: 24/11/2024 7:20:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[xuat_su](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ten_xuat_su] [nvarchar](50) NULL,
	[trang_thai] [nvarchar](50) NULL,
 CONSTRAINT [PK_suat_xu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[hoa_don]  WITH CHECK ADD  CONSTRAINT [FK_hoa_don_khach_hang] FOREIGN KEY([id_khach_hang])
REFERENCES [dbo].[khach_hang] ([id])
GO
ALTER TABLE [dbo].[hoa_don] CHECK CONSTRAINT [FK_hoa_don_khach_hang]
GO
ALTER TABLE [dbo].[hoa_don]  WITH CHECK ADD  CONSTRAINT [FK_hoa_don_khuyen_mai] FOREIGN KEY([id_khuyen_mai])
REFERENCES [dbo].[khuyen_mai] ([id])
GO
ALTER TABLE [dbo].[hoa_don] CHECK CONSTRAINT [FK_hoa_don_khuyen_mai]
GO
ALTER TABLE [dbo].[hoa_don]  WITH CHECK ADD  CONSTRAINT [FK_hoa_don_nhan_vien] FOREIGN KEY([id_nhan_vien])
REFERENCES [dbo].[nhan_vien] ([id])
GO
ALTER TABLE [dbo].[hoa_don] CHECK CONSTRAINT [FK_hoa_don_nhan_vien]
GO
ALTER TABLE [dbo].[hoa_don]  WITH CHECK ADD  CONSTRAINT [FK_hoa_don_phuong_thuc_thanh_toan] FOREIGN KEY([id_phuong_thuc_thanh_toan])
REFERENCES [dbo].[phuong_thuc_thanh_toan] ([id])
GO
ALTER TABLE [dbo].[hoa_don] CHECK CONSTRAINT [FK_hoa_don_phuong_thuc_thanh_toan]
GO
ALTER TABLE [dbo].[hoa_don_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_hoa_don_chi_tiet_hoa_don] FOREIGN KEY([id_hoa_don])
REFERENCES [dbo].[hoa_don] ([id])
GO
ALTER TABLE [dbo].[hoa_don_chi_tiet] CHECK CONSTRAINT [FK_hoa_don_chi_tiet_hoa_don]
GO
ALTER TABLE [dbo].[hoa_don_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_hoa_don_chi_tiet_san_pham_chi_tiet] FOREIGN KEY([id_san_pham_chi_tiet])
REFERENCES [dbo].[san_pham_chi_tiet] ([id])
GO
ALTER TABLE [dbo].[hoa_don_chi_tiet] CHECK CONSTRAINT [FK_hoa_don_chi_tiet_san_pham_chi_tiet]
GO
ALTER TABLE [dbo].[khach_hang]  WITH CHECK ADD  CONSTRAINT [FK_khach_hang_danh_gia] FOREIGN KEY([id_danh_gia])
REFERENCES [dbo].[danh_gia] ([id])
GO
ALTER TABLE [dbo].[khach_hang] CHECK CONSTRAINT [FK_khach_hang_danh_gia]
GO
ALTER TABLE [dbo].[khach_hang]  WITH CHECK ADD  CONSTRAINT [FK_khach_hang_dia_chi] FOREIGN KEY([id_dia_chi])
REFERENCES [dbo].[dia_chi] ([id])
GO
ALTER TABLE [dbo].[khach_hang] CHECK CONSTRAINT [FK_khach_hang_dia_chi]
GO
ALTER TABLE [dbo].[lich_su_thanh_toan]  WITH CHECK ADD  CONSTRAINT [FK_lich_su_thanh_toan_hoa_don] FOREIGN KEY([id_hoa_don])
REFERENCES [dbo].[hoa_don] ([id])
GO
ALTER TABLE [dbo].[lich_su_thanh_toan] CHECK CONSTRAINT [FK_lich_su_thanh_toan_hoa_don]
GO
ALTER TABLE [dbo].[nhan_vien]  WITH CHECK ADD  CONSTRAINT [FK_nhan_vien_dia_chi] FOREIGN KEY([id_dia_chi])
REFERENCES [dbo].[dia_chi] ([id])
GO
ALTER TABLE [dbo].[nhan_vien] CHECK CONSTRAINT [FK_nhan_vien_dia_chi]
GO
ALTER TABLE [dbo].[san_pham]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_danh_muc] FOREIGN KEY([id_danh_muc])
REFERENCES [dbo].[danh_muc] ([id])
GO
ALTER TABLE [dbo].[san_pham] CHECK CONSTRAINT [FK_san_pham_danh_muc]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_chat_lieu] FOREIGN KEY([id_chat_lieu])
REFERENCES [dbo].[chat_lieu] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_chat_lieu]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_kich_thuoc] FOREIGN KEY([id_kich_thuoc])
REFERENCES [dbo].[kich_thuoc] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_kich_thuoc]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_ma_giam_gia] FOREIGN KEY([id_ma_giam_gia])
REFERENCES [dbo].[ma_giam_gia] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_ma_giam_gia]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_mau_sac] FOREIGN KEY([id_mau_sac])
REFERENCES [dbo].[mau_sac] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_mau_sac]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_san_pham] FOREIGN KEY([id_san_pham])
REFERENCES [dbo].[san_pham] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_san_pham]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_thuong_hieu] FOREIGN KEY([id_thuong_hieu])
REFERENCES [dbo].[thuong_hieu] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_thuong_hieu]
GO
ALTER TABLE [dbo].[san_pham_chi_tiet]  WITH CHECK ADD  CONSTRAINT [FK_san_pham_chi_tiet_xuat_su] FOREIGN KEY([id_xuat_su])
REFERENCES [dbo].[xuat_su] ([id])
GO
ALTER TABLE [dbo].[san_pham_chi_tiet] CHECK CONSTRAINT [FK_san_pham_chi_tiet_xuat_su]
GO
USE [master]
GO
ALTER DATABASE [DATN] SET  READ_WRITE 
GO
