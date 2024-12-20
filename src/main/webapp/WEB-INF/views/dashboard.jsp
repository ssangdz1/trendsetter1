<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TrendSetter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .container {
            margin-top: 30px;
        }

        .bill-section, .product-section, .payment-section, .bill-footer {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            border: 1px solid #ddd; /* Thêm đường viền */
            margin-bottom: 20px; /* Tạo không gian giữa các phần */
        }

        .bill-header, .bill-footer, .product-section {
            margin-bottom: 20px;
            border-bottom: 1px solid #ddd; /* Đường viền dưới mỗi phần */
        }

        .info span {
            font-size: 16px;
            font-weight: 600;
        }

        .btn-outline-primary, .btn-success {
            margin-top: 10px;
        }

        .d-flex {
            align-items: center;
        }

        .confirm-button button {
            width: 100%;
        }

        .payment-section {
            margin-top: 30px;
        }

        /* Thêm đường viền cho phần thanh toán */
        .payment-section .info {
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }

        .product-list table, .table th, .table td {
            border: 1px solid #ddd; /* Đường viền cho bảng sản phẩm */
        }

        .modal-content {
            border: 1px solid #ddd; /* Đường viền cho modal */
        }

        /* Định dạng hình tròn cho số lượng sản phẩm */
        .badge-count {
            position: absolute;
            top: 5px; /* Đặt vị trí của hình tròn ở góc trên bên trái của nút */
            right: 5px; /* Đặt vị trí của hình tròn ở góc trên bên phải của nút */
            background-color: red; /* Màu nền của hình tròn */
            color: white; /* Màu chữ trong hình tròn */
            border-radius: 50%; /* Tạo hình tròn */
            padding: 5px 10px; /* Khoảng cách xung quanh số lượng */
            font-size: 14px; /* Kích thước chữ */
            font-weight: bold; /* Làm đậm chữ */
        }

        .icon-box {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: #f5f5f5;
            border-radius: 50%;
        }

        .fas {
            font-size: 18px;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="container mt-4">
        <h1 class="text-center mb-3">Bán Hàng Tại Quầy</h1>
        <%--Form giao diện--%>
        <div class="container mt-5">
            <!-- Form hóa đơn -->
            <div class="bill-section">
                <!-- Nút tạo hóa đơn -->
                <form action="/create-hoa-don" method="post">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5>Danh sách hóa đơn</h5>
                        <button class="btn btn-primary ms-auto">
                            <i class="fas fa-plus"></i> Tạo hóa đơn
                        </button>
                    </div>
                </form>

                <!-- Lặp qua danh sách hóa đơn -->
                <div class="product-section">
                    <div class="row">
                        <c:forEach var="hoaDon" items="${hoaDons}" varStatus="status">
                            <div class="col-12 col-md-4 mb-3">
                                <form action="/sell-counter" method="GET">
                                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                                    <button type="submit"
                                            class="btn btn-outline-primary w-100 position-relative shadow-sm">
                                        <div class="card border-light">
                                            <div class="card-body text-center">
                                                <h5 class="card-title">
                                                    Hóa Đơn <span>${status.index + 1}</span>
                                                </h5>
                                            </div>
                                        </div>
                                        <!-- Phần tử hiển thị số lượng sản phẩm trong hình tròn -->
                                        <span class="badge-count">${hoaDon.tongSanPham}</span>
                                    </button>
                                </form>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Phần Sản Phẩm: -->
        <div id="productSection" style="display: none;">
            <!-- Chức năng -->
            <div class="bill-header d-flex justify-content-between align-items-center">
                <strong>Danh Sách Sản Phẩm</strong>
                <div class="d-flex gap-2">
                    <!-- Nút QR và Thêm sản phẩm -->
                    <button class="btn btn-outline-primary">
                        <i class="fas fa-qrcode"></i> QR Code
                    </button>
                    <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        <i class="fas fa-cart-plus"></i> Thêm sản phẩm
                    </button>
                </div>
            </div>

            <!-- Modal Thêm Sản Phẩm -->
            <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="addProductModalLabel">Thêm Sản Phẩm Vào Hóa Đơn Chi Tiết</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/add-product-order" method="post">
                                <input type="hidden" name="idHoaDon" value="${hoaDon.id}">
                                <div class="table-responsive">
                                    <table class="table table-bordered table-striped">
                                        <thead class="text-center">
                                        <tr class="text-center">
                                            <th>STT</th>
                                            <th>Sản Phẩm</th>
                                            <th>Số Lượng</th>
                                            <th>Tồn Kho</th>
                                            <th>Chất Liệu</th>
                                            <th>Thương Hiệu</th>
                                            <th>Xuất Sứ</th>
                                            <th>Trạng Thái</th>
                                            <th>Chọn</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="sanPhamChiTiet" items="${sanPhamChiTiet}" varStatus="status">
                                            <tr>
                                                <td class="text-center">${status.index + 1}</td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <img src="<c:url value='/images/${sanPhamChiTiet.hinhAnh[0].urlHinhAnh}'/>"
                                                             alt="Product Image" class="img-fluid" width="80">
                                                        <div class="ms-3">
                                                            <strong>${sanPhamChiTiet.sanPham.tenSanPham}</strong>
                                                            (${sanPhamChiTiet.mauSac.tenMauSac}
                                                            - ${sanPhamChiTiet.kichThuoc.tenKichThuoc})<br>
                                                            <small class="text-danger font-weight-bold fs-5">${sanPhamChiTiet.gia}
                                                                VND</small><br>
                                                            <small class="text-muted">Tồn
                                                                Kho: ${sanPhamChiTiet.soLuong}</small>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="text-center">
                                                    <input type="number" name="soLuong" value="1" min="1"
                                                           max="${sanPhamChiTiet.soLuong}"
                                                           class="form-control" readonly>
                                                </td>
                                                <td class="text-center">${sanPhamChiTiet.soLuong}</td>
                                                <td class="text-center">${sanPhamChiTiet.chatLieu.tenChatLieu}</td>
                                                <td class="text-center">${sanPhamChiTiet.sanPham.thuongHieu.tenThuongHieu}</td>
                                                <td class="text-center">${sanPhamChiTiet.sanPham.xuatSu.quocGia}</td>
                                                <td class="text-center">
                                            <span class="badge ${sanPhamChiTiet.trangThai == 'Đang Hoạt Động' ? 'bg-success' : 'bg-danger'}">
                                                    ${sanPhamChiTiet.trangThai}
                                            </span>
                                                </td>
                                                <td class="text-center">
                                                    <button type="submit" name="idSanPhamChiTiet"
                                                            value="${sanPhamChiTiet.id}"
                                                            class="btn btn-outline-primary">
                                                        Chọn
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Hiển thị danh sách sản phẩm trong giỏ hàng -->
            <div class="product-list">
                <table class="table table-bordered table-striped align-middle">
                    <thead class="text-center">
                    <tr>
                        <th>STT</th>
                        <th>Sản Phẩm</th>
                        <th style="width: 10%">Số Lượng</th>
                        <th>Tồn Kho</th>
                        <th>Giá</th>
                        <th>Chất Liệu</th>
                        <th>Thương Hiệu</th>
                        <th>Xuất Sứ</th>
                        <th>Thành Tiền</th>
                        <th>Trạng Thái</th>
                        <th>Chọn</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="hoaDonChiTiet" items="${hoaDonChiTiet}" varStatus="status">
                        <tr>
                        <tr>
                            <td class="text-center">${status.index + 1}</td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="<c:url value='/images/${hoaDonChiTiet.sanPhamChiTiet.hinhAnh[0].urlHinhAnh}'/>"
                                         alt="Product Image" class="img-fluid" width="80">
                                    <div class="ms-3">
                                        <strong>${hoaDonChiTiet.sanPhamChiTiet.sanPham.tenSanPham}</strong> <br>
                                        <small>Màu Sắc : ${hoaDonChiTiet.sanPhamChiTiet.mauSac.tenMauSac}</small> <br>
                                        <small>Size : ${hoaDonChiTiet.sanPhamChiTiet.kichThuoc.tenKichThuoc}</small><br>
                                        <small class="text-danger font-weight-bold fs-5">${hoaDonChiTiet.sanPhamChiTiet.gia}
                                            VND</small><br>
                                        <small class="text-muted">Tồn
                                            Kho: ${hoaDonChiTiet.sanPhamChiTiet.soLuong}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <form action="/update-product-order" method="post">
                                    <input type="hidden" name="idHoaDonChiTiet" value="${hoaDonChiTiet.id}">
                                    <input type="hidden" name="idHoaDon" value="${hoaDon.id}">
                                    <input type="number" name="soLuong" value="${hoaDonChiTiet.soLuong}"
                                           min="1" class="form-control" required onchange="this.form.submit()">
                                </form>
                            </td>
                            <td class="text-center">${hoaDonChiTiet.sanPhamChiTiet.soLuong}</td>
                            <td class="text-center">${hoaDonChiTiet.sanPhamChiTiet.gia}</td>
                            <td class="text-center">${hoaDonChiTiet.sanPhamChiTiet.chatLieu.tenChatLieu}</td>
                            <td class="text-center">${hoaDonChiTiet.sanPhamChiTiet.sanPham.thuongHieu.tenThuongHieu}</td>
                            <td class="text-center">${hoaDonChiTiet.sanPhamChiTiet.sanPham.xuatSu.quocGia}</td>
                            <td class="text-center">${hoaDonChiTiet.thanhTien}</td>
                            <td class="text-center">
                            <span class="badge ${hoaDonChiTiet.sanPhamChiTiet.trangThai == 'Đang Hoạt Động' ? 'bg-success' : 'bg-danger'}">
                                    ${hoaDonChiTiet.sanPhamChiTiet.trangThai}
                            </span>
                            </td>
                            <td>
                                <form action="/delete-product-order" method="post">
                                    <input type="hidden" name="idHoaDon" value="${hoaDon.id}">
                                    <input type="hidden" name="idHoaDonChiTiet" value="${hoaDonChiTiet.id}">
                                    <button type="submit" class="btn btn-danger">
                                        <i class="fas fa-trash"></i> Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <h3 class="text-end">
                    <strong>Tổng Tiền: </strong>
                    <small class="text-danger font-weight-bold fs-5">${hoaDon.tongTien} VND</small>
                </h3>

            </div>
        </div>
        <!-- Phần Tài Khoản Khách Hàng -->
        <div class="bill-footer">
            <div class="d-flex justify-content-between align-items-center">
                <h3>Tài khoản</h3>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#customerModal">
                    <i class="fas fa-user"></i> Chọn tài khoản
                </button>

                <!-- Modal Chọn Khách Hàng -->
                <div class="modal fade" id="customerModal" tabindex="-1" aria-labelledby="customerModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="customerModalLabel">Danh sách khách hàng</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th>Tên Khách Hàng</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Chọn</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="khachHang" items="${khachHangs}">
                                        <tr>
                                            <td>${khachHang.hoTen}</td>
                                            <td>${khachHang.email}</td>
                                            <td>${khachHang.sdt}</td>
                                            <td>
                                                <form action="/add-customer" method="post">
                                                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                                                    <input type="hidden" name="khachHangId" value="${khachHang.id}">
                                                    <button type="submit" class="btn btn-primary">Chọn</button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <p>Tên khách hàng:
                <span style="background-color: #ddd; padding: 5px; border-radius: 5px;">
                <c:choose>
                    <c:when test="${hoaDon.khachHang != null}">
                        ${hoaDon.khachHang.hoTen}
                    </c:when>
                    <c:otherwise>
                        Chưa chọn khách hàng
                    </c:otherwise>
                </c:choose>
            </span>
            </p>
        </div>
        </p>

        <!-- Phần Thanh Toán -->
        <div class="payment-section">
            <div class="row">
                <div class="row">
                    <!-- Cột thông tin giao hàng bên trái -->
                    <div class="col-md-6">
                        <h3>📦 Thông tin giao hàng</h3>
                        <div class="d-flex align-items-center">
                            <span><i class="fas fa-box"></i> <strong>Giao Hàng:</strong></span>
                        </div>
                        <!-- Form giao hàng -->
                        <div class="mt-3" id="shippingForm" style="display: none;">
                            <div class="card card-body">
                                <form action="/update-shipping" method="post">
                                    <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                                    <input type="hidden" name="khachHangId" value="${hoaDon.khachHang.id}">

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="soNha" class="form-label">Số Nhà:</label>
                                            <input type="text" id="soNha" name="soNha" class="form-control"
                                                   value="${hoaDon.khachHang.diaChis[0].soNha != null ? hoaDon.khachHang.diaChis[0].soNha : ''}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="phuong" class="form-label">Phường:</label>
                                            <input type="text" id="phuong" name="phuong" class="form-control"
                                                   value="${hoaDon.khachHang.diaChis[0].phuong != null ? hoaDon.khachHang.diaChis[0].phuong : ''}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="huyen" class="form-label">Huyện:</label>
                                            <input type="text" id="huyen" name="huyen" class="form-control"
                                                   value="${hoaDon.khachHang.diaChis[0].huyen != null ? hoaDon.khachHang.diaChis[0].huyen : ''}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="thanhPho" class="form-label">Thành Phố:</label>
                                            <input type="text" id="thanhPho" name="thanhPho" class="form-control"
                                                   value="${hoaDon.khachHang.diaChis[0].thanhPho != null ? hoaDon.khachHang.diaChis[0].thanhPho : ''}">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary w-100">Cập nhật giao hàng</button>
                                </form>
                            </div>
                        </div>
                    </div>


                    <!-- Cột thông tin thanh toán bên phải -->
                    <div class="col-md-6">
                        <h3>🔒 Thông tin thanh toán</h3>
                        <%--phương thức thanh toán--%>
                        <div class="d-flex align-items-center">
                            <span>
                                <i class="fas fa-credit-card"></i>
                                <strong>Phương thức thanh toán: </strong>
                                ${hoaDon.phuongThucThanhToan.tenPhuongThuc}
                            </span>
                            <button type="button" class="btn btn-outline-primary ms-auto" data-bs-toggle="modal"
                                    data-bs-target="#paymentModal">
                                <i class="bi bi-credit-card"></i>
                            </button>
                            <!-- Modal Payment -->
                            <div class="modal fade" id="paymentModal" tabindex="-1" aria-labelledby="paymentModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="paymentModalLabel">Chọn phương thức thanh
                                                toán</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/add-payment-method" method="post">
                                                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                                                <div class="mb-3">
                                                    <label for="phuongThucThanhToan" class="form-label"><i
                                                            class="fas fa-credit-card"></i> Phương thức thanh
                                                        toán:</label>
                                                    <select id="phuongThucThanhToan" name="phuongThucThanhToan"
                                                            class="form-select" required>
                                                        <option value="" disabled selected>Chọn phương thức thanh toán
                                                        </option>
                                                        <c:forEach items="${listPhuongThucThanhToan}"
                                                                   var="phuongThucThanhToan">
                                                            <option value="${phuongThucThanhToan.id}">${phuongThucThanhToan.tenPhuongThuc}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Cập nhật</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--Mã Giảm Gía--%>
                        <div class="d-flex align-items-center">
                            <span>
                            <i class="fas fa-tag"></i>
                            <strong>Mã giảm giá: </strong>
                            ${hoaDon.khuyenMai != null ? hoaDon.khuyenMai.tenChuongTrinh : "Chưa có mã giảm giá"}
                        </span>
                            <button type="button" class="btn btn-outline-primary ms-auto" data-bs-toggle="modal"
                                    data-bs-target="#discountModal">
                                <i class="fas fa-tag"></i>
                            </button>
                            <!-- Modal Discount -->
                            <div class="modal fade" id="discountModal" tabindex="-1"
                                 aria-labelledby="discountModalLabel"
                                 aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="discountModalLabel">Chọn mã giảm giá</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                    aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="/apply-khuyen-mai" method="post">
                                                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                                                <div class="mb-3">
                                                    <label for="tenChuongTrinh" class="form-label"><i
                                                            class="fas fa-tag"></i> Mã giảm giá:</label>
                                                    <select id="tenChuongTrinh" name="tenChuongTrinh"
                                                            class="form-select" required>
                                                        <option value="" disabled selected>Chọn mã giảm giá</option>
                                                        <c:forEach items="${listKhuyenMai}" var="khuyenMai">
                                                            <option value="${khuyenMai.tenChuongTrinh}">
                                                                    ${khuyenMai.tenChuongTrinh} -
                                                                    ${khuyenMai.giaTri}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Áp dụng</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Giao hàng -->
                        <div class="info mb-4 d-flex align-items-center">
                            <div class="icon-box me-2">
                                <i class="fas fa-box text-primary"></i>
                            </div>
                            <span class="me-auto fw-bold">Giao Hàng:</span>
                            <div class="form-check form-switch">
                                <input class="form-check-input" type="checkbox" id="deliverySwitch">
                            </div>
                        </div>

                        <!-- Phí Ship -->
                        <div class="info mb-4" id="shipFeeSection" style="display: none;">
                            <div class="d-flex align-items-center">
                                <span class="me-2"><i class="fas fa-box"></i> Phí Ship:</span>
                                <input type="text" class="form-control w-auto" value="${hoaDon.phiShip}"  style="max-width: 200px;" /> VND
                            </div>
                        </div>


                        <!-- Tiền hàng và giảm giá -->
                        <div class="info mb-4">
                            <span><i class="fas fa-box"></i> Tiền hàng:</span>
                            <span>${hoaDon.tongTien} VNĐ</span>
                        </div>
                        <div class="info mb-4">
                            <span><i class="fas fa-percent"></i> Giảm giá:</span>
                            <span>${hoaDon.khuyenMai.giaTri} VNĐ</span>
                        </div>
                        <div class="info mb-3">
                            <strong>Tổng tiền:</strong>
                            <strong>${hoaDon.tongTien - hoaDon.khuyenMai.giaTri - hoaDon.phiShip} VNĐ</strong>
                        </div>
                        <div class="confirm-button mt-3">
                            <form action="/confirm-payment" method="POST">
                                <input type="hidden" name="hoaDonId" value="${hoaDon.id}">
                                <button class="btn btn-success w-100">
                                    <i class="fas fa-check-circle"></i> Xác nhận thanh toán
                                </button>
                            </form>
                        </div>
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
    // Kiểm tra nếu URL có chứa tham số hoaDonId, thì hiển thị phần sản phẩm
    window.onload = function () {
        const urlParams = new URLSearchParams(window.location.search);
        const hoaDonId = urlParams.get('hoaDonId');

        if (hoaDonId) {
            document.getElementById('productSection').style.display = 'block';
        }
    };

    // lắng nghe nghe sự kiện update số lượng
    document.querySelectorAll('input[name="soLuong"]').forEach(input => {
        input.addEventListener('change', function () {
            const form = this.closest('form');
            const formData = new FormData(form);

            fetch(form.action, {
                method: form.method,
                body: formData
            })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Cập nhật giao diện: số lượng, thành tiền, tổng tiền
                        document.querySelector('.total-price h4 strong').textContent = `Tổng tiền: ${data.tongTien} VND`;
                    } else {
                        alert(data.message);
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    });
</script>

<%-- Ẩn hiện form giao hàng--%>
<script>
    const deliverySwitch = document.getElementById('deliverySwitch');
    const shippingForm = document.getElementById('shippingForm');
    const shipFeeSection = document.getElementById('shipFeeSection');

    deliverySwitch.addEventListener('change', function() {
        if (this.checked) {
            // Show the form when the checkbox is checked
            shippingForm.style.display = 'block';
            // Show the "Phí Ship" section when the checkbox is checked
            shipFeeSection.style.display = 'block';
        } else {
            // Hide the form when the checkbox is unchecked
            shippingForm.style.display = 'none';
            // Hide the "Phí Ship" section when the checkbox is unchecked
            shipFeeSection.style.display = 'none';
        }
    });

</script>
</body>
</html>
