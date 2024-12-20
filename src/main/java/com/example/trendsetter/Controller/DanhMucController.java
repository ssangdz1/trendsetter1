package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.DanhMuc;
import com.example.trendsetter.Repository.DanhMucRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/danh-muc")
public class DanhMucController {

    @Autowired
    DanhMucRepository danhMucRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<DanhMuc> danhMucPage = danhMucRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", danhMucPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", danhMucPage.getTotalPages());
        return "DanhMuc/hien-thi";
    }

    @PostMapping("/add")
    public String addChatLieu(@RequestParam String tenDanhMuc, RedirectAttributes redirectAttributes) {
        if (danhMucRepository.existsByTenDanhMuc(tenDanhMuc)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục đã tồn tại!");
            return "redirect:/danh-muc/hien-thi";
        }

        DanhMuc danhMuc = new DanhMuc();
        danhMuc.setTenDanhMuc(tenDanhMuc);
        danhMucRepository.save(danhMuc);

        redirectAttributes.addFlashAttribute("successMessage", "Danh Mục đã được thêm thành công!");
        return "redirect:/danh-muc/hien-thi";
    }

    @PostMapping("/update")
    public String updateDanhMuc(@RequestParam("id") Integer id, @RequestParam String tenDanhMuc, RedirectAttributes redirectAttributes) {
        if (danhMucRepository.existsByTenDanhMuc(tenDanhMuc)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên danh mục đã tồn tại!");
            return "redirect:/danh-muc/hien-thi";
        }

        DanhMuc danhMuc = danhMucRepository.findById(id).get();
        if (danhMuc != null) {
            danhMuc.setTenDanhMuc(tenDanhMuc);
            danhMucRepository.save(danhMuc);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật danh mục thành công!");
        }
        return "redirect:/danh-muc/hien-thi";
    }


    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        DanhMuc danhMuc = danhMucRepository.findById(id).orElse(null);
        if (danhMuc == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Danh mục không tồn tại!");
            return "redirect:/danh-muc/hien-thi";
        }
        model.addAttribute("danhMuc", danhMuc);
        return "DanhMuc/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (danhMucRepository.existsById(id)) {
            danhMucRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa danh mục thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Danh Mục không tồn tại!");
        }
        return "redirect:/danh-muc/hien-thi";
    }
}
