<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân Viên</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thay vì Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Nhân Viên</h1>

    <%--Form tìm kiếm--%>
    <div class="container mt-5">
        <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
            <!-- Tiêu đề -->
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-funnel me-2 text-primary" style="font-size: 1.5rem;"></i>
                <h5 class="text-primary mb-0">Bộ lọc</h5>
            </div>

            <!-- Bộ lọc -->
            <form id="filterForm" action="/nhan-vien/hien-thi" method="get">
                <div class="row align-items-center">
                    <div class="col-md-4 mb-3">
                        <label for="searchInput" class="form-label">Tìm kiếm:</label>
                        <input type="text" name="hoTen" id="searchInput" class="form-control"
                               placeholder="Tìm kiếm nhân viên"
                               value="${param.hoTen}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="statusSelect" class="form-label">Trạng thái:</label>
                        <select name="trangThai" id="statusSelect" class="form-select">
                            <option value="all" ${param.trangThai == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="Đang Hoạt Động" ${param.trangThai == 'Đang Hoạt Động' ? 'selected' : ''}>
                                Hoạt động
                            </option>
                            <option value="Không Hoạt Động" ${param.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>
                                Không hoạt động
                            </option>
                        </select>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Chức Vụ</label>
                        <select class="form-select" name="chucVu">
                            <option value="all" ${param.chucVu == 'all' ? 'selected' : ''}>Tất cả</option>
                            <c:forEach items="${listChucVu}" var="chucVu">
                                <option value="${chucVu.id}" ${chucVu.id == param.chucVu ? 'selected' : ''}>
                                        ${chucVu.tenChucVu}
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
        <!-- Thêm mới và Danh sách nhân viên -->
        <div class="border p-3">
            <!-- Nút thêm mới -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5>Danh sách nhân viên</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </button>
            </div>

            <!-- Danh sách nhân viên -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped text-center align-middle">
                    <thead>
                    <tr>
                        <th>STT</th>
                        <th>Họ Và Tên</th>
                        <th>Số Điện Thoại</th>
                        <th>Email</th>
                        <th>Mật Khẩu</th>
                        <th>Chức Vụ</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSach}" var="nhanVien" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${nhanVien.hoTen}</td>
                            <td>${nhanVien.sdt}</td>
                            <td>${nhanVien.email}</td>
                            <td>${nhanVien.matKhau}</td>
                            <td>${nhanVien.chucVu}</td>
                            <td>
                                <!-- Nút trạng thái -->
                                <button class="btn ${nhanVien.trangThai == 'Đang Hoạt Động' ? 'btn-success' : 'btn-danger'}"
                                        data-bs-toggle="modal"
                                        data-bs-target="#suaTrangThaiModal-${nhanVien.id}">
                                        ${nhanVien.trangThai}
                                </button>
                            </td>
                            <td>
                                <!-- Nút sửa -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${nhanVien.id}">
                                    <i class="bi bi-pencil-square">Chi Tiết</i>
                                </button>
                                <!-- Nút xóa -->
                                <form action="/nhan-vien/delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                    <input type="hidden" name="id" value="${nhanVien.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash">Xóa</i>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <!-- Modal sửa -->
                        <div class="modal fade" id="suaModal-${nhanVien.id}" tabindex="-1"
                             aria-labelledby="suaModalLabel-${nhanVien.id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Sửa Nhân Viên</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <form action="/nhan-vien/update" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="id" value="${nhanVien.id}">
                                            <div class="mb-3">
                                                <label for="hoTen-${nhanVien.id}" class="form-label">Họ Tên</label>
                                                <input type="text" class="form-control" id="hoTen-${nhanVien.id}"
                                                       name="hoTen" value="${nhanVien.hoTen}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="sdt-${nhanVien.id}" class="form-label">Số Điện Thoại</label>
                                                <input type="text" class="form-control" id="sdt-${nhanVien.id}"
                                                       name="sdt" value="${nhanVien.sdt}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="email-${nhanVien.id}" class="form-label">Email</label>
                                                <input type="email" class="form-control" id="email-${nhanVien.id}"
                                                       name="email" value="${nhanVien.email}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="matKhau-${nhanVien.id}" class="form-label">Mật Khẩu</label>
                                                <input type="password" class="form-control" id="matKhau-${nhanVien.id}"
                                                       name="matKhau" value="${nhanVien.matKhau}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="gioiTinh-${nhanVien.id}" class="form-label">Giới Tính</label><br>
                                                <input type="radio" class="form-check-input" id="gioiTinhNam-${nhanVien.id}" name="gioiTinh" value="Nam" ${nhanVien.gioiTinh == 'Nam' ? 'checked' : ''}> Nam
                                                <input type="radio" class="form-check-input" id="gioiTinhNu-${nhanVien.id}" name="gioiTinh" value="Nữ" ${nhanVien.gioiTinh == 'Nữ' ? 'checked' : ''}> Nữ
                                            </div>

                                            <div class="mb-3">
                                                <label for="trangThai-${nhanVien.id}" class="form-label">Trạng Thái</label>
                                                <input type="text" class="form-control" id="trangThai-${nhanVien.id}"
                                                       name="trangThai" value="${nhanVien.trangThai}" required>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Lưu</button>
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <!-- Modal sửa trạng thái -->
                        <div class="modal fade" id="suaTrangThaiModal-${nhanVien.id}" tabindex="-1"
                             aria-labelledby="suaTrangThaiModalLabel-${nhanVien.id}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <!-- Header của Modal -->
                                    <div class="modal-header bg-warning text-white">
                                        <h5 class="modal-title" id="suaTrangThaiModalLabel-${nhanVien.id}">Cập Nhật Trạng
                                            Thái</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <!-- Nội dung của Modal -->
                                    <div class="modal-body">
                                        <form action="/nhan-vien/update-trang-thai" method="post">
                                            <input type="hidden" name="id" value="${nhanVien.id}">
                                            <div class="form-group">
                                                <label for="trangThai-${nhanVien.id}">Chọn Trạng Thái:</label>
                                                <select class="form-control" id="trangThai-${nhanVien.id}"
                                                        name="trangThai">
                                                    <option value="Đang Hoạt Động" ${nhanVien.trangThai == 'Đang Hoạt Động' ? 'selected' : ''}>
                                                        Đang Hoạt Động
                                                    </option>
                                                    <option value="Không Hoạt Động" ${nhanVien.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>
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
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Mới Chất Liệu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/nhan-vien/add" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="hoTen" class="form-label">Họ Và Tên</label>
                                <input type="text" class="form-control" id="hoTen" name="hoTen" required>
                            </div>
                            <div class="mb-3">
                                <label for="sdt" class="form-label">Số Điện Thoại</label>
                                <input type="text" class="form-control" id="sdt" name="sdt" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="matKhau" class="form-label">Mật Khẩu</label>
                                <input type="matKhau" class="form-control" id="matKhau" name="matKhau" required>
                            </div>
                            <div class="mb-3">
                                <label  class="form-label">Giới Tính</label><br>
                                <input type="radio" class="form-check-input"  name="gioiTinh" value="Nam"> Nam
                                <input type="radio" class="form-check-input"  name="gioiTinh" value="Nữ"> Nữ
                            </div>
                            <div class="mb-3">
                                <label  class="form-label">Chức Vụ</label><br>
                                <input type="radio" class="form-check-input"  name="chucVu" value="Quản Lý"> Quản Lý
                                <input type="radio" class="form-check-input"  name="chucVu" value="Nhân Viên"> Nhân Viên
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Lưu</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        </div>
                    </form>
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
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
