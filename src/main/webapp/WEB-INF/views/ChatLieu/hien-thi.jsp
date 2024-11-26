<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý chất liệu</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý chất liệu</h1>

    <!-- Nút mở modal thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm mới
    </button>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Id</th>
            <th>Tên Chất Liệu</th>
            <th>Mô Tả</th>
            <th>Id SPCT</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="chatLieu">
            <tr>
                <td>${chatLieu.id}</td>
                <td>${chatLieu.tenChatLieu}</td>
                <td>${chatLieu.moTa}</td>
                <td>${chatLieu.sanPhamChiTiet}</td>
                <td>
                    <!-- Nút sửa (mở modal) -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${chatLieu.id}">
                        <i class="bi bi-info-circle"></i> Chi Tiết
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/chat-lieu/delete?id=${chatLieu.id}" class="text-white text-decoration-none">
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal Sửa -->
            <div class="modal fade" id="suaModal-${chatLieu.id}" tabindex="-1" aria-labelledby="suaModalLabel-${chatLieu.id}" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="suaModalLabel-${chatLieu.id}">Sửa Chất Liệu</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Form sửa -->
                            <form action="/chat-lieu/update" method="post">
                                <input type="hidden" name="id" value="${chatLieu.id}">
                                <div class="mb-3">
                                    <label for="tenChatLieu-${chatLieu.id}" class="form-label">Tên Chất Liệu</label>
                                    <input type="text" class="form-control" id="tenChatLieu-${chatLieu.id}" name="tenChatLieu"
                                           value="${chatLieu.tenChatLieu}" required>
                                </div>
                                <div class="mb-3">
                                    <label for="moTa-${chatLieu.id}" class="form-label">Mô Tả</label>
                                    <textarea class="form-control" id="moTa-${chatLieu.id}" name="moTa" rows="3" required>${chatLieu.moTa}</textarea>
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
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Chất Liệu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- Form thêm mới -->
                <form action="/chat-lieu/add" method="post">
                    <div class="mb-3">
                        <label for="tenChatLieu" class="form-label">Tên Chất Liệu</label>
                        <input type="text" class="form-control" id="tenChatLieu" name="tenChatLieu" required>
                    </div>
                    <div class="mb-3">
                        <label for="moTa" class="form-label">Mô Tả</label>
                        <textarea class="form-control" id="moTa" name="moTa" rows="3" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
