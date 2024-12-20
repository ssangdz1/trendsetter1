package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhGia;
import com.example.trendsetter.Entity.KhachHang;
import com.example.trendsetter.Entity.KhuyenMai;
import com.example.trendsetter.Entity.NhanVien;
import com.example.trendsetter.Repository.DanhGiaRepository;
import com.example.trendsetter.Repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
@RequestMapping("/khach-hang")
public class KhachHangController {
    @Autowired
    KhachHangRepository khachHangRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {

        Page<KhachHang> khachHangPage = khachHangRepository.findAll(PageRequest.of(page, 5));

        model.addAttribute("danhSach",khachHangRepository.findAll());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", khachHangPage.getTotalPages());
        return "KhachHang/hien-thi";
    }

    @PostMapping("/add")
    public String add(KhachHang khachHang, RedirectAttributes redirectAttributes){
        khachHang.setTrangThai("Đang Hoạt Động");
        khachHangRepository.save(khachHang);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm khách hàng thành công!");
        return "redirect:/khach-hang/hien-thi";
    }

    @PostMapping("/update")
    public String update(KhachHang khachHang,RedirectAttributes redirectAttributes){
        khachHang.setTrangThai("Đang Hoạt Động");
        khachHangRepository.save(khachHang);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khách hàng thành công!");
        return "redirect:/khach-hang/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (khachHangRepository.existsById(id)) {
            khachHangRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa khách hàng thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Khách hàng không tồn tại!");
        }
        return "redirect:/khach-hang/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<KhachHang> optionalKhachHang = khachHangRepository.findById(id);
        if (optionalKhachHang.isPresent()) {
            KhachHang khachHang = optionalKhachHang.get();
            // Cập nhật trạng thái
            khachHang.setTrangThai(trangThai);
            khachHangRepository.save(khachHang); // Lưu thay đổi
        }
        return "redirect:/khach-hang/hien-thi"; // Điều hướng về trang hiển thị
    }
}
