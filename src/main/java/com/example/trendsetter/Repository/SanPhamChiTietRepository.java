package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.SanPhamChiTiet;
import jakarta.persistence.criteria.From;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface SanPhamChiTietRepository extends JpaRepository<SanPhamChiTiet,Integer>{
}
