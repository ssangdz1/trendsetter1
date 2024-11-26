<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Sản Phẩm Chi Tiết</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-check {
            margin-bottom: 10px; /* Tăng khoảng cách giữa các mục */
        }
    </style>

</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Quản lý Sản Phẩm Chi Tiết</h1>

    <!-- Nút thêm mới -->
    <button class="btn btn-primary btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#themMoiModal">
        <i class="bi bi-plus-circle"></i> Thêm Mới
    </button>

    <!-- Bảng sản phẩm chi tiết -->
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>
                <input type="checkbox" id="selectAllCheckbox"> Chọn tất cả
            </th>
            <th>ID</th>
            <th>Tên Sản Phẩm</th>
            <th>Giá Bán</th>
            <th>Tồn Kho</th>
            <th>Trạng Thái</th>
            <th>Chức Năng</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${danhSach}" var="spct">
            <tr>
                <td>
                    <input type="checkbox" class="itemCheckbox" name="selectedIds" value="${spct.id}">
                </td>
                <td>${spct.id}</td>
                <td>${spct.sanPham.tenSanPham}<br>
                    Thương Hiệu : ${spct.thuongHieu.tenThuongHieu}<br>
                    Xuất Sứ : ${spct.xuatSu.tenXuatSu}</td>
                <td>${spct.giaBan}</td>
                <td>${spct.soLuong}</td>
                <td>${spct.trangThai}</td>
                <td>
                    <!-- Nút sửa -->
                    <button class="btn btn-warning btn-sm" data-bs-toggle="modal" data-bs-target="#suaModal-${spct.id}">
                        <i class="bi bi-pencil-square"></i> Sửa
                    </button>
                    <!-- Nút xóa -->
                    <button class="btn btn-danger btn-sm">
                        <a href="/san-pham-chi-tiet/delete?id=${spct.id}" class="text-white text-decoration-none" >
                            <i class="bi bi-trash"></i> Xóa
                        </a>
                    </button>
                </td>
            </tr>

            <!-- Modal sửa sản phẩm chi tiết -->
            <div class="modal fade" id="suaModal-${spct.id}" tabindex="-1" aria-labelledby="suaModalLabel-${spct.id}" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-warning text-white">
                            <h5 class="modal-title" id="suaModalLabel-${spct.id}">Sửa Sản Phẩm Chi Tiết</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/san-pham-chi-tiet/update" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="${spct.id}">

                                <!-- Giá Bán và Số Lượng -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="giaBan-${spct.id}" class="form-label">Giá Bán</label>
                                        <input type="number" step="0.01" class="form-control" id="giaBan-${spct.id}" name="giaBan" value="${spct.giaBan}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="soLuong-${spct.id}" class="form-label">Số Lượng</label>
                                        <input type="number" class="form-control" id="soLuong-${spct.id}" name="soLuong" value="${spct.soLuong}" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="ngayTao-${spct.id}" class="form-label">Ngày Tạo</label>
                                        <input type="datetime-local" class="form-control" id="ngayTao-${spct.id}" name="ngayTao" value="${spct.ngayTao}" readonly>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="ngaySua-${spct.id}" class="form-label">Ngày Sửa</label>
                                        <input type="datetime-local" class="form-control" id="ngaySua-${spct.id}" name="ngaySua" value="${spct.ngaySua}" readonly>
                                    </div>
                                </div>

                                <!-- Danh Mục Chọn -->
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="sanPham-${spct.id}" class="form-label">Tên Sản Phẩm</label>
                                        <select class="form-select" id="sanPham-${spct.id}" name="sanPham" required>
                                            <c:forEach items="${listSanPham}" var="sanPham">
                                                <option value="${sanPham.id}" ${sanPham.id == spct.sanPham.id ? 'selected' : ''}>${sanPham.tenSanPham}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="xuatSu-${spct.id}" class="form-label">Xuất Sứ</label>
                                        <select class="form-select" id="xuatSu-${spct.id}" name="xuatSu" required>
                                            <c:forEach items="${listXuatSu}" var="xuatSu">
                                                <option value="${xuatSu.id}" ${xuatSu.id == spct.xuatSu.id ? 'selected' : ''}>${xuatSu.tenXuatSu}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>

                                <!-- Thông Tin Khác -->


                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="thuongHieu-${spct.id}" class="form-label">Thương Hiệu</label>
                                        <select class="form-select" id="thuongHieu-${spct.id}" name="thuongHieu" required>
                                            <c:forEach items="${listThuongHieu}" var="thuongHieu">
                                                <option value="${thuongHieu.id}" ${thuongHieu.id == spct.thuongHieu.id ? 'selected' : ''}>${thuongHieu.tenThuongHieu}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">Lưu Thay Đổi</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        </tbody>
    </table>


    <button id="deleteSelectedBtn" class="btn btn-danger btn-sm">
        <i class="bi bi-trash"></i> Xóa Đã Chọn
    </button>
