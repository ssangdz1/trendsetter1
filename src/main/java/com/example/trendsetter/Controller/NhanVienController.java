package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.DiaChiRepository;
import com.example.trendsetter.Repository.KhachHangRepository;
import com.example.trendsetter.Repository.NhanVienRepository;
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
@RequestMapping("/nhan-vien")
public class NhanVienController {
    @Autowired
    NhanVienRepository nhanVienRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {

        Page<NhanVien> nhanVienPage = nhanVienRepository.findAll(PageRequest.of(page, 5));

        model.addAttribute("danhSach",nhanVienRepository.findAll());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", nhanVienPage.getTotalPages());
        return "NhanVien/hien-thi";
    }

    @PostMapping("/add")
    public String add(NhanVien nhanVien, RedirectAttributes redirectAttributes){
        nhanVien.setTrangThai("Đang Hoạt Động");
        nhanVienRepository.save(nhanVien);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm nhân viên thành công!");
        return "redirect:/nhan-vien/hien-thi";
    }

    @PostMapping("/update")
    public String update(NhanVien nhanVien,RedirectAttributes redirectAttributes){
        nhanVien.setTrangThai(nhanVien.getTrangThai());
        nhanVienRepository.save(nhanVien);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật nhân viên thành công!");
        return "redirect:/nhan-vien/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (nhanVienRepository.existsById(id)) {
            nhanVienRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa nhân viên thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Nhân viên không tồn tại!");
        }
        return "redirect:/nhan-vien/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<NhanVien> optionalNhanVien = nhanVienRepository.findById(id);
        if (optionalNhanVien.isPresent()) {
            NhanVien nhanVien = optionalNhanVien.get();
            // Cập nhật trạng thái
            nhanVien.setTrangThai(trangThai);
            nhanVienRepository.save(nhanVien); // Lưu thay đổi
        }
        return "redirect:/nhan-vien/hien-thi"; // Điều hướng về trang hiển thị
    }
}
