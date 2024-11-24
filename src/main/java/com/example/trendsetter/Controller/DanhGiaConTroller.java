package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.DanhGia;
import com.example.trendsetter.Repository.DanhGiaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/danh-gia")
public class DanhGiaConTroller {
    @Autowired
    DanhGiaRepository danhGiaRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",danhGiaRepository.findAll());
        return "DanhGia/hien-thi";
    }
    @PostMapping("/add")
    public String add(DanhGia danhGia){
        danhGiaRepository.save(danhGia);
        return "redirect:/danh-gia/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("danhGia",danhGiaRepository.findById(id));
        return "ChatLieu/hien-thi";
    }
    @PostMapping("/update")
    public String update(DanhGia danhGia){
        danhGiaRepository.save(danhGia);
        return "redirect:/danh-gia/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        danhGiaRepository.deleteById(id);
        return "redirect:/danh-gia/hien-thi";
    }
}
