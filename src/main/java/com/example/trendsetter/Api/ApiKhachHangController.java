package com.example.trendsetter.Api;

import com.example.trendsetter.Controller.NhanVienController;
import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.KhachHang;
import com.example.trendsetter.Entity.NhanVien;
import com.example.trendsetter.Repository.KhachHangRepository;
import com.example.trendsetter.Repository.NhanVienRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/khachhang")
public class ApiKhachHangController {
    @Autowired
    KhachHangRepository khachHangRepository;

    @GetMapping("/hien-thi")
    public List<KhachHang> hienThi(){
        return khachHangRepository.findAll();
    }

    @PostMapping("/add")
    public String add(@RequestBody KhachHang khachHang){
        KhachHang kh = khachHangRepository.save(khachHang);
        if (kh == null){
            return "error";
        }
        return "Them thanh cong";
    }

}
