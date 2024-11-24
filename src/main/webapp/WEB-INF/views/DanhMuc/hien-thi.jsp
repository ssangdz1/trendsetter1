<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Danh Mục</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Danh Mục</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng danh mục -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên Danh Mục</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="danhMuc">
            <tr>
                <td>${danhMuc.id}</td>
                <td>${danhMuc.tenDanhMuc}</td>
                <td>${danhMuc.trangThai}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${danhMuc.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/danh-muc/delete?id=${danhMuc.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa danh mục -->
            <div class="modal fade" id="suaModal-${danhMuc.id}" tabindex="-1" aria-labelledby="suaModalLabel-${danhMuc.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${danhMuc.id}">Sửa Danh Mục</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa danh mục -->
                            <form action="/danh-muc/update" method="post">
                                <input type="hidden" name="id" value="${danhMuc.id}">
                                <div class="mb-3">
                                    <label for="tenDanhMuc-${danhMuc.id}" class="form-label">Tên Danh Mục</label>
                                    <input type="text" class="form-control" id="tenDanhMuc-${danhMuc.id}" name="tenDanhMuc" value="${danhMuc.tenDanhMuc}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="trangThai-${danhMuc.id}" class="form-label">Trạng Thái</label>
                                    <select class="form-select" id="trangThai-${danhMuc.id}" name="trangThai" required>
                                        <option value="Active" ${danhMuc.trangThai == 'Hoạt Động' ? 'selected' : ''}>Hoạt Động</option>
                                        <option value="Inactive" ${danhMuc.trangThai == 'Ngừng Hoạt Động' ? 'selected' : ''}>Ngừng Hoạt Động</option>
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
</div>

<!-- Modal thêm mới danh mục -->
<div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Danh Mục</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form thêm mới danh mục -->
                <form action="/danh-muc/add" method="post">
                    <div class="mb-3">
                        <label for="tenDanhMuc" class="form-label">Tên Danh Mục</label>
                        <input type="text" class="form-control" id="tenDanhMuc" name="tenDanhMuc" required>
                    </div>
                    <div class="mb-3">
                        <label for="trangThai" class="form-label">Trạng Thái</label>
                        <select class="form-select" id="trangThai" name="trangThai" required>
                            <option value="Hoạt Động">Hoạt Động</option>
                            <option value="Ngừng Hoạt Động">Ngừng Hoạt Động</option>
                        </select>
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
