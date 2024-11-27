package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.MauSac;
import com.example.trendsetter.Entity.ThuongHieu;
import com.example.trendsetter.Repository.ThuongHieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/thuong-hieu")
public class ThuongHieuController {
    @Autowired
    ThuongHieuRepository thuongHieuRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",thuongHieuRepository.findAll());
        return "ThuongHieu/hien-thi";
    }
    @PostMapping("/add")
    public String add(ThuongHieu thuongHieu){
        thuongHieu.setTrangThai("Đang Hoạt Động");
        thuongHieuRepository.save(thuongHieu);
        return "redirect:/thuong-hieu/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("thuongHieu",thuongHieuRepository.findById(id));
        return "ThuongHieu/hien-thi";
    }
    @PostMapping("/update")
    public String update(ThuongHieu thuongHieu){
        thuongHieu.setTrangThai("Đang Hoạt Động");
        thuongHieuRepository.save(thuongHieu);
        return "redirect:/thuong-hieu/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        thuongHieuRepository.deleteById(id);
        return "redirect:/thuong-hieu/hien-thi";
    }
}
