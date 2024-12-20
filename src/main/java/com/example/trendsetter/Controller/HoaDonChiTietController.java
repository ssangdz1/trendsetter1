package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.*;
import com.example.trendsetter.Service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/hoa-don-chi-tiet")
public class HoaDonChiTietController {
    @Autowired
    HoaDonChiTietRepository hoaDonChiTietRepository;

    @Autowired
    SanPhamChiTietRepository sanPhamChiTietRepository;

    @Autowired
    PhuongThucThanhToanRepository phuongThucThanhToanRepository;

    @Autowired
    HoaDonRepository hoaDonRepository;

    @Autowired
    SanPhamRepository sanPhamRepository;

    @ModelAttribute("listHoaDon")
    List<HoaDon> getListHoaDon(){
        return hoaDonRepository.findAll();
    }

    @ModelAttribute("listSanPhamChiTiet")
    List<SanPhamChiTiet> getListSanPhamChiTiet(){
        return sanPhamChiTietRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int pageHoaDon,
                          @RequestParam(defaultValue = "0") int pageHoaDonChiTiet,
                          Model model) {
        // Sắp xếp theo id giảm dần
        Sort sort = Sort.by(Sort.Order.desc("id"));

        // Phân trang HoaDon
        Page<HoaDon> hoaDonPage = hoaDonRepository.findAll(PageRequest.of(pageHoaDon, 5, sort));
        model.addAttribute("danhSachHoaDon", hoaDonPage.getContent());
        model.addAttribute("pageNumber", pageHoaDon);
        model.addAttribute("totalPages", hoaDonPage.getTotalPages());

        // Phân trang HoaDonChiTiet
        Page<HoaDonChiTiet> hoaDonChiTietPage = hoaDonChiTietRepository.findAll(PageRequest.of(pageHoaDonChiTiet, 5, sort));
        model.addAttribute("danhSachHoaDonChiTiet", hoaDonChiTietPage.getContent());
        model.addAttribute("pageNumber1", pageHoaDonChiTiet);
        model.addAttribute("totalPages1", hoaDonChiTietPage.getTotalPages());

        return "HoaDonChiTiet/hien-thi"; // Trả về trang hiển thị
    }


    @PostMapping("/add")
    public String addHoaDonChiTiet(@ModelAttribute HoaDonChiTiet hoaDonChiTiet, RedirectAttributes redirectAttributes) {
        try {
            // Lấy sản phẩm chi tiết và tính toán thành tiền
            SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
            if (sanPhamChiTiet == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm không tồn tại!");
                return "redirect:/hoa-don-chi-tiet/hien-thi";
            }

            // Tính thành tiền: Thành tiền = Giá * Số lượng
            hoaDonChiTiet.setGia((float)(double) sanPhamChiTiet.getGia());
            Integer soLuong = hoaDonChiTiet.getSoLuong();
            if (soLuong != null && hoaDonChiTiet.getGia() != null) {
                Float thanhTien = hoaDonChiTiet.getGia().floatValue() * soLuong.floatValue();
                hoaDonChiTiet.setThanhTien(thanhTien);
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Giá hoặc số lượng không hợp lệ!");
                return "redirect:/hoa-don-chi-tiet/hien-thi";
            }

            // Lưu hóa đơn chi tiết
            hoaDonChiTietRepository.save(hoaDonChiTiet);

            // Cập nhật tồn kho sản phẩm chi tiết
            boolean isStockUpdated = updateStock(sanPhamChiTiet, -soLuong);
            if (!isStockUpdated) {
                redirectAttributes.addFlashAttribute("errorMessage", "Số lượng tồn kho không đủ để bán!");
                return "redirect:/hoa-don-chi-tiet/hien-thi";
            }

            // Cập nhật tổng tiền hóa đơn
            updateHoaDonTongTien(hoaDonChiTiet.getHoaDon());

            // Thông báo thành công
            redirectAttributes.addFlashAttribute("successMessage", "Hóa đơn chi tiết đã được tạo thành công! Thành tiền: " + hoaDonChiTiet.getThanhTien());
            return "redirect:/hoa-don-chi-tiet/hien-thi";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            return "redirect:/hoa-don-chi-tiet/hien-thi";
        }
    }




