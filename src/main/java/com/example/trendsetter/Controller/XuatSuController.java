package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.ThuongHieu;
import com.example.trendsetter.Entity.XuatSu;
import com.example.trendsetter.Repository.XuatSuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/xuat-su")
public class XuatSuController {
    @Autowired
    XuatSuRepository xuatSuRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<XuatSu> xuatSuPage = xuatSuRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", xuatSuPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", xuatSuPage.getTotalPages());
        return "XuatSu/hien-thi";
    }

    @PostMapping("/add")
    public String addXuatSu(@RequestParam String quocGia, RedirectAttributes redirectAttributes) {
        if (xuatSuRepository.existsByQuocGia(quocGia)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên xuất sứ đã tồn tại!");
            return "redirect:/xuat-su/hien-thi";
        }

        XuatSu xuatSu = new XuatSu();
        xuatSu.setQuocGia(quocGia);
        xuatSuRepository.save(xuatSu);

        redirectAttributes.addFlashAttribute("successMessage", "Xuất sứ đã được thêm thành công!");
        return "redirect:/xuat-su/hien-thi";
    }

    @PostMapping("/update")
    public String updateXuatSu(@RequestParam("id") Integer id, @RequestParam String quocGia, RedirectAttributes redirectAttributes) {
        if (xuatSuRepository.existsByQuocGia(quocGia)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Tên xuất sứ đã tồn tại!");
            return "redirect:/xuat-su/hien-thi";
        }
        XuatSu xuatSu = xuatSuRepository.findById(id).get();
        if (xuatSu != null) {
            xuatSu.setQuocGia(quocGia);
            xuatSuRepository.save(xuatSu);
            redirectAttributes.addFlashAttribute("successMessage", "Cập nhật xuất sứ thành công!");
        }
        return "redirect:/xuat-su/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        XuatSu xuatSu = xuatSuRepository.findById(id).orElse(null);
        if (xuatSu == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Xuất sứ không tồn tại!");
            return "redirect:/xuat-su/hien-thi";
        }
        model.addAttribute("xuatSu", xuatSu);
        return "XuatSu/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (xuatSuRepository.existsById(id)) {
            xuatSuRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa xuất sứ thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Xuất sứ không tồn tại!");
        }
        return "redirect:/xuat-su/hien-thi";
    }
}
