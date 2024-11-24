<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Đánh Giá</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Đánh Giá</h1>

    <!-- Nút mở modal thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm mới
    </button>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Id</th>
            <th>Số Sao</th>
            <th>Nhận Xét</th>
            <th>Ngày Đánh Giá</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="danhGia">
            <tr>
                <td>${danhGia.id}</td>
                <td>${danhGia.soSao}</td>
                <td>${danhGia.nhanXet}</td>
                <td>${danhGia.ngayDanhGia}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${danhGia.id}">
                        <i class="bi bi-info-circle"></i> Chi Tiết
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/danh-gia/delete?id=${danhGia.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal Sửa -->
            <div class="modal fade" id="suaModal-${danhGia.id}" tabindex="-1" aria-labelledby="suaModalLabel-${danhGia.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${danhGia.id}">Sửa Đánh Giá</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa -->
                            <form action="/danh-gia/update" method="post">
                                <input type="hidden" name="id" value="${danhGia.id}">
                                <div class="mb-3">
                                    <label for="soSao-${danhGia.id}" class="form-label">Số Sao</label>
                                    <select class="form-select" id="soSao-${danhGia.id}" name="soSao" required>
                                        <option value="1" ${danhGia.soSao == 1 ? 'selected' : ''}>1 Sao</option>
                                        <option value="2" ${danhGia.soSao == 2 ? 'selected' : ''}>2 Sao</option>
                                        <option value="3" ${danhGia.soSao == 3 ? 'selected' : ''}>3 Sao</option>
                                        <option value="4" ${danhGia.soSao == 4 ? 'selected' : ''}>4 Sao</option>
                                        <option value="5" ${danhGia.soSao == 5 ? 'selected' : ''}>5 Sao</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="nhanXet-${danhGia.id}" class="form-label">Nhận Xét</label>
                                    <textarea class="form-control" id="nhanXet-${danhGia.id}" name="nhanXet" rows="3" required>${danhGia.nhanXet}</textarea>
                                </div>
                                <div class="mb-3">
                                    <label for="ngayDanhGia-${danhGia.id}" class="form-label">Ngày Đánh Giá</label>
                                    <input type="date" id="ngayDanhGia-${danhGia.id}" class="form-control" name="ngayDanhGia" value="${danhGia.ngayDanhGia}" readonly>
                                </div>
                                <button type="submit" class="btn btn-primary">Chỉnh sửa</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal Thêm Mới -->
<div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Đánh Giá</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form thêm mới -->
                <form action="/danh-gia/add" method="post">
                    <div class="mb-3">
                        <label for="soSao" class="form-label">Số Sao</label>
                        <select class="form-select" id="soSao" name="soSao" required>
                            <option value="1">1 Sao</option>
                            <option value="2">2 Sao</option>
                            <option value="3">3 Sao</option>
                            <option value="4">4 Sao</option>
                            <option value="5">5 Sao</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="nhanXet" class="form-label">Nhận Xét</label>
                        <textarea class="form-control" id="nhanXet" name="nhanXet" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="ngayDanhGia" class="form-label">Ngày Đánh Giá</label>
                        <input type="date" id="ngayDanhGia" class="form-control" name="ngayDanhGia" readonly>
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script>
    window.onload = function() {
        // Set today's date for the "Ngày Đánh Giá" field in "Thêm Mới" form
        var today = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
        document.getElementById('ngayDanhGia').value = today;
    };
</script>

</body>
</html>
