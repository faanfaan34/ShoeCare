import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors.dart';
import '../../../core/data.dart';
import '../../../core/helpers.dart';
import '../../../widgets/shared.dart';
import 'form_pesan_screen.dart';

class DetailLayananScreen extends StatelessWidget {
  final LayananModel layanan;
  const DetailLayananScreen({super.key, required this.layanan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        NavyHeader(title: 'Detail ${layanan.nama}', subtitle: 'Informasi lengkap layanan'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 100),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Hero icon
            Container(
              width: double.infinity, padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(20)),
              child: Icon(layanan.icon, color: AppC.n5, size: 72)),
            const SizedBox(height: 18),
            Text(layanan.nama,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: AppC.n8)),
            const SizedBox(height: 6),
            RichText(text: TextSpan(
              style: const TextStyle(fontSize: 13, color: AppC.mut),
              children: [
                const TextSpan(text: 'Biaya layanan: '),
                TextSpan(text: '+${fmtRp(layanan.tambah)}',
                  style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: AppC.n5)),
              ])),
            const SizedBox(height: 6),
            const Text('Harga akhir tergantung jenis bahan sepatu yang dipilih',
              style: TextStyle(fontSize: 12, color: AppC.mut)),
            const SizedBox(height: 16),

            // Tabel harga per jenis
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
              child: Column(children: [
                const Text('ESTIMASI HARGA PER PASANG',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppC.n7, letterSpacing: 1)),
                const SizedBox(height: 10),
                ...jenisData.map((j) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(children: [
                    Container(width: 26, height: 26,
                      decoration: BoxDecoration(color: AppC.w, borderRadius: BorderRadius.circular(8)),
                      child: Icon(j.icon, size: 14, color: AppC.n5)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(j.nama,
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppC.n8))),
                    Text('${fmtRp(j.harga)} + ${fmtRp(layanan.tambah)}',
                      style: const TextStyle(fontSize: 11, color: AppC.mut)),
                    const SizedBox(width: 6),
                    Text('= ${fmtRp(j.harga + layanan.tambah)}',
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppC.n5)),
                  ]))).toList(),
              ])),
            const SizedBox(height: 16),

            // Tags
            Wrap(spacing: 8, runSpacing: 8, children: [
              _tag(Icons.access_time_rounded,    layanan.durasi),
              _tag(Icons.emoji_events_rounded,   layanan.badge),
              _tag(Icons.security_rounded,       'Bergaransi'),
              _tag(Icons.local_shipping_rounded, 'Jemput Antar'),
            ]),
            const SizedBox(height: 16),
            Text(layanan.desk, style: const TextStyle(fontSize: 13.5, color: AppC.mut, height: 1.7)),
            const SizedBox(height: 18),

            Text('Yang Kamu Dapatkan',
              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: AppC.n8)),
            const SizedBox(height: 12),
            ...layanan.ket.map((k) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Container(width: 24, height: 24,
                  decoration: BoxDecoration(color: AppC.n7, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.check_rounded, size: 13, color: Colors.white)),
                const SizedBox(width: 10),
                Text(k, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: AppC.n7)),
              ]))).toList(),
          ]))),
      ]),
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
        decoration: const BoxDecoration(
          color: AppC.w, border: Border(top: BorderSide(color: AppC.bdr, width: 1.5))),
        child: PrimaryButton(
          label: 'Pesan Sekarang',
          icon: Icons.shopping_bag_rounded,
          onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => FormPesanScreen(layanan: layanan)))))),
    );
  }

  Widget _tag(IconData icon, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 12, color: AppC.n6),
      const SizedBox(width: 5),
      Text(label, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppC.n6)),
    ]));
}