<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Thương Hiệu</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Thương Hiệu</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng thương hiệu -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên Thương Hiệu</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="thuongHieu">
            <tr>
                <td>${thuongHieu.id}</td>
                <td>${thuongHieu.tenThuongHieu}</td>
                <td>${thuongHieu.trangThai}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${thuongHieu.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/thuong-hieu/delete?id=${thuongHieu.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa thương hiệu -->
            <div class="modal fade" id="suaModal-${thuongHieu.id}" tabindex="-1" aria-labelledby="suaModalLabel-${thuongHieu.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${thuongHieu.id}">Sửa Thương Hiệu</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa thương hiệu -->
                            <form action="/thuong-hieu/update" method="post">
                                <input type="hidden" name="id" value="${thuongHieu.id}">
                                <div class="mb-3">
                                    <label for="tenThuongHieu-${thuongHieu.id}" class="form-label">Tên Thương Hiệu</label>
                                    <input type="text" class="form-control" id="tenThuongHieu-${thuongHieu.id}" name="tenThuongHieu" value="${thuongHieu.tenThuongHieu}" required>
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

<!-- Modal thêm mới thương hiệu -->
<div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Thương Hiệu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form thêm mới thương hiệu -->
                <form action="/thuong-hieu/add" method="post">
                    <div class="mb-3">
                        <label for="tenThuongHieu" class="form-label">Tên Thương Hiệu</label>
                        <input type="text" class="form-control" id="tenThuongHieu" name="tenThuongHieu" required>
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
