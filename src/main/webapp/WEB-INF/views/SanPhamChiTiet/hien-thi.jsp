<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Sản Phẩm Chi Tiết</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thay vì Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Sử dụng Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

    <style>
        /* Container cho ảnh */
        .position-relative {
            position: relative;
            width: 100px;
            height: 100px;
            overflow: hidden;
        }

        /* Ảnh hiển thị */
        .image-overlay {
            display: block;
            width: 100%;
            height: 100%;
            object-fit: cover; /* Đảm bảo ảnh vừa vặn */
            border-radius: 5px; /* Bo góc ảnh */
        }

        /* Overlay icons (Xem và Xóa) */
        .overlay-icons {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            display: flex;
            gap: 5px;
            visibility: hidden; /* Ẩn khi không hover */
            opacity: 0;
            transition: visibility 0.3s, opacity 0.3s;
        }

        /* Hiển thị icons khi hover */
        .position-relative:hover .overlay-icons {
            visibility: visible;
            opacity: 1;
        }

        /* Kiểu cho nút */
        .btn-icon {
            padding: 5px;
            font-size: 12px;
            width: 32px;
            height: 32px;
            border-radius: 50%; /* Bo tròn nút */
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: rgba(0, 0, 0, 0.6); /* Nền tối nhẹ */
            color: white;
        }

        .btn-icon:hover {
            background-color: rgba(0, 0, 0, 0.8); /* Tối hơn khi hover */
        }
    </style>

