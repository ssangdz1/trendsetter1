package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.KichThuoc;
import com.example.trendsetter.Repository.KichThuocRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/kich-thuoc")
public class KichThuocController {

    @Autowired
    KichThuocRepository kichThuocRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",kichThuocRepository.findAll());
        return "KichThuoc/hien-thi";
    }
    @PostMapping("/add")
    public String add(KichThuoc kichThuoc){
        kichThuocRepository.save(kichThuoc);
        return "redirect:/kich-thuoc/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("kichThuoc",kichThuocRepository.findById(id));
        return "KichThuoc/hien-thi";
    }
    @PostMapping("/update")
    public String update(KichThuoc kichThuoc){
        kichThuocRepository.save(kichThuoc);
        return "redirect:/kich-thuoc/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        kichThuocRepository.deleteById(id);
        return "redirect:/kich-thuoc/hien-thi";
    }
}
