package com.example.trendsetter.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/trangchu")
public class TrangChuController {
    @GetMapping("/home")
    public String showtrangchu() {
        return "/trangchu/home";
    }
}
