package com.example.trendsetter.Api;

import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.KhachHang;
import com.example.trendsetter.Repository.DiaChiRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/diachi")
public class ApiDiaChiController {
    @Autowired
    DiaChiRepository diaChiRepository;


    @GetMapping("/hien-thi")
    public List<DiaChi> hienThi(){
        return diaChiRepository.findAll();
    }

    @GetMapping("/khach-hang")
    public List<DiaChi> khachHang(){
        return diaChiRepository.getAllBy();
    }

    @PostMapping("/add")
    public String add(@RequestBody DiaChi diaChi){
        DiaChi dc = diaChiRepository.save(diaChi);
        if (dc == null){
            return "error";
        }
        return "Them thanh cong";
    }

    @PostMapping("/update")
    public String update(@RequestBody DiaChi diaChi){
        DiaChi dc = diaChiRepository.save(diaChi);
        if (dc == null){
            return "error";
        }
        return "Sua thanh cong";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id){
        diaChiRepository.deleteById(id);
        return "xoa thanh cong";
    }

    @GetMapping("/phan-trang")
    public List<DiaChi> phanTrang(@RequestParam(value = "page",defaultValue = "0")Integer page){
        int pageSize = 2;
        Pageable pageable = PageRequest.of(page,pageSize);
        return diaChiRepository.findAll(pageable).getContent();
    }
}
