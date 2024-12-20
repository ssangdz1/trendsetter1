package com.example.trendsetter.Service;

import com.example.trendsetter.Entity.HoaDon;
import org.springframework.stereotype.Service;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
@Service
public class PdfService {
    public File generateInvoicePdf(HoaDon hoaDon) throws IOException {
        // Đường dẫn file PDF (có thể cấu hình để lưu tại nơi khác)
        String pdfPath = "invoices/hoa_don_" + hoaDon.getId() + ".pdf";
        File file = new File(pdfPath);

        // Tạo thư mục nếu chưa tồn tại
        file.getParentFile().mkdirs();

        // Khởi tạo iText PdfWriter
        try (PdfWriter writer = new PdfWriter(new FileOutputStream(file))) {
            PdfDocument pdf = new PdfDocument(writer);
            Document document = new Document(pdf);

            // Thêm nội dung vào PDF
            document.add(new Paragraph("HÓA ĐƠN THANH TOÁN")
                    .setBold().setFontSize(16));
            document.add(new Paragraph("Mã hóa đơn: " + hoaDon.getId()));
            document.add(new Paragraph("Khách hàng: " + hoaDon.getKhachHang().getHoTen()));
            document.add(new Paragraph("Ngày tạo: " + hoaDon.getNgayTao()));
            document.add(new Paragraph("Tổng tiền: " + hoaDon.getTongTien() + " VND"));

            // Kiểm tra khuyến mãi
            if (hoaDon.getKhuyenMai() != null) {
                document.add(new Paragraph("Khuyến mãi: " + hoaDon.getKhuyenMai().getTenChuongTrinh()));
                document.add(new Paragraph("Giảm giá: " + hoaDon.getKhuyenMai().getGiaTri() + " VND"));
            }

            document.add(new Paragraph("Trạng thái: " + hoaDon.getTrangThai()));
            document.close();
        }

        return file;
    }
}
