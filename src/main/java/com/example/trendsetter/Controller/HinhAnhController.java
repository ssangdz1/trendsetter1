package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.HinhAnh;
import com.example.trendsetter.Repository.HinhAnhRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    @GetMapping("/hien-thi")
    public String hienThi(Model model){
        model.addAttribute("danhSach",hinhAnhRepository.findAll());
        return "HinhAnh/hien-thi";
    }
    @PostMapping("/add")
    public String add(
        @RequestParam("urlHinhAnh") MultipartFile hinhAnhFile,
        Model model){
            HinhAnh hinhAnh = new HinhAnh();
            hinhAnh.setTrangThai("Đang Hoạt Động");
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
                hinhAnhRepository.save(hinhAnh);
            } catch (IOException e) {
                e.printStackTrace();
                model.addAttribute("error", "Lỗi khi tải lên hình ảnh");
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
                         Model model){
        HinhAnh hinhAnh = hinhAnhRepository.findById(id).get();
        hinhAnh.setTrangThai("Đang Hoạt Động");
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
            hinhAnhRepository.save(hinhAnh);
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "Lỗi khi tải lên hình ảnh");
            return "HinhAnh/hien-thi";
        }
        return "redirect:/hinh-anh/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id")Integer id){
        hinhAnhRepository.deleteById(id);
        return "redirect:/hinh-anh/hien-thi";
    }
}
