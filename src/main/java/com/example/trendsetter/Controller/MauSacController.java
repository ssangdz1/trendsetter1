package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.KichThuoc;
import com.example.trendsetter.Entity.MauSac;
import com.example.trendsetter.Repository.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/mau-sac")
public class MauSacController {
    @Autowired
    MauSacRepository mauSacRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<MauSac> mauSacPage = mauSacRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", mauSacPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", mauSacPage.getTotalPages());
        return "MauSac/hien-thi";
    }

    @PostMapping("/add")
    public String addMauSac(@RequestParam String tenMauSac, RedirectAttributes redirectAttributes) {
        if (mauSacRepository.existsByTenMauSac(tenMauSac)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên màu sắc đã tồn tại!");
            return "redirect:/mau-sac/hien-thi";
        }

        MauSac mauSac = new MauSac();
        mauSac.setTenMauSac(tenMauSac);
        mauSacRepository.save(mauSac);

        redirectAttributes.addFlashAttribute("successMessage", "Màu Sắc đã được thêm thành công!");
        return "redirect:/mau-sac/hien-thi";
    }

    @PostMapping("/update")
    public String updateMauSac(@RequestParam("id") Integer id, @RequestParam String tenMauSac, RedirectAttributes redirectAttributes) {
        if (mauSacRepository.existsByTenMauSac(tenMauSac)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên màu sắc đã tồn tại!");
            return "redirect:/mau-sac/hien-thi";
        }
        MauSac mauSac = mauSacRepository.findById(id).get();
        if (mauSac != null) {
            mauSac.setTenMauSac(tenMauSac);
            mauSacRepository.save(mauSac);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật màu sắc thành công!");
        }
        return "redirect:/mau-sac/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        MauSac mauSac = mauSacRepository.findById(id).orElse(null);
        if (mauSac == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Màu sắc không tồn tại!");
            return "redirect:/mau-sac/hien-thi";
        }
        model.addAttribute("mauSac", mauSac);
        return "MauSac/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (mauSacRepository.existsById(id)) {
            mauSacRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa màu sắc thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Màu sắc không tồn tại!");
        }
        return "redirect:/mau-sac/hien-thi";
    }
}
