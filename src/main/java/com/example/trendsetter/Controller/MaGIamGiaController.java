package com.example.trendsetter.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ma-giam-gia")
public class MaGIamGiaController {
    @GetMapping("/hien-thi")
    public String hienThi(){
        return "MaGiamGia/hien-thi";
    }
}
