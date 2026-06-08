import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../core/helpers.dart';
import '../../widgets/shared.dart';
import '../lacak_screen.dart';
import '../order/detail_riwayat_screen.dart';
import '../order/nilai_order_screen.dart';

class RiwayatTab extends StatefulWidget {
  const RiwayatTab({super.key});
  @override
  State<RiwayatTab> createState() => _RiwayatTabState();
}

class _RiwayatTabState extends State<RiwayatTab> {
  String _filter = 'semua';

  List<RiwayatModel> get _shown {
    if (_filter == 'aktif')   return riwayatData.where((r) => r.status != 'selesai').toList();
    if (_filter == 'selesai') return riwayatData.where((r) => r.status == 'selesai').toList();
    return riwayatData;
  }

  void _push(Widget w) => Navigator.push(context, MaterialPageRoute(builder: (_) => w));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // Header
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppC.n8,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(24))),
          child: Stack(children: [
            Positioned.fill(child: CustomPaint(painter: GridPainter())),
            Builder(builder: (ctx) {
              final top = MediaQuery.of(ctx).padding.top;
              return Padding(
                padding: EdgeInsets.fromLTRB(20, top + 12, 20, 22),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Riwayat', style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
                Text('Pesanan', style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: AppC.n2)),
                Text('Semua transaksi tersimpan di sini',
                  style: TextStyle(fontSize: 12.5, color: Colors.white.withOpacity(.42))),
                const SizedBox(height: 18),
                                Row(
                  children: [
                    for (final d in [
                      ['24', 'Total'],
                      ['21', 'Selesai'],
                      ['3', 'Aktif']
                    ])
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.09),
                            border: Border.all(
                              color: Colors.white.withOpacity(.12),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            children: [
                              Text(
                                d[0],
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: d[1] == 'Aktif'
                                      ? AppC.n2
                                      : Colors.white,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                d[1],
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(.42),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        }),
      ]),
    ),

        // Filter tabs
        Padding(padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
          child: Row(children: ['semua','aktif','selesai'].map((t) =>
            GestureDetector(
              onTap: () => setState(() => _filter = t),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: _filter == t ? AppC.n7 : AppC.w,
                  border: _filter == t ? null : Border.all(color: AppC.bdr, width: 2),
                  borderRadius: BorderRadius.circular(20)),
                child: Text(t[0].toUpperCase() + t.substring(1),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
                    color: _filter == t ? Colors.white : AppC.mut))))).toList())),

        // Order cards
        ..._shown.map((o) => Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 11),
          child: GestureDetector(
            onTap: () => _push(DetailRiwayatScreen(item: o)),
            child: AppCard(child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(o.id, style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: AppC.mut, letterSpacing: .8)),
                StatusChip(status: o.status),
              ]),
              const SizedBox(height: 11),
              Row(children: [
                Container(width: 52, height: 52,
                  decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
                  child: Icon(o.icon, color: AppC.n5, size: 22)),
                const SizedBox(width: 11),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(o.layanan, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
                  const SizedBox(height: 2),
                  Text(o.items, style: const TextStyle(fontSize: 11.5, color: AppC.mut)),
                  const SizedBox(height: 3),
                  Row(children: [
                    const Icon(Icons.calendar_today_rounded, size: 11, color: AppC.mut),
                    const SizedBox(width: 4),
                    Text(o.tgl, style: const TextStyle(fontSize: 11, color: AppC.mut)),
                  ]),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Text(fmtRp(o.harga), style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppC.n5)),
                  const Text('Total', style: TextStyle(fontSize: 10, color: AppC.mut)),
                ]),
              ]),
              const SizedBox(height: 11),
              const Divider(color: AppC.n0, height: 1),
              const SizedBox(height: 11),
              Row(children: o.status == 'selesai' ? [
                Expanded(child: _btn(false, Icons.star_outline_rounded, 'Nilai', () => _push(NilaiOrderScreen(item: o)))),
                const SizedBox(width: 8),
                Expanded(child: _btn(true, Icons.refresh_rounded, 'Pesan Lagi', () {})),
              ] : o.status == 'diproses' ? [
                Expanded(child: _btn(false, Icons.location_on_rounded, 'Lacak', () => _push(const LacakScreen()))),
                const SizedBox(width: 8),
                Expanded(child: _btn(true, Icons.chat_bubble_rounded, 'Hubungi', () {})),
              ] : [
                Expanded(child: _btn(false, Icons.info_outline_rounded, 'Detail', () => _push(DetailRiwayatScreen(item: o)))),
                const SizedBox(width: 8),
                Expanded(child: _btn(true, Icons.navigation_rounded, 'Lacak', () => _push(const LacakScreen()))),
              ]),
            ])))),
        ).toList(),
        const SizedBox(height: 20),
      ]),
    );
  }

  Widget _btn(bool primary, IconData icon, String label, VoidCallback onTap) =>
    GestureDetector(onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: primary ? AppC.n7 : AppC.n0,
          borderRadius: BorderRadius.circular(11)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, size: 12, color: primary ? Colors.white : AppC.n7),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: primary ? Colors.white : AppC.n7)),
        ])));
}