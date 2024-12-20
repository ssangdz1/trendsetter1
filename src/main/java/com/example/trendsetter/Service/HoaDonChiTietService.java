package com.example.trendsetter.Service;

import com.example.trendsetter.Entity.HoaDon;
import com.example.trendsetter.Entity.HoaDonChiTiet;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Entity.SanPhamChiTiet;
import com.example.trendsetter.Repository.HoaDonChiTietRepository;
import com.example.trendsetter.Repository.HoaDonRepository;
import com.example.trendsetter.Repository.SanPhamChiTietRepository;
import com.example.trendsetter.Repository.SanPhamRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Service
public class HoaDonChiTietService {
    @Autowired
    private HoaDonChiTietRepository hoaDonChiTietRepository;
    @Autowired
    private SanPhamChiTietRepository sanPhamChiTietRepository;
    @Autowired
    private HoaDonRepository hoaDonRepository;
    @Autowired
    private SanPhamRepository sanPhamRepository;


    // Phương thức cập nhật số lượng trong hóa đơn chi tiết
    public String updateQuantityOrder(Integer idHoaDonChiTiet, Integer soLuong, Integer idHoaDon, RedirectAttributes redirectAttributes) {
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findById(idHoaDonChiTiet).orElse(null);
        if (hoaDonChiTiet == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn chi tiết không tồn tại!");
            return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
        }

        // Kiểm tra số lượng mới
        if (soLuong < 1) {
            redirectAttributes.addFlashAttribute("errorMessage", "Số lượng phải lớn hơn 0!");
            return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
        }

        // Lấy sản phẩm chi tiết
        SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();

        // Kiểm tra số lượng tồn kho
        int soLuongTonKho = sanPhamChiTiet.getSoLuong();
        int soLuongBanHang = hoaDonChiTiet.getSoLuong();
        int soLuongMoi = soLuong - soLuongBanHang;

        if (soLuongTonKho < soLuongMoi) {
            redirectAttributes.addFlashAttribute("errorMessage", "Số lượng tồn kho không đủ.");
            return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
        }

        // Cập nhật thông tin hóa đơn chi tiết
        hoaDonChiTiet.setSoLuong(soLuong);
        Float thanhTien = sanPhamChiTiet.getGia().floatValue() * soLuong;
        hoaDonChiTiet.setThanhTien(thanhTien);
        hoaDonChiTietRepository.save(hoaDonChiTiet);

        // Cập nhật tồn kho sản phẩm chi tiết
        sanPhamChiTiet.setSoLuong(soLuongTonKho - soLuongMoi);
        sanPhamChiTietRepository.save(sanPhamChiTiet);

        // Cập nhật tồn kho sản phẩm chính
        SanPham sanPham = sanPhamChiTiet.getSanPham();
        updateStockForProduct(sanPham);

        // Cập nhật tổng tiền hóa đơn
        updateInvoiceTotal(idHoaDon);

        return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
    }

    // Phương thức thêm sản phẩm vào hóa đơn
    public String addProductDetailToHoaDon(Integer idSanPhamChiTiet, Integer idHoaDon, Integer soLuong, RedirectAttributes redirectAttributes) {
        SanPhamChiTiet sanPhamChiTiet = sanPhamChiTietRepository.findById(idSanPhamChiTiet).orElse(null);
        if (sanPhamChiTiet == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Sản phẩm chi tiết không tồn tại.");
            return "redirect:/sell-counter";
        }

        HoaDon hoaDon = hoaDonRepository.findById(idHoaDon).orElse(null);
        if (hoaDon == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn không tồn tại.");
            return "redirect:/sell-counter";
        }

        // Kiểm tra số lượng tồn kho
        if (sanPhamChiTiet.getSoLuong() < soLuong) {
            redirectAttributes.addFlashAttribute("errorMessage", "Số lượng tồn kho không đủ.");
            return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
        }

        // Tạo mới hoặc cập nhật sản phẩm chi tiết trong hóa đơn
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findByHoaDonIdAndSanPhamChiTietId(idHoaDon, idSanPhamChiTiet).orElse(new HoaDonChiTiet());
        hoaDonChiTiet.setHoaDon(hoaDon);
        hoaDonChiTiet.setSanPhamChiTiet(sanPhamChiTiet);
        hoaDonChiTiet.setSoLuong(hoaDonChiTiet.getSoLuong() == null ? soLuong : hoaDonChiTiet.getSoLuong() + soLuong);
        hoaDonChiTiet.setGia(sanPhamChiTiet.getGia().floatValue());
        hoaDonChiTiet.setThanhTien(hoaDonChiTiet.getSoLuong() * hoaDonChiTiet.getGia());
        hoaDonChiTietRepository.save(hoaDonChiTiet);

        // Trừ số lượng tồn kho
        sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() - soLuong);
        sanPhamChiTietRepository.save(sanPhamChiTiet);

