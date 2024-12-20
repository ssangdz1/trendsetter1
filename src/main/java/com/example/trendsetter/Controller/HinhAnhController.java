package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.HinhAnh;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Repository.HinhAnhRepository;
import com.example.trendsetter.Repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@Controller
@RequestMapping("/hinh-anh")
public class HinhAnhController {
    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    HinhAnhRepository hinhAnhRepository;

    @Autowired
    SanPhamRepository sanPhamRepository;

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<HinhAnh> hinhAnhPage = hinhAnhRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach",hinhAnhPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", hinhAnhPage.getTotalPages());
        return "HinhAnh/hien-thi";
    }
    @PostMapping("/add")
    public String add(
        @RequestParam("urlHinhAnh") MultipartFile hinhAnhFile,
        RedirectAttributes redirectAttributes){
            HinhAnh hinhAnh = new HinhAnh();
            try {
                // Xử lý upload hình ảnh
                if (hinhAnhFile != null && !hinhAnhFile.isEmpty()) {
                    String fileName = System.currentTimeMillis() + "_" + hinhAnhFile.getOriginalFilename();
                    Path uploadFolderPath = Paths.get(uploadPath);
                    if (!Files.exists(uploadFolderPath)) Files.createDirectories(uploadFolderPath);

                    // Lưu ảnh vào thư mục
                    Path filePath = uploadFolderPath.resolve(fileName);
                    Files.copy(hinhAnhFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                    // Lưu đường dẫn ảnh
                    hinhAnh.setUrlHinhAnh(fileName);
                }

                // Lưu sản phẩm chi tiết
                redirectAttributes.addFlashAttribute("successMessage", "Hình ảnh đã được thêm thành công!");
                hinhAnhRepository.save(hinhAnh);
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tải lên hình ảnh");
                return "HinhAnh/hien-thi";
            }
            return "redirect:/hinh-anh/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id")Integer id, Model model){
        model.addAttribute("hinhAnh",hinhAnhRepository.findById(id));
        return "HinhAnh/hien-thi";
    }

    @PostMapping("/update")
    public String update(@RequestParam("id") Integer id,
                         @RequestParam("urlHinhAnh") MultipartFile hinhAnhFile,
                         RedirectAttributes redirectAttributes){
        HinhAnh hinhAnh = hinhAnhRepository.findById(id).get();
        try {
            // Xử lý upload hình ảnh
            if (hinhAnhFile != null && !hinhAnhFile.isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + hinhAnhFile.getOriginalFilename();
                Path uploadFolderPath = Paths.get(uploadPath);
                if (!Files.exists(uploadFolderPath)) Files.createDirectories(uploadFolderPath);

                // Lưu ảnh vào thư mục
                Path filePath = uploadFolderPath.resolve(fileName);
                Files.copy(hinhAnhFile.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                // Lưu đường dẫn ảnh
                hinhAnh.setUrlHinhAnh(fileName);
            }

            redirectAttributes.addFlashAttribute("successMessage", "Hình ảnh đã được sửa thành công!");
            hinhAnhRepository.save(hinhAnh);
        } catch (IOException e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Lỗi khi tải lên hình ảnh");
            return "HinhAnh/hien-thi";
        }
        return "redirect:/hinh-anh/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id,RedirectAttributes redirectAttributes){
        if (hinhAnhRepository.existsById(id)){
            hinhAnhRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Hình ảnh đã được xóa thành công!");
        }else {
            redirectAttributes.addFlashAttribute("errorMessage", "Chất liệu không tồn tại!");
        }
        return "redirect:/hinh-anh/hien-thi";
    }
}
