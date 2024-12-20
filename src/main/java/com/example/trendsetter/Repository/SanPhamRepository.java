package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.DanhMuc;
import com.example.trendsetter.Entity.SanPham;
import com.example.trendsetter.Entity.ThuongHieu;
import com.example.trendsetter.Entity.XuatSu;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SanPhamRepository extends JpaRepository<SanPham,Integer> {

    Optional<SanPham> findByTenSanPhamAndDanhMucIdAndThuongHieuIdAndXuatSuId(
            String tenSanPham, Integer idDanhMuc, Integer idThuongHieu, Integer idXuatSu);

    boolean existsByTenSanPhamAndDanhMucIdAndThuongHieuIdAndXuatSuId(String tenSanPham, Integer danhMucId, Integer thuongHieuId, Integer xuatSuId);

}
