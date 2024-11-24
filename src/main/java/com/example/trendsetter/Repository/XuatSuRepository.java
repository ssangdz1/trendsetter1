package com.example.trendsetter.Repository;

import com.example.trendsetter.Entity.XuatSu;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface XuatSuRepository extends JpaRepository<XuatSu,Integer> {
}
