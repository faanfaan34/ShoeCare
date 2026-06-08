// ════════════════════════════════════════════
//  tambah_sepatu_screen.dart
// ════════════════════════════════════════════
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class TambahSepatuScreen extends StatelessWidget {
  const TambahSepatuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Tambah Sepatu', subtitle: 'Daftarkan sepatu baru'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            ...[
              [Icons.auto_awesome_rounded,  'Nama Sepatu',  'Nike Air Force 1'],
              [Icons.label_outline_rounded, 'Merek',        'Nike / Adidas / Vans'],
              [Icons.palette_outlined,      'Warna',        'Putih, Hitam, dll'],
              [Icons.tag_rounded,           'Ukuran',       '42'],
              [Icons.calendar_today_rounded,'Tahun Beli',   '2023'],
              [Icons.assignment_outlined,   'Catatan',      'Kondisi khusus, dll'],
            ].map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AppInput(
                label: f[1] as String,
                hint: f[2] as String,
                icon: f[0] as IconData))).toList(),
            PrimaryButton(
              label: 'Simpan Sepatu',
              icon: Icons.check_rounded,
              onTap: () => Navigator.pop(context)),
          ]))),
      ]));
  }
}