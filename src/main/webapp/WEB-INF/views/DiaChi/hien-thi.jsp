<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Địa Chỉ</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Địa Chỉ</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng địa chỉ -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>ID</th>
            <th>Số Nhà</th>
            <th>Phường</th>
            <th>Quận</th>
            <th>Huyện</th>
            <th>Thành Phố</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="diaChi">
            <tr>
                <td>${diaChi.id}</td>
                <td>${diaChi.tenDuong}</td>
                <td>${diaChi.soNha}</td>
                <td>${diaChi.phuong}</td>
                <td>${diaChi.huyen}</td>
                <td>${diaChi.thanhPho}</td>
                <td>${diaChi.trangThai}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${diaChi.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/dia-chi/delete?id=${diaChi.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa địa chỉ -->
            <div class="modal fade" id="suaModal-${diaChi.id}" tabindex="-1" aria-labelledby="suaModalLabel-${diaChi.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${diaChi.id}">Sửa Địa Chỉ</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa địa chỉ -->
                            <form action="/dia-chi/update" method="post">
                                <input type="hidden" name="id" value="${diaChi.id}">
                                <div class="mb-3">
                                    <label for="tenDuong-${diaChi.id}" class="form-label">Tên Đường</label>
                                    <input type="text" class="form-control" id="tenDuong-${diaChi.id}" name="tenDuong" value="${diaChi.tenDuong}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="soNha-${diaChi.id}" class="form-label">Số Nhà</label>
                                    <input type="number" class="form-control" id="soNha-${diaChi.id}" name="soNha" value="${diaChi.soNha}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="phuong-${diaChi.id}" class="form-label">Phường</label>
                                    <input type="text" class="form-control" id="phuong-${diaChi.id}" name="phuong" value="${diaChi.phuong}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="huyen-${diaChi.id}" class="form-label">Huyện</label>
                                    <input type="text" class="form-control" id="huyen-${diaChi.id}" name="huyen" value="${diaChi.huyen}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="thanhPho-${diaChi.id}" class="form-label">Thành Phố</label>
                                    <input type="text" class="form-control" id="thanhPho-${diaChi.id}" name="thanhPho" value="${diaChi.thanhPho}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="trangThai-${diaChi.id}" class="form-label">Trạng Thái</label>
                                    <select class="form-select" id="trangThai-${diaChi.id}" name="trangThai" required>
                                        <option value="Mặc định" ${diaChi.trangThai == 'Mặc định' ? 'selected' : ''}>Mặc Định</option>
                                        <option value="Địa chỉ 1" ${diaChi.trangThai == 'Địa chỉ 1' ? 'selected' : ''}>Địa chỉ 1</option>
                                        <option value="Địa chỉ 2" ${diaChi.trangThai == 'Địa chỉ 2' ? 'selected' : ''}>Địa chỉ 2</option>
                                        <option value="Địa chỉ 3" ${diaChi.trangThai == 'Địa chỉ 3' ? 'selected' : ''}>Địa chỉ 3</option>
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

<!-- Modal thêm mới địa chỉ -->
<div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Địa Chỉ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form thêm mới địa chỉ -->
                <form action="/dia-chi/add" method="post">
                    <div class="mb-3">
                        <label for="tenDuong" class="form-label">Tên Đường</label>
                        <input type="text" class="form-control" id="tenDuong" name="tenDuong" required>
                    </div>
                    <div class="mb-3">
                        <label for="soNha" class="form-label">Số Nhà</label>
                        <input type="number" class="form-control" id="soNha" name="soNha" required>
                    </div>
                    <div class="mb-3">
                        <label for="phuong" class="form-label">Phường</label>
                        <input type="text" class="form-control" id="phuong" name="phuong" required>
                    </div>
                    <div class="mb-3">
                        <label for="huyen" class="form-label">Huyện</label>
                        <input type="text" class="form-control" id="huyen" name="huyen" required>
                    </div>
                    <div class="mb-3">
                        <label for="thanhPho" class="form-label">Thành Phố</label>
                        <input type="text" class="form-control" id="thanhPho" name="thanhPho" required>
                    </div>
                    <div class="mb-3">
                        <label for="trangThai" class="form-label">Trạng Thái</label>
                        <select class="form-select" id="trangThai" name="trangThai" required>
                            <option value="Mặc định">Mặc định</option>
                            <option value="Địa chỉ 1">Địa chỉ 1</option>
                            <option value="Địa chỉ 2">Địa chỉ 2</option>
                            <option value="Địa chỉ 3">Địa chỉ 3</option>
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
