package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.KichThuoc;
import com.example.trendsetter.Entity.SanPhamChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface KichThuocRepository extends JpaRepository<KichThuoc,Integer> {
    boolean existsByTenKichThuoc(String tenKichThuoc);
}
