<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Sản Phẩm</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Sản Phẩm</h1>

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
                <h5>Danh sách sản phẩm</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </button>
            </div>


            <!-- Bảng sản phẩm -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped text-center align-middle">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên Sản Phẩm</th>
                        <th>Tồn Kho</th>
                        <th>Thương Hiệu</th>
                        <th>Xuất Sứ</th>
                        <th>Danh Mục</th>
                        <th>Mô tả</th>
                        <th>Trạng Thái</th>
                        <th>Chức Năng</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${danhSach}" var="sanPham" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>${sanPham.tenSanPham}</td>
                            <td>${sanPham.soLuong}</td>
                            <td>${sanPham.thuongHieu.tenThuongHieu}</td>
                            <td>${sanPham.xuatSu.quocGia}</td>
                            <td>${sanPham.danhMuc.tenDanhMuc}</td>
                            <td>${sanPham.moTa}</td>
                            <td>
                                <!-- Nút trạng thái -->
                                <button class="btn ${sanPham.trangThai == 'Đang Hoạt Động' ? 'btn-success' : 'btn-danger'}"
                                        data-bs-toggle="modal"
                                        data-bs-target="#suaTrangThaiModal-${sanPham.id}">
                                        ${sanPham.trangThai}
                                </button>
                            </td>
                            <td>
                                <!-- Nút sửa (mở modal) -->
                                <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                        data-bs-target="#suaModal-${sanPham.id}">
                                    <i class="bi bi-pencil-square"></i> Sửa
                                </button>
                                <!-- Nút xóa -->
                                <form action="/san-pham/delete" method="post"
                                      onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');" style="display:inline;">
                                    <input type="hidden" name="id" value="${sanPham.id}">
                                    <button type="submit" class="btn btn-danger btn-sm">
                                        <i class="bi bi-trash"></i> Xóa
                                    </button>
                                </form>
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
                                        <form action="/san-pham/update" method="post">
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
                                                        name="thuongHieu" required>
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
                                        <form action="/san-pham/update-trang-thai" method="post">
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

        <!-- Modal thêm mới sản phẩm -->
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="themMoiLabel">Thêm Mới Sản Phẩm</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Form thêm mới sản phẩm -->
                        <form action="/san-pham/add" method="post">
                            <div class="modal-body">
                                <!-- Hàng: Tên sản phẩm và Danh mục -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="tenSanPham" class="form-label">Tên Sản Phẩm</label>
                                        <input type="text" class="form-control" id="tenSanPham" name="tenSanPham"
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
                                    <textarea class="form-control" id="moTa" name="moTa" rows="4" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                            </div>
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
