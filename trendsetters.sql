CREATE DATABASE TrendSetters;
GO

USE TrendSetters;
GO

-- Bảng DiaChi (Địa chỉ khách hàng)
CREATE TABLE DiaChi (
    id INT PRIMARY KEY IDENTITY,
    so_nha NVARCHAR(50),
    phuong NVARCHAR(100),
    huyen NVARCHAR(100),
    thanh_pho NVARCHAR(100),
    trang_thai NVARCHAR(50)
);
GO

-- Bảng DanhMuc (Danh mục sản phẩm)
CREATE TABLE DanhMuc (
    id INT PRIMARY KEY IDENTITY,
    ten_danh_muc NVARCHAR(255),
    trang_thai NVARCHAR(50)
);
GO

-- Bảng MauSac (Màu sắc sản phẩm)
CREATE TABLE MauSac (
    id INT PRIMARY KEY IDENTITY,
    ten_mau_sac NVARCHAR(255),
    trang_thai NVARCHAR(50)
);
GO

-- Bảng KichThuoc (Kích thước sản phẩm)
CREATE TABLE KichThuoc (
    id INT PRIMARY KEY IDENTITY,
    ten_kich_thuoc NVARCHAR(255),
    trang_thai NVARCHAR(50)
);
GO

-- Bảng ChatLieu (Chất liệu sản phẩm)
CREATE TABLE ChatLieu (
    id INT PRIMARY KEY IDENTITY,
    ten_chat_lieu NVARCHAR(255),
    mo_ta NVARCHAR(255)
);
GO

-- Bảng ThuongHieu (Thương hiệu sản phẩm)
CREATE TABLE ThuongHieu (
    id INT PRIMARY KEY IDENTITY,
    ten_thuong_hieu NVARCHAR(255),
    trang_thai NVARCHAR(50)
);
GO

-- Bảng XuatSu (Xuất xứ sản phẩm)
CREATE TABLE XuatSu (
    id INT PRIMARY KEY IDENTITY,
    ten_xuat_su NVARCHAR(255),
    trang_thai NVARCHAR(50)
);
GO

-- Bảng PhuongThucThanhToan (Phương thức thanh toán)
CREATE TABLE PhuongThucThanhToan (
    id INT PRIMARY KEY IDENTITY,
    ten_phuong_thuc NVARCHAR(100),
    ngay_tao DATETIME,
    ngay_sua DATETIME,
    trang_thai NVARCHAR(50)
);
GO

-- Bảng NhanVien (Nhân viên)
CREATE TABLE NhanVien (
    id INT PRIMARY KEY IDENTITY,
    ho_ten NVARCHAR(255),
    sdt NVARCHAR(20),
    email NVARCHAR(100),
    mat_khau NVARCHAR(255),
    gioi_tinh NVARCHAR(10),
    chuc_vu NVARCHAR(100),
    ngay_tao DATETIME,
    ngay_sua DATETIME,
    trang_thai NVARCHAR(50)
);
GO

-- Bảng KhachHang (Khách hàng)
CREATE TABLE KhachHang (
    id INT PRIMARY KEY IDENTITY,
    ho_ten NVARCHAR(255),
    sdt NVARCHAR(20),
    email NVARCHAR(100),
    gioi_tinh NVARCHAR(10),
    mat_khau NVARCHAR(255),
    id_dia_chi INT,
    trang_thai NVARCHAR(50),
    FOREIGN KEY (id_dia_chi) REFERENCES DiaChi(id)
);
GO

-- Bảng SanPham (Sản phẩm)
CREATE TABLE SanPham (
    id INT PRIMARY KEY IDENTITY,
    ten_san_pham NVARCHAR(255),
    ngay_tao DATETIME,
    ngay_sua DATETIME,
    id_danh_muc INT,
    trang_thai NVARCHAR(50),
    FOREIGN KEY (id_danh_muc) REFERENCES DanhMuc(id)
);
GO

-- Bảng SanPhamChiTiet (Chi tiết sản phẩm)
CREATE TABLE SanPhamChiTiet (
    id INT PRIMARY KEY IDENTITY,
    id_san_pham INT,
    id_mau_sac INT,
    id_kich_thuoc INT,
    id_chat_lieu INT,
    id_thuong_hieu INT,
    id_xuat_su INT,
    so_luong INT,
    gia_ban DECIMAL(18, 2),
    ngay_tao DATETIME,
    ngay_sua DATETIME,
    FOREIGN KEY (id_san_pham) REFERENCES SanPham(id),
    FOREIGN KEY (id_mau_sac) REFERENCES MauSac(id),
    FOREIGN KEY (id_kich_thuoc) REFERENCES KichThuoc(id),
    FOREIGN KEY (id_chat_lieu) REFERENCES ChatLieu(id),
    FOREIGN KEY (id_thuong_hieu) REFERENCES ThuongHieu(id),
    FOREIGN KEY (id_xuat_su) REFERENCES XuatSu(id)
);
GO

