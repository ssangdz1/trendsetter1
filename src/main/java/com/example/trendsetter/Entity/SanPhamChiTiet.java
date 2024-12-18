package com.example.trendsetter.Entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
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

    @Column(name = "gia_ban")
    private Double giaBan;

    @Column(name = "so_luong")
    private Integer soLuong;

    @Column(name = "ngay_tao")
    private LocalDateTime ngayTao;

    @Column(name = "ngay_sua")
    private LocalDateTime ngaySua;

    @Column(name = "trang_thai")
    private String trangThai;

    @ManyToOne
    @JoinColumn(name = "id_san_pham",referencedColumnName = "id")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "id_thuong_hieu",referencedColumnName = "id")
    private ThuongHieu thuongHieu;

    @ManyToOne
    @JoinColumn(name = "id_xuat_su",referencedColumnName = "id")
    private XuatSu xuatSu;

    @OneToMany(mappedBy = "sanPhamChiTiet")
    private List<HinhAnh> hinhAnh;

    @OneToMany(mappedBy = "sanPhamChiTiet")
    private List<ChatLieu> chatLieu;

    @OneToMany(mappedBy = "sanPhamChiTiet")
    private List<MauSac> mauSac;

    @OneToMany(mappedBy = "sanPhamChiTiet")
    private List<KichThuoc> kichThuoc;
}