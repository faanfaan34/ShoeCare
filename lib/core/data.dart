import 'package:flutter/material.dart';
import 'colors.dart';

// ─── MODELS ───────────────────────────────────

class LayananModel {
  final int id, tambah;
  final IconData icon;
  final String nama, desk, durasi, badge;
  final List<String> ket;
  const LayananModel({
    required this.id, required this.icon, required this.nama,
    required this.desk, required this.tambah, required this.durasi,
    required this.badge, required this.ket,
  });
}

class JenisModel {
  final String id, nama, desk, tips;
  final IconData icon;
  final int harga;
  final Color bg, icColor;
  const JenisModel({
    required this.id, required this.icon, required this.nama,
    required this.desk, required this.harga,
    required this.bg, required this.icColor, required this.tips,
  });
}

class RiwayatModel {
  final String id, layanan, jenis, items, tgl, status, kurir, no, alamat;
  final IconData icon;
  final int harga;
  const RiwayatModel({
    required this.id, required this.icon, required this.layanan,
    required this.jenis, required this.items, required this.tgl,
    required this.harga, required this.status, required this.kurir,
    required this.no, required this.alamat,
  });
}

class PaymentModel {
  final IconData icon;
  final String nama, detail;
  const PaymentModel({required this.icon, required this.nama, required this.detail});
}

// ─── MOCK DATA ────────────────────────────────

final List<LayananModel> layananData = [
  LayananModel(
    id: 1, icon: Icons.water_drop_rounded, nama: 'Reguler',
    desk: 'Pencucian standar menyeluruh menggunakan deterjen premium. Cocok untuk perawatan rutin sepatu sehari-hari.',
    tambah: 20000, durasi: '3 Hari', badge: 'Terpopuler',
    ket: ['Cuci bagian luar & dalam', 'Sikat sol & upper', 'Pengeringan alami', 'Finishing & pewangi'],
  ),
  LayananModel(
    id: 2, icon: Icons.bolt_rounded, nama: 'Fast Clean',
    desk: 'Proses kilat selesai dalam 24 jam tanpa mengorbankan kualitas. Solusi tepat saat kamu butuh cepat.',
    tambah: 40000, durasi: '24 Jam', badge: 'Tercepat',
    ket: ['Semua proses cuci reguler', 'Antrian prioritas utama', 'Notifikasi real-time', 'Pengiriman ekspres'],
  ),
  LayananModel(
    id: 3, icon: Icons.auto_awesome_rounded, nama: 'Deep Clean',
    desk: 'Pembersihan menyeluruh hingga ke lapisan terdalam — sol, insole, tali, dan upper. Hasilnya seperti baru dari toko.',
    tambah: 55000, durasi: '2 Hari', badge: 'Premium',
    ket: ['Cuci ultra-sonic', 'Bersihkan insole & tali', 'Sterilisasi UV', 'Deodorizer premium anti-jamur'],
  ),
  LayananModel(
    id: 4, icon: Icons.wb_sunny_rounded, nama: 'Unyellowing',
    desk: 'Memutihkan sol yang menguning kembali ke warna kristal aslinya. Teknologi H₂O₂ aman dan teruji.',
    tambah: 30000, durasi: '2 Hari', badge: 'Sol Putih',
    ket: ['Formula H₂O₂ aman', 'Plastik wrap + paparan UV', 'Sol kembali kristal putih', 'Aman untuk semua jenis bahan'],
  ),
];