-- Bảng SanPhamHinhAnh (Hình ảnh sản phẩm chi tiết)
CREATE TABLE SanPhamHinhAnh (
    id INT PRIMARY KEY IDENTITY,
    id_san_pham_chi_tiet INT,
    url_hinh_anh NVARCHAR(255),
    ngay_tao DATETIME,
    trang_thai NVARCHAR(50),
    FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES SanPhamChiTiet(id)
);
GO

-- Bảng MaGiamGia (Mã giảm giá)
CREATE TABLE MaGiamGia (
    id INT PRIMARY KEY IDENTITY,
    ma_giam_gia NVARCHAR(50),
    gia_tri DECIMAL(18, 2),
    ngay_bat_dau DATETIME,
    ngay_ket_thuc DATETIME,
    ngay_tao DATETIME,
    ngay_sua DATETIME,
    trang_thai NVARCHAR(50)
);
GO

-- Bảng KhuyenMai (Chương trình khuyến mãi)
CREATE TABLE KhuyenMai (
    id INT PRIMARY KEY IDENTITY,
    ten_chuong_trinh NVARCHAR(255),
    mo_ta NVARCHAR(255),
    gia_tri DECIMAL(18, 2),
    dieu_kien NVARCHAR(255),
    trang_thai NVARCHAR(50),
    ngay_tao DATETIME,
    ngay_sua DATETIME
);
GO

-- Bảng HoaDon (Hóa đơn)
CREATE TABLE HoaDon (
    id INT PRIMARY KEY IDENTITY,
    id_khach_hang INT,
    id_nhan_vien INT,
    id_khuyen_mai INT,
    tong_tien DECIMAL(18, 2),
    ngay_tao DATETIME,
    ngay_cap_nhat DATETIME,
    id_phuong_thuc_thanh_toan INT,
    trang_thai NVARCHAR(50),
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id),
    FOREIGN KEY (id_nhan_vien) REFERENCES NhanVien(id),
    FOREIGN KEY (id_khuyen_mai) REFERENCES KhuyenMai(id),
    FOREIGN KEY (id_phuong_thuc_thanh_toan) REFERENCES PhuongThucThanhToan(id)
);
GO

-- Bảng HoaDonChiTiet (Chi tiết hóa đơn)
CREATE TABLE HoaDonChiTiet (
    id INT PRIMARY KEY IDENTITY,
    id_san_pham_chi_tiet INT,
    id_hoa_don INT,
    so_luong INT,
    gia DECIMAL(18, 2),
    gia_tri_giam DECIMAL(18, 2) DEFAULT 0, -- Thêm trường giảm giá
    id_ma_giam_gia INT,  -- Thêm mã giảm giá
    ngay_tao DATETIME,
    ngay_sua DATETIME,
    FOREIGN KEY (id_san_pham_chi_tiet) REFERENCES SanPhamChiTiet(id),
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id),
    FOREIGN KEY (id_ma_giam_gia) REFERENCES MaGiamGia(id) -- Liên kết với mã giảm giá
);
GO

-- Bảng LichSuThanhToan (Lịch sử thanh toán)
CREATE TABLE LichSuThanhToan (
    id INT PRIMARY KEY IDENTITY,
    id_hoa_don INT,
    ngay_thanh_toan DATETIME,
    phuong_thuc_thanh_toan NVARCHAR(50),
    so_tien_da_thanh_toan DECIMAL(18, 2),
    trang_thai NVARCHAR(50),
    FOREIGN KEY (id_hoa_don) REFERENCES HoaDon(id)
);
GO

-- Bảng ThongKe (Thống kê)
CREATE TABLE ThongKe (
    id INT PRIMARY KEY IDENTITY,
    thoi_gian NVARCHAR(255),
    tong_doanh_thu DECIMAL(18, 2),
    san_pham_ban_chay NVARCHAR(255),
    tong_hoa_don INT,
    so_luong_khach_hang_moi INT
);
GO
-- Bảng DanhGia (Đánh giá sản phẩm từ khách hàng)
CREATE TABLE DanhGia (
    id INT PRIMARY KEY IDENTITY,
    id_khach_hang INT,
    so_sao INT,
    nhan_xet NVARCHAR(255),
    ngay_danh_gia DATETIME,
    trang_thai NVARCHAR(50), 
    FOREIGN KEY (id_khach_hang) REFERENCES KhachHang(id)
);
GO

