package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Repository.ChatLieuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/chat-lieu")
public class ChatLieuController {

    @Autowired
    ChatLieuRepository chatLieuRepository;

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",chatLieuRepository.findAll());
        return "ChatLieu/hien-thi";
    }
    @PostMapping("/add")
    public String add(ChatLieu chatLieu){
        chatLieuRepository.save(chatLieu);
        return "redirect:/chat-lieu/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id,Model model){
        model.addAttribute("chatLieu",chatLieuRepository.findById(id));
        return "ChatLieu/hien-thi";
    }
    @PostMapping("/update")
    public String update(ChatLieu chatLieu){
        chatLieuRepository.save(chatLieu);
        return "redirect:/chat-lieu/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        chatLieuRepository.deleteById(id);
        return "redirect:/chat-lieu/hien-thi";
    }
}
