<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khách hàng</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thay vì Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Khách Hàng</h1>

    <%--Form tìm kiếm--%>
    <div class="container mt-5">
        <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
            <!-- Tiêu đề -->
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-funnel me-2 text-primary" style="font-size: 1.5rem;"></i>
                <h5 class="text-primary mb-0">Bộ lọc</h5>
            </div>

            <!-- Bộ lọc -->
            <form id="filterForm" action="/khach-hang/hien-thi" method="get">
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

    <%--Giao diện--%>
    <div class="container mt-5">
        <!-- Thêm mới và Danh sách chất liệu -->
        <div class="border p-3">
            <!-- Nút thêm mới -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5>Danh sách khách hàng</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </button>
            </div>

            <!-- Danh sách chất liệu -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped text-center align-middle">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Họ Tên</th>
                        <th>Số Điện Thoại</th>
                        <th>Email</th>
                        <th>Mật Khẩu</th>
                        <th>Giới Tính</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSach}" var="khachHang" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${khachHang.hoTen}</td>
                            <td>${khachHang.sdt}</td>
                            <td>${khachHang.email}</td>
                            <td>${khachHang.matKhau}</td>
                            <td>${khachHang.gioiTinh}</td>
                            <td>
                                <!-- Nút trạng thái -->
                                <button class="btn ${khachHang.trangThai == 'Đang Hoạt Động' ? 'btn-success' : 'btn-danger'}"
                                        data-bs-toggle="modal"
                                        data-bs-target="#suaTrangThaiModal-${khachHang.id}">
                                        ${khachHang.trangThai}
                                </button></td>
                            <td>
                                <!-- Nút sửa -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${khachHang.id}">
                                    <i class="bi bi-pencil-square">Chi Tiết</i>
                                </button>
                                <!-- Nút xóa -->
                                <form action="/khach-hang/delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                    <input type="hidden" name="id" value="${khachHang.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash">Xóa</i>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <!-- Modal sửa -->
                        <div class="modal fade" id="suaModal-${khachHang.id}" tabindex="-1" aria-labelledby="suaModalLabel-${khachHang.id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="suaModalLabel-${khachHang.id}">Sửa Khách Hàng</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <form action="/khach-hang/update" method="post">
                                        <input type="hidden" name="id" value="${khachHang.id}">
                                        <div class="modal-body">
                                            <div class="mb-3">
                                                <label for="hoTen-${khachHang.id}" class="form-label">Họ và Tên</label>
                                                <input type="text" class="form-control" id="hoTen-${khachHang.id}" name="hoTen" value="${khachHang.hoTen}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="sdt-${khachHang.id}" class="form-label">Số Điện Thoại</label>
                                                <input type="text" class="form-control" id="sdt-${khachHang.id}" name="sdt" value="${khachHang.sdt}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="email-${khachHang.id}" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="email-${khachHang.id}" name="email" value="${khachHang.email}" autocomplete="email" required>
                                            </div>
                                            <div class="mb-3">
                                                <div class="input-group">
                                                    <input type="password" class="form-control" id="matKhau-${khachHang.id}" name="matKhau" value="${khachHang.matKhau}" autocomplete="password" required>
                                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('${khachHang.id}')">
                                                        <i class="fa fa-eye" id="toggleIcon-${khachHang.id}"></i>
                                                    </button>

                                                </div>
                                            </div>
                                            <div class="mb-3">
                                                <label for="gioiTinh-${khachHang.id}" class="form-label">Giới Tính</label><br>
                                                <input type="radio" class="form-check-input" id="gioiTinhNam-${khachHang.id}" name="gioiTinh" value="Nam" ${khachHang.gioiTinh == 'Nam' ? 'checked' : ''}> Nam
                                                <input type="radio" class="form-check-input" id="gioiTinhNu-${khachHang.id}" name="gioiTinh" value="Nữ" ${khachHang.gioiTinh == 'Nữ' ? 'checked' : ''}> Nữ
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                            <button type="submit" class="btn btn-primary">Lưu Thay Đổi</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <!-- Modal sửa trạng thái -->
                        <div class="modal fade" id="suaTrangThaiModal-${khachHang.id}" tabindex="-1"
                             aria-labelledby="suaTrangThaiModalLabel-${khachHang.id}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <!-- Header của Modal -->
                                    <div class="modal-header bg-warning text-white">
                                        <h5 class="modal-title" id="suaTrangThaiModalLabel-${khachHang.id}">Cập Nhật Trạng
                                            Thái</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <!-- Nội dung của Modal -->
                                    <div class="modal-body">
                                        <form action="/khach-hang/update-trang-thai" method="post">
                                            <input type="hidden" name="id" value="${khachHang.id}">
                                            <div class="form-group">
                                                <label for="trangThai-${khachHang.id}">Chọn Trạng Thái:</label>
                                                <select class="form-control" id="trangThai-${khachHang.id}"
                                                        name="trangThai">
                                                    <option value="Đang Hoạt Động" ${khachHang.trangThai == 'Đang Hoạt Động' ? 'selected' : ''}>
                                                        Đang Hoạt Động
                                                    </option>
                                                    <option value="Không Hoạt Động" ${khachHang.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>
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
            </div>

            <!-- Phân trang -->
            <nav aria-label="Page navigation" class="mt-3">
                <ul class="pagination justify-content-center">
                    <c:if test="${not empty totalPages and totalPages > 0}">
                        <c:forEach var="i" begin="${0}" end="${totalPages - 1}">
                            <li class="page-item ${pageNumber == i ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                </ul>
            </nav>
        </div>
        <!-- Modal Thêm mới -->
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="themMoiModalLabel">Thêm Khách Hàng Mới</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/khach-hang/add" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="hoTen" class="form-label">Họ và Tên</label>
                                <input type="text" class="form-control" id="hoTen" name="hoTen" required>
                            </div>
                            <div class="mb-3">
                                <label for="sdt" class="form-label">Số Điện Thoại</label>
                                <input type="text" class="form-control" id="sdt" name="sdt" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" autocomplete="email" required>
                            </div>
                            <div class="mb-3">
                                <div class="input-group">
                                    <input type="password" class="form-control" id="matKhau-new" name="matKhau" autocomplete="password" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('new')">
                                        <i class="fa fa-eye" id="toggleIcon-new"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label  class="form-label">Giới Tính</label><br>
                                <input type="radio" class="form-check-input"  name="gioiTinh" value="Nam"> Nam
                                <input type="radio" class="form-check-input"  name="gioiTinh" value="Nữ"> Nữ
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary">Thêm mới</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>    </div>

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

    function togglePassword(id) {
        const button = document.getElementById(`toggleIcon-${id}`);
        if (!button) {
            console.error("Không tìm thấy phần tử button với id:", id);
            return;
        }

        const modal = button.closest('.modal-content');
        if (!modal) {
            console.error("Không tìm thấy modal-content.");
            return;
        }

        const passwordField = modal.querySelector('[name="matKhau"]');
        const toggleIcon = modal.querySelector('.btn-outline-secondary i');
        if (!passwordField || !toggleIcon) {
            console.error("Không tìm thấy phần tử mật khẩu hoặc biểu tượng toggle.");
            return;
        }

        const isPasswordVisible = passwordField.type === "text";
        passwordField.type = isPasswordVisible ? "password" : "text";
        toggleIcon.className = isPasswordVisible ? "fa fa-eye" : "fa fa-eye-slash";
    }

</script>




<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
