import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class SyaratScreen extends StatelessWidget {
  const SyaratScreen({super.key});

  static const _secs = [
    ['1. Penerimaan Syarat',       'Dengan menggunakan aplikasi ShoeCare, kamu setuju terikat pada syarat dan ketentuan ini. Harap baca dengan seksama sebelum menggunakan layanan kami.'],
    ['2. Layanan Kami',            'ShoeCare menyediakan layanan cuci, restorasi, dan perawatan sepatu. Kami berhak mengubah, menambah, atau menghentikan layanan kapan saja tanpa pemberitahuan.'],
    ['3. Tanggung Jawab Pengguna', 'Pengguna bertanggung jawab atas keakuratan informasi yang diberikan, keamanan akun, dan segala aktivitas yang terjadi melalui akun mereka.'],
    ['4. Kebijakan Privasi',       'Data pribadi kamu aman bersama kami. Kami tidak menjual, menyewakan, atau membagi data pribadi kepada pihak ketiga tanpa persetujuanmu.'],
    ['5. Garansi & Klaim',         'Kami memberikan garansi kepuasan untuk semua layanan. Klaim dapat diajukan dalam 48 jam setelah sepatu diterima dengan bukti foto yang valid.'],
    ['6. Perubahan Syarat',        'ShoeCare berhak mengubah syarat ini kapan saja. Penggunaan layanan setelah perubahan berarti persetujuanmu atas syarat yang baru.'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Syarat & Ketentuan', subtitle: 'Terakhir diperbarui: 1 Maret 2024'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: _secs.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s[0], style: GoogleFonts.fraunces(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n8)),
              const SizedBox(height: 7),
              Text(s[1], style: const TextStyle(fontSize: 13, color: AppC.mut, height: 1.7)),
            ]))).toList())),
      ]));
  }
}