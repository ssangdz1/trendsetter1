package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhMuc;
import com.example.trendsetter.Repository.DanhMucRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/danh-muc")
public class DanhMucController {

    @Autowired
    DanhMucRepository danhMucRepository;
    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",danhMucRepository.findAll());
        return "DanhMuc/hien-thi";
    }
    @PostMapping("/add")
    public String add(DanhMuc danhMuc){
        danhMuc.setTrangThai("Đang Hoạt Động");
        danhMucRepository.save(danhMuc);
        return "redirect:/danh-muc/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("danhGia",danhMucRepository.findById(id));
        return "DanhMuc/hien-thi";
    }
    @PostMapping("/update")
    public String update(DanhMuc danhMuc){
        danhMuc.setTrangThai("Đang Hoạt Động");
        danhMucRepository.save(danhMuc);
        return "redirect:/danh-muc/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        danhMucRepository.deleteById(id);
        return "redirect:/danh-muc/hien-thi";
    }
}
