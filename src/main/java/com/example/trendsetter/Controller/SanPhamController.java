package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.DanhMuc;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Entity.ThuongHieu;
import com.example.trendsetter.Entity.XuatSu;
import com.example.trendsetter.Repository.DanhMucRepository;
import com.example.trendsetter.Repository.SanPhamRepository;
import com.example.trendsetter.Repository.ThuongHieuRepository;
import com.example.trendsetter.Repository.XuatSuRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/san-pham")
public class SanPhamController {
    @Autowired
    SanPhamRepository sanPhamRepository;

    @Autowired
    DanhMucRepository danhMucRepository;

    @Autowired
    ThuongHieuRepository thuongHieuRepository;

    @Autowired
    XuatSuRepository xuatSuRepository;

    @ModelAttribute("listThuongHieu")
    List<ThuongHieu> getListThuongHieu(){
        return thuongHieuRepository.findAll();
    }

    @ModelAttribute("listXuatSu")
    List<XuatSu> getListXuatSu(){
        return xuatSuRepository.findAll();
    }

    @ModelAttribute("listDanhMuc")
    List<DanhMuc> getListDanhMuc(){
        return danhMucRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0") int page, Model model) {
        Page<SanPham> sanPhamPage = sanPhamRepository.findAll(PageRequest.of(page, 5));
        model.addAttribute("danhSach", sanPhamPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", sanPhamPage.getTotalPages());
        return "SanPham/hien-thi";
    }

    @PostMapping("/add")
    public String addSanPham(@ModelAttribute SanPham sanPham,
                             RedirectAttributes redirectAttributes) {
        boolean exists = sanPhamRepository.existsByTenSanPhamAndDanhMucIdAndThuongHieuIdAndXuatSuId(
                sanPham.getTenSanPham(),
                sanPham.getDanhMuc().getId(),
                sanPham.getThuongHieu().getId(),
                sanPham.getXuatSu().getId()
        );

        if (exists) {
            redirectAttributes.addFlashAttribute("message", "Sản phẩm đã tồn tại với danh mục, thương hiệu và xuất xứ này!");
            return "redirect:/san-pham/hien-thi";
        }

        sanPham.setTrangThai("Đang Hoạt Động");
        sanPhamRepository.save(sanPham);

        redirectAttributes.addFlashAttribute("successMessage", "Sản phẩm đã được thêm thành công!");
        return "redirect:/san-pham/hien-thi";
    }


    @PostMapping("/update")
    public String updateSanPham(@ModelAttribute SanPham sanPham, RedirectAttributes redirectAttributes) {
        Optional<SanPham> existingSanPham = sanPhamRepository.findByTenSanPhamAndDanhMucIdAndThuongHieuIdAndXuatSuId(
                sanPham.getTenSanPham(),
                sanPham.getDanhMuc().getId(),
                sanPham.getThuongHieu().getId(),
                sanPham.getXuatSu().getId()
        );

        if (existingSanPham.isPresent() && !existingSanPham.get().getId().equals(sanPham.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm đã tồn tại với danh mục, thương hiệu và xuất xứ này!");
            return "redirect:/san-pham/hien-thi";
        }
        sanPham.setTrangThai("Đang Hoạt Động");
        sanPhamRepository.save(sanPham);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
        return "redirect:/san-pham/hien-thi";
    }


    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model, RedirectAttributes redirectAttributes) {
        SanPham sanPham = sanPhamRepository.findById(id).orElse(null);
        if (sanPham == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản Phẩm không tồn tại!");
            return "redirect:/san-pham/hien-thi";
        }
        model.addAttribute("sanPham", sanPham);
        return "SanPham/hien-thi";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        if (sanPhamRepository.existsById(id)) {
            sanPhamRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm không tồn tại!");
        }
        return "redirect:/san-pham/hien-thi";
    }

    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<SanPham> optionalSP = sanPhamRepository.findById(id);
        if (optionalSP.isPresent()) {
            SanPham sp = optionalSP.get();
            // Cập nhật trạng thái
            sp.setTrangThai(trangThai);
            sanPhamRepository.save(sp); // Lưu thay đổi
        }
        return "redirect:/san-pham/hien-thi"; // Điều hướng về trang hiển thị
    }
}
