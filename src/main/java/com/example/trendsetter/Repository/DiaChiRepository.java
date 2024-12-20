package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.DiaChi;
import com.example.trendsetter.Entity.KhachHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DiaChiRepository extends JpaRepository<DiaChi,Integer> {
    @Query("""
        SELECT new com.example.trendsetter.Entity.DiaChi(
                dc.id,
                dc.soNha,
                dc.phuong,
                dc.huyen,
                dc.thanhPho,
                dc.trangThai,
                dc.khachHang
        )FROM DiaChi dc
""")
    public List<DiaChi> getAllBy();

    List<DiaChi> findByKhachHangIdAndTrangThaiFalse(Integer khachHangId);  // Trang thái là 0
}
