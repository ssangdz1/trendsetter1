package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhGia;
import com.example.trendsetter.Repository.DanhGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/danh-gia")
public class DanhGiaConTroller {
    @Autowired
    DanhGiaRepository danhGiaRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {

        Page<DanhGia> danhGiaPage = danhGiaRepository.findAll(PageRequest.of(page, 5));

        model.addAttribute("danhSach",danhGiaRepository.findAll());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", danhGiaPage.getTotalPages());
        return "DanhGia/hien-thi";
    }

    @PostMapping("/add")
    public String add(DanhGia danhGia,RedirectAttributes redirectAttributes){
        danhGia.setNgayDanhGia(LocalDateTime.now());
        danhGiaRepository.save(danhGia);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm đánh giá thành công!");
        return "redirect:/danh-gia/hien-thi";
    }

    @PostMapping("/update")
    public String update(DanhGia danhGia,RedirectAttributes redirectAttributes){
        danhGia.setNgayDanhGia(LocalDateTime.now());
        danhGiaRepository.save(danhGia);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật đánh giá thành công!");
        return "redirect:/danh-gia/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (danhGiaRepository.existsById(id)) {
            danhGiaRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa đánh giá thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Đánh giá không tồn tại!");
        }
        return "redirect:/danh-gia/hien-thi";
    }
}
