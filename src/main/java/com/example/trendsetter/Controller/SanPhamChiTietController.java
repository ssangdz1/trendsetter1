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
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

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
    public String addSanPhamChiTiet(
            @ModelAttribute SanPhamChiTiet sanPhamChiTiet,
            @RequestParam List<String> tenMauSac, // Danh sách tên màu sắc
            @RequestParam List<String> tenKichThuoc, // Danh sách tên kích thước
            @RequestParam List<String> tenChatLieu // Danh sách tên chất liệu
    ) {
        // Gán giá trị mặc định cho SanPhamChiTiet
        sanPhamChiTiet.setNgayTao(LocalDateTime.now());
        sanPhamChiTiet.setNgaySua(LocalDateTime.now());
        sanPhamChiTiet.setTrangThai("Đang Hoạt Động");

        // Lưu sản phẩm chi tiết
        sanPhamChiTietRepository.save(sanPhamChiTiet);

        // Thêm màu sắc
        for (String tenMau : tenMauSac) {
            MauSac mauSac = new MauSac();
            mauSac.setTenMauSac(tenMau);
            mauSac.setTrangThai("Đang Hoạt Động");
            mauSac.setSanPhamChiTiet(sanPhamChiTiet);
            mauSacRepository.save(mauSac);
        }

        // Thêm kích thước
        for (String tenKich : tenKichThuoc) {
            KichThuoc kichThuoc = new KichThuoc();
            kichThuoc.setTenKichThuoc(tenKich);
            kichThuoc.setTrangThai("Đang Hoạt Động");
            kichThuoc.setSanPhamChiTiet(sanPhamChiTiet);
            kichThuocRepository.save(kichThuoc);
        }

        // Thêm chất liệu
        for (String tenChat : tenChatLieu) {
            ChatLieu chatLieu = new ChatLieu();
            chatLieu.setTenChatLieu(tenChat);
            chatLieu.setMoTa("Mô tả mặc định"); // Thay đổi nếu cần
            chatLieu.setSanPhamChiTiet(sanPhamChiTiet);
            chatLieuRepository.save(chatLieu);
        }

        return "redirect:/san-pham-chi-tiet/hien-thi";
    }


    @GetMapping("/update/{id}")
    public String showUpdate(@PathVariable("id") Integer id, Model model) {
        model.addAttribute("spct", sanPhamChiTietRepository.findById(id));
        return "SanPhamChiTiet/hien-thi";
    }

    @PostMapping("/update")
    public String update(
            @ModelAttribute SanPhamChiTiet sanPhamChiTiet,
            @RequestParam List<String> tenMauSac, // Danh sách tên màu sắc mới
            @RequestParam List<String> tenKichThuoc, // Danh sách tên kích thước mới
            @RequestParam List<String> tenChatLieu, // Danh sách tên chất liệu mới
            RedirectAttributes redirectAttributes
    ) {
        // Tìm sản phẩm chi tiết để cập nhật
        SanPhamChiTiet existingSanPhamChiTiet = sanPhamChiTietRepository.findById(sanPhamChiTiet.getId())
                .orElse(null);
        if (existingSanPhamChiTiet == null) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }

        // Cập nhật thông tin cơ bản
        existingSanPhamChiTiet.setNgayTao(sanPhamChiTiet.getNgayTao());
        existingSanPhamChiTiet.setNgaySua(LocalDateTime.now());
        existingSanPhamChiTiet.setTrangThai("Đang Hoạt Động");

        // Cập nhật màu sắc
        mauSacRepository.deleteAllBySanPhamChiTiet(existingSanPhamChiTiet);
        for (String tenMau : tenMauSac) {
            MauSac mauSac = new MauSac();
            mauSac.setTenMauSac(tenMau);
            mauSac.setSanPhamChiTiet(existingSanPhamChiTiet);
            mauSacRepository.save(mauSac);
        }

        // Cập nhật kích thước
        kichThuocRepository.deleteAllBySanPhamChiTiet(existingSanPhamChiTiet);
        for (String tenKich : tenKichThuoc) {
            KichThuoc kichThuoc = new KichThuoc();
            kichThuoc.setTenKichThuoc(tenKich);
            kichThuoc.setSanPhamChiTiet(existingSanPhamChiTiet);
            kichThuocRepository.save(kichThuoc);
        }

        // Cập nhật chất liệu
        chatLieuRepository.deleteAllBySanPhamChiTiet(existingSanPhamChiTiet);
        for (String tenChat : tenChatLieu) {
            ChatLieu chatLieu = new ChatLieu();
            chatLieu.setTenChatLieu(tenChat);
            chatLieu.setSanPhamChiTiet(existingSanPhamChiTiet);
            chatLieuRepository.save(chatLieu);
        }

        // Lưu thay đổi
        sanPhamChiTietRepository.save(existingSanPhamChiTiet);
        redirectAttributes.addFlashAttribute("success", "Cập nhật sản phẩm thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }


    @GetMapping("/delete")
    public String delete(@RequestParam("id") Integer id, RedirectAttributes redirectAttributes) {
        // Kiểm tra sản phẩm có tồn tại không
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id)
                .orElse(null);
        if (sanPhamChiTiet == null) {
            redirectAttributes.addFlashAttribute("error", "Sản phẩm không tồn tại!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }

        // Xóa các mối quan hệ
        mauSacRepository.deleteAllBySanPhamChiTiet(sanPhamChiTiet);
        kichThuocRepository.deleteAllBySanPhamChiTiet(sanPhamChiTiet);
        chatLieuRepository.deleteAllBySanPhamChiTiet(sanPhamChiTiet);

        // Xóa sản phẩm chi tiết
        sanPhamChiTietRepository.deleteById(id);

        redirectAttributes.addFlashAttribute("success", "Xóa sản phẩm thành công!");
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
