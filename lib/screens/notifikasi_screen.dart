import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';

class NotifikasiScreen extends StatelessWidget {
  const NotifikasiScreen({super.key});

  static const _items = [
    {'icon': Icons.bolt_rounded,           'judul': 'Pesanan SC-0324-02 Sedang Diproses', 'isi': 'Sepatu kamu sedang dicuci oleh tim kami. Estimasi selesai besok pukul 14.00.', 'waktu': '5 menit lalu',  'baru': true},
    {'icon': Icons.local_shipping_rounded, 'judul': 'Kurir Dalam Perjalanan',             'isi': 'Budi Santoso sedang menuju lokasi kamu. Estimasi tiba 15 menit lagi.',         'waktu': '1 jam lalu',    'baru': true},
    {'icon': Icons.check_circle_rounded,   'judul': 'Pesanan SC-0324-01 Selesai!',        'isi': 'Deep Clean Nike Air Force 1 kamu sudah selesai dan siap dikirim.',             'waktu': '2 hari lalu',   'baru': false},
    {'icon': Icons.chat_bubble_rounded,    'judul': 'Info Layanan Terbaru',               'isi': 'ShoeCare kini hadir di lebih banyak wilayah. Cek area layanan kami.',           'waktu': '3 hari lalu',   'baru': false},
    {'icon': Icons.star_rounded,           'judul': 'Bagaimana Pengalamanmu?',            'isi': 'Berikanlah penilaian untuk pesanan SC-0324-04 agar kami terus berkembang.',     'waktu': '5 hari lalu',   'baru': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Notifikasi', subtitle: 'Update terbaru pesananmu'),
        Expanded(child: ListView.separated(
          padding: const EdgeInsets.all(18),
          itemCount: _items.length,
          separatorBuilder: (_, __) => const Divider(color: AppC.n0, height: 1),
          itemBuilder: (_, i) {
            final n = _items[i];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(children: [
                Container(width: 44, height: 44,
                  decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
                  child: Icon(n['icon'] as IconData, color: AppC.n5, size: 19)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(n['judul'] as String,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n8, height: 1.3)),
                  const SizedBox(height: 4),
                  Text(n['isi'] as String,
                    style: const TextStyle(fontSize: 11.5, color: AppC.mut, height: 1.5)),
                  const SizedBox(height: 4),
                  Text(n['waktu'] as String, style: const TextStyle(fontSize: 11, color: AppC.mut)),
                ])),
                if (n['baru'] as bool)
                  Container(width: 7, height: 7,
                    margin: const EdgeInsets.only(left: 6, top: 4),
                    decoration: const BoxDecoration(color: AppC.n4, shape: BoxShape.circle)),
              ]));
          })),
      ]));
  }
}