import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Edit Profil', subtitle: 'Perbarui data dirimu'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            // Avatar
            Column(children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  gradient: AppC.navyGrad,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: AppC.n5.withOpacity(.32), blurRadius: 16, offset: const Offset(0, 6))]),
                child: const Center(child: Text('A',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white)))),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: AppC.n7, borderRadius: BorderRadius.circular(20)),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.image_rounded, size: 14, color: Colors.white),
                    SizedBox(width: 5),
                    Text('Ganti Foto', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                  ]))),
              const SizedBox(height: 22),
            ]),
            ...[
              [Icons.person_outline_rounded,  'Nama Depan',    'Ahmad'],
              [Icons.person_outline_rounded,  'Nama Belakang', 'Farhan'],
              [Icons.email_outlined,          'Email',         'ahmad.farhan@email.com'],
              [Icons.phone_outlined,          'No. Telepon',   '+62 812-3456-7890'],
              [Icons.cake_outlined,           'Tanggal Lahir', '15 Agustus 1995'],
              [Icons.location_on_outlined,    'Kota',          'Jakarta'],
            ].map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AppInput(
                label: f[1] as String,
                hint: '',
                icon: f[0] as IconData,
                controller: TextEditingController(text: f[2] as String)))).toList(),
            const SizedBox(height: 4),
            PrimaryButton(
              label: 'Simpan Perubahan',
              icon: Icons.check_rounded,
              onTap: () => Navigator.pop(context)),
          ]))),
      ]));
  }
}