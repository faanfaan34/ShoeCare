import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../core/helpers.dart';
import '../../widgets/shared.dart';
import '../notifikasi_screen.dart';
import '../lacak_screen.dart';
import '../order/detail_layanan_screen.dart';
import '../order/form_pesan_screen.dart';
import '../bantuan_screen.dart';

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  void _push(BuildContext ctx, Widget w) =>
      Navigator.push(ctx, MaterialPageRoute(builder: (_) => w));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // ── Header ──
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppC.n8,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: Stack(children: [
            Positioned.fill(child: CustomPaint(painter: GridPainter())),
            Positioned(right: -20, top: -20,
              child: Container(width: 200, height: 200,
                decoration: BoxDecoration(shape: BoxShape.circle,
                  gradient: RadialGradient(colors: [AppC.n3.withOpacity(.24), Colors.transparent])))),
            Builder(
              builder: (ctx) {
                final top = MediaQuery.of(ctx).padding.top;

                return Padding(
                  padding: EdgeInsets.fromLTRB(20, top + 12, 20, 22),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // isi row avatar
                        ],
                      ),
                      const SizedBox(height: 18),
                      GestureDetector(
                        onTap: () => _push(context, const LacakScreen()),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.09),
                            border: Border.all(
                              color: Colors.white.withOpacity(.13),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: AppC.n5,
                                  borderRadius: BorderRadius.circular(13),
                                ),
                                child: const Icon(
                                  Icons.bolt_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Pesanan Aktif · SC-0324-02',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        color: Colors.white.withOpacity(.42),
                                      ),
                                    ),
                                    const Text(
                                      'Fast Clean · 2 Pasang',
                                      style: TextStyle(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 11,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppC.n3.withOpacity(.22),
                                  border: Border.all(
                                    color: AppC.n3.withOpacity(.45),
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Diproses',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppC.n2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ]),
        ),

        // ── Aksi Cepat ──
        Padding(padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
          child: const SectionTitle(title: 'Aksi Cepat')),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(children: [
            _quickAction(context, Icons.water_drop_rounded,    'Cuci\nSekarang',  () {}),
            _quickAction(context, Icons.local_shipping_rounded, 'Jemput\nSepatu', () => _push(context, FormPesanScreen())),
            _quickAction(context, Icons.inventory_2_rounded,   'Lacak\nPesanan', () => _push(context, const LacakScreen())),
            _quickAction(context, Icons.chat_bubble_rounded,   'Chat\nCS',        () => _push(context, const BantuanScreen())),
          ])),

        // ── Penawaran ──
        Padding(padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
          child: const SectionTitle(title: 'Penawaran')),
        SizedBox(height: 175, child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          children: [
            _promoCard('Hari Ini',      'Cuci 2 Pasang\nGratis Ongkos\nJemput!', Icons.local_shipping_rounded),
            const SizedBox(width: 12),
            _promoCard('Teknologi Baru','UV Sanitize\nGratis Bersama\nDeep Clean!', Icons.auto_awesome_rounded),
          ])),

        // ── Layanan ──
        Padding(padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
          child: SectionTitle(title: 'Layanan Kami', action: 'Lihat Semua', onAction: () {})),
        SizedBox(height: 148, child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          itemCount: layananData.length,
          separatorBuilder: (_, __) => const SizedBox(width: 11),
          itemBuilder: (ctx, i) {
            final s = layananData[i];
            final minPrice = jenisData[0].harga + s.tambah;
            return GestureDetector(
              onTap: () => _push(ctx, DetailLayananScreen(layanan: s)),
              child: Container(
                width: 126,
                padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
                decoration: AppC.cardDeco(r: 18).copyWith(
                  border: i == 1 ? Border.all(color: AppC.n5, width: 2) : null),
                child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  if (i == 1) Align(alignment: Alignment.topRight,
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppC.n7, borderRadius: BorderRadius.circular(5)),
                      child: const Text('TERLARIS', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)))),
                  Container(width: 48, height: 48,
                    decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(15)),
                    child: Icon(s.icon, color: AppC.n5, size: 22)),
                  Text(s.nama, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppC.n7), textAlign: TextAlign.center),
                  Text('Mulai ${fmtRp(minPrice)}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppC.n5)),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Icon(Icons.access_time_rounded, size: 10, color: AppC.mut),
                    const SizedBox(width: 3),
                    Text(s.durasi, style: const TextStyle(fontSize: 10, color: AppC.mut)),
                  ]),
                ])));
          })),

        // ── Spesialis ──
        Padding(padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
          child: SectionTitle(title: 'Spesialis Terdekat', action: 'Lihat Semua', onAction: () {})),
        ...[
          {'initials': 'AF', 'nm': 'Ahmad Farhan', 'dt': 'Spesialis Sneakers · 5 Thn', 'rat': '4.9', 'dist': '0.8 km'},
          {'initials': 'SR', 'nm': 'Siti Rahayu',  'dt': 'Spesialis Kulit & Suede · 7 Thn', 'rat': '5.0', 'dist': '1.2 km'},
        ].map((sp) => Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
          child: AppCard(child: Row(children: [
            Container(width: 50, height: 50,
              decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
              child: Center(child: Text(sp['initials']!,
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n5)))),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(sp['nm']!, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppC.n8)),
              Text(sp['dt']!, style: const TextStyle(fontSize: 11.5, color: AppC.mut)),
            ])),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  const Icon(Icons.star_rounded, size: 11, color: AppC.n5),
                  const SizedBox(width: 3),
                  Text(sp['rat']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppC.n5)),
                ])),
              const SizedBox(height: 4),
              Row(children: [
                const Icon(Icons.location_on_rounded, size: 11, color: AppC.mut),
                Text(sp['dist']!, style: const TextStyle(fontSize: 11, color: AppC.mut)),
              ]),
            ]),
          ])))).toList(),
        const SizedBox(height: 20),
      ]),
    );
  }

  Widget _quickAction(BuildContext ctx, IconData icon, String label, VoidCallback onTap) =>
    Expanded(child: GestureDetector(onTap: onTap, child: Column(children: [
      Container(width: 54, height: 54,
        decoration: AppC.cardDeco(r: 17),
        child: Icon(icon, color: AppC.n5, size: 22)),
      const SizedBox(height: 7),
      Text(label, textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppC.n7, height: 1.3)),
    ])));

  Widget _promoCard(String eye, String title, IconData icon) =>
    Container(width: 270, padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: BoxDecoration(gradient: AppC.darkGrad, borderRadius: BorderRadius.circular(20)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          Text(eye.toUpperCase(),
            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 2, color: AppC.n2)),
          const SizedBox(height: 4),
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white, height: 1.25)),
          const SizedBox(height: 10),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppC.n5, borderRadius: BorderRadius.circular(20)),
            child: const Text('Pakai Sekarang', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white))),
        ])),
        const SizedBox(width: 8),
        Icon(icon, color: Colors.white.withOpacity(.18), size: 52),
      ]));
}