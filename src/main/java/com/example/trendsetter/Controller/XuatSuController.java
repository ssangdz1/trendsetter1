package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ThuongHieu;
import com.example.trendsetter.Entity.XuatSu;
import com.example.trendsetter.Repository.XuatSuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/xuat-su")
public class XuatSuController {
    @Autowired
    XuatSuRepository xuatSuRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",xuatSuRepository.findAll());
        return "XuatSu/hien-thi";
    }
    @PostMapping("/add")
    public String add(XuatSu xuatSu){
        xuatSuRepository.save(xuatSu);
        return "redirect:/xuat-su/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("xuatSu",xuatSuRepository.findById(id));
        return "XuatSu/hien-thi";
    }
    @PostMapping("/update")
    public String update(XuatSu xuatSu){
        xuatSuRepository.save(xuatSu);
        return "redirect:/xuat-su/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        xuatSuRepository.deleteById(id);
        return "redirect:/xuat-su/hien-thi";
    }
}