    @PostMapping("/deleteHoaDonChiTiet")
    public String deleteHoaDonChiTiet(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        Optional<HoaDonChiTiet> hoaDonChiTietOptional = hoaDonChiTietRepository.findById(id);
        if (hoaDonChiTietOptional.isPresent()) {
            HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietOptional.get();
            SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();

            // Hoàn trả lại số lượng tồn kho
            if (sanPhamChiTiet != null) {
                updateStock(sanPhamChiTiet, hoaDonChiTiet.getSoLuong());
            }

            // Xóa hóa đơn chi tiết
            hoaDonChiTietRepository.deleteById(id);

            // Cập nhật tổng tiền hóa đơn
            updateHoaDonTongTien(hoaDonChiTiet.getHoaDon());

            redirectAttributes.addFlashAttribute("successMessage", "Xóa hóa đơn chi tiết thành công và cập nhật tổng tiền!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn chi tiết không tồn tại!");
        }
        return "redirect:/hoa-don-chi-tiet/hien-thi";
    }



    @PostMapping("/addHoaDon")
    public String addHoaDon(RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = new HoaDon();
        hoaDon.setNgayTao(LocalDateTime.now());
        hoaDon.setTrangThai("Đang Xử Lý");
        hoaDonRepository.save(hoaDon);

        redirectAttributes.addFlashAttribute("successMessage", "Hóa đơn đã được tạo thành công!");
        return "redirect:/hoa-don-chi-tiet/hien-thi";
    }


    @GetMapping("/detail/{id}")
    public String showDetail(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findById(id).orElse(null);
        if (hoaDonChiTiet == null) {
            redirectAttributes.addFlashAttribute("message", "Hóa đơn chi tiết không tồn tại!");
            return "redirect:/hoa-don-chi-tiet/hien-thi";  // Quay lại danh sách hóa đơn nếu không tìm thấy
        }
        model.addAttribute("hoaDonChiTiet", hoaDonChiTiet);
        return "HoaDonChiTiet/detail";  // Trả về trang hiển thị chi tiết
    }


    @PostMapping("/deleteHoaDon")
    public String deleteHoaDon(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (hoaDonRepository.existsById(id)) {
            hoaDonRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa hóa đơn thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại!");
        }
        return "redirect:/hoa-don-chi-tiet/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai , RedirectAttributes redirectAttributes) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<HoaDon> optionalHD = hoaDonRepository.findById(id);
        if (optionalHD.isPresent()) {
            HoaDon hd = optionalHD.get();
            // Cập nhật trạng thái
            hd.setTrangThai(trangThai);
            hoaDonRepository.save(hd); // Lưu thay đổi
        }
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhập trạng thái thành công!");
        return "redirect:/hoa-don-chi-tiet/hien-thi"; // Điều hướng về trang hiển thị
    }


    // Phương thức phụ: Cập nhật tổng tiền hóa đơn
    private void updateHoaDonTongTien(HoaDon hoaDon) {
        if (hoaDon != null) {
            double tongTien = hoaDon.getHoaDonChiTiet().stream()
                    .mapToDouble(ct -> ct.getSoLuong() * ct.getSanPhamChiTiet().getGia())
                    .sum();
            hoaDon.setTongTien(tongTien);
            hoaDonRepository.save(hoaDon);
        }
    }

    // Phương thức phụ: Cập nhật tồn kho
    private boolean updateStock(SanPhamChiTiet sanPhamChiTiet, int soLuongThayDoi) {
        int soLuongTonMoi = sanPhamChiTiet.getSoLuong() + soLuongThayDoi;
        if (soLuongTonMoi < 0) {
            return false; // Số lượng tồn kho không đủ
        }

        // Cập nhật số lượng tồn kho cho sản phẩm chi tiết
        sanPhamChiTiet.setSoLuong(soLuongTonMoi);
        sanPhamChiTietRepository.save(sanPhamChiTiet);

        // Cập nhật số lượng tồn kho cho sản phẩm chính
        SanPham sanPham = sanPhamChiTiet.getSanPham();
        List<SanPhamChiTiet> listSanPhamChiTiet = sanPhamChiTietRepository.findBySanPham(sanPham);
        int tongSoLuong = listSanPhamChiTiet.stream()
                .filter(spct -> spct.getSoLuong() != null)
                .mapToInt(SanPhamChiTiet::getSoLuong)
                .sum();
        sanPham.setSoLuong(tongSoLuong);
        sanPhamRepository.save(sanPham);

        return true;
    }
}
