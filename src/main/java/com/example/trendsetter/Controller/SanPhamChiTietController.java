package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/san-pham-chi-tiet")
public class SanPhamChiTietController {

    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;

    @Autowired
    private KichThuocRepository kichThuocRepository;

    @Autowired
    private MauSacRepository mauSacRepository;

    @Autowired
    private ChatLieuRepository chatLieuRepository;

    @Autowired
    private ThuongHieuRepository thuongHieuRepository;

    @Autowired
    private XuatSuRepository xuatSuRepository;

    @Autowired
    private SanPhamRepository sanPhamRepository;

    @ModelAttribute("listXuatSu")
    List<XuatSu> getListXuatSu() {
        return xuatSuRepository.findAll();
    }

    @ModelAttribute("listMauSac")
    List<MauSac> getListMauSac() {
        return mauSacRepository.findAll();
    }

    @ModelAttribute("listKichThuoc")
    List<KichThuoc> getListKichThuoc() {
        return kichThuocRepository.findAll();
    }

    @ModelAttribute("listThuongHieu")
    List<ThuongHieu> getListThuongHieu() {
        return thuongHieuRepository.findAll();
    }

    @ModelAttribute("listChatLieu")
    List<ChatLieu> getListChatLieu() {
        return chatLieuRepository.findAll();
    }

    @ModelAttribute("listSanPham")
    List<SanPham> getListSanPham() {
        return sanPhamRepository.findAll();
    }

    @GetMapping("/hien-thi")
    public String hienThi( Model model) {
        model.addAttribute("danhSach", sanPhamChiTietRepository.findAll());
        return "SanPhamChiTiet/hien-thi";
    }

    @PostMapping("/add")
    public String add(SanPhamChiTiet sanPhamChiTiet,
                      @ModelAttribute MauSac mauSac,
                      @ModelAttribute KichThuoc kichThuoc,
                      @ModelAttribute ChatLieu chatLieu) {
        sanPhamChiTiet.setNgayTao(LocalDateTime.now());
        sanPhamChiTiet.setTrangThai("Đang Hoạt Động");
        sanPhamChiTietRepository.save(sanPhamChiTiet);
        mauSacRepository.save(mauSac);
        mauSac.setTrangThai("");
        chatLieuRepository.save(chatLieu);
        chatLieu.setMoTa("");
        kichThuocRepository.save(kichThuoc);
        kichThuoc.setTrangThai("");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("spct", sanPhamChiTietRepository.findById(id));
        return "SanPhamChiTiet/hien-thi";
    }

    @PostMapping("/update")
    public String update(SanPhamChiTiet sanPhamChiTiet) {
        sanPhamChiTiet.setNgayTao(sanPhamChiTiet.getNgayTao());
        sanPhamChiTiet.setNgaySua(LocalDateTime.now());
        sanPhamChiTiet.setTrangThai("Đang Hoạt Động");
        sanPhamChiTietRepository.save(sanPhamChiTiet);
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id) {
        sanPhamChiTietRepository.deleteById(id);
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @PostMapping("/delete-multiple")
    public String deleteMultiple(@RequestParam List<Integer> ids, RedirectAttributes redirectAttributes) {
        if (ids == null || ids.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Không có sản phẩm nào được chọn để xóa.");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }
            // Thực hiện xóa từng sản phẩm chi tiết theo danh sách ID
            ids.forEach(id -> sanPhamChiTietRepository.deleteById(id));

        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @PostMapping("/update-so-luong")
    public String updateSoLuong(@RequestParam List<Integer> id, @RequestParam List<Integer> soLuong) {
        for (int i = 0; i < id.size(); i++) {
            SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id.get(i)).orElseThrow(() -> new RuntimeException("Sản phẩm không tồn tại"));
            sanPhamChiTiet.setSoLuong(soLuong.get(i));
            sanPhamChiTietRepository.save(sanPhamChiTiet);
        }
        return "redirect:/san-pham-chi-tiet"; // Điều hướng lại đến trang quản lý sản phẩm chi tiết
    }
}
