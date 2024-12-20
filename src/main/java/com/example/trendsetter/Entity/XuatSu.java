package com.example.trendsetter.Entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "xuat_su")
public class XuatSu {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank(message = "Quốc gia không được để trống")
    @Size(max = 100, message = "Quốc gia không được vượt quá 100 ký tự")
    @Column(name = "quoc_gia")
    private String quocGia;
}
