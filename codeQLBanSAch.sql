create database QLBanSach;
use QLBanSach;
create table if not exists KhachHang (
	ma_KH int ,
	ho_ten varchar(100),
	tai_khoan varchar(100),
    mat_khau varchar(20),
    email varchar(100),
    dia_chi varchar(100),
    dien_thoai varchar(20),
    gioi_tinh varchar(10),
    ngay_sinh datetime,
    primary key (ma_KH)
);
alter table KhachHang
	MODIFY COLUMN ma_KH int not null,
    MODIFY COLUMN ho_ten varchar(100) not null,
    MODIFY COLUMN tai_khoan varchar(100) not null,
    MODIFY COLUMN mat_khau varchar(20) not null;
 
create table if not exists DonHang (
	ma_don_hang int,
    da_thanh_toan boolean,
    ngay_giao datetime,
    ngay_dat datetime,
    tinh_trang_giao_hang varchar(200),
    primary key(ma_don_hang)
);
alter table DonHang
	MODIFY COLUMN ma_don_hang int not null;
 
create table if not exists ChuDe(
	ma_chu_de int,
    ten_chu_de varchar(100),
    primary key(ma_chu_de)
);
alter table ChuDe
	MODIFY COLUMN ma_chu_de int not null,
	MODIFY COLUMN ten_chu_de varchar(100) not null;
create table if not exists TacGia(
	ma_tac_gia int,
    ten_tac_gia varchar(100),
    dien_thoai varchar(20),
    dia_chi varchar(100),
    tieu_su varchar(100),
    primary key(ma_tac_gia)
);
alter table TacGia
	MODIFY COLUMN ma_tac_gia int not null,
	MODIFY COLUMN ten_tac_gia varchar(100) not null;
create table if not exists Sach(
	ma_sach int not null,
    ten_sach varchar(100) not null,
    gia_ban varchar(20),
    mo_ta varchar(100),
    anh_bia binary,
    ngay_cap_nhat datetime,
    so_luong_ton int
);

create table if not exists NhaXuatBan (
	ma_nxb int not null,
    ten_nxb varchar(100) not null,
    dia_chi varchar(100),
    dien_thoai varchar(20)
);

alter table Sach 
	add column ma_chu_de_chon int,
    add constraint fk_machude_machudechon 
    foreign key (ma_chu_de_chon) references ChuDe(ma_chu_de);
alter table Sach 
	add column ma_nxb_lam int,
    add constraint fk_manxb_manxblam 
    foreign key (ma_nxb_lam) references NhaXuatBan(ma_nxb);
alter table Sach
	add primary key (ma_sach);
alter table NhaXuatBan
	add primary key (ma_nxb);
    
alter table DonHang 
	add column ma_kh_mua int,
    add constraint fk_makh_makhmua 
    foreign key (ma_kh_mua) references KhachHang(ma_KH);
 
create table if not exists chi_tiet_don_hang(
	ma_don_hang int not null,
	ma_sach int not null,
	so_luong int not null,
	don_gia float not null default 0,
	primary key (ma_don_hang,ma_sach)
);

create table if not exists chi_tiet_tac_gia(
	ma_tac_gia int not null,
	ma_sach int not null,
	vai_tro varchar(255) not null,
	vi_tri varchar(255) not null,
	primary key (ma_tac_gia,ma_sach)
);

alter table chi_tiet_don_hang
add constraint fk_chi_tiet_don_hang_don_hang
foreign key (ma_don_hang) references DonHang(ma_don_hang);
alter table chi_tiet_don_hang
add constraint fk_chi_tiet_don_hang_sach
foreign key (ma_sach) references Sach(ma_sach);

alter table chi_tiet_tac_gia
add constraint fk_chi_tiet_tac_gia_tac_gia
foreign key (ma_tac_gia) references TacGia(ma_tac_gia);
alter table chi_tiet_tac_gia
add constraint fk_chi_tiet_tac_gia_sach
foreign key (ma_sach) references Sach(ma_sach);