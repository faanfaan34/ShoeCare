import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../widgets/shared.dart';
import 'tambah_sepatu_screen.dart';

class KoleksiSepatuScreen extends StatelessWidget {
  const KoleksiSepatuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Koleksi Sepatu', subtitle: 'Sepatu yang terdaftar'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            ...sepatuData.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppCard(child: Row(children: [
                Container(width: 50, height: 50,
                  decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
                  child: const Icon(Icons.auto_awesome_rounded, color: AppC.n5, size: 22)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(s['nama']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
                  Text('Ukuran ${s['ukuran']} · ${s['warna']}',
                    style: const TextStyle(fontSize: 12, color: AppC.mut)),
                  RichText(text: TextSpan(
                    style: const TextStyle(fontSize: 12, color: AppC.mut),
                    children: [
                      const TextSpan(text: 'Terakhir dicuci: '),
                      TextSpan(text: s['terakhir'],
                        style: const TextStyle(fontWeight: FontWeight.w600, color: AppC.n5)),
                    ])),
                ])),
                const Icon(Icons.chevron_right_rounded, color: AppC.mut, size: 18),
              ])))).toList(),
            PrimaryButton(
              label: 'Tambah Sepatu',
              icon: Icons.add_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahSepatuScreen()))),
          ])),
      ]));
  }
}