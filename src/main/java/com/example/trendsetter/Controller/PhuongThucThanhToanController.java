package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.PhuongThucThanhToan;
import com.example.trendsetter.Repository.PhuongThucThanhToanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Controller
@RequestMapping("/phuong-thuc-thanh-toan")
public class PhuongThucThanhToanController {
    @Autowired
    PhuongThucThanhToanRepository phuongThucThanhToanRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model) {
        model.addAttribute("danhSach", phuongThucThanhToanRepository.findAll());
        return "PhuongThucThanhToan/hien-thi";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute PhuongThucThanhToan phuongThucThanhToan) {
        phuongThucThanhToan.setNgayTao(LocalDateTime.now());
        phuongThucThanhToanRepository.save(phuongThucThanhToan);
        return "redirect:/phuong-thuc-thanh-toan/hien-thi";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute PhuongThucThanhToan phuongThucThanhToan) {
        phuongThucThanhToan.setNgaySua(LocalDateTime.now());
        phuongThucThanhToanRepository.save(phuongThucThanhToan);
        return "redirect:/phuong-thuc-thanh-toan/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id) {
        phuongThucThanhToanRepository.deleteById(id);
        return "redirect:/phuong-thuc-thanh-toan/hien-thi";
    }
}
