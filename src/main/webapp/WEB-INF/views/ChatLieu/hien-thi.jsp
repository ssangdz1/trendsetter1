<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý chất liệu</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Thay vì Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Chất Liệu</h1>

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
                <h5>Danh sách chất liệu</h5>
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
                        <th>Tên Chất Liệu</th>
                        <th>Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSach}" var="chatLieu" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${chatLieu.tenChatLieu}</td>
                            <td>
                                <!-- Nút sửa -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${chatLieu.id}">
                                    <i class="bi bi-pencil-square">Chi Tiết</i>
                                </button>
                                <!-- Nút xóa -->
                                <form action="/chat-lieu/delete" method="post" style="display:inline;"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                    <input type="hidden" name="id" value="${chatLieu.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash">Xóa</i>
                                    </button>
                                </form>
                            </td>
                        </tr>

                        <!-- Modal sửa -->
                        <div class="modal fade" id="suaModal-${chatLieu.id}" tabindex="-1"
                             aria-labelledby="suaModalLabel-${chatLieu.id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">Sửa Chất Liệu</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                    </div>
                                    <form action="/chat-lieu/update" method="post">
                                        <div class="modal-body">
                                            <input type="hidden" name="id" value="${chatLieu.id}">
                                            <div class="mb-3">
                                                <label for="tenChatLieu-${chatLieu.id}" class="form-label">Tên Chất
                                                    Liệu</label>
                                                <input type="text" class="form-control" id="tenChatLieu-${chatLieu.id}"
                                                       name="tenChatLieu" value="${chatLieu.tenChatLieu}" required>
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
        <!-- Modal Thêm mới -->
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Thêm Mới Chất Liệu</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/chat-lieu/add" method="post">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="tenChatLieu" class="form-label">Tên chất liệu</label>
                                <input type="text" class="form-control" id="tenChatLieu" name="tenChatLieu" required>
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
