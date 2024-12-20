package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.*;
import jakarta.transaction.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet,Integer>{
    @Modifying
    @Transactional
    @Query("DELETE FROM SanPhamChiTiet sp WHERE sp.sanPham.id = :sanPhamId")
    void deleteBySanPhamId(@Param("sanPhamId") Integer sanPhamId);

    List<SanPhamChiTiet> findBySanPham(SanPham sanPham);

    Optional<SanPhamChiTiet> findByMauSacAndKichThuocAndChatLieu(
            MauSac mauSac, KichThuoc kichThuoc, ChatLieu chatLieu);
}
