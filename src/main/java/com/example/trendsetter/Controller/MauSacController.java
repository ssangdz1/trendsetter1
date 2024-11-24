package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.KichThuoc;
import com.example.trendsetter.Entity.MauSac;
import com.example.trendsetter.Repository.MauSacRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/mau-sac")
public class MauSacController {
    @Autowired
    MauSacRepository mauSacRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",mauSacRepository.findAll());
        return "MauSac/hien-thi";
    }
    @PostMapping("/add")
    public String add(MauSac mauSac){
        mauSacRepository.save(mauSac);
        return "redirect:/mau-sac/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("mauSac",mauSacRepository.findById(id));
        return "MauSac/hien-thi";
    }
    @PostMapping("/update")
    public String update(MauSac mauSac){
        mauSacRepository.save(mauSac);
        return "redirect:/mau-sac/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        mauSacRepository.deleteById(id);
        return "redirect:/mau-sac/hien-thi";
    }
}
