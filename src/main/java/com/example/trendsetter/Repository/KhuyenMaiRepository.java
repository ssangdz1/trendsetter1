package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.KhuyenMai;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface KhuyenMaiRepository extends JpaRepository<KhuyenMai,Integer> {
    Optional<KhuyenMai> findByTenChuongTrinh(String tenChuongTrinh);
}