final List<JenisModel> jenisData = [
  JenisModel(id: 'canvas',  icon: Icons.grid_view_rounded,  nama: 'Canvas',  desk: 'Kanvas, kain, rajut',        harga: 15000, bg: AppC.n0,                    icColor: AppC.n5,                 tips: 'Hindari sikat keras di area kain'),
  JenisModel(id: 'leather', icon: Icons.layers_rounded,     nama: 'Leather', desk: 'Kulit asli & sintetis',       harga: 30000, bg: const Color(0xFFFFF8F0),     icColor: const Color(0xFF8B5A2B), tips: 'Gunakan kondisioner setelah cuci'),
  JenisModel(id: 'mesh',    icon: Icons.air_rounded,        nama: 'Mesh',    desk: 'Jaring, anyaman, ventilasi',  harga: 20000, bg: const Color(0xFFF0FFF4),     icColor: const Color(0xFF1B6B3A), tips: 'Keringkan sempurna agar tidak bau'),
  JenisModel(id: 'suede',   icon: Icons.brush_rounded,      nama: 'Suede',   desk: 'Beludru, nubuck, velour',     harga: 35000, bg: const Color(0xFFF5F0FF),     icColor: const Color(0xFF6B21A8), tips: 'Tidak disarankan untuk layanan basah biasa'),
];

final List<RiwayatModel> riwayatData = [
  RiwayatModel(id: 'SC-0324-01', icon: Icons.auto_awesome_rounded, layanan: 'Deep Clean',  jenis: 'Canvas',  items: 'Nike Air Force 1 · 1 Pasang',  tgl: '15 Mar 2024', harga: 70000,  status: 'selesai',  kurir: 'Budi S.',  no: '0812-3456', alamat: 'Jl. Sudirman No. 12, Jakarta'),
  RiwayatModel(id: 'SC-0324-02', icon: Icons.bolt_rounded,         layanan: 'Fast Clean',  jenis: 'Leather', items: 'Adidas Stan Smith · 2 Pasang', tgl: '18 Mar 2024', harga: 140000, status: 'diproses', kurir: 'Andi R.',  no: '0811-2233', alamat: 'Jl. Sudirman No. 12, Jakarta'),
  RiwayatModel(id: 'SC-0324-03', icon: Icons.water_drop_rounded,   layanan: 'Reguler',     jenis: 'Mesh',    items: 'Vans Old Skool · 1 Pasang',    tgl: '10 Mar 2024', harga: 55000,  status: 'dijemput', kurir: 'Rudi P.',  no: '0813-5566', alamat: 'Jl. Sudirman No. 12, Jakarta'),
  RiwayatModel(id: 'SC-0324-04', icon: Icons.wb_sunny_rounded,     layanan: 'Unyellowing', jenis: 'Canvas',  items: 'Converse Chuck · 1 Pasang',    tgl: '5 Mar 2024',  harga: 45000,  status: 'selesai',  kurir: 'Siti M.',  no: '0814-7788', alamat: 'Jl. Sudirman No. 12, Jakarta'),
  RiwayatModel(id: 'SC-0324-05', icon: Icons.auto_awesome_rounded, layanan: 'Deep Clean',  jenis: 'Suede',   items: 'New Balance 574 · 1 Pasang',   tgl: '28 Feb 2024', harga: 90000,  status: 'selesai',  kurir: 'Budi S.',  no: '0812-3456', alamat: 'Jl. Sudirman No. 12, Jakarta'),
];

final List<PaymentModel> paymentData = [
  PaymentModel(icon: Icons.account_balance_wallet_rounded, nama: 'GoPay',             detail: '•••• 3421'),
  PaymentModel(icon: Icons.account_balance_wallet_rounded, nama: 'OVO',               detail: '•••• 7890'),
  PaymentModel(icon: Icons.account_balance_rounded,        nama: 'Transfer Bank BCA', detail: '•••• 5566'),
];

final List<Map<String, String>> sepatuData = [
  {'nama': 'Nike Air Force 1',  'warna': 'Putih',       'ukuran': '42', 'terakhir': '15 Mar 2024'},
  {'nama': 'Adidas Stan Smith', 'warna': 'Putih/Hijau', 'ukuran': '41', 'terakhir': '18 Mar 2024'},
  {'nama': 'Vans Old Skool',    'warna': 'Hitam/Putih', 'ukuran': '42', 'terakhir': '10 Mar 2024'},
  {'nama': 'Converse Chuck 70', 'warna': 'Merah',       'ukuran': '43', 'terakhir': '5 Mar 2024'},
];