package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.ChatLieu;
import com.example.trendsetter.Entity.SanPhamChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ChatLieuRepository extends JpaRepository<ChatLieu,Integer> {
    void deleteAllBySanPhamChiTiet(SanPhamChiTiet sanPhamChiTiet);

}
