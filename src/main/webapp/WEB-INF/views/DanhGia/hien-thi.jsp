<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Quản lý Đánh Giá</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center mb-3">Quản lý Đánh Giá</h1>

    <%--Form tìm kiếm--%>
    <div class="container mt-5">
        <div class="p-4 shadow rounded" style="background-color: #f8f9fa;">
            <!-- Tiêu đề -->
            <div class="d-flex align-items-center mb-4">
                <i class="bi bi-funnel me-2 text-primary" style="font-size: 1.5rem;"></i>
                <h5 class="text-primary mb-0">Bộ lọc</h5>
            </div>

            <!-- Bộ lọc -->
            <form id="filterForm" action="/danh-gia/hien-thi" method="get">
                <div class="row align-items-center">
                    <div class="col-md-4 mb-3">
                        <label for="searchInput" class="form-label">Tìm kiếm:</label>
                        <input type="text" name="nhanXet" id="searchInput" class="form-control"
                               placeholder="Tìm kiếm" value="${param.nhanXet}">
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="statusSelect" class="form-label">Số Sao:</label>
                        <select name="soSao" id="statusSelect" class="form-select">
                            <option value="all" ${param.soSao == 'all' ? 'selected' : ''}>Tất cả</option>
                            <option value="1" ${param.soSao == '1' ? 'selected' : ''}>1 Sao</option>
                            <option value="2" ${param.soSao == '2' ? 'selected' : ''}>2 Sao</option>
                            <option value="3" ${param.soSao == '3' ? 'selected' : ''}>3 Sao</option>
                            <option value="4" ${param.soSao == '4' ? 'selected' : ''}>4 Sao</option>
                            <option value="5" ${param.soSao == '5' ? 'selected' : ''}>5 Sao</option>
                        </select>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary me-2">
                        <i class="bi bi-search"></i> Tìm kiếm
                    </button>
                </div>
            </form>
        </div>
    </div>

    <%--Giao diện--%>
    <div class="container mt-5">
        <div class="border p-3">
            <!-- Nút thêm mới -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5>Danh sách đánh giá</h5>
                <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#themMoiModal">
                    <i class="bi bi-plus-circle"></i> Thêm mới
                </button>
            </div>

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
                            <button class="btn btn-warning btn-sm" data-bs-toggle="modal"
                                    data-bs-target="#suaModal-${danhGia.id}">
                                <i class="bi bi-info-circle"></i> Chi Tiết
                            </button>
                            <form action="/danh-gia/delete" method="post" style="display:inline;"
                                  onsubmit="return confirm('Bạn có chắc chắn muốn xóa?');">
                                <input type="hidden" name="id" value="${danhGia.id}">
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="bi bi-trash">Xóa</i>
                                </button>
                            </form>
                        </td>
                    </tr>

                    <%-- Modal Sửa --%>
                    <div class="modal fade" id="suaModal-${danhGia.id}" tabindex="-1"
                         aria-labelledby="suaModalLabel-${danhGia.id}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="suaModalLabel-${danhGia.id}">Sửa Đánh Giá</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
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
                                            <textarea class="form-control" id="nhanXet-${danhGia.id}" name="nhanXet"
                                                      rows="3" required>${danhGia.nhanXet}</textarea>
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
            <!-- Phân trang -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <!-- Kiểm tra nếu totalPages và pageNumber có giá trị hợp lệ -->
                    <c:if test="${not empty totalPages and totalPages > 0}">
                        <c:forEach var="i" begin="${pageNumber - 2 < 0 ? 0 : pageNumber - 2}"
                                   end="${pageNumber + 2 >= totalPages ? totalPages - 1 : pageNumber + 2}">
                            <li class="page-item ${pageNumber == i ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </c:if>
                    <!-- Nếu không có trang, có thể hiển thị thông báo hoặc không có gì -->
                    <c:if test="${empty totalPages or totalPages == 0}">
                        <li class="page-item disabled">
                            <span class="page-link">No pages available</span>
                        </li>
                    </c:if>
                </ul>
            </nav>
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
                            <button type="submit" class="btn btn-primary">Lưu</button>
                        </form>
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
    window.onload = function () {
        // Set today's date for the "Ngày Đánh Giá" field in "Thêm Mới" form
        var today = new Date().toISOString().split('T')[0]; // Get current date in YYYY-MM-DD format
        document.getElementById('ngayDanhGia').value = today;
    };


</script>
<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
