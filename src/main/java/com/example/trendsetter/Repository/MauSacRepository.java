package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.MauSac;
import com.example.trendsetter.Entity.SanPhamChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MauSacRepository extends JpaRepository<MauSac,Integer> {
    void deleteAllBySanPhamChiTiet(SanPhamChiTiet sanPhamChiTiet);

}
