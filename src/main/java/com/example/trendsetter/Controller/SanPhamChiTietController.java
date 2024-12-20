package com.example.trendsetter.Controller;

import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/san-pham-chi-tiet")
public class SanPhamChiTietController {
    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private HinhAnhRepository hinhAnhRepository;

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

    @Autowired
    private DanhMucRepository danhMucRepository;

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

    @ModelAttribute("listDanhMuc")
    List<DanhMuc> getListDanhMuc() {
        return danhMucRepository.findAll();
    }

    @ModelAttribute("listHinhAnh")
    List<HinhAnh> getListHinhAnh() {
        return hinhAnhRepository.findAll();
    }


    @PostMapping("/addSanPham")
    public String addSanPham(@ModelAttribute SanPham sanPham,
                             RedirectAttributes redirectAttributes) {
        boolean exists = sanPhamRepository.existsByTenSanPhamAndDanhMucIdAndThuongHieuIdAndXuatSuId(
                sanPham.getTenSanPham(),
                sanPham.getDanhMuc().getId(),
                sanPham.getThuongHieu().getId(),
                sanPham.getXuatSu().getId()
        );

        if (exists) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm đã tồn tại với danh mục, thương hiệu và xuất xứ này!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }

        sanPham.setTrangThai("Đang Hoạt Động");
        sanPhamRepository.save(sanPham);

