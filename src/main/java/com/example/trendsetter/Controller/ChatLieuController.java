package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Repository.ChatLieuRepository;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/chat-lieu")
public class ChatLieuController {

    @Autowired
    ChatLieuRepository chatLieuRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<ChatLieu> chatLieuPage = chatLieuRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", chatLieuPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", chatLieuPage.getTotalPages());
        return "ChatLieu/hien-thi";
    }

    @PostMapping("/add")
    public String addChatLieu(@RequestParam String tenChatLieu, RedirectAttributes redirectAttributes) {
        if (chatLieuRepository.existsByTenChatLieu(tenChatLieu)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên chất liệu đã tồn tại!");
            return "redirect:/chat-lieu/hien-thi";
        }

        ChatLieu chatLieu = new ChatLieu();
        chatLieu.setTenChatLieu(tenChatLieu);
        chatLieuRepository.save(chatLieu);

        redirectAttributes.addFlashAttribute("successMessage", "Chất liệu đã được thêm thành công!");
        return "redirect:/chat-lieu/hien-thi";
    }

    @PostMapping("/update")
    public String updateChatLieu(@RequestParam("id") Integer id, @RequestParam String tenChatLieu, RedirectAttributes redirectAttributes) {
        if (chatLieuRepository.existsByTenChatLieu(tenChatLieu)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên chất liệu đã tồn tại!");
            return "redirect:/chat-lieu/hien-thi";
        }
        ChatLieu chatLieu = chatLieuRepository.findById(id).get();
        if (chatLieu != null) {
            chatLieu.setTenChatLieu(tenChatLieu);
            chatLieuRepository.save(chatLieu);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chất liệu thành công!");
        }
        return "redirect:/chat-lieu/hien-thi";
    }


    @GetMapping("/detail/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        ChatLieu chatLieu = chatLieuRepository.findById(id).orElse(null);
        if (chatLieu == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Chất liệu không tồn tại!");
            return "redirect:/chat-lieu/hien-thi";
        }
        model.addAttribute("chatLieu", chatLieu);
        return "ChatLieu/hien-thi";
    }

    @PostMapping("/delete/{id}")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (chatLieuRepository.existsById(id)) {
            chatLieuRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa chất liệu thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Chất liệu không tồn tại!");
        }
        return "redirect:/chat-lieu/hien-thi";
    }

}
