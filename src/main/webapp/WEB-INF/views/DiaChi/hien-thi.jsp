<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Địa Chỉ</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Thêm CSS Select2 -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />

    <!-- Thêm jQuery và Select2 JavaScript -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Địa Chỉ</h1>

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

    <%--Giao diện--%>
    <div class="container mt-5">
        <!-- Thêm mới và Danh sách chất liệu -->
        <div class="border p-3">
            <!-- Nút thêm mới -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5>Danh sách địa chỉ</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </button>
            </div>

            <!-- Bảng địa chỉ -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped align-middle">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Khách Hàng</th>
                        <th>Số Nhà</th>
                        <th>Phường</th>
                        <th>Huyện</th>
                        <th>Thành Phố</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSach}" var="diaChi" varStatus="status">
                        <tr>
                            <td><input type="hidden" value="${diaChi.id}">${status.index + 1}</td>
                            <td>
                                Họ và tên : ${diaChi.khachHang.hoTen}<br>
                                Số điện thoại : ${diaChi.khachHang.sdt}<br>
                                Email : ${diaChi.khachHang.email}<br>
                                Giới tính : ${diaChi.khachHang.gioiTinh}
                            </td>
                            <td>${diaChi.soNha}</td>
                            <td>${diaChi.phuong}</td>
                            <td>${diaChi.huyen}</td>
                            <td>${diaChi.thanhPho}</td>
                            <td>${diaChi.trangThai == true ? 'Mặc định' : 'Không Mặc Định'}</td>
                            <td>
                                <!-- Nút sửa (mở modal) -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${diaChi.id}">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </button>
                                <!-- Nút xóa -->
                                <form action="/dia-chi/delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                    <input type="hidden" name="id" value="${diaChi.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash">Xóa</i>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <!-- Modal sửa địa chỉ -->
                        <div class="modal fade" id="suaModal-${diaChi.id}" tabindex="-1"
                             aria-labelledby="suaModalLabel-${diaChi.id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="suaModalLabel-${diaChi.id}">Sửa Địa Chỉ</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Form sửa địa chỉ -->
                                        <form action="/dia-chi/update" method="post">
                                            <input type="hidden" name="id" value="${diaChi.id}">
                                            <div class="mb-3">
                                                <label class="form-label">Khách Hàng</label>
                                                <select class="form-select" name="khachHang" required>
                                                    <option value="">Chọn khách hàng</option>
                                                    <c:forEach items="${listKhachHang}" var="khachHang">
                                                        <option value="${khachHang.id}"
                                                            ${diaChi.khachHang.id == khachHang.id ? 'selected' : ''}>
                                                                ${khachHang.hoTen} - ${khachHang.sdt}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <div class="mb-3">
                                                <label for="soNha-${diaChi.id}" class="form-label">Số Nhà</label>
                                                <input type="number" class="form-control" id="soNha-${diaChi.id}" name="soNha"
                                                       value="${diaChi.soNha}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="phuong-${diaChi.id}" class="form-label">Phường</label>
                                                <input type="text" class="form-control" id="phuong-${diaChi.id}" name="phuong"
                                                       value="${diaChi.phuong}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="huyen-${diaChi.id}" class="form-label">Huyện</label>
                                                <input type="text" class="form-control" id="huyen-${diaChi.id}" name="huyen"
                                                       value="${diaChi.huyen}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="thanhPho-${diaChi.id}" class="form-label">Thành Phố</label>
                                                <input type="text" class="form-control" id="thanhPho-${diaChi.id}"
                                                       name="thanhPho" value="${diaChi.thanhPho}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="trangThai-${diaChi.id}" class="form-label">Trạng Thái</label>
                                                <select class="form-select" id="trangThai-${diaChi.id}" name="trangThai" required>
                                                    <option value="true" ${diaChi.trangThai == true ? 'selected' : ''}>Mặc Định</option>
                                                    <option value="false" ${diaChi.trangThai == false ? 'selected' : ''}>Không Mặc Định</option>
                                                </select>
                                            </div>
                                            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
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
                        <c:if test="${not empty totalPages and totalPages > 0}">
                            <c:forEach var="i" begin="${pageNumber - 2 < 0 ? 0 : pageNumber - 2}"
                                       end="${pageNumber + 2 >= totalPages ? totalPages - 1 : pageNumber + 2}">
                                <li class="page-item ${pageNumber == i ? 'active' : ''}">
                                    <a class="page-link" href="?page=${i}">${i + 1}</a>
                                </li>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty totalPages or totalPages == 0}">
                            <li class="page-item disabled">
                                <span class="page-link">No pages available</span>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

        <!-- Modal thêm mới địa chỉ -->
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="themMoiLabel">Thêm Mới Địa Chỉ</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Form thêm mới địa chỉ -->
                        <form action="/dia-chi/add" method="post">
                            <div class="mb-3">
                                <label for="khachHang-${diaChi.id}" class="form-label">Khách Hàng</label>
                                <select class="form-select" id="khachHang-${diaChi.id}" name="khachHang" required>
                                    <option value="">Chọn khách hàng</option>
                                    <c:forEach items="${listKhachHang}" var="khachHang">
                                        <option value="${khachHang.id}" ${khachHang.id == diaChi.khachHang.id ? 'selected' : ''}>
                                                ${khachHang.hoTen} - ${khachHang.sdt}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="tenDuong" class="form-label">Tên Đường</label>
                                <input type="text" class="form-control" id="tenDuong" name="tenDuong" required>
                            </div>
                            <div class="mb-3">
                                <label for="soNha" class="form-label">Số Nhà</label>
                                <input type="number" class="form-control" id="soNha" name="soNha" required>
                            </div>
                            <div class="mb-3">
                                <label for="phuong" class="form-label">Phường</label>
                                <input type="text" class="form-control" id="phuong" name="phuong" required>
                            </div>
                            <div class="mb-3">
                                <label for="huyen" class="form-label">Huyện</label>
                                <input type="text" class="form-control" id="huyen" name="huyen" required>
                            </div>
                            <div class="mb-3">
                                <label for="thanhPho" class="form-label">Thành Phố</label>
                                <input type="text" class="form-control" id="thanhPho" name="thanhPho" required>
                            </div>
                            <div class="mb-3">
                                <label for="trangThai" class="form-label">Trạng Thái</label>
                                <select class="form-select" id="trangThai" name="trangThai" required>
                                    <option value="true">Mặc Định</option>
                                    <option value="false">Không Mặc Định</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Thêm Mới</button>
                        </form>
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

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
