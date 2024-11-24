<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Phương Thức Thanh Toán</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Phương Thức Thanh Toán</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng phương thức thanh toán -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Tên Phương Thức</th>
            <th>Ngày Tạo</th>
            <th>Ngày Sửa</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="phuongThucThanhToan">
            <tr>
                <td>${phuongThucThanhToan.id}</td>
                <td>${phuongThucThanhToan.tenPhuongThuc}</td>
                <td>${phuongThucThanhToan.ngayTao}</td>
                <td>${phuongThucThanhToan.ngaySua}</td>
                <td>${phuongThucThanhToan.trangThai}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${phuongThucThanhToan.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/phuong-thuc-thanh-toan/delete?id=${phuongThucThanhToan.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa phương thức thanh toán -->
            <div class="modal fade" id="suaModal-${phuongThucThanhToan.id}" tabindex="-1" aria-labelledby="suaModalLabel-${phuongThucThanhToan.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${phuongThucThanhToan.id}">Sửa Phương Thức Thanh Toán</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa phương thức thanh toán -->
                            <form action="/phuong-thuc-thanh-toan/update" method="post">
                                <input type="hidden" name="id" value="${phuongThucThanhToan.id}">
                                <div class="mb-3">
                                    <label for="tenPhuongThuc-${phuongThucThanhToan.id}" class="form-label">Tên Phương Thức</label>
                                    <input type="text" class="form-control" id="tenPhuongThuc-${phuongThucThanhToan.id}" name="tenPhuongThuc" value="${phuongThucThanhToan.tenPhuongThuc}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="ngayTao-${phuongThucThanhToan.id}" class="form-label">Ngày Tạo</label>
                                    <input type="datetime-local" class="form-control" id="ngayTao-${phuongThucThanhToan.id}" name="ngayTao" value="${phuongThucThanhToan.ngayTao}" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="trangThai-${phuongThucThanhToan.id}" class="form-label">Trạng Thái</label>
                                    <select class="form-select" id="trangThai-${phuongThucThanhToan.id}" name="trangThai" required>
                                        <option value="Hoạt Động" ${phuongThucThanhToan.trangThai == 'Hoạt Động' ? 'selected' : ''}>Hoạt Động</option>
                                        <option value="Không Hoạt Động" ${phuongThucThanhToan.trangThai == 'Không Hoạt Động' ? 'selected' : ''}>Không Hoạt Động</option>
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

<!-- Modal thêm mới phương thức thanh toán -->
<div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Phương Thức Thanh Toán</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form thêm mới phương thức thanh toán -->
                <form action="/phuong-thuc-thanh-toan/add" method="post">
                    <div class="mb-3">
                        <label for="tenPhuongThuc" class="form-label">Tên Phương Thức</label>
                        <input type="text" class="form-control" id="tenPhuongThuc" name="tenPhuongThuc" required>
                    </div>
                    <div class="mb-3">
                        <label for="trangThai" class="form-label">Trạng Thái</label>
                        <select class="form-select" id="trangThai" name="trangThai" required>
                            <option value="Hoạt Động">Hoạt Động</option>
                            <option value="Không Hoạt Động">Không Hoạt Động</option>
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
