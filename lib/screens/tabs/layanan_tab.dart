import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../core/helpers.dart';
import '../../widgets/shared.dart';
import '../order/detail_layanan_screen.dart';

class LayananTab extends StatelessWidget {
  const LayananTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Header
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppC.n8,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: Stack(children: [
            Positioned.fill(child: CustomPaint(painter: GridPainter())),
            Positioned(right: -30, top: -30,
              child: Container(width: 200, height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [AppC.n3.withOpacity(.22), Colors.transparent])))),
            Builder(
  builder: (ctx) {
    final top = MediaQuery.of(ctx).padding.top;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, top + 12, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Layanan',
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            'ShoeCare',
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppC.n2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Pilih layanan terbaik untuk sepatumu',
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.white.withOpacity(.42),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 11,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              border: Border.all(
                color: Colors.white.withOpacity(.18),
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: Colors.white54,
                  size: 16,
                ),
                const SizedBox(width: 9),
                Text(
                  'Cari layanan...',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.white.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
),
          ]),
        ),

        // Tabel harga jenis bahan
        Padding(padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
          child: Text('Harga Berdasarkan Jenis Bahan',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n8))),
        const SizedBox(height: 12),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            decoration: AppC.cardDeco(),
            child: Column(children: [
              Container(
                decoration: const BoxDecoration(
                  color: AppC.n7,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(children: jenisData.map((j) => Expanded(child: Column(children: [
                  Icon(j.icon, color: Colors.white.withOpacity(.7), size: 20),
                  const SizedBox(height: 4),
                  Text(j.nama, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 2),
                  Text('+${fmtRp(j.harga)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppC.n2)),
                ]))).toList())),
              Container(
                decoration: const BoxDecoration(
                  color: AppC.n0,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                child: Row(children: [
                  const Icon(Icons.info_outline_rounded, size: 13, color: AppC.n5),
                  const SizedBox(width: 6),
                  Expanded(child: RichText(text: const TextSpan(
                    style: TextStyle(fontSize: 10.5, color: AppC.mut),
                    children: [
                      TextSpan(text: 'Harga akhir = '),
                      TextSpan(text: 'Biaya Jenis Bahan', style: TextStyle(fontWeight: FontWeight.w700, color: AppC.n7)),
                      TextSpan(text: ' + '),
                      TextSpan(text: 'Biaya Layanan', style: TextStyle(fontWeight: FontWeight.w700, color: AppC.n7)),
                    ]))),
                ])),
            ]))),

        // List layanan
        Padding(padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
          child: Text('Pilih Layanan',
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n8))),
        const SizedBox(height: 12),
        ...layananData.map((s) {
          final hMin = jenisData[0].harga + s.tambah;
          final hMax = jenisData[3].harga + s.tambah;
          return Padding(padding: const EdgeInsets.fromLTRB(18, 0, 18, 12),
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailLayananScreen(layanan: s))),
              child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Container(width: 54, height: 54,
                    decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(16)),
                    child: Icon(s.icon, color: AppC.n5, size: 24)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(s.nama, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n8)),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(8)),
                        child: Text(s.badge, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppC.n5))),
                    ]),
                    const SizedBox(height: 3),
                    Text(s.desk, style: const TextStyle(fontSize: 12, color: AppC.mut, height: 1.45), maxLines: 2, overflow: TextOverflow.ellipsis),
                  ])),
                ]),
                const SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Mulai dari', style: TextStyle(fontSize: 10, color: AppC.mut)),
                    RichText(text: TextSpan(
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppC.n5),
                      children: [
                        TextSpan(text: fmtRp(hMin)),
                        TextSpan(text: '  —  ${fmtRp(hMax)}',
                          style: const TextStyle(fontSize: 11, color: AppC.mut, fontWeight: FontWeight.w500)),
                      ])),
                  ]),
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                      decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(8)),
                      child: Row(children: [
                        const Icon(Icons.access_time_rounded, size: 10, color: AppC.mut),
                        const SizedBox(width: 4),
                        Text(s.durasi, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppC.mut)),
                      ])),
                    const SizedBox(width: 6),
                    const Icon(Icons.chevron_right_rounded, size: 17, color: AppC.mut),
                  ]),
                ]),
                const SizedBox(height: 12),
                const Divider(color: AppC.n0, height: 1),
                const SizedBox(height: 10),
                Wrap(spacing: 6, runSpacing: 6,
                  children: s.ket.map((k) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(20)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.check_rounded, size: 10, color: AppC.n5),
                      const SizedBox(width: 4),
                      Text(k, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppC.n6)),
                    ]))).toList()),
              ]))));
        }).toList(),
        const SizedBox(height: 20),
      ]),
    );
  }
}