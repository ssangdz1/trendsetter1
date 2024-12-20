<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý khuyến mại</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thay vì Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Khuyến Mãi</h1>

    <%--Form tìm kiếm--%>
    <div class="container mt-5">
        <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
            <!-- Tiêu đề -->
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-funnel me-2 text-primary" style="font-size: 1.5rem;"></i>
                <h5 class="text-primary mb-0">Bộ lọc</h5>
            </div>

            <!-- Bộ lọc -->
            <form id="filterForm" action="/khuyen-mai/hien-thi" method="get">
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
                <h5>Danh sách khuyến mãi</h5>
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
                        <th>Tên Chương Trình</th>
                        <th>Gía Trị</th>
                        <th>Điều Kiện</th>
                        <th>Ngày Bắt Đầu</th>
                        <th>Ngày Kết Thúc</th>
                        <th>Mô Tả</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSach}" var="khuyenMai" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${khuyenMai.tenChuongTrinh}</td>
                            <td>${khuyenMai.giaTri}</td>
                            <td>${khuyenMai.dieuKien}</td>
                            <td>${khuyenMai.ngayTao}</td>
                            <td>${khuyenMai.ngaySua}</td>
                            <td>${khuyenMai.moTa}</td>
                            <!-- Nút trạng thái -->
                            <td>
                                <button class="btn ${khuyenMai.trangThai == 'Đang Hoạt Động' ? 'btn-success' : 'btn-danger'}"
                                        data-bs-toggle="modal"
                                        data-bs-target="#suaTrangThaiModal-${khuyenMai.id}">
                                        ${khuyenMai.trangThai}
                                </button>
                            </td>
                            <td>
                                <!-- Nút sửa -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${khuyenMai.id}">
                                    <i class="bi bi-pencil-square">Chi Tiết</i>
                                </button>
                                <!-- Nút xóa -->
                                <form action="/khuyen-mai/delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                    <input type="hidden" name="id" value="${khuyenMai.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash">Xóa</i>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <!-- Modal sửa -->
                        <div class="modal fade" id="suaModal-${khuyenMai.id}" tabindex="-1"
                             aria-labelledby="suaModalLabel-${khuyenMai.id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Sửa Khuyến Mại</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <form action="/khuyen-mai/update" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="id" value="${khuyenMai.id}">
                                            <div class="mb-3">
                                                <label for="tenChuongTrinh-${khuyenMai.id}" class="form-label">Tên
                                                    Chương Trình</label>
                                                <input type="text" class="form-control"
                                                       id="tenChuongTrinh-${khuyenMai.id}"
                                                       name="tenChuongTrinh" value="${khuyenMai.tenChuongTrinh}"
                                                       required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="giaTri-${khuyenMai.id}" class="form-label">Giá Trị
                                                    Giảm</label>
                                                <input type="text" class="form-control" id="giaTri-${khuyenMai.id}"
                                                       name="giaTri" value="${khuyenMai.giaTri}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="dieuKien-${khuyenMai.id}" class="form-label">Điều Kiện
                                                    Giảm</label>
                                                <input type="text" class="form-control" id="dieuKien-${khuyenMai.id}"
                                                       name="dieuKien" value="${khuyenMai.dieuKien}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="ngayTao-${khuyenMai.id}" class="form-label">Ngày Tạo</label>
                                                <input type="datetime-local" class="form-control"
                                                       id="ngayTao-${khuyenMai.id}"
                                                       name="ngayTao" value="${khuyenMai.ngayTao}" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label for="ngaySua-${khuyenMai.id}" class="form-label">Ngày Kết
                                                    Thúc</label>
                                                <input type="datetime-local" class="form-control"
                                                       id="ngaySua-${khuyenMai.id}"
                                                       name="ngaySua" value="${khuyenMai.ngaySua}" required>
                                            </div>
                                            <div class="mb-3">
                                                <label for="moTa-${khuyenMai.id}" class="form-label">Mô Tả</label>
                                                <input type="text" class="form-control" id="moTa-${khuyenMai.id}"
                                                       name="moTa" value="${khuyenMai.moTa}" required>
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
                        <div class="modal fade" id="suaTrangThaiModal-${khuyenMai.id}" tabindex="-1"
                             aria-labelledby="suaTrangThaiModalLabel-${khuyenMai.id}" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <!-- Header của Modal -->
                                    <div class="modal-header bg-warning text-white">
                                        <h5 class="modal-title" id="suaTrangThaiModalLabel-${khuyenMai.id}">Cập Nhật Trạng Thái</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <!-- Nội dung của Modal -->
                                    <div class="modal-body">
                                        <form action="/khuyen-mai/update-trang-thai" method="post">
                                            <input type="hidden" name="id" value="${khuyenMai.id}">
                                            <div class="form-group">
                                                <label for="trangThai-${khuyenMai.id}">Chọn Trạng Thái:</label>
                                                <select class="form-control" id="trangThai-${sanPham.id}"
                                                        name="trangThai">
                                                    <option value="Đang Hoạt Động" ${khuyenMai.trangThai == 'Đang Hoạt Động' ? 'selected' : ''}>
                                                        Đang Hoạt Động
                                                    </option>
                                                    <option value="Không Hoạt Động" ${khuyenMai.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>
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
        <!-- Modal Thêm mới -->
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Mới Khuyến Mại</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/khuyen-mai/add" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="tenChuongTrinh" class="form-label">Tên Chương Trình</label>
                                <input type="text" class="form-control" id="tenChuongTrinh" name="tenChuongTrinh" required>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="giaTri" class="form-label">Giá Trị Giảm</label>
                                <input type="text" class="form-control" id="giaTri" name="giaTri" required>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="dieuKien" class="form-label">Điều Kiện Giảm</label>
                                <input type="text" class="form-control" id="dieuKien" name="dieuKien" required>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="ngaySua" class="form-label">Ngày Kết Thúc</label>
                                <input type="datetime-local" class="form-control" id="ngaySua" name="ngaySua" required>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="moTa" class="form-label">Mô Tả</label>
                                <input type="text" class="form-control" id="moTa" name="moTa" required>
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
