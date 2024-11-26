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
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Hình Ảnh</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng hình ảnh -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>URL Hình Ảnh</th>
            <th>ID SPCT</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="hinhAnh">
            <tr>
                <td>${hinhAnh.id}</td>
                <td><img src="/images/${hinhAnh.urlHinhAnh}" alt="Hình Ảnh" class="img-thumbnail" style="max-width: 100px;"></td>
                <td>${hinhAnh.sanPhamChiTiet}</td>
                <td>${hinhAnh.trangThai}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${hinhAnh.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/hinh-anh/delete?id=${hinhAnh.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa hình ảnh -->
            <div class="modal fade" id="suaModal-${hinhAnh.id}" tabindex="-1" aria-labelledby="suaModalLabel-${hinhAnh.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${hinhAnh.id}">Sửa Hình Ảnh</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa hình ảnh -->
                            <form action="/hinh-anh/update" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="${hinhAnh.id}">
                                <div class="mb-3">
                                    <label for="urlHinhAnh-${hinhAnh.id}" class="form-label">URL Hình Ảnh</label>
                                    <input type="file" class="form-control" id="urlHinhAnh-${hinhAnh.id}" name="urlHinhAnh" value="${hinhAnh.urlHinhAnh}" required>
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
                        <label for="urlHinhAnh" class="form-label">URL Hình Ảnh</label>
                        <input type="file" class="form-control" id="urlHinhAnh" name="urlHinhAnh" required>
                    </div>
                    <button type="submit" class="btn btn-primary">Thêm Mới</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