        // Cập nhật số lượng tồn kho cho sản phẩm chính
        SanPham sanPham = sanPhamChiTiet.getSanPham();
        updateStockForProduct(sanPham);

        // Cập nhật tổng tiền hóa đơn
        updateInvoiceTotal(idHoaDon);

        redirectAttributes.addFlashAttribute("successMessage", "Thêm sản phẩm vào hóa đơn thành công!");
        return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
    }

    // Phương thức xóa sản phẩm khỏi hóa đơn
    public String deleteProductOrder(Integer idHoaDonChiTiet, Integer idHoaDon, RedirectAttributes redirectAttributes) {
        HoaDonChiTiet hoaDonChiTiet = hoaDonChiTietRepository.findById(idHoaDonChiTiet).orElse(null);
        if (hoaDonChiTiet == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Hóa đơn chi tiết không tồn tại.");
            return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
        }

        // Hoàn trả lại số lượng tồn kho cho sản phẩm chi tiết
        SanPhamChiTiet sanPhamChiTiet = hoaDonChiTiet.getSanPhamChiTiet();
        if (sanPhamChiTiet != null) {
            sanPhamChiTiet.setSoLuong(sanPhamChiTiet.getSoLuong() + hoaDonChiTiet.getSoLuong());
            sanPhamChiTietRepository.save(sanPhamChiTiet);

            // Cập nhật số lượng tồn kho cho sản phẩm chính
            SanPham sanPham = sanPhamChiTiet.getSanPham();
            updateStockForProduct(sanPham);
        }

        // Xóa hóa đơn chi tiết
        hoaDonChiTietRepository.deleteById(idHoaDonChiTiet);
        redirectAttributes.addFlashAttribute("successMessage", "Xóa hóa đơn chi tiết thành công!");

        // Cập nhật tổng tiền hóa đơn
        updateInvoiceTotal(idHoaDon);

        return "redirect:/sell-counter?hoaDonId=" + idHoaDon;
    }

    // Phương thức cập nhật tồn kho cho sản phẩm chính
    private void updateStockForProduct(SanPham sanPham) {
        List<SanPhamChiTiet> listSanPhamChiTiet = sanPhamChiTietRepository.findBySanPham(sanPham);
        int tongSoLuong = listSanPhamChiTiet.stream()
                .filter(spct -> spct.getSoLuong() != null)
                .mapToInt(SanPhamChiTiet::getSoLuong)
                .sum();
        sanPham.setSoLuong(tongSoLuong);
        sanPhamRepository.save(sanPham);
    }

    // Phương thức cập nhật tổng tiền hóa đơn
    private void updateInvoiceTotal(Integer idHoaDon) {
        HoaDon hoaDon = hoaDonRepository.findById(idHoaDon).orElse(null);
        if (hoaDon != null) {
            double tongTien = hoaDonChiTietRepository.findByHoaDonId(idHoaDon).stream()
                    .mapToDouble(HoaDonChiTiet::getThanhTien)
                    .sum();
            hoaDon.setTongTien(tongTien);
            hoaDonRepository.save(hoaDon);
        }
    }
}
