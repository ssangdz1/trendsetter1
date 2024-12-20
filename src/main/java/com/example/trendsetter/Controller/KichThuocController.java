package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.KichThuoc;
import com.example.trendsetter.Repository.KichThuocRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/kich-thuoc")
public class KichThuocController {

    @Autowired
    KichThuocRepository kichThuocRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<KichThuoc> kichThuocPage = kichThuocRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", kichThuocPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", kichThuocPage.getTotalPages());
        return "KichThuoc/hien-thi";
    }

    @PostMapping("/add")
    public String addKichThuoc(@RequestParam String tenKichThuoc, RedirectAttributes redirectAttributes) {
        if (kichThuocRepository.existsByTenKichThuoc(tenKichThuoc)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên kích thước đã tồn tại!");
            return "redirect:/kich-thuoc/hien-thi";
        }

        KichThuoc kichThuoc = new KichThuoc();
        kichThuoc.setTenKichThuoc(tenKichThuoc);
        kichThuocRepository.save(kichThuoc);

        redirectAttributes.addFlashAttribute("successMessage", "Kích thước đã được thêm thành công!");
        return "redirect:/kich-thuoc/hien-thi";
    }

    @PostMapping("/update")
    public String updateKichThuoc(@RequestParam("id") Integer id, @RequestParam String tenKichThuoc, RedirectAttributes redirectAttributes) {
        if (kichThuocRepository.existsByTenKichThuoc(tenKichThuoc)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên kích thước đã tồn tại!");
            return "redirect:/kich-thuoc/hien-thi";
        }
        KichThuoc kichThuoc = kichThuocRepository.findById(id).get();
        if (kichThuoc != null) {
            kichThuoc.setTenKichThuoc(tenKichThuoc);
            kichThuocRepository.save(kichThuoc);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật kích thước thành công!");
        }
        return "redirect:/kich-thuoc/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        KichThuoc kichThuoc = kichThuocRepository.findById(id).orElse(null);
        if (kichThuoc == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Kích thước không tồn tại!");
            return "redirect:/kich-thuoc/hien-thi";
        }
        model.addAttribute("kichThuoc", kichThuoc);
        return "KichThuoc/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (kichThuocRepository.existsById(id)) {
            kichThuocRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa kích thước thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Kích thước không tồn tại!");
        }
        return "redirect:/kich-thuoc/hien-thi";
    }
}