</head>
<body>
<div class="container mt-5">
    <div class="border p-3">
        <h1 class="text-center mb-3">Quản lý Sản Phẩm Chi Tiết</h1>
        <%--Form tìm kiếm--%>
        <div class="container mt-5">
            <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
                <!-- Tiêu đề -->
                <div class="d-flex align-items-center mb-4">
                    <i class="bi bi-funnel me-2 text-primary" style="font-size: 1.5rem;"></i>
                    <h5 class="text-primary mb-0">Bộ lọc</h5>
                </div>

                <!-- Bộ lọc -->
                <form id="filterForm" action="/san-pham-chi-tiet/hien-thi" method="get">
                    <div class="row align-items-center">
                        <div class="col-md-4 mb-3">
                            <label for="searchInput" class="form-label">Tìm kiếm:</label>
                            <input type="text" name="tenSanPham" id="searchInput" class="form-control"
                                   placeholder="Tìm kiếm"
                                   value="${param.tenSanPham}">
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
                            <label class="form-label">Thương Hiệu</label>
                            <select class="form-select" name="tenThuongHieu">
                                <option value="all" ${param.tenThuongHieu == 'all' ? 'selected' : ''}>Tất cả</option>
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

        <%--Quản Lý Sản Phẩm--%>
        <div class="container mt-5">
            <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
                <!-- Header -->
                <div class="d-flex align-items-center mb-4">
                    <h5 class="text-primary">
                        <i class="fas fa-bars"></i> Danh sách sản phẩm
                    </h5>
                </div>

                <!-- Thanh Button -->
                <div class="d-flex justify-content-between mb-3">
                    <!-- Nút Xóa Đã Chọn -->
                    <button id="deleteSelectedBtn" class="btn btn-danger btn-sm">
                        <i class="bi bi-trash"></i> Xóa Đã Chọn
                    </button>

                    <!-- Nút Thêm Mới -->
                    <button class="btn btn-primary btn-sm ms-auto" data-bs-toggle="modal"
                            data-bs-target="#themMoiModal">
                        <i class="bi bi-plus-circle"></i> Thêm Mới
                    </button>

                    <!-- Modal Thêm Mới -->
                    <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiModalLabel"
                         aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="themMoiModalLabel">Thêm Mới</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <form action="/san-pham-chi-tiet/addSanPham" method="post">
                                    <div class="modal-body">
                                        <!-- Hàng: Tên sản phẩm và Danh mục -->
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label for="tenSanPham" class="form-label">Tên Sản Phẩm</label>
                                                <input type="text" class="form-control" id="tenSanPham"
                                                       name="tenSanPham"
                                                       required>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="danhMuc" class="form-label">Danh Mục</label>
                                                <select class="form-select" id="danhMuc" name="danhMuc" required>
                                                    <c:forEach items="${listDanhMuc}" var="danhMuc">
                                                        <option value="${danhMuc.id}">${danhMuc.tenDanhMuc}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                        <!-- Hàng: Thương hiệu và Xuất sứ -->
                                        <div class="row mb-3">
                                            <div class="col-md-6">
                                                <label for="thuongHieu" class="form-label">Thương Hiệu</label>
                                                <select class="form-select" id="thuongHieu" name="thuongHieu" required>
                                                    <c:forEach items="${listThuongHieu}" var="thuongHieu">
                                                        <option value="${thuongHieu.id}">${thuongHieu.tenThuongHieu}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="col-md-6">
                                                <label for="xuatSu" class="form-label">Xuất Sứ</label>
                                                <select class="form-select" id="xuatSu" name="xuatSu" required>
                                                    <c:forEach items="${listXuatSu}" var="xuatSu">
                                                        <option value="${xuatSu.id}">${xuatSu.quocGia}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>

                                        <!-- Mô Tả -->
                                        <div class="mb-3">
                                            <label for="moTa" class="form-label">Mô Tả</label>
                                            <textarea class="form-control" id="moTa" name="moTa" rows="4"
                                                      required></textarea>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng
                                        </button>
                                        <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Bảng sản phẩm-->
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th style="width: 1%;"><input type="checkbox" id="selectAll"></th>
                        <th style="width: 1%;">STT</th>
                        <th style="width:10%;">Tên Sản Phẩm</th>
                        <th style="width: 10%;">Thương Hiệu</th>
                        <th style="width: 10%;">Xuất Sứ</th>
                        <th style="width: 10%;">Danh Mục</th>
                        <th style="width: 5%;">Tồn Kho</th>
                        <th style="width: 10%;">Trạng Thái</th>
                        <th style="width: 10%;">Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSachSanPham}" var="sanPham" varStatus="status">
                        <tr>
                            <td>
                                <input type="checkbox" name="ids[]" class="selectProduct" value="${sanPham.id}">
                            </td>
                            <td><input type="hidden" value="${sanPham.id}">${status.index+1}</td>
                            <td>${sanPham.tenSanPham}</td>
                            <td>${sanPham.thuongHieu.tenThuongHieu}</td>
                            <td>${sanPham.xuatSu.quocGia}</td>
                            <td>${sanPham.danhMuc.tenDanhMuc}</td>
                            <td>${sanPham.soLuong}</td>
                            <td>
                                <!-- Nút trạng thái -->
                                <button class="btn ${sanPham.trangThai == 'Đang Hoạt Động' ? 'btn-success' : 'btn-danger'}"
                                        data-bs-toggle="modal"
                                        data-bs-target="#suaTrangThaiModal-${sanPham.id}">
                                        ${sanPham.trangThai}
                                </button>
                            </td>
                            <td>
                                <!-- Nút sửa -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${sanPham.id}">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </button>
                                <!-- Nút xóa -->
                                <button class="btn btn-danger btn-sm">
                                    <a href="/san-pham-chi-tiet/deleteSanPham?id=${sanPham.id}"
                                       class="text-white text-decoration-none">
                                        <i class="bi bi-trash"></i> Xóa
                                    </a>
                                </button>
                            </td>
                        </tr>
                        <!-- Modal sửa sản phẩm -->
                        <div class="modal fade" id="suaModal-${sanPham.id}" tabindex="-1"
                             aria-labelledby="suaModalLabel-${sanPham.id}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <!-- Header -->
                                    <div class="modal-header bg-warning text-white">
                                        <h5 class="modal-title" id="suaModalLabel-${sanPham.id}">Sửa Sản Phẩm</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>

                                    <!-- Body -->
                                    <div class="modal-body">
                                        <form action="/san-pham-chi-tiet/updateSanPham" method="post">
                                            <input type="hidden" name="id" value="${sanPham.id}">
                                            <div class="mb-3">
                                                <label for="tenSanPham-${sanPham.id}" class="form-label">Tên Sản
                                                    Phẩm</label>
                                                <input type="text" class="form-control" id="tenSanPham-${sanPham.id}"
                                                       name="tenSanPham" value="${sanPham.tenSanPham}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="soLuong-${sanPham.id}" class="form-label">Số Lượng</label>
                                                <input type="number" class="form-control" id="soLuong-${sanPham.id}"
                                                       name="soLuong" value="${sanPham.soLuong}" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="thuongHieu-${thuongHieu.id}" class="form-label">Thương
                                                    Hiệu</label>
                                                <select class="form-select" id="thuongHieu-${thuongHieu.id}"
                                                        name="thuongHieu"
                                                        required>
                                                    <c:forEach items="${listThuongHieu}" var="thuongHieu">
                                                    <option type="radio"
                                                            value="${thuongHieu.id}"> ${thuongHieu.tenThuongHieu}
                                                        </c:forEach>

                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label for="xuatSu-${xuatSu.id}" class="form-label">Xuat Su</label>
                                                <select class="form-select" id="danhMuc-${sanPham.id}" name="xuatSu"
                                                        required>
                                                    <c:forEach items="${listXuatSu}" var="xuatSu">
                                                        <option value="${xuatSu.id}" ${xuatSu.id == sanPham.xuatSu.id ? 'selected' : ''}>${xuatSu.quocGia}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label for="danhMuc-${sanPham.id}" class="form-label">Danh Mục</label>
                                                <select class="form-select" id="danhMuc-${sanPham.id}" name="danhMuc"
                                                        required>
                                                    <c:forEach items="${listDanhMuc}" var="danhMuc">
                                                        <option value="${danhMuc.id}" ${danhMuc.id == sanPham.danhMuc.id ? 'selected' : ''}>${danhMuc.tenDanhMuc}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="mb-3">
                                                <label for="moTa-${sanPham.id}" class="form-label">Mô Tả</label>
                                                <input type="text" class="form-control" id="moTa-${sanPham.id}"
                                                       name="moTa"
                                                       value="${sanPham.moTa}" required>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal sửa trạng thái -->
                        <div class="modal fade" id="suaTrangThaiModal-${sanPham.id}" tabindex="-1"
                             aria-labelledby="suaTrangThaiModalLabel-${sanPham.id}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <!-- Header của Modal -->
                                    <div class="modal-header bg-warning text-white">
                                        <h5 class="modal-title" id="suaTrangThaiModalLabel-${sanPham.id}">Cập Nhật Trạng
                                            Thái</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <!-- Nội dung của Modal -->
                                    <div class="modal-body">
                                        <form action="/san-pham-chi-tiet/update-trang-thai" method="post">
                                            <input type="hidden" name="id" value="${sanPham.id}">
                                            <div class="form-group">
                                                <label for="trangThai-${sanPham.id}">Chọn Trạng Thái:</label>
                                                <select class="form-control" id="trangThai-${sanPham.id}"
                                                        name="trangThai">
                                                    <option value="Đang Hoạt Động" ${sanPham.trangThai == 'Đang Hoạt Động' ? 'selected' : ''}>
                                                        Đang Hoạt Động
                                                    </option>
                                                    <option value="Không Hoạt Động" ${sanPham.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>
                                                        Không Hoạt Động
                                                    </option>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary mt-3 w-100">Lưu Thay Đổi
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <!-- Kiểm tra nếu totalPages và pageNumber có giá trị hợp lệ -->
                        <c:if test="${not empty totalPages and totalPages > 0}">
                            <c:forEach var="i" begin="${pageNumber - 2 < 0 ? 0 : pageNumber - 2}"
                                       end="${pageNumber + 2 >= totalPages ? totalPages - 1 : pageNumber + 2}">
                                <li class="page-item ${pageNumber == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                        <!-- Nếu không có trang, có thể hiển thị thông báo hoặc không có gì -->
                        <c:if test="${empty totalPages or totalPages == 0}">
                            <li class="page-item disabled">
                                <span class="page-link">No pages available</span>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

        <%--Form add sản phẩm chi tiết--%>
        <div class="container mt-5">
            <div class="p-5 shadow rounded bg-white">
                <h3 class="text-primary fw-bold text-center mb-4">
                    <i class="bi bi-plus-circle me-2"></i> Tạo Sản Phẩm Chi Tiết
                </h3>
                <form action="/san-pham-chi-tiet/addSanPhamChiTiet" method="post" enctype="multipart/form-data">
                    <!-- Dòng đầu tiên -->
                    <div class="row g-4">
                        <!-- Sản phẩm -->
                        <div class="col-md-6">
                            <label for="sanPham" class="form-label font-weight-bold">Sản Phẩm</label>
                            <select id="sanPham" name="sanPham" class="form-select select2" required>
                                <option value="" disabled selected>Chọn sản phẩm</option>
                                <c:forEach items="${listSanPham}" var="sanPham">
                                    <option value="${sanPham.id}" data-subtext="
                Thương hiệu: ${sanPham.thuongHieu.tenThuongHieu}
                Xuất xứ: ${sanPham.xuatSu.quocGia}
                Danh mục: ${sanPham.danhMuc.tenDanhMuc}">
                                            ${sanPham.tenSanPham}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Màu sắc -->
                        <div class="col-md-6">
                            <label for="mauSac" class="form-label">Màu Sắc</label>
                            <select id="mauSac" name="mauSac" class="form-select" required>
                                <option value="" disabled selected>Chọn màu sắc</option>
                                <c:forEach items="${listMauSac}" var="mauSac">
                                    <option value="${mauSac.id}">${mauSac.tenMauSac}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <!-- Kích thước -->
                        <div class="col-md-6">
                            <label for="kichThuoc" class="form-label">Kích Thước</label>
                            <select id="kichThuoc" name="kichThuoc" class="form-select" required>
                                <option value="" disabled selected>Chọn kích thước</option>
                                <c:forEach items="${listKichThuoc}" var="kichThuoc">
                                    <option value="${kichThuoc.id}">${kichThuoc.tenKichThuoc}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <!-- Chất liệu -->
                        <div class="col-md-6">
                            <label for="chatLieu" class="form-label">Chất Liệu</label>
                            <select id="chatLieu" name="chatLieu" class="form-select" required>
                                <option value="" disabled selected>Chọn chất liệu</option>
                                <c:forEach items="${listChatLieu}" var="chatLieu">
                                    <option value="${chatLieu.id}">${chatLieu.tenChatLieu}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <!-- Nút hành động -->
                    <div class="mt-4 d-flex justify-content-center">
                        <button type="submit" class="btn btn-primary me-3">
                            <i class="bi bi-check-circle"></i> Tạo Sản Phẩm
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <%--Form sản phẩm chi tiết và upload hình ảnh--%>
        <div class="container mt-5">
            <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h5 class="text-primary d-flex align-items-center">
                        <i class="bi bi-box-seam me-2"></i>
                        Chi Tiết Sản Phẩm
                    </h5>
                </div>
                <!-- Bảng chi tiết sản phẩm -->
                <table class="table table-bordered">
                    <thead class="table-warning">
                    <tr>
                        <th style="width: 5%;">STT</th>
                        <th style="width: 20%;">Tên Sản Phẩm</th>
                        <th style="width: 10%;">Màu Sắc</th>
                        <th style="width: 10%;">Kích Thước</th>
                        <th style="width: 15%;">Chất Liệu</th>
                        <th style="width: 15%;">Số Lượng</th>
                        <th style="width: 15%;">Gia</th>
                        <th style="width: 5%;">Hành Động</th>
                        <th style="width: 30%;">Upload Ảnh</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSachSanPhamChiTiet}" var="spct" varStatus="status">
                        <tr>
                            <td><input type="hidden" value="${spct.id}">${status.index+1}</td>
                            <td>
                                <strong>Tên :</strong>${spct.sanPham.tenSanPham}<br>
                                <strong>Thương Hiệu :</strong> ${spct.sanPham.thuongHieu.tenThuongHieu}<br>
                                <strong>Xuất Sứ :</strong> ${spct.sanPham.xuatSu.quocGia}<br>
                                <strong>Danh Mục :</strong> ${spct.sanPham.danhMuc.tenDanhMuc}<br>
                            </td>
                            <form action="/san-pham-chi-tiet/updateSanPhamChiTiet" method="post">
                                <input type="hidden" name="id" value="${spct.id}">
                                <td>
                                    <select name="mauSac" class="form-control">
                                        <c:forEach items="${listMauSac}" var="mauSac">
                                            <option value="${mauSac.id}" ${mauSac.id == spct.mauSac.id ? 'selected' : ''}>
                                                    ${mauSac.tenMauSac}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <select name="kichThuoc" class="form-control">
                                        <c:forEach items="${listKichThuoc}" var="kichThuoc">
                                            <option value="${kichThuoc.id}" ${kichThuoc.id == spct.kichThuoc.id ? 'selected' : ''}>
                                                    ${kichThuoc.tenKichThuoc}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <select name="chatLieu" class="form-control">
                                        <c:forEach items="${listChatLieu}" var="chatLieu">
                                            <option value="${chatLieu.id}" ${chatLieu.id == spct.chatLieu.id ? 'selected' : ''}>
                                                    ${chatLieu.tenChatLieu}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td>
                                    <input type="number" name="soLuong" value="${spct.soLuong}" class="form-control"
                                           min="0"
                                           required>
                                </td>
                                <td><input type="number" name="gia" value="${spct.gia}" class="form-control" min="0"
                                           required>
                                </td>
                                <td>
                                    <button type="submit" class="btn btn-primary">Cập Nhật</button>
                            </form>
                            <button><a href="/san-pham-chi-tiet/deleteSPCT?id=${spct.id}">Xóa</a></button>
                            </td>
                            <td class="text-center">
                                <!-- Hiển thị danh sách hình ảnh -->
                                <div class="d-flex flex-wrap justify-content-center">
                                    <c:forEach items="${spct.hinhAnh}" var="hinhAnh">
                                        <div class="position-relative m-1" style="width: 100px; height: 100px;">
                                            <!-- Ảnh -->
                                            <img src="/images/${hinhAnh.urlHinhAnh}" alt="Hình Ảnh"
                                                 class="img-thumbnail image-overlay">
                                            <div class="overlay-icons">
                                                <!-- Icon Xem -->
                                                <button type="button" class="btn btn-sm btn-light btn-icon me-1"
                                                        title="Xem"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#viewImageModal-${hinhAnh.id}">
                                                    <i class="bi bi-eye"></i>
                                                </button>
                                                <!-- Icon Xóa -->
                                                <form action="/san-pham-chi-tiet/delete?id=${hinhAnh.id}"
                                                      style="display: inline;">
                                                    <input type="hidden" name="id" value="${hinhAnh.id}">
                                                    <button type="submit" class="btn btn-sm btn-light btn-icon"
                                                            title="Xóa"
                                                            onclick="return confirm('Bạn có chắc chắn muốn xóa ảnh này?')">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>

                                        <!-- Modal để xem ảnh -->
                                        <div class="modal fade" id="viewImageModal-${hinhAnh.id}" tabindex="-1"
                                             aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Xem Hình Ảnh</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body text-center">
                                                        <img src="/images/${hinhAnh.urlHinhAnh}" alt="Hình Ảnh"
                                                             class="img-fluid rounded">
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary"
                                                                data-bs-dismiss="modal">
                                                            Đóng
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Nút tải lên hình ảnh -->
                                <button type="button" class="btn btn-light btn-sm mt-2" data-bs-toggle="modal"
                                        data-bs-target="#modalHinhAnh-${spct.id}">
                                    + Upload
                                </button>
                            </td>
                        </tr>

                        <!-- Modal tải lên hình ảnh -->
                        <div class="modal fade" id="modalHinhAnh-${spct.id}" tabindex="-1"
                             aria-labelledby="modalHinhAnh-${spct.id}" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Tải Lên Hình Ảnh</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <form action="/san-pham-chi-tiet/addHinhAnh" method="post"
                                          enctype="multipart/form-data">
                                        <div class="mb-3">
                                            <label for="urlHinhAnh" class="form-label">URL Hình Ảnh</label>
                                            <input type="file" class="form-control" id="urlHinhAnh" name="urlHinhAnh"
                                                   required>
                                        </div>
                                        <input type="hidden" name="id" value="${spct.id}">
                                        <button type="submit" class="btn btn-primary">Thêm Mới</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <!-- Kiểm tra nếu totalPages và pageNumber có giá trị hợp lệ -->
                        <c:if test="${not empty totalPages1 and totalPages1 > 0}">
                            <c:forEach var="i" begin="${pageNumber1 - 2 < 0 ? 0 : pageNumber1 - 2}"
                                       end="${pageNumber1 + 2 >= totalPages1 ? totalPages1 - 1 : pageNumber1 + 2}">
                                <li class="page-item ${pageNumber1 == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                        <!-- Nếu không có trang, có thể hiển thị thông báo hoặc không có gì -->
                        <c:if test="${empty totalPages1 or totalPages1 == 0}">
                            <li class="page-item disabled">
                                <span class="page-link">No pages available</span>
                            </li>
                        </c:if>
                    </ul>
                </nav>
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
<%--checkboxAll--%>
<script>
    document.getElementById("selectAll").addEventListener("change", function () {
        const checkboxes = document.querySelectorAll(".selectProduct");
        checkboxes.forEach(checkbox => checkbox.checked = this.checked);
    });

</script>
<!-- Bootstrap JS và Popper.js (để modal hoạt động) -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

</body>
</html>