<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý hóa đơn chi tiết</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Hóa Đơn Chi Tiết</h1>

    <%--Form tìm kiếm--%>
    <div class="container mt-5">
        <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
            <!-- Tiêu đề -->
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-funnel me-2 text-primary" style="font-size: 1.5rem;"></i>
                <h5 class="text-primary mb-0">Bộ lọc</h5>
            </div>

            <!-- Bộ lọc -->
            <form id="filterForm" action="/hoa-don/hien-thi" method="get">
                <div class="row align-items-center">
                    <div class="col-md-4 mb-3">
                        <label for="searchInput" class="form-label">Tìm kiếm:</label>
                        <input type="text" name="khachHang" id="searchInput" class="form-control"
                               placeholder="Tìm kiếm"
                               value="${param.khachHang}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="statusSelect" class="form-label">Trạng thái:</label>
                        <select name="trangThai" id="statusSelect" class="form-select">
                            <option value="all" ${param.trangThai == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="Đang Hoạt Động" ${param.trangThai == 'Đang Hoạt Động' ? 'selected' : ''}>
                                Hoạt
                                động
                            </option>
                            <option value="Không Hoạt Động" ${param.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>
                                Không
                                hoạt động
                            </option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Khoảng Giá</label>
                        <select class="form-select" name="tenThuongHieu">
                            <option value="all" ${param.gia == 'all' ? 'selected' : ''}>Tất cả</option>
                            <c:forEach items="${listThuongHieu}" var="thuongHieu">
                                <option value="${thuongHieu.id}" ${thuongHieu.id == param.tenThuongHieu ? 'selected' : ''}>
                                        ${thuongHieu.tenThuongHieu}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="bi bi-search"></i> Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%--Giao diện--%>
    <div class="container mt-5">
        <div class="border mt-5">
            <%--Form hóa đơn--%>
            <div class="container mt-5">
                <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
                    <!-- Nút thêm mới -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>Danh sách hóa đơn</h5>
                        <!-- Nút thêm mới -->
                        <form action="/hoa-don-chi-tiet/addHoaDon" method="post">
                            <button type="submit" class="btn btn-primary btn-sm mb-3">
                                <i class="bi bi-plus-circle"></i> Tạo hóa đơn
                            </button>
                        </form>
                    </div>

                    <!-- Bảng hóa đơn -->
                    <div class="table-responsive">

                        <table class="table table-bordered table-striped align-middle">
                            <thead class="thead-dark text-center">
                            <tr>
                                <th style="width: 1%;">ID</th>
                                <th style="width: 10%;">Khách Hàng</th>
                                <th style="width: 10%;">Nhân Viên</th>
                                <th style="width: 10%;">Khuyến Mại</th>
                                <th style="width: 10%;">Tổng Tiền</th>
                                <th style="width: 25%;">Ngày</th>
                                <th style="width: 13%;">Phương Thức</th>
                                <th style="width: 15%;">Trạng Thái</th>
                                <th style="width: 12%;">Chức Năng</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${danhSachHoaDon}" var="hoaDon" varStatus="status">
                                <tr>
                                    <td class="text-center">${status.index+1}</td>
                                    <td class="text-center">${hoaDon.khachHang.hoTen}</td>
                                    <td class="text-center">${hoaDon.nhanVien.tenNhanVien}</td>
                                    <td class="text-center">${hoaDon.khuyenMai.tenChuongTrinh}</td>
                                    <td class="text-center">${hoaDon.tongTien}</td>
                                    <td>Ngày Tạo : ${hoaDon.ngayTao} <br>
                                        Ngày Sửa : ${hoaDon.ngaySua} </td>
                                    <td class="text-center">
                                            ${hoaDon.phuongThucThanhToan.tenPhuongThuc}
                                    </td>
                                    <td class="text-center">
                                        <button class="btn ${hoaDon.trangThai == 'Đang Xử Lý' ? 'btn-danger' : 'btn-success'}"
                                                data-bs-toggle="modal"
                                                data-bs-target="#suaTrangThaiModal-${hoaDon.id}">
                                                ${hoaDon.trangThai}
                                        </button>
                                    </td>
                                    <td class="text-center">
                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                                data-bs-target="#detailModal-${hoaDon.id}">
                                            <i class="bi bi-pencil-square"></i>
                                        </button>
                                        <form action="/hoa-don-chi-tiet/deleteHoaDon" method="post"
                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');"
                                              style="display:inline;">
                                            <input type="hidden" name="id" value="${hoaDon.id}">
                                            <button class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i>
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Modal detail hóa đơn -->
                                <div class="modal fade" id="detailModal-${hoaDon.id}" tabindex="-1"
                                     aria-labelledby="detailModalLabel-${hoaDon.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="detailModalLabel-${hoaDon.id}">Chi Tiết Hóa
                                                    Đơn</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="container-fluid mt-4">
                                                    <h3>Chi Tiết Hóa Đơn</h3>
                                                    <div class="card">
                                                        <div class="card-body">
                                                            <div class="row mb-3">
                                                                <div class="col-6">
                                                                    <label class="form-label">Khách Hàng</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.khachHang.hoTen}" readonly>
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Nhân Viên</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.nhanVien.tenNhanVien}"
                                                                           readonly>
                                                                </div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-6">
                                                                    <label class="form-label">Khuyến Mãi</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.khuyenMai.tenChuongTrinh}"
                                                                           readonly>
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Phương Thức Thanh
                                                                        Toán</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.phuongThucThanhToan.tenPhuongThuc}"
                                                                           readonly>
                                                                </div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-6">
                                                                    <label class="form-label">Tổng Tiền</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.tongTien}" readonly>
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Trạng Thái</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.trangThai}" readonly>
                                                                </div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-6">
                                                                    <label class="form-label">Ngày Tạo</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.ngayTao}" readonly>
                                                                </div>
                                                                <div class="col-6">
                                                                    <label class="form-label">Ngày Sửa</label>
                                                                    <input type="text" class="form-control"
                                                                           value="${hoaDon.ngaySua}" readonly>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Modal sửa trạng thái -->
                                <div class="modal fade" id="suaTrangThaiModal-${hoaDon.id}" tabindex="-1"
                                     aria-labelledby="suaTrangThaiModalLabel-${hoaDon.id}" aria-hidden="true">
                                    <div class="modal-dialog modal-lg">
                                        <div class="modal-content">
                                            <div class="modal-header bg-warning text-white">
                                                <h5 class="modal-title" id="suaTrangThaiModalLabel-${hoaDon.id}">Cập
                                                    Nhật
                                                    Trạng
                                                    Thái</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                        aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="/hoa-don-chi-tiet/update-trang-thai" method="post">
                                                    <input type="hidden" name="id" value="${hoaDon.id}">
                                                    <div class="form-group">
                                                        <label for="trangThai-${hoaDon.id}">Chọn Trạng Thái:</label>
                                                        <select class="form-control" id="trangThai-${hoaDon.id}"
                                                                name="trangThai">
                                                            <option value="Đã Thanh Toán" ${hoaDon.trangThai == 'Đã Thanh Toán' ? 'selected' : ''}>
                                                                Đã Thanh Toán
                                                            </option>
                                                            <option value="Đang Xử Lý" ${hoaDon.trangThai == 'Đang Xử Lý' ? 'selected' : ''}>
                                                                Đang Xử Lý
                                                            </option>
                                                        </select>
                                                    </div>
                                                    <button type="submit" class="btn btn-primary mt-3 w-100">Lưu Thay
                                                        Đổi
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>

                        <!-- Phân trang cho HoaDon -->
                        <nav aria-label="Page navigation">
                            <ul class="pagination justify-content-center">
                                <!-- Kiểm tra nếu có tổng số trang hợp lệ -->
                                <c:if test="${not empty totalPages and totalPages > 0}">
                                    <c:forEach var="i" begin="${pageNumber - 2 < 0 ? 0 : pageNumber - 2}"
                                               end="${pageNumber + 2 >= totalPages ? totalPages - 1 : pageNumber + 2}">
                                        <li class="page-item ${pageNumber == i ? 'active' : ''}">
                                            <a class="page-link"
                                               href="?pageHoaDon=${i}&pageHoaDonChiTiet=${pageNumber1}">${i + 1}</a>
                                        </li>
                                    </c:forEach>
                                </c:if>
                                <!-- Thông báo nếu không có trang -->
                                <c:if test="${empty totalPages or totalPages == 0}">
                                    <li class="page-item disabled">
                                        <span class="page-link">No pages available</span>
                                    </li>
                                </c:if>
                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <%--Form hóa đơn chi tiết--%>
            <div class="container mt-5">
                <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
                    <!-- Nút thêm mới -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>Danh sách hóa đơn chi tiết</h5>
                        <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                            <i class="bi bi-plus-circle"></i> Thêm mới
                        </button>
                    </div>

                    <!-- Bảng hóa đơn chi tiết -->
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped align-middle">
                            <thead class="text-center">
                            <tr>
                                <th>Id</th>
                                <th>Sản Phẩm</th>
                                <th>Hóa Đơn</th>
                                <th>Số Lượng</th>
                                <th>Giá</th>
                                <th>Thành Tiền</th>
                                <th>Chức Năng</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${danhSachHoaDonChiTiet}" var="hoaDonChiTiet" varStatus="status">
                                <tr>
                                    <td class="text-center">${status.index + 1}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <!-- Kiểm tra và hiển thị hình ảnh -->
                                            <c:if test="${not empty hoaDonChiTiet.sanPhamChiTiet.hinhAnh}">
                                                <img src="/images/${hoaDonChiTiet.sanPhamChiTiet.hinhAnh[0].urlHinhAnh}"
                                                     alt="Hình Ảnh" class="img-thumbnail me-2"
                                                     style="width: 80px; height: 80px;">
                                            </c:if>
                                            <div>
                                                <strong>${hoaDonChiTiet.sanPhamChiTiet.sanPham.tenSanPham}</strong><br>
                                                <strong>Màu: </strong>${hoaDonChiTiet.sanPhamChiTiet.mauSac.tenMauSac}<br>
                                                <strong>Size: </strong>${hoaDonChiTiet.sanPhamChiTiet.kichThuoc.tenKichThuoc}<br>
                                                <small class="text-danger font-weight-bold">${hoaDonChiTiet.sanPhamChiTiet.gia} VND</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="text-center">${hoaDonChiTiet.hoaDon.id}</td>
                                    <td class="text-center">${hoaDonChiTiet.soLuong}</td>
                                    <td class="text-center">${hoaDonChiTiet.gia}</td>
                                    <td class="text-center">${hoaDonChiTiet.thanhTien}</td>
                                    <td class="text-center">
                                        <!-- Nút sửa -->
                                        <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                                data-bs-target="#suaModal-${hoaDonChiTiet.id}">
                                            <i class="bi bi-info-circle"></i> Chi Tiết
                                        </button>
                                        <!-- Nút xóa -->
                                        <form action="/hoa-don-chi-tiet/deleteHoaDonChiTiet" method="post"
                                              onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');"
                                              style="display:inline;">
                                            <input type="hidden" name="id" value="${hoaDonChiTiet.id}">
                                            <button type="submit" class="btn btn-danger btn-sm">
                                                <i class="bi bi-trash"></i> Xóa
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                                <!-- Modal Chi Tiết -->
                                <div class="modal fade" id="suaModal-${hoaDonChiTiet.id}" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-xl">
                                        <div class="modal-content">
                                            <!-- Header -->
                                            <div class="modal-header bg-primary text-white">
                                                <h5 class="modal-title" id="modalLabel">Chi Tiết Hóa Đơn</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>

                                            <!-- Body -->
                                            <div class="modal-body">
                                                <div class="row">
                                                    <!-- Khung Sản Phẩm -->
                                                    <div class="col-md-5">
                                                        <div class="card">
                                                            <c:if test="${not empty hoaDonChiTiet.sanPhamChiTiet.hinhAnh}">
                                                                <img src="/images/${hoaDonChiTiet.sanPhamChiTiet.hinhAnh[0].urlHinhAnh}"
                                                                     alt="Hình Ảnh Sản Phẩm" class="card-img-top"
                                                                     style="width: 100%; height: 300px; object-fit: contain; background-color: #f8f9fa;">
                                                            </c:if>
                                                            <div class="card-body">
                                                                <h5 class="card-title text-center">${hoaDonChiTiet.sanPhamChiTiet.sanPham.tenSanPham}</h5>
                                                                <p class="text-center text-muted">${hoaDonChiTiet.sanPhamChiTiet.gia} VND</p>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- Thông Tin Sản Phẩm -->
                                                    <div class="col-md-7">
                                                        <h6>Thông Tin Chi Tiết</h6>
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item"><strong>Màu:</strong> ${hoaDonChiTiet.sanPhamChiTiet.mauSac.tenMauSac}</li>
                                                            <li class="list-group-item"><strong>Size:</strong> ${hoaDonChiTiet.sanPhamChiTiet.kichThuoc.tenKichThuoc}</li>
                                                            <li class="list-group-item"><strong>Hóa Đơn:</strong> ${hoaDonChiTiet.hoaDon.id}</li>
                                                            <li class="list-group-item"><strong>Số Lượng:</strong> ${hoaDonChiTiet.soLuong}</li>
                                                            <li class="list-group-item"><strong>Giá:</strong> ${hoaDonChiTiet.gia} VND</li>
                                                            <li class="list-group-item"><strong>Thành Tiền:</strong> ${hoaDonChiTiet.thanhTien} VND</li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Footer -->
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <!-- Phân trang cho HoaDonChiTiet -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <!-- Kiểm tra nếu có tổng số trang hợp lệ -->
                            <c:if test="${not empty totalPages1 and totalPages1 > 0}">
                                <c:forEach var="i" begin="${pageNumber1 - 2 < 0 ? 0 : pageNumber1 - 2}"
                                           end="${pageNumber1 + 2 >= totalPages1 ? totalPages1 - 1 : pageNumber1 + 2}">
                                    <li class="page-item ${pageNumber1 == i ? 'active' : ''}">
                                        <a class="page-link"
                                           href="?pageHoaDon=${pageNumber}&pageHoaDonChiTiet=${i}">${i + 1}</a>
                                    </li>
                                </c:forEach>
                            </c:if>
                            <!-- Thông báo nếu không có trang -->
                            <c:if test="${empty totalPages1 or totalPages1 == 0}">
                                <li class="page-item disabled">
                                    <span class="page-link">No pages available</span>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </div>

                <!-- Modal Thêm Mới -->
                <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Hóa Đơn Chi Tiết</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="/hoa-don-chi-tiet/add" method="post">
                                    <!-- Bảng danh sách sản phẩm -->
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover align-middle">
                                            <thead class="table-dark text-center">
                                            <tr>
                                                <th>#</th>
                                                <th>Tên Sản Phẩm</th>
                                                <th>Chất Liệu</th>
                                                <th>Thương Hiệu</th>
                                                <th>Xuất Xứ</th>
                                                <th>Chọn</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${listSanPhamChiTiet}" var="sanPhamChiTiet" varStatus="status">
                                                <tr>
                                                    <td class="text-center">${status.index + 1}</td>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:if test="${not empty sanPhamChiTiet.hinhAnh}">
                                                                <img src="/images/${sanPhamChiTiet.hinhAnh[0].urlHinhAnh}" alt="Hình Ảnh" class="img-thumbnail me-2" style="width: 80px; height: 80px;">
                                                            </c:if>
                                                            <div>
                                                                <span class="fw-bold">${sanPhamChiTiet.sanPham.tenSanPham}</span><br>
                                                                <small>
                                                                    <strong>Màu sắc:</strong> ${sanPhamChiTiet.mauSac.tenMauSac}<br>
                                                                    <strong>Size:</strong> ${sanPhamChiTiet.kichThuoc.tenKichThuoc}<br>
                                                                    <small class="text-danger font-weight-bold fs-5">${sanPhamChiTiet.gia} VND</small>
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td class="text-center">${sanPhamChiTiet.chatLieu.tenChatLieu}</td>
                                                    <td class="text-center">${sanPhamChiTiet.sanPham.thuongHieu.tenThuongHieu}</td>
                                                    <td class="text-center">${sanPhamChiTiet.sanPham.xuatSu.quocGia}</td>
                                                    <td class="text-center">
                                                        <input type="radio" name="sanPhamChiTiet" value="${sanPhamChiTiet.id}" data-gia="${sanPhamChiTiet.gia}" required onclick="setGiaAndCalculate(this)">
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Giá và số lượng -->
                                    <input type="hidden" id="gia" name="gia" value="">
                                    <div class="mb-3">
                                        <label for="soLuong" class="form-label font-weight-bold">Số Lượng</label>
                                        <input type="number" id="soLuong" name="soLuong" class="form-control" required oninput="calculateThanhTien()">
                                    </div>
                                    <div class="mb-3">
                                        <label for="thanhTien" class="form-label font-weight-bold">Thành Tiền</label>
                                        <input type="text" id="thanhTien" class="form-control" disabled>
                                    </div>

                                    <!-- Chọn hóa đơn -->
                                    <div class="mb-3">
                                        <label for="hoaDon" class="form-label font-weight-bold">Hóa Đơn</label>
                                        <select id="hoaDon" name="hoaDon" class="form-select" required>
                                            <option value="" disabled selected>Chọn hóa đơn</option>
                                            <c:forEach items="${listHoaDon}" var="hoaDon">
                                                <option value="${hoaDon.id}">${hoaDon.id}</option>
                                            </c:forEach>
                                        </select>
                                    </div>

                                    <!-- Nút hành động -->
                                    <div class="text-end">
                                        <button type="submit" class="btn btn-primary">Lưu</button>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--Form báo lỗi--%>
    <div aria-live="polite" aria-atomic="true" class="position-relative">
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <c:if test="${not empty successMessage}">
                <div class="toast align-items-center text-bg-success border-0" role="alert" aria-live="assertive"
                     aria-atomic="true" data-bs-delay="5000">
                    <div class="d-flex">
                        <div class="toast-body">
                                ${successMessage}
                        </div>
                        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="toast align-items-center text-bg-danger border-0" role="alert" aria-live="assertive"
                     aria-atomic="true" data-bs-delay="5000">
                    <div class="d-flex">
                        <div class="toast-body">
                                ${errorMessage}
                        </div>
                        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast"
                                aria-label="Close"></button>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<%--Thông báo lỗi--%>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const toastElements = document.querySelectorAll('.toast');
        toastElements.forEach(function (toastElement) {
            const toast = new bootstrap.Toast(toastElement);
            toast.show();
        });
    });
</script>
<script>
    // Khi chọn sản phẩm, cập nhật giá và tính thành tiền
    function setGiaAndCalculate(radioButton) {
        var gia = radioButton.getAttribute('data-gia');
        document.getElementById('gia').value = gia;
        calculateThanhTien();
    }

    // Tính thành tiền
    function calculateThanhTien() {
        var gia = parseFloat(document.getElementById('gia').value);
        var soLuong = parseInt(document.getElementById('soLuong').value);
        if (gia && soLuong) {
            var thanhTien = gia * soLuong;
            document.getElementById('thanhTien').value = thanhTien.toFixed(2);
        } else {
            document.getElementById('thanhTien').value = '';
        }
    }
</script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
