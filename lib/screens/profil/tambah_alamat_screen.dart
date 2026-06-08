import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class TambahAlamatScreen extends StatelessWidget {
  const TambahAlamatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Tambah Alamat', subtitle: 'Isi detail alamat baru'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            ...[
              [Icons.label_outline_rounded,     'Label Alamat',          'Rumah / Kantor'],
              [Icons.person_outline_rounded,    'Nama Penerima',         'Ahmad Farhan'],
              [Icons.phone_outlined,            'No. Telepon',           '+62 812-3456-7890'],
              [Icons.location_on_outlined,      'Provinsi',              'DKI Jakarta'],
              [Icons.business_outlined,         'Kota / Kabupaten',      'Jakarta Pusat'],
              [Icons.navigation_outlined,       'Kelurahan / Kecamatan', 'Tanah Abang'],
              [Icons.tag_rounded,               'Kode Pos',              '10220'],
              [Icons.assignment_outlined,       'Detail Alamat',         'Jl. / Blok / RT / RW'],
            ].map((f) => Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AppInput(
                label: f[1] as String,
                hint: f[2] as String,
                icon: f[0] as IconData))).toList(),
            PrimaryButton(
              label: 'Simpan Alamat',
              icon: Icons.check_rounded,
              onTap: () => Navigator.pop(context)),
          ]))),
      ]));
  }
}