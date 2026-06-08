import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../core/helpers.dart';
import '../../widgets/shared.dart';
import '../lacak_screen.dart';
import 'nilai_order_screen.dart';

class DetailRiwayatScreen extends StatelessWidget {
  final RiwayatModel item;
  const DetailRiwayatScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        NavyHeader(title: 'Detail Pesanan', subtitle: item.id),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            // Hero
            Container(
              padding: const EdgeInsets.all(20), margin: const EdgeInsets.only(bottom: 14),
              decoration: BoxDecoration(gradient: AppC.darkGrad, borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Container(width: 72, height: 72,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.1), borderRadius: BorderRadius.circular(18)),
                  child: Icon(item.icon, size: 34, color: Colors.white)),
                const SizedBox(width: 16),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item.layanan,
                    style: GoogleFonts.poppins(fontSize: 19, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 3),
                  Text(item.id, style: TextStyle(fontSize: 11.5, color: Colors.white.withOpacity(.45))),
                  const SizedBox(height: 4),
                  Text(fmtRp(item.harga),
                    style: GoogleFonts.poppins(fontSize: 21, fontWeight: FontWeight.w800, color: AppC.n2)),
                ])),
              ])),

            AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('INFORMASI PESANAN',
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppC.mut, letterSpacing: 1)),
              const SizedBox(height: 12),
              ...[
                ['Layanan',    item.layanan],
                ['Jenis Bahan', item.jenis],
                ['Item',       item.items],
                ['Tanggal',    item.tgl],
                ['Total',      fmtRp(item.harga)],
              ].map((r) => Padding(padding: const EdgeInsets.only(bottom: 9),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(r[0], style: const TextStyle(fontSize: 13, color: AppC.mut)),
                  Flexible(child: Text(r[1],
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                      color: r[0] == 'Total' ? AppC.n5 : AppC.n8),
                    textAlign: TextAlign.right)),
                ]))).toList(),
              Padding(padding: const EdgeInsets.only(bottom: 9),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text('Status', style: TextStyle(fontSize: 13, color: AppC.mut)),
                  StatusChip(status: item.status),
                ])),
            ])),
            const SizedBox(height: 11),

            AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('INFORMASI KURIR',
                style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppC.mut, letterSpacing: 1)),
              const SizedBox(height: 12),
              ...[
                ['Nama',   item.kurir],
                ['No. HP', item.no],
                ['Alamat', item.alamat],
              ].map((r) => Padding(padding: const EdgeInsets.only(bottom: 9),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(r[0], style: const TextStyle(fontSize: 13, color: AppC.mut)),
                  Flexible(child: Text(r[1],
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n8),
                    textAlign: TextAlign.right)),
                ]))).toList(),
            ])),
            const SizedBox(height: 14),

            item.status == 'selesai'
              ? PrimaryButton(
                  label: 'Beri Penilaian', icon: Icons.star_outline_rounded,
                  onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => NilaiOrderScreen(item: item))))
              : PrimaryButton(
                  label: 'Lacak Pesanan', icon: Icons.navigation_rounded,
                  onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LacakScreen()))),
          ]))),
      ]));
  }
}