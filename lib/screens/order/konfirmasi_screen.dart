import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors.dart';
import '../../../core/data.dart';
import '../../../core/helpers.dart';
import '../../../widgets/shared.dart';
import 'sukses_screen.dart';

class KonfirmasiScreen extends StatelessWidget {
  final JenisModel jenis;
  final LayananModel layanan;
  final int qty, hJ, hL, hS, tot;
  final String metode, jemput;

  const KonfirmasiScreen({
    super.key,
    required this.jenis, required this.layanan,
    required this.qty, required this.hJ, required this.hL,
    required this.hS, required this.tot,
    required this.metode, required this.jemput,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Konfirmasi Pesanan', subtitle: 'Periksa kembali sebelum bayar'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 100),
          child: Column(children: [
            // Hero
            Container(
              padding: const EdgeInsets.all(18), margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(gradient: AppC.darkGrad, borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Container(width: 64, height: 64,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.1), borderRadius: BorderRadius.circular(18)),
                  child: Icon(jenis.icon, size: 30, color: Colors.white.withOpacity(.8))),
                const SizedBox(width: 14),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Pesanan Kamu', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(.45))),
                  Text('${jenis.nama} · ${layanan.nama}',
                    style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text(fmtRp(tot),
                    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: AppC.n2)),
                ]),
              ])),

            _card('Detail Layanan', [
              ['Jenis Bahan', jenis.nama],
              ['Layanan', layanan.nama],
              ['Estimasi Selesai', layanan.durasi],
              ['Penjemputan', jemput == 'sekarang' ? 'Jemput Sekarang' : 'Dijadwalkan'],
            ]),
            _card('Rincian Harga', [
              ['Biaya Bahan (${jenis.nama})', fmtRp(hJ)],
              ['Biaya Layanan (${layanan.nama})', fmtRp(hL)],
              ['Harga per Pasang', fmtRp(hS)],
              ['Jumlah', '× $qty pasang'],
              ['Ongkos Jemput', 'Gratis'],
            ], total: fmtRp(tot)),
            _card('Pembayaran & Alamat', [
              ['Metode Bayar', metode],
              ['Alamat', 'Jl. Sudirman No. 12, Jakarta Pusat 10220'],
            ]),
          ]))),
      ]),
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
        decoration: const BoxDecoration(color: AppC.w, border: Border(top: BorderSide(color: AppC.bdr, width: 1.5))),
        child: PrimaryButton(
          label: 'Bayar & Konfirmasi ${fmtRp(tot)}',
          icon: Icons.check_rounded,
          onTap: () => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const SuksesScreen()), (r) => r.isFirst)))),
    );
  }

  Widget _card(String title, List<List<String>> rows, {String? total}) =>
    Padding(padding: const EdgeInsets.only(bottom: 13),
      child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title.toUpperCase(),
          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppC.mut, letterSpacing: 1)),
        const SizedBox(height: 12),
        ...rows.map((r) => Padding(padding: const EdgeInsets.only(bottom: 9),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(r[0], style: const TextStyle(fontSize: 13, color: AppC.mut)),
            Flexible(child: Text(r[1],
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n8),
              textAlign: TextAlign.right)),
          ]))).toList(),
        if (total != null) ...[
          const Divider(color: AppC.n0, height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Total Bayar', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppC.n7)),
            Text(total, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: AppC.n5)),
          ]),
        ],
      ])));
}