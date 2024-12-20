package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhGia;
import com.example.trendsetter.Entity.KhuyenMai;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Repository.DanhGiaRepository;
import com.example.trendsetter.Repository.KhuyenMaiRepository;
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
@RequestMapping("/khuyen-mai")
public class KhuyenMaiController {
    @Autowired
    KhuyenMaiRepository khuyenMaiRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {

        Page<KhuyenMai> khuyenMaiPage = khuyenMaiRepository.findAll(PageRequest.of(page, 5));

        model.addAttribute("danhSach",khuyenMaiRepository.findAll());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", khuyenMaiPage.getTotalPages());
        return "KhuyenMai/hien-thi";
    }

    @PostMapping("/add")
    public String add(KhuyenMai khuyenMai, RedirectAttributes redirectAttributes){
        khuyenMai.setNgayTao(LocalDateTime.now());
        khuyenMai.setTrangThai("Đang Hoạt Động");
        khuyenMaiRepository.save(khuyenMai);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm khuyến mại thành công!");
        return "redirect:/khuyen-mai/hien-thi";
    }

    @PostMapping("/update")
    public String update(KhuyenMai khuyenMai,RedirectAttributes redirectAttributes){
        khuyenMai.setNgayTao(khuyenMai.getNgayTao());
        khuyenMaiRepository.save(khuyenMai);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật khuyến mại thành công!");
        return "redirect:/khuyen-mai/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (khuyenMaiRepository.existsById(id)) {
            khuyenMaiRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa khuyến mại thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Khuyến mại không tồn tại!");
        }
        return "redirect:/khuyen-mai/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<KhuyenMai> optionalKhuyenMai = khuyenMaiRepository.findById(id);
        if (optionalKhuyenMai.isPresent()) {
            KhuyenMai khuyenMai = optionalKhuyenMai.get();
            // Cập nhật trạng thái
            khuyenMai.setTrangThai(trangThai);
            khuyenMaiRepository.save(khuyenMai); // Lưu thay đổi
        }
        return "redirect:/khuyen-mai/hien-thi"; // Điều hướng về trang hiển thị
    }
}
