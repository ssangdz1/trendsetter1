package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.HoaDon;
import com.example.trendsetter.Entity.HoaDonChiTiet;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Entity.SanPhamChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HoaDonRepository extends JpaRepository<HoaDon,Integer> {
    // Đếm số lượng hóa đơn có trạng thái cụ thể
    long countByTrangThai(String trangThai);

    // Lấy danh sách hóa đơn theo trạng thái
    List<HoaDon> findByTrangThai(String trangThai);
}
