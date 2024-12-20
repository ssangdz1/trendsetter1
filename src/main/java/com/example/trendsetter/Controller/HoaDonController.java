package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.HoaDonRepository;
import com.example.trendsetter.Repository.PhuongThucThanhToanRepository;
import com.example.trendsetter.Repository.SanPhamChiTietRepository;
import com.example.trendsetter.Repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/hoa-don")
public class HoaDonController {
    @Autowired
    HoaDonRepository hoaDonRepository;

    @Autowired
    PhuongThucThanhToanRepository phuongThucThanhToanRepository;

    @Autowired
    SanPhamRepository sanPhamRepository;

    @ModelAttribute("listPhuongThucThanhToan")
    List<PhuongThucThanhToan> getListPhuongThucThanhToan(){
        return phuongThucThanhToanRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<HoaDon> hoaDonPage = hoaDonRepository.findAll(PageRequest.of(page, 5));
        Page<SanPham> sanPhamPage = sanPhamRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", hoaDonPage.getContent());
        model.addAttribute("listSanPham", sanPhamPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", hoaDonPage.getTotalPages());
        return "HoaDon/hien-thi";
    }

    @PostMapping("/add")
    public String addHoaDon(RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = new HoaDon();
        hoaDon.setNgayTao(LocalDateTime.now());
        hoaDon.setTrangThai("Đang Xử Lý");
        hoaDonRepository.save(hoaDon);

        redirectAttributes.addFlashAttribute("successMessage", "Hóa đơn đã được tạo thành công!");
        return "redirect:/hoa-don/hien-thi";
    }

    @GetMapping("/detail/{id}")
    public String showDetail(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        HoaDon hoaDon = hoaDonRepository.findById(id).orElse(null);
        if (hoaDon == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại!");
            return "redirect:/hoa-don/hien-thi";  // Quay lại danh sách hóa đơn nếu không tìm thấy
        }
        model.addAttribute("hoaDon", hoaDon);
        return "HoaDon/detail";  // Trả về trang hiển thị chi tiết
    }


    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (hoaDonRepository.existsById(id)) {
            hoaDonRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa hóa đơn thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại!");
        }
        return "redirect:/hoa-don/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai , RedirectAttributes redirectAttributes) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<HoaDon> optionalSP = hoaDonRepository.findById(id);
        if (optionalSP.isPresent()) {
            HoaDon hd = optionalSP.get();
            // Cập nhật trạng thái
            hd.setTrangThai(trangThai);
            hoaDonRepository.save(hd); // Lưu thay đổi
        }
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhập trạng thái thành công!");
        return "redirect:/hoa-don/hien-thi"; // Điều hướng về trang hiển thị
    }
}
