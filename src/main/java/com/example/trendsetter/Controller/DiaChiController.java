package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.KhachHang;
import com.example.trendsetter.Repository.DiaChiRepository;
import com.example.trendsetter.Repository.KhachHangRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/dia-chi")
public class DiaChiController {

    @Autowired
    DiaChiRepository diaChiRepository;

    @Autowired
    KhachHangRepository khachHangRepository;

    @ModelAttribute("listKhachHang")
    List<KhachHang> getListKhachHang(){
        return khachHangRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<DiaChi> diaChiPage = diaChiRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach",diaChiRepository.findAll());
        model.addAttribute("listKhachHang",khachHangRepository.findAll());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", diaChiPage.getTotalPages());
        return "DiaChi/hien-thi";
    }
    @PostMapping("/add")
    public String add(DiaChi diaChi, RedirectAttributes redirectAttributes) {
        KhachHang khachHang = khachHangRepository.findById(diaChi.getKhachHang().getId()).orElse(null);
        if (khachHang != null) {
            diaChi.setKhachHang(khachHang);
            diaChiRepository.save(diaChi);
            redirectAttributes.addFlashAttribute("successMessage", "Thêm địa chỉ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Khách hàng không tồn tại!");
        }
        return "redirect:/dia-chi/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("diaChi",diaChiRepository.findById(id));
        return "DiaChi/hien-thi";
    }

    @PostMapping("/update")
    public String update(DiaChi diaChi, RedirectAttributes redirectAttributes) {
        KhachHang khachHang = khachHangRepository.findById(diaChi.getKhachHang().getId()).orElse(null);
        if (khachHang != null) {
            diaChi.setKhachHang(khachHang);
            diaChiRepository.save(diaChi);
            redirectAttributes.addFlashAttribute("successMessage", "Sửa địa chỉ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Khách hàng không tồn tại!");
        }
        return "redirect:/dia-chi/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (diaChiRepository.existsById(id)) {
            diaChiRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa địa chỉ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Địa Chỉ không tồn tại!");
        }
        return "redirect:/dia-chi/hien-thi";
    }

    public List<DiaChi> getDiaChisByKhachHangId(Integer khachHangId) {
        return diaChiRepository.findByKhachHangIdAndTrangThaiFalse(khachHangId);
    }
}
