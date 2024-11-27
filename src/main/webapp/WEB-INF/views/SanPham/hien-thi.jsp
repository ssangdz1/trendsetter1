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
    <h1 class="mb-3">Quản lý Sản Phẩm</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng sản phẩm -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên Sản Phẩm</th>
            <th>Danh Mục</th>
            <th>Ngày Tạo</th>
            <th>Ngày Sửa</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="sanPham">
            <tr>
                <td>${sanPham.id}</td>
                <td>${sanPham.tenSanPham}</td>
                <td>${sanPham.danhMuc.tenDanhMuc}</td>
                <td>${sanPham.ngayTao}</td>
                <td>${sanPham.ngaySua}</td>
                <td>${sanPham.trangThai}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${sanPham.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/san-pham/delete?id=${sanPham.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa sản phẩm -->
            <div class="modal fade" id="suaModal-${sanPham.id}" tabindex="-1" aria-labelledby="suaModalLabel-${sanPham.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${sanPham.id}">Sửa Sản Phẩm</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa sản phẩm -->
                            <form action="/san-pham/update" method="post">
                                <input type="hidden" name="id" value="${sanPham.id}">
                                <div class="mb-3">
                                    <label for="tenSanPham-${sanPham.id}" class="form-label">Tên Sản Phẩm</label>
                                    <input type="text" class="form-control" id="tenSanPham-${sanPham.id}" name="tenSanPham" value="${sanPham.tenSanPham}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="danhMuc-${sanPham.id}" class="form-label">Danh Mục</label>
                                    <select class="form-select" id="danhMuc-${sanPham.id}" name="danhMuc" required>
                                        <c:forEach items="${listDanhMuc}" var="danhMuc">
                                            <option value="${danhMuc.id}" ${danhMuc.id == sanPham.danhMuc.id ? 'selected' : ''}>${danhMuc.tenDanhMuc}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="ngayTao-${sanPham.id}" class="form-label">Ngày Tạo</label>
                                    <input type="datetime-local" class="form-control" id="ngayTao-${sanPham.id}" name="ngayTao" value="${sanPham.ngayTao}" readonly>
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
                    <div class="mb-3">
                        <label for="tenSanPham" class="form-label">Tên Sản Phẩm</label>
                        <input type="text" class="form-control" id="tenSanPham" name="tenSanPham" required>
                    </div>
                    <div class="mb-3">
                        <label for="danhMuc" class="form-label">Danh Mục</label>
                        <select class="form-select" id="danhMuc" name="danhMuc" required>
                            <c:forEach items="${listDanhMuc}" var="danhMuc">
                                <option value="${danhMuc.id}">${danhMuc.tenDanhMuc}</option>
                            </c:forEach>
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
