package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.KhachHang;
import com.example.trendsetter.Entity.KhuyenMai;
import com.example.trendsetter.Entity.PhuongThucThanhToan;
import com.example.trendsetter.Repository.KhuyenMaiRepository;
import com.example.trendsetter.Repository.PhuongThucThanhToanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Optional;

@Controller
@RequestMapping("/phuong-thuc-thanh-toan")
public class PhuongThucThanhToanController {
    @Autowired
    PhuongThucThanhToanRepository phuongThucThanhToanRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {

        Page<PhuongThucThanhToan> phuongThucThanhToanRepositoryPage = phuongThucThanhToanRepository.findAll(PageRequest.of(page, 5));

        model.addAttribute("danhSach",phuongThucThanhToanRepository.findAll());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", phuongThucThanhToanRepositoryPage.getTotalPages());
        return "PhuongThucThanhToan/hien-thi";
    }

    @PostMapping("/add")
    public String add(PhuongThucThanhToan phuongThucThanhToan, RedirectAttributes redirectAttributes){
        phuongThucThanhToan.setNgayTao(LocalDateTime.now());
        phuongThucThanhToan.setTrangThai("Đang Hoạt Động");
        phuongThucThanhToanRepository.save(phuongThucThanhToan);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm phương thức thanh toán thành công!");
        return "redirect:/phuong-thuc-thanh-toan/hien-thi";
    }

    @PostMapping("/update")
    public String update(PhuongThucThanhToan phuongThucThanhToan,RedirectAttributes redirectAttributes){
        phuongThucThanhToan.setNgayTao(phuongThucThanhToan.getNgayTao());
        phuongThucThanhToan.setNgaySua(LocalDateTime.now());
        phuongThucThanhToanRepository.save(phuongThucThanhToan);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật phương thức thanh toán thành công!");
        return "redirect:/phuong-thuc-thanh-toan/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (phuongThucThanhToanRepository.existsById(id)) {
            phuongThucThanhToanRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa phương thức thanh toán thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Phương thức Thanh toán không tồn tại!");
        }
        return "redirect:/phuong-thuc-thanh-toan/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<PhuongThucThanhToan> optionalPhuongThucThanhToan = phuongThucThanhToanRepository.findById(id);
        if (optionalPhuongThucThanhToan.isPresent()) {
            PhuongThucThanhToan phuongThucThanhToan = optionalPhuongThucThanhToan.get();
            // Cập nhật trạng thái
            phuongThucThanhToan.setTrangThai(trangThai);
            phuongThucThanhToanRepository.save(phuongThucThanhToan); // Lưu thay đổi
        }
        return "redirect:/phuong-thuc-thanh-toan/hien-thi"; // Điều hướng về trang hiển thị
    }
}
