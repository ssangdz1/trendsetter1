package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.SanPhamChiTiet;
import jakarta.persistence.criteria.From;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet,Integer>{
    @Query("SELECT sp FROM SanPhamChiTiet sp JOIN FETCH sp.hinhAnh ha JOIN FETCH sp.chatLieu cl JOIN FETCH sp.mauSac ms JOIN FETCH sp.kichThuoc kt")
    List<SanPhamChiTiet> findAllWithDetails();
}