        redirectAttributes.addFlashAttribute("successMessage", "Sản phẩm đã được thêm thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }


    @PostMapping("/updateSanPham")
    public String updateSanPham(@ModelAttribute SanPham sanPham, RedirectAttributes redirectAttributes) {
        Optional<SanPham> existingSanPham = sanPhamRepository.findByTenSanPhamAndDanhMucIdAndThuongHieuIdAndXuatSuId(
                sanPham.getTenSanPham(),
                sanPham.getDanhMuc().getId(),
                sanPham.getThuongHieu().getId(),
                sanPham.getXuatSu().getId()
        );

        if (existingSanPham.isPresent() && !existingSanPham.get().getId().equals(sanPham.getId())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm đã tồn tại với danh mục, thương hiệu và xuất xứ này!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }
        sanPham.setTrangThai("Đang Hoạt Động");
        sanPhamRepository.save(sanPham);
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật sản phẩm thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @GetMapping("/deleteSanPham")
    public String delete(SanPham sanPham,RedirectAttributes redirectAttributes) {
        sanPhamChiTietRepository.deleteBySanPhamId(sanPham.getId());
        sanPhamRepository.deleteById(sanPham.getId());
        redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @GetMapping("/hien-thi")
    public String hienThi(@RequestParam(defaultValue = "0")int page, Model model) {
        // Thêm vào model để gửi đến view
        // Sắp xếp SanPhamChiTiet theo id giảm dần
        Sort sort = Sort.by(Sort.Order.desc("id")); // Sắp xếp giảm dần theo id
        Page<SanPham> sanPhamPage = sanPhamRepository.findAll(PageRequest.of(page, 5,sort));
        Page<SanPhamChiTiet> sanPhamChiTietPage = sanPhamChiTietRepository.findAll(PageRequest.of(page, 5,sort));
        model.addAttribute("danhSachSanPham", sanPhamPage.getContent());
        model.addAttribute("danhSachSanPhamChiTiet", sanPhamChiTietPage.getContent());
        model.addAttribute("pageNumber", page);
        model.addAttribute("totalPages", sanPhamPage.getTotalPages());
        model.addAttribute("pageNumber1", page);
        model.addAttribute("totalPages1", sanPhamChiTietPage.getTotalPages());
        return "SanPhamChiTiet/hien-thi"; // Trả về trang hiển thị
    }

    @PostMapping("/addSanPhamChiTiet")
    public String addSanPhamChiTiet(SanPhamChiTiet sanPhamChiTiet, RedirectAttributes redirectAttributes) {
        Optional<SanPhamChiTiet> existing = sanPhamChiTietRepository
                .findByMauSacAndKichThuocAndChatLieu(
                        sanPhamChiTiet.getMauSac(),
                        sanPhamChiTiet.getKichThuoc(),
                        sanPhamChiTiet.getChatLieu()
                );

        if (existing.isPresent()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Chi tiết sản phẩm đã tồn tại!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }

        sanPhamChiTiet.setTrangThai("Đang Hoạt Động");
        sanPhamChiTietRepository.save(sanPhamChiTiet);
        redirectAttributes.addFlashAttribute("successMessage", "Thêm chi tiết sản phẩm thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }


    @PostMapping("/updateSanPhamChiTiet")
    public String capNhatChiTietSanPham(
            @RequestParam("id") Integer id,
            @RequestParam("mauSac") Integer mauSacId,
            @RequestParam("kichThuoc") Integer kichThuocId,
            @RequestParam("chatLieu") Integer chatLieuId,
            @RequestParam("soLuong") Integer soLuong,
            @RequestParam("gia") Double gia,
            RedirectAttributes redirectAttributes) {

        // Lấy chi tiết sản phẩm từ cơ sở dữ liệu
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
        if (sanPhamChiTiet == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Chi tiết sản phẩm không tồn tại!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }

        // Lấy các đối tượng liên quan
        MauSac mauSac = mauSacRepository.findById(mauSacId).orElse(null);
        KichThuoc kichThuoc = kichThuocRepository.findById(kichThuocId).orElse(null);
        ChatLieu chatLieu = chatLieuRepository.findById(chatLieuId).orElse(null);

        if (mauSac == null || kichThuoc == null || chatLieu == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Thông tin màu sắc, kích thước hoặc chất liệu không hợp lệ!");
            return "redirect:/san-pham-chi-tiet/hien-thi";
        }

        // Cập nhật chi tiết sản phẩm
        sanPhamChiTiet.setMauSac(mauSac);
        sanPhamChiTiet.setKichThuoc(kichThuoc);
        sanPhamChiTiet.setChatLieu(chatLieu);
        sanPhamChiTiet.setSoLuong(soLuong);
        sanPhamChiTiet.setGia(gia);
        sanPhamChiTietRepository.save(sanPhamChiTiet);

        // Lấy sản phẩm chính
        SanPham sanPham = sanPhamChiTiet.getSanPham();

        // Tính lại số lượng tồn kho từ tất cả sản phẩm chi tiết liên kết
        List<SanPhamChiTiet> listSanPhamChiTiet = sanPhamChiTietRepository.findBySanPham(sanPham);
        int tongSoLuong = listSanPhamChiTiet.stream()
                .filter(spct -> spct.getSoLuong() != null)
                .mapToInt(SanPhamChiTiet::getSoLuong)
                .sum();

        // Cập nhật số lượng tồn kho cho sản phẩm chính
        sanPham.setSoLuong(tongSoLuong);
        sanPhamRepository.save(sanPham);


        // Thêm thông báo thành công
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật chi tiết sản phẩm thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @GetMapping("/deleteSPCT")
    public String deleteSPCT(@RequestParam("id") Integer id,RedirectAttributes redirectAttributes) {
        // Lấy chi tiết sản phẩm cần xóa từ cơ sở dữ liệu
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);

        if (sanPhamChiTiet != null) {
            // Xóa chi tiết sản phẩm
            sanPhamChiTietRepository.deleteById(id);

            // Lấy sản phẩm chính
            SanPham sanPham = sanPhamChiTiet.getSanPham();

            // Tính lại số lượng tồn kho từ tất cả sản phẩm chi tiết liên kết
            List<SanPhamChiTiet> listSanPhamChiTiet = sanPhamChiTietRepository.findBySanPham(sanPham);
            int tongSoLuong = listSanPhamChiTiet.stream()
                    .filter(spct -> spct.getSoLuong() != null)
                    .mapToInt(SanPhamChiTiet::getSoLuong)
                    .sum();

            // Cập nhật số lượng tồn kho cho sản phẩm chính
            sanPham.setSoLuong(tongSoLuong);
            sanPhamRepository.save(sanPham);

        }
        redirectAttributes.addFlashAttribute("successMessage", "Xóa sản phẩm chi tiết thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @PostMapping("/addHinhAnh")
    public String add(@RequestParam("id") Integer id,
                      @RequestParam("urlHinhAnh") MultipartFile hinhAnhFile,
                      Model model,
                      RedirectAttributes redirectAttributes) {
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

            // Lưu thông tin sản phẩm chi tiết và hình ảnh
            SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(id).orElse(null);
            if (sanPhamChiTiet != null) {
                hinhAnh.setSanPhamChiTiet(sanPhamChiTiet);
                hinhAnhRepository.save(hinhAnh);
            } else {
                return "SanPhamChiTiet/hien-thi";
            }

        } catch (IOException e) {
            e.printStackTrace();
            return "SanPhamChiTiet/hien-thi";
        }
        redirectAttributes.addFlashAttribute("successMessage", "Upload hình ảnh thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }

    @GetMapping("/delete")
    public String deleteHinhAnh(@RequestParam("id") Integer id,RedirectAttributes redirectAttributes) {
        // Tìm đối tượng HinhAnh trong cơ sở dữ liệu
        HinhAnh hinhAnh = hinhAnhRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy hình ảnh với ID: " + id));

        // Tạo đường dẫn tệp hình ảnh
        String filePath = uploadPath + File.separator + hinhAnh.getUrlHinhAnh();

        // Xóa tệp hình ảnh khỏi hệ thống tệp
        File file = new File(filePath);
        if (file.exists()) {
            if (file.delete()) {
                System.out.println("Xóa tệp hình ảnh thành công: " + filePath);
            } else {
                System.out.println("Không thể xóa tệp hình ảnh: " + filePath);
            }
        }

        // Xóa hình ảnh khỏi cơ sở dữ liệu
        hinhAnhRepository.deleteById(id);

        // Điều hướng về trang danh sách
        redirectAttributes.addFlashAttribute("successMessage", "Xóa sản hình ảnh thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi";
    }


    @PostMapping("/update-trang-thai")
    public String updateTrangThai(@RequestParam("id") Integer id, @RequestParam("trangThai") String trangThai , RedirectAttributes redirectAttributes) {
        // Tìm sản phẩm chi tiết theo ID
        Optional<SanPham> optionalSP = sanPhamRepository.findById(id);
        if (optionalSP.isPresent()) {
            SanPham sp = optionalSP.get();
            // Cập nhật trạng thái
            sp.setTrangThai(trangThai);
            sanPhamRepository.save(sp); // Lưu thay đổi
        }
        redirectAttributes.addFlashAttribute("successMessage", "Cập nhập trạng thái thành công!");
        return "redirect:/san-pham-chi-tiet/hien-thi"; // Điều hướng về trang hiển thị
    }
}