package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.MaGiamGia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MaGiamGiaRepository extends JpaRepository<MaGiamGia,Integer> {
}
