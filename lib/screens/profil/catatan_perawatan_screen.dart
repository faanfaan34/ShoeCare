import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../widgets/shared.dart';

class CatatanPerawatanScreen extends StatelessWidget {
  const CatatanPerawatanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Catatan Perawatan', subtitle: 'Jadwal & preferensi cucimu'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: sepatuData.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Icon(Icons.auto_awesome_rounded, size: 16, color: AppC.n5),
                const SizedBox(width: 8),
                Text(s['nama']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
              ]),
              const SizedBox(height: 10),
              ...[
                ['Frekuensi Cuci',  'Setiap 2 Minggu'],
                ['Layanan Favorit', 'Deep Clean'],
                ['Terakhir Dicuci', s['terakhir']!],
                ['Catatan',        'Hindari sikat keras di bagian upper'],
              ].map((r) => Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(r[0], style: const TextStyle(fontSize: 12.5, color: AppC.mut)),
                  Flexible(child: Text(r[1],
                    style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: AppC.n7),
                    textAlign: TextAlign.right)),
                ]))).toList(),
            ])))).toList())),
      ]));
  }
}