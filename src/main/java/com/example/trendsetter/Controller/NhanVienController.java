package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.MauSac;
import com.example.trendsetter.Entity.NhanVien;
import com.example.trendsetter.Repository.DiaChiRepository;
import com.example.trendsetter.Repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/nhan-vien")
public class NhanVienController {
    @Autowired
    NhanVienRepository nhanVienRepository;

    @Autowired
    DiaChiRepository diaChiRepository;

    @ModelAttribute("listDiaChi")
    List<DiaChi> getListDiaChỉ(){
        return diaChiRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",nhanVienRepository.findAll());
        return "NhanVien/hien-thi";
    }
    @PostMapping("/add")
    public String add(NhanVien nhanVien){
        nhanVienRepository.save(nhanVien);
        return "redirect:/nhan-vien/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("nhanVien",nhanVienRepository.findById(id));
        return "NhanVien/hien-thi";
    }
    @PostMapping("/update")
    public String update(NhanVien nhanVien){
        nhanVienRepository.save(nhanVien);
        return "redirect:/nhan-vien/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        nhanVienRepository.deleteById(id);
        return "redirect:/nhan-vien/hien-thi";
    }
}
