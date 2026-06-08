import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';
import 'tambah_alamat_screen.dart';

class AlamatScreen extends StatelessWidget {
  const AlamatScreen({super.key});

  static const _alamat = [
    {'label': 'Rumah',  'detail': 'Jl. Sudirman No. 12, Karet Tengsin, Tanah Abang, Jakarta Pusat 10220', 'utama': true},
    {'label': 'Kantor', 'detail': 'Jl. HR Rasuna Said Kav. 62, Kuningan, Jakarta Selatan 12940',           'utama': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Alamat Saya', subtitle: 'Kelola alamat penjemputan'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            ..._alamat.map((a) => Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(8)),
                    child: Text(a['label'] as String,
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppC.n7))),
                  if (a['utama'] as bool)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: AppC.n0,
                        border: Border.all(color: AppC.n1, width: 1.5),
                        borderRadius: BorderRadius.circular(8)),
                      child: const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.check_rounded, size: 10, color: AppC.n5),
                        SizedBox(width: 4),
                        Text('Utama', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppC.n5)),
                      ])),
                ]),
                const SizedBox(height: 7),
                Text(a['detail'] as String,
                  style: const TextStyle(fontSize: 13, color: AppC.mut, height: 1.5)),
                const SizedBox(height: 10),
                Row(children: [
                  Expanded(child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(10)),
                      child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Icon(Icons.edit_rounded, size: 12, color: AppC.n7),
                        SizedBox(width: 5),
                        Text('Edit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppC.n7)),
                      ])))),
                  if (!(a['utama'] as bool)) ...[
                    const SizedBox(width: 8),
                    Expanded(child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(color: const Color(0xFFFEF2F2), borderRadius: BorderRadius.circular(10)),
                        child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.delete_outline_rounded, size: 12, color: AppC.dan),
                          SizedBox(width: 5),
                          Text('Hapus', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppC.dan)),
                        ])))),
                  ],
                ]),
              ])))).toList(),
            PrimaryButton(
              label: 'Tambah Alamat Baru',
              icon: Icons.add_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahAlamatScreen()))),
          ])),
      ]));
  }
}