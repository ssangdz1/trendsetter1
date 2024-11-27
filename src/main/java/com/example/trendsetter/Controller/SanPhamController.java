package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhMuc;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Repository.DanhMucRepository;
import com.example.trendsetter.Repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/san-pham")
public class SanPhamController {
    @Autowired
    SanPhamRepository sanPhamRepository;

    @Autowired
    DanhMucRepository danhMucRepository;

    @ModelAttribute("listDanhMuc")
    List<DanhMuc> getListDanhMuc(){
        return danhMucRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",sanPhamRepository.findAll());
        return "SanPham/hien-thi";
    }
    @PostMapping("/add")
    public String add(SanPham sanPham){
        sanPham.setNgayTao(LocalDateTime.now());
        sanPham.setTrangThai("Đang Hoạt Động");
        sanPhamRepository.save(sanPham);
        return "redirect:/san-pham/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("sanPham",sanPhamRepository.findById(id));
        return "SanPham/hien-thi";
    }
    @PostMapping("/update")
    public String update(SanPham sanPham){
        sanPham.setNgaySua(LocalDateTime.now());
        sanPham.setTrangThai("Đang Hoạt Động");
        sanPhamRepository.save(sanPham);
        return "redirect:/san-pham/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        sanPhamRepository.deleteById(id);
        return "redirect:/san-pham/hien-thi";
    }
}
