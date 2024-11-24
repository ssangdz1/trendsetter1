package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.DanhGia;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DanhGiaRepository extends JpaRepository<DanhGia,Integer> {
}
