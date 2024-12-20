<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Hình Ảnh</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- FilePond CSS (thư viện hiện đại cho file upload) -->
    <link href="https://cdn.jsdelivr.net/npm/filepond@4.30.4/dist/filepond.css" rel="stylesheet"/>
    <style>
        .modal-body {
            max-height: 75vh;
            overflow-y: auto;
        }

        .preview-container {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 30px;
        }

        .preview-img {
            max-width: 100%;
            height: auto;
            display: block;
        }

        .arrow {
            font-size: 30px;
            color: #007bff;
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Hình Ảnh</h1>

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
                <h5>Danh sách hình ảnh</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </button>
            </div>

            <!-- Bảng hình ảnh -->
            <table class="table table-bordered table-striped text-center align-middle">
                <thead>
                <tr>
                    <th style="width: 5%" ;>ID</th>
                    <th style="width: 40%" ;>URL Hình Ảnh</th>
                    <th style="width: 30%" ;>ID San Pham</th>
                    <th style="width: 20%">Chức Năng</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${danhSach}" var="hinhAnh" varStatus="status">
                    <tr>
                        <td><input type="hidden" value="${hinhAnh.id}">${status.index+1}</td>
                        <td>
                            <img src="/images/${hinhAnh.urlHinhAnh}" alt="Hình Ảnh" class="img-thumbnail"
                                 style="max-width: 100px; cursor: pointer;" data-bs-toggle="modal"
                                 data-bs-target="#viewImageModal-${hinhAnh.id}">
                        </td>
                        <td>${hinhAnh.sanPhamChiTiet.id}</td>
                        <td>
                            <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                    data-bs-target="#suaModal-${hinhAnh.id}">
                                <i class="bi bi-pencil-square"></i> Sửa
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <a href="/hinh-anh/delete?id=${hinhAnh.id}" class="text-white text-decoration-none">
                                    <i class="bi bi-trash"></i> Xóa
                                </a>
                            </button>
                        </td>
                    </tr>

                    <!-- Modal sửa hình ảnh -->
                    <div class="modal fade" id="suaModal-${hinhAnh.id}" tabindex="-1"
                         aria-labelledby="suaModalLabel-${hinhAnh.id}" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="suaModalLabel-${hinhAnh.id}">Sửa Hình Ảnh</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <!-- Hiển thị ảnh cũ bên trái và ảnh mới bên phải -->
                                    <div class="preview-container">
                                        <div>
                                            <h6>Ảnh Cũ</h6>
                                            <img src="/images/${hinhAnh.urlHinhAnh}" alt="Hình Ảnh hiện tại"
                                                 class="preview-img" style="max-width: 150px; cursor: pointer;">
                                        </div>
                                        <div class="arrow">➡</div>
                                        <div>
                                            <h6>Ảnh Mới</h6>
                                            <img id="previewImg-${hinhAnh.id}" class="preview-img"
                                                 style="max-width: 150px; cursor: pointer;"/>
                                        </div>
                                    </div>
                                    <div class="text-center mt-3">
                                        <p><strong>Bạn có muốn thay ảnh này không?</strong></p>
                                    </div>

                                    <!-- Form sửa hình ảnh -->
                                    <form action="/hinh-anh/update" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="id" value="${hinhAnh.id}">
                                        <div class="mb-3">
                                            <label for="urlHinhAnh-${hinhAnh.id}" class="form-label">Chọn ảnh
                                                mới</label>
                                            <!-- Input file cho hình ảnh -->
                                            <input type="file" class="form-control" name="urlHinhAnh"
                                                   id="urlHinhAnh-${hinhAnh.id}" required>
                                        </div>
                                        <button type="submit" class="btn btn-success btn-lg w-100 mt-3">Lưu thay đổi
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

        <!-- Modal thêm mới hình ảnh -->
        <div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="themMoiLabel">Thêm Mới Hình Ảnh</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Form thêm mới hình ảnh -->
                        <form action="/hinh-anh/add" method="post" enctype="multipart/form-data">
                            <div class="mb-3">
                                <label for="urlHinhAnh" class="form-label">Chọn ảnh mới</label>
                                <input type="file" class="form-control" name="urlHinhAnh" id="urlHinhAnh" required>
                                <!-- Khung ảnh preview -->
                                <img id="previewImg" class="preview-img"/>
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

<script>
    // JavaScript cho việc xem trước ảnh khi chọn file
    document.querySelectorAll('input[type="file"]').forEach(input => {
        input.addEventListener('change', function (event) {
            const file = event.target.files[0];
            const reader = new FileReader();
            const preview = document.getElementById('previewImg-' + event.target.id.split('-')[1]);

            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = 'block'; // Hiển thị ảnh
            };

            if (file) {
                reader.readAsDataURL(file);
            }
        });
    });

    // JavaScript cho modal thêm mới
    document.getElementById('urlHinhAnh').addEventListener('change', function (event) {
        const file = event.target.files[0];
        const reader = new FileReader();
        const preview = document.getElementById('previewImg');

        reader.onload = function (e) {
            preview.src = e.target.result;
            preview.style.display = 'block'; // Hiển thị ảnh
        };

        if (file) {
            reader.readAsDataURL(file);
        }
    });
</script>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>
