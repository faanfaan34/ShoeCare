import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class KeamananScreen extends StatefulWidget {
  const KeamananScreen({super.key});
  @override
  State<KeamananScreen> createState() => _KeamananScreenState();
}

class _KeamananScreenState extends State<KeamananScreen> {
  bool _t1 = true, _t2 = false, _t3 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Keamanan & Privasi', subtitle: 'Jaga keamanan akunmu'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            // Info akun
            AppCard(child: Column(children: [
              ...[
                [Icons.key_rounded,    'Ubah Kata Sandi',   'Terakhir diubah 3 bulan lalu', true],
                [Icons.email_outlined, 'Verifikasi Email',  'ahmad@email.com · Terverifikasi ✓', false],
                [Icons.phone_outlined, 'Verifikasi No. HP', '+62 812 · Terverifikasi ✓', false],
              ].asMap().entries.map((e) => Column(children: [
                if (e.key > 0) const Divider(height: 1, color: AppC.n0),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                  leading: Container(width: 42, height: 42,
                    decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(13)),
                    child: Icon(e.value[0] as IconData, size: 18, color: AppC.n5)),
                  title: Text(e.value[1] as String,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
                  subtitle: Text(e.value[2] as String,
                    style: const TextStyle(fontSize: 12, color: AppC.mut)),
                  trailing: (e.value[3] as bool)
                    ? const Icon(Icons.chevron_right_rounded, color: AppC.mut)
                    : null),
              ])).toList(),
            ])),
            const SizedBox(height: 11),

            // Toggle settings
            AppCard(child: Column(children: [
              ...[
                [Icons.security_rounded,      'Autentikasi 2 Faktor',  'Keamanan ekstra untuk akunmu'],
                [Icons.notifications_rounded, 'Login Notifikasi',      'Notifikasi setiap kali masuk'],
                [Icons.visibility_outlined,   'Tampilkan Aktivitas',   'Riwayat login & aktivitas'],
              ].asMap().entries.map((e) {
                final i = e.key;
                final item = e.value;
                final vals = [_t1, _t2, _t3];
                return Column(children: [
                  if (i > 0) const Divider(height: 1, color: AppC.n0),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                    leading: Container(width: 42, height: 42,
                      decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(13)),
                      child: Icon(item[0] as IconData, size: 18, color: AppC.n5)),
                    title: Text(item[1] as String,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
                    subtitle: Text(item[2] as String,
                      style: const TextStyle(fontSize: 12, color: AppC.mut)),
                    trailing: Switch.adaptive(
                      value: vals[i],
                      onChanged: (v) => setState(() {
                        if (i == 0) _t1 = v;
                        if (i == 1) _t2 = v;
                        if (i == 2) _t3 = v;
                      }),
                      activeColor: AppC.n5)),
                ]);
              }).toList(),
            ])),
            const SizedBox(height: 11),

            // Hapus akun
            GestureDetector(
              onTap: () {},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  border: Border.all(color: AppC.bdr, width: 2),
                  borderRadius: BorderRadius.circular(15)),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.delete_outline_rounded, size: 17, color: AppC.dan),
                  SizedBox(width: 8),
                  Text('Hapus Akun', style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700, color: AppC.dan)),
                ]))),
          ])),
      ]));
  }
}