</div>

<!-- Modal thêm mới sản phẩm chi tiết -->
<div class="modal fade" id="themMoiModal" tabindex="-1" aria-labelledby="themMoiLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="themMoiLabel">Thêm Mới Sản Phẩm Chi Tiết</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/san-pham-chi-tiet/add" method="post" enctype="multipart/form-data">
                    <!-- Các trường thông tin -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="giaBan" class="form-label">Giá Bán</label>
                            <input type="number" step="0.01" class="form-control" id="giaBan" name="giaBan" required>
                        </div>
                        <div class="col-md-6">
                            <label for="soLuong" class="form-label">Số Lượng</label>
                            <input type="number" class="form-control" id="soLuong" name="soLuong" required>
                        </div>
                    </div>

                    <!-- Danh Mục Chọn -->
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="sanPham" class="form-label">Tên Sản Phẩm</label>
                            <select class="form-select" id="sanPham" name="sanPham" required>
                                <c:forEach items="${listSanPham}" var="sanPham">
                                    <option value="${sanPham.id}">${sanPham.tenSanPham}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="xuatSu" class="form-label">Tên Xuất Sứ</label>
                            <select class="form-select" id="xuatSu" name="xuatSu" required>
                                <c:forEach items="${listXuatSu}" var="xuatSu">
                                    <option value="${xuatSu.id}">${xuatSu.tenXuatSu}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="thuongHieu" class="form-label">Tên Thương Hiệu</label>
                            <select class="form-select" id="thuongHieu" name="thuongHieu" required>
                                <c:forEach items="${listThuongHieu}" var="thuongHieu">
                                    <option value="${thuongHieu.id}">${thuongHieu.tenThuongHieu}</option>
                                </c:forEach>
                            </select>
                        </div>

                    </div>
<%--                    Thông tin khác--%>
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="mauSac" class="form-label">Tên Màu Sắc</label>
                            <div id="mauSac">
                                <c:forEach items="${listMauSac}" var="mauSac">
                                    <div class="form-check d-flex align-items-center">
                                        <input class="form-check-input me-2" type="checkbox" id="mauSac${mauSac.id}" name="mauSac" value="${mauSac.id}">
                                        <label class="form-check-label" for="mauSac${mauSac.id}">
                                                ${mauSac.tenMauSac}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="kichThuoc" class="form-label">Tên Kích Thước</label>
                            <div id="kichThuoc">
                                <c:forEach items="${listKichThuoc}" var="kichThuoc">
                                    <div class="form-check d-flex align-items-center">
                                        <input class="form-check-input me-2" type="checkbox" id="kichThuoc${kichThuoc.id}" name="kichThuoc" value="${kichThuoc.id}">
                                        <label class="form-check-label" for="kichThuoc${kichThuoc.id}">
                                                ${kichThuoc.tenKichThuoc}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="chatLieu" class="form-label">Tên Chất Liệu</label>
                            <div id="chatLieu">
                                <c:forEach items="${listChatLieu}" var="chatLieu">
                                    <div class="form-check d-flex align-items-center">
                                        <input class="form-check-input me-2" type="checkbox" id="chatLieu${chatLieu.id}" name="chatLieu" value="${chatLieu.id}">
                                        <label class="form-check-label" for="chatLieu${chatLieu.id}">
                                                ${chatLieu.tenChatLieu}
                                        </label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Thêm Sản Phẩm</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    document.getElementById('deleteSelectedBtn').addEventListener('click', function () {
        // Lấy tất cả checkbox đã được chọn
        const selectedIds = Array.from(document.querySelectorAll('input[name="selectedIds"]:checked')).map(cb => cb.value);

        // Kiểm tra nếu không có mục nào được chọn
        if (selectedIds.length === 0) {
            alert('Vui lòng chọn ít nhất một sản phẩm để xóa.');
            return;
        }

        // Xác nhận xóa
        if (confirm('Bạn có chắc chắn muốn xóa các sản phẩm đã chọn không?')) {
            // Tạo một form động để gửi yêu cầu xóa
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '/san-pham-chi-tiet/delete-multiple'; // URL xử lý xóa nhiều

            // Thêm các input hidden chứa id sản phẩm đã chọn vào form
            selectedIds.forEach(id => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'ids';
                input.value = id;
                form.appendChild(input);
            });

            // Gửi form
            document.body.appendChild(form);
            form.submit();
        }
    });

    document.getElementById('selectAllCheckbox').addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('.itemCheckbox');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

</script>


<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
