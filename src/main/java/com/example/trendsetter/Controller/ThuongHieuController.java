package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.MauSac;
import com.example.trendsetter.Entity.ThuongHieu;
import com.example.trendsetter.Repository.ThuongHieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/thuong-hieu")
public class ThuongHieuController {
    @Autowired
    ThuongHieuRepository thuongHieuRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<ThuongHieu> thuongHieuPage = thuongHieuRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", thuongHieuPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", thuongHieuPage.getTotalPages());
        return "ThuongHieu/hien-thi";
    }

    @PostMapping("/add")
    public String addThuongHieu(@RequestParam String tenThuongHieu, RedirectAttributes redirectAttributes) {
        if (thuongHieuRepository.existsByTenThuongHieu(tenThuongHieu)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên thương hiệu đã tồn tại!");
            return "redirect:/thuong-hieu/hien-thi";
        }

        ThuongHieu thuongHieu = new ThuongHieu();
        thuongHieu.setTenThuongHieu(tenThuongHieu);
        thuongHieuRepository.save(thuongHieu);

        redirectAttributes.addFlashAttribute("successMessage", "Thương hiệu đã được thêm thành công!");
        return "redirect:/thuong-hieu/hien-thi";
    }

    @PostMapping("/update")
    public String updateThuongHieu(@RequestParam("id") Integer id, @RequestParam String tenThuongHieu, RedirectAttributes redirectAttributes) {
        if (thuongHieuRepository.existsByTenThuongHieu(tenThuongHieu)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên thương hiệu đã tồn tại!");
            return "redirect:/thuong-hieu/hien-thi";
        }
        ThuongHieu thuongHieu = thuongHieuRepository.findById(id).get();
        if (thuongHieu != null) {
            thuongHieu.setTenThuongHieu(tenThuongHieu);
            thuongHieuRepository.save(thuongHieu);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thương hiệu thành công!");
        }
        return "redirect:/thuong-hieu/hien-thi";
    }


    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        ThuongHieu thuongHieu = thuongHieuRepository.findById(id).orElse(null);
        if (thuongHieu == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Thương hiệu không tồn tại!");
            return "redirect:/thuong-hieu/hien-thi";
        }
        model.addAttribute("thuongHieu", thuongHieu);
        return "ThuongHieu/hien-thi";
    }


    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (thuongHieuRepository.existsById(id)) {
            thuongHieuRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa thương hiệu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Thương hiệu không tồn tại!");
        }
        return "redirect:/thuong-hieu/hien-thi";
    }
}
