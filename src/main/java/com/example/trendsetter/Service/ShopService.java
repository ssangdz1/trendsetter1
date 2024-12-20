package com.example.trendsetter.Service;

import com.example.trendsetter.DTO.ShippingUpdateRequest;
import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class ShopService {

    @Autowired
    private HoaDonChiTietService hoaDonChiTietService;

    @Autowired
    private HoaDonChiTietRepository hoaDonChiTietRepository;

    @Autowired
    private HoaDonRepository hoaDonRepository;

    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;

    @Autowired
    private KhachHangRepository khachHangRepository;

    @Autowired
    private PhuongThucThanhToanRepository phuongThucThanhToanRepository;

    @Autowired
    private KhuyenMaiRepository khuyenMaiRepository;

    @Autowired
    private DiaChiRepository diaChiRepository;

    @Autowired
    private PdfService pdfService;

    @ModelAttribute("listPhuongThucThanhToan")
    List<PhuongThucThanhToan> getPhuongThuc(){
        return phuongThucThanhToanRepository.findAll();
    }


    // Tạo hóa đơn
    public String createHoaDon(HoaDon hoaDon, RedirectAttributes redirectAttributes) {
        long countDangXuLy = hoaDonRepository.countByTrangThai("Đang xử lý");
        if (countDangXuLy >= 3) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã đạt giới hạn 3 hóa đơn đang xử lý. Không thể tạo thêm.");
            return "redirect:/sell-counter"; // Redirect về danh sách hóa đơn
        }

        hoaDon.setTrangThai("Đang Xử Lý");
        hoaDon.setNgayTao(LocalDateTime.now());
        hoaDonRepository.save(hoaDon);
        return "redirect:/sell-counter";
    }

    public void getHoaDonAndProducts(Integer hoaDonId, Model model, RedirectAttributes redirectAttributes) {
        // Lấy danh sách hóa đơn, sản phẩm, khách hàng
        List<HoaDon> hoaDons = hoaDonRepository.findByTrangThai("Đang Xử Lý");
        List<SanPhamChiTiet> sanPhamChiTiet = sanPhamChiTietRepository.findAll();
        List<KhachHang> khachHangs = khachHangRepository.findAll();
        List<PhuongThucThanhToan> listPhuongThucThanhToan = phuongThucThanhToanRepository.findAll();
        List<KhuyenMai> listKhuyenMai = khuyenMaiRepository.findAll();

        model.addAttribute("hoaDons", hoaDons);
        model.addAttribute("sanPhamChiTiet", sanPhamChiTiet);
        model.addAttribute("khachHangs", khachHangs);
        model.addAttribute("listPhuongThucThanhToan", listPhuongThucThanhToan);
        model.addAttribute("listKhuyenMai", listKhuyenMai);

        // Đếm sản phẩm cho từng hóa đơn
        for (HoaDon hoaDon : hoaDons) {
            int tongSanPham = hoaDon.getHoaDonChiTiet()
                    .stream()
                    .mapToInt(HoaDonChiTiet::getSoLuong)
                    .sum();
            // Đảm bảo class HoaDon có getter và setter cho `tongSanPham`.
            hoaDon.setTongSanPham(tongSanPham);
        }



        // Kiểm tra nếu hoaDonId không phải null
        if (hoaDonId != null) {
            HoaDon hoaDon = hoaDonRepository.findById(hoaDonId).orElse(null);
            if (hoaDon == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại");
                return;
            }

            List<HoaDonChiTiet> hoaDonChiTiet = hoaDonChiTietRepository.findByHoaDonId(hoaDonId);
            if (hoaDonChiTiet == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Chi tiết hóa đơn không tồn tại");
                return;
            }

            model.addAttribute("hoaDonChiTiet", hoaDonChiTiet);
            model.addAttribute("hoaDon", hoaDon);

        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "ID hóa đơn không hợp lệ");
            return;
        }
    }


    // Thêm khách hàng vào hóa đơn
    public String addCustomerToInvoice(Integer hoaDonId, Integer khachHangId,RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = hoaDonRepository.findById(hoaDonId).orElse(null);
        if (hoaDon == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại!");
            return "redirect:/sell-counter";
        }

        KhachHang khachHang = khachHangRepository.findById(khachHangId).orElse(null);
        if (khachHang == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Khách hàng không tồn tại!");
            return "redirect:/sell-counter";
        }

        hoaDon.setKhachHang(khachHang);  // Cập nhật khách hàng nếu cần
        hoaDonRepository.save(hoaDon);
        redirectAttributes.addFlashAttribute("successMessage", "Thông tin giao hàng đã được cập nhật!");
        return "redirect:/sell-counter?hoaDonId=" + hoaDonId;
    }

    // Xử lý các hành động thêm, sửa, xóa sản phẩm trong hóa đơn
    public String handleProductOrder(String action, Integer idSanPhamChiTiet, Integer idHoaDon, Integer soLuong,
                                     Integer idHoaDonChiTiet, RedirectAttributes redirectAttributes) {
        switch (action) {
            case "add":
                return hoaDonChiTietService.addProductDetailToHoaDon(idSanPhamChiTiet, idHoaDon, soLuong, redirectAttributes);
            case "update":
                return hoaDonChiTietService.updateQuantityOrder(idHoaDonChiTiet, soLuong, idHoaDon, redirectAttributes);
            case "delete":
                return hoaDonChiTietService.deleteProductOrder(idHoaDonChiTiet, idHoaDon, redirectAttributes);
            default:
                return "redirect:/sell-counter"; // Action không hợp lệ
        }
    }

    public String addPaymentMethod(Integer hoaDonId,Integer phuongThucThanhToanId,RedirectAttributes redirectAttributes){
        // Lấy hóa đơn từ cơ sở dữ liệu
        HoaDon hoaDon = hoaDonRepository.findById(hoaDonId).orElse(null);
        if (hoaDon == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại");
            return "redirect:/sell-counter";
        }

        // Lấy phương thức thanh toán từ cơ sở dữ liệu
        PhuongThucThanhToan phuongThucThanhToan = phuongThucThanhToanRepository.findById(phuongThucThanhToanId).orElse(null);
        if (phuongThucThanhToan == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Phương thức thanh toán không tồn tại");
            return "redirect:/sell-counter";
        }

        // Cập nhật phương thức thanh toán cho hóa đơn
        hoaDon.setPhuongThucThanhToan(phuongThucThanhToan);
        hoaDonRepository.save(hoaDon);

        redirectAttributes.addFlashAttribute("successMessage", "Phương thức thanh toán đã được cập nhật!");
        return "redirect:/sell-counter?hoaDonId=" + hoaDonId;
    }

    public String applyKhuyenMai(Integer hoaDonId, String tenChuongTrinh, RedirectAttributes redirectAttributes) {
        try {
            // Lấy hóa đơn từ cơ sở dữ liệu
            HoaDon hoaDon = hoaDonRepository.findById(hoaDonId)
                    .orElseThrow(() -> new RuntimeException("Hóa đơn không tồn tại"));

            // Lấy khuyến mãi dựa trên tên chương trình
            KhuyenMai khuyenMai = khuyenMaiRepository.findByTenChuongTrinh(tenChuongTrinh)
                    .orElseThrow(() -> new RuntimeException("Mã khuyến mãi không hợp lệ"));

            // Kiểm tra điều kiện khuyến mãi (tổng tiền phải lớn hơn hoặc bằng điều kiện)
            if (hoaDon.getTongTien() >= khuyenMai.getDieuKien()) {
                // Cập nhật khuyến mãi cho hóa đơn
                hoaDon.setKhuyenMai(khuyenMai);

                // Lưu lại hóa đơn đã cập nhật vào cơ sở dữ liệu
                hoaDonRepository.save(hoaDon);

                // Thêm thông báo thành công
                redirectAttributes.addFlashAttribute("successMessage", "Khuyến mãi đã được áp dụng!");
            } else {
                // Nếu điều kiện khuyến mãi không thỏa mãn
                redirectAttributes.addFlashAttribute("errorMessage", "Điều kiện khuyến mãi không thỏa mãn.");
            }

            // Chuyển hướng về trang sell-counter với hoaDonId
            return "redirect:/sell-counter?hoaDonId=" + hoaDonId;

        } catch (Exception e) {
            // Bắt lỗi và thêm thông báo lỗi
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/sell-counter?hoaDonId=" + hoaDonId;
        }
    }

    public String confirmPayment(Integer hoaDonId, RedirectAttributes redirectAttributes){
        try {
            HoaDon hoaDon = hoaDonRepository.findById(hoaDonId)
                    .orElseThrow(() -> new RuntimeException("Hóa đơn không tồn tại"));

            // Kiểm tra nếu có khuyến mãi áp dụng
            if (hoaDon.getKhuyenMai() != null) {
                // Cập nhật tổng tiền sau khi áp dụng khuyến mãi
                Double tongTienMoi = hoaDon.getTongTien() - hoaDon.getKhuyenMai().getGiaTri();
                hoaDon.setTongTien(tongTienMoi);
            }

            // Cập nhật trạng thái thanh toán của hóa đơn
            hoaDon.setTrangThai("Đã thanh toán");
            hoaDon.setNgaySua(LocalDateTime.now());  // Cập nhật thời gian sửa

            // Lưu lại hóa đơn đã cập nhật vào cơ sở dữ liệu
            hoaDonRepository.save(hoaDon);

            // Tạo file PDF
            File pdfFile = pdfService.generateInvoicePdf(hoaDon);

            // Lưu thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage", "Thanh toán thành công! Hóa đơn PDF đã được tạo tại: " + pdfFile.getAbsolutePath());

            return "redirect:/sell-counter";
        } catch (Exception e) {
            // Xử lý lỗi nếu có
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/sell-counter?hoaDonId=" + hoaDonId;
        }
    }

    public String updateShippingAddress(ShippingUpdateRequest request,Integer hoaDonId, RedirectAttributes redirectAttributes) {
        try {
            // Tìm hóa đơn dựa trên ID
            HoaDon hoaDon = hoaDonRepository.findById(request.getHoaDonId())
                    .orElseThrow(() -> new RuntimeException("Hóa đơn không tồn tại"));

            // Lấy thông tin khách hàng từ hóa đơn
            KhachHang khachHang = hoaDon.getKhachHang();

            if (!khachHang.getId().equals(request.getKhachHangId())) {
                throw new RuntimeException("Khách hàng không khớp với hóa đơn!");
            }

            // Lấy danh sách địa chỉ hiện có của khách hàng
            List<DiaChi> diaChis = khachHang.getDiaChis();

            // Tìm hoặc tạo mới địa chỉ
            DiaChi diaChi = diaChis.stream()
                    .findFirst() // Lấy địa chỉ đầu tiên nếu có
                    .orElse(new DiaChi()); // Nếu không, tạo mới

            // Cập nhật thông tin địa chỉ
            diaChi.setKhachHang(khachHang);
            diaChi.setSoNha(request.getSoNha());
            diaChi.setPhuong(request.getPhuong());
            diaChi.setHuyen(request.getHuyen());
            diaChi.setThanhPho(request.getThanhPho());
            diaChi.setTrangThai(true); // Đánh dấu địa chỉ này là mặc định

            // Lưu địa chỉ
            diaChiRepository.save(diaChi);

            // Lưu thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật địa chỉ giao hàng thành công!");

            return "redirect:/sell-counter?hoaDonId=" + hoaDonId;

        } catch (Exception e) {
            // Xử lý lỗi nếu xảy ra
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/sell-counter?hoaDonId=" + hoaDonId;

        }
    }


}
