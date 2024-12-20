package com.example.trendsetter.Controller;

import com.example.trendsetter.DTO.ShippingUpdateRequest;
import com.example.trendsetter.Entity.*;
import com.example.trendsetter.Repository.HoaDonRepository;
import com.example.trendsetter.Service.ShopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class ShopController {

    @Autowired
    private ShopService shopService;


    @GetMapping("/sell-counter")
    public String sellCounter(@RequestParam(value = "hoaDonId", required = false) Integer hoaDonId,
                              Model model,
                              RedirectAttributes redirectAttributes) {
        shopService.getHoaDonAndProducts(hoaDonId, model, redirectAttributes);
        return "dashboard"; // Return to the page where the form is rendered
    }

    @PostMapping("/create-hoa-don")
    public String createHoaDon(HoaDon hoaDon, RedirectAttributes redirectAttributes) {
        return shopService.createHoaDon(hoaDon, redirectAttributes);
    }

    @PostMapping("/add-product-order")
    public String addProductOrder(@RequestParam("idSanPhamChiTiet") Integer idSanPhamChiTiet,
                                  @RequestParam("idHoaDon") Integer idHoaDon,
                                  @RequestParam("soLuong") Integer soLuong,
                                  RedirectAttributes redirectAttributes) {
        return shopService.handleProductOrder("add",idSanPhamChiTiet , idHoaDon, soLuong,null, redirectAttributes);
    }

    @PostMapping("/update-product-order")
    public String updateQuantityOrder(@RequestParam("idHoaDonChiTiet") Integer idHoaDonChiTiet,
                                      @RequestParam("soLuong") Integer soLuong,
                                      @RequestParam("idHoaDon") Integer idHoaDon,
                                      RedirectAttributes redirectAttributes) {
        return shopService.handleProductOrder("update", null, idHoaDon, soLuong, idHoaDonChiTiet, redirectAttributes);
    }

    @PostMapping("/delete-product-order")
    public String deleteProductOrder(@RequestParam("idHoaDonChiTiet") Integer idHoaDonChiTiet,
                                     @RequestParam("idHoaDon") Integer idHoaDon,
                                     RedirectAttributes redirectAttributes) {
        return shopService.handleProductOrder("delete", null, idHoaDon, null, idHoaDonChiTiet, redirectAttributes);
    }

    @PostMapping("/add-customer")
    public String addCustomerToInvoice(@RequestParam("hoaDonId") Integer hoaDonId,
                                       @RequestParam("khachHangId") Integer khachHangId,
                                       RedirectAttributes redirectAttributes) {
        return shopService.addCustomerToInvoice(hoaDonId, khachHangId,redirectAttributes);
    }


    @PostMapping("/add-payment-method")
    public String addPaymentMethod(@RequestParam("hoaDonId") Integer hoaDonId,
                                   @RequestParam("phuongThucThanhToan") Integer phuongThucThanhToanId,
                                   RedirectAttributes redirectAttributes) {
        return shopService.addPaymentMethod(hoaDonId, phuongThucThanhToanId, redirectAttributes);
    }

    @PostMapping("/apply-khuyen-mai")
    public String applyKhuyenMai(@RequestParam("hoaDonId") Integer hoaDonId,
                                 @RequestParam("tenChuongTrinh") String tenChuongTrinh,
                                 RedirectAttributes redirectAttributes) {
        return shopService.applyKhuyenMai(hoaDonId, tenChuongTrinh, redirectAttributes);
    }

    @PostMapping("/confirm-payment")
    public String confirmPayment(@RequestParam("hoaDonId") Integer hoaDonId,
                                 RedirectAttributes redirectAttributes) {
        return shopService.confirmPayment(hoaDonId, redirectAttributes);
    }

    @PostMapping("/update-shipping")
    public String updateShipping(@ModelAttribute ShippingUpdateRequest request,
                                 Integer hoaDonId,
                                 RedirectAttributes redirectAttributes) {
        return shopService.updateShippingAddress(request,hoaDonId , redirectAttributes);
    }

}

