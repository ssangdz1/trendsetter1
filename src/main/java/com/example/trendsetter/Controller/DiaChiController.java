package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhMuc;
import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Repository.DiaChiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/dia-chi")
public class DiaChiController {

    @Autowired
    DiaChiRepository diaChiRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",diaChiRepository.findAll());
        return "DiaChi/hien-thi";
    }
    @PostMapping("/add")
    public String add(DiaChi diaChi){
        diaChiRepository.save(diaChi);
        return "redirect:/dia-chi/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("diaChi",diaChiRepository.findById(id));
        return "DiaChi/hien-thi";
    }
    @PostMapping("/update")
    public String update(DiaChi diaChi){
        diaChiRepository.save(diaChi);
        return "redirect:/dia-chi/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        diaChiRepository.deleteById(id);
        return "redirect:/dia-chi/hien-thi";
    }
}
