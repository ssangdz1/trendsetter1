package com.example.trendsetter.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;


@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "san_pham_chi_tiet")
public class SanPhamChiTiet {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_san_pham",referencedColumnName = "id")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "id_mau_sac",referencedColumnName = "id")
    private MauSac mauSac;

    @ManyToOne
    @JoinColumn(name = "id_kich_thuoc",referencedColumnName = "id")
    private KichThuoc kichThuoc;

    @ManyToOne
    @JoinColumn(name = "id_chat_lieu",referencedColumnName = "id")
    private ChatLieu chatLieu;

    @Column(name = "so_luong")
    private Integer soLuong;

    @Column(name = "trang_thai")
    private String trangThai;

    @Column(name = "gia")
    private Double gia;

    @OneToMany(mappedBy = "sanPhamChiTiet",cascade = CascadeType.ALL)
    private List<HinhAnh> hinhAnh;

}