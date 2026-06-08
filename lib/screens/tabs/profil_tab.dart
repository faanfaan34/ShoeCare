import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';
import '../login_screen.dart';
import '../profil/edit_profil_screen.dart';
import '../profil/alamat_screen.dart';
import '../profil/pembayaran_screen.dart';
import '../profil/notif_setting_screen.dart';
import '../profil/koleksi_sepatu_screen.dart';
import '../profil/catatan_perawatan_screen.dart';
import '../profil/keamanan_screen.dart';
import '../bantuan_screen.dart';
import '../profil/ulasan_screen.dart';
import '../profil/syarat_screen.dart';

class ProfilTab extends StatelessWidget {
  const ProfilTab({super.key});

  void _push(BuildContext ctx, Widget w) =>
      Navigator.push(ctx, MaterialPageRoute(builder: (_) => w));

  @override
  Widget build(BuildContext context) {
    final menuGroups = [
      {
        'grp': 'Akun',
        'items': [
          {'icon': Icons.edit_rounded,           'lb': 'Edit Profil',           'sb': 'Nama, foto, dan biodata',   'screen': () => const EditProfilScreen()},
          {'icon': Icons.location_on_rounded,    'lb': 'Alamat Saya',           'sb': '2 alamat tersimpan',        'screen': () => const AlamatScreen()},
          {'icon': Icons.credit_card_rounded,    'lb': 'Metode Pembayaran',     'sb': 'GoPay, OVO, Transfer',      'screen': () => const PembayaranScreen()},
          {'icon': Icons.notifications_rounded,  'lb': 'Pengaturan Notifikasi', 'sb': 'Push, Email, SMS',          'screen': () => const NotifSettingScreen()},
        ],
      },
      {
        'grp': 'Sepatu Saya',
        'items': [
          {'icon': Icons.auto_awesome_rounded,  'lb': 'Koleksi Sepatu',    'sb': '4 pasang terdaftar',       'screen': () => const KoleksiSepatuScreen()},
          {'icon': Icons.assignment_rounded,    'lb': 'Catatan Perawatan', 'sb': 'Jadwal & preferensi cuci', 'screen': () => const CatatanPerawatanScreen()},
        ],
      },
      {
        'grp': 'Lainnya',
        'items': [
          {'icon': Icons.security_rounded,       'lb': 'Keamanan & Privasi',   'sb': 'Kata sandi, 2FA',       'screen': () => const KeamananScreen()},
          {'icon': Icons.help_outline_rounded,   'lb': 'Bantuan & FAQ',        'sb': 'Pusat bantuan',         'screen': () => const BantuanScreen()},
          {'icon': Icons.star_outline_rounded,   'lb': 'Beri Ulasan Aplikasi', 'sb': 'Rating di Play Store',  'screen': () => const UlasanScreen()},
          {'icon': Icons.description_outlined,   'lb': 'Syarat & Ketentuan',   'sb': 'Kebijakan privasi',     'screen': () => const SyaratScreen()},
        ],
      },
    ];

    return SingleChildScrollView(
      child: Column(children: [
        // Header
        Builder(builder: (ctx) {
          final top = MediaQuery.of(ctx).padding.top;
          return Container(
            width: double.infinity,
            color: AppC.n8,
            child: Stack(children: [
              Positioned.fill(child: CustomPaint(painter: GridPainter())),
              Positioned(
                left: 0, right: 0, top: -30,
                child: Center(
                  child: Container(
                    width: 220, height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [AppC.n3.withOpacity(.2), Colors.transparent]))))),
              Padding(
                padding: EdgeInsets.fromLTRB(22, top + 16, 22, 28),
                child: Column(children: [
                  // Avatar
                  Stack(alignment: Alignment.bottomRight, children: [
                    Container(
                      width: 82, height: 82,
                      decoration: BoxDecoration(
                        gradient: AppC.navyGrad,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [BoxShadow(
                          color: AppC.n5.withOpacity(.42),
                          blurRadius: 20, offset: const Offset(0, 8))]),
                      child: Center(
                        child: Text('A',
                          style: GoogleFonts.poppins(
                            fontSize: 32, fontWeight: FontWeight.w700,
                            color: Colors.white)))),
                    GestureDetector(
                      onTap: () => _push(context, const EditProfilScreen()),
                      child: Container(
                        width: 28, height: 28,
                        decoration: BoxDecoration(
                          color: AppC.w,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [BoxShadow(
                            color: Colors.black.withOpacity(.12),
                            blurRadius: 6)]),
                        child: const Icon(Icons.edit_rounded, size: 14, color: AppC.n5))),
                  ]),
                  const SizedBox(height: 10),
                  Text('Ahmad Farhan',
                    style: GoogleFonts.poppins(
                      fontSize: 21, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text('ahmad.farhan@email.com',
                    style: TextStyle(fontSize: 12.5, color: Colors.white.withOpacity(.42))),
                  const SizedBox(height: 8),
                  Wrap(spacing: 7, children: [
                    _badge(Icons.phone_rounded,      '+62 812-3456-7890'),
                    _badge(Icons.location_on_rounded, 'Jakarta'),
                  ]),
                  const SizedBox(height: 18),
                  // Stats
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.07),
                      border: Border.all(color: Colors.white.withOpacity(.1)),
                      borderRadius: BorderRadius.circular(17)),
                    child: Row(children: [
                      for (final e in [
                        ['24', 'Pesanan'],
                        ['4.9', 'Rating'],
                        ['3', 'Aktif'],
                      ].asMap().entries)
                        Expanded(child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            border: e.key < 2
                              ? const Border(right: BorderSide(color: Colors.white12))
                              : null),
                          child: Column(children: [
                            Text(e.value[0],
                              style: GoogleFonts.poppins(
                                fontSize: 19, fontWeight: FontWeight.w700,
                                color: e.key == 2 ? AppC.n2 : Colors.white)),
                            const SizedBox(height: 2),
                            Text(e.value[1],
                              style: TextStyle(
                                fontSize: 10, color: Colors.white.withOpacity(.38))),
                          ]))),
                    ])),
                ])),
            ]));
        }),

        const SizedBox(height: 16),

        // Menu groups
        ...menuGroups.map((grp) => Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 11),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(left: 2, bottom: 8),
              child: Text(
                (grp['grp'] as String).toUpperCase(),
                style: const TextStyle(
                  fontSize: 10, fontWeight: FontWeight.w700,
                  color: AppC.mut, letterSpacing: 1.5))),
            Container(
              decoration: AppC.cardDeco(),
              child: Column(
                children: (grp['items'] as List).asMap().entries.map((e) {
                  final item = e.value as Map;
                  return Column(children: [
                    if (e.key > 0)
                      const Divider(height: 1, color: AppC.n0, indent: 16, endIndent: 16),
                    ListTile(
                      onTap: () => _push(context, (item['screen'] as Function)() as Widget),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                      leading: Container(
                        width: 36, height: 36,
                        decoration: BoxDecoration(
                          color: AppC.n0, borderRadius: BorderRadius.circular(11)),
                        child: Icon(item['icon'] as IconData, size: 17, color: AppC.n5)),
                      title: Text(item['lb'] as String,
                        style: const TextStyle(
                          fontSize: 13.5, fontWeight: FontWeight.w600, color: AppC.n8)),
                      subtitle: Text(item['sb'] as String,
                        style: const TextStyle(fontSize: 11, color: AppC.mut)),
                      trailing: const Icon(
                        Icons.chevron_right_rounded, color: AppC.mut, size: 18)),
                  ]);
                }).toList()),
            ),
          ]))).toList(),

        // Logout
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 28),
          child: GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF3FF),
                border: Border.all(color: AppC.bdr, width: 2),
                borderRadius: BorderRadius.circular(15)),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.logout_rounded, size: 17, color: AppC.dan),
                SizedBox(width: 8),
                Text('Keluar dari Akun',
                  style: TextStyle(
                    fontSize: 14.5, fontWeight: FontWeight.w700, color: AppC.dan)),
              ])))),
      ]),
    );
  }

  Widget _badge(IconData icon, String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(.09),
      border: Border.all(color: Colors.white.withOpacity(.16)),
      borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 11, color: Colors.white.withOpacity(.7)),
      const SizedBox(width: 5),
      Text(text,
        style: TextStyle(
          fontSize: 10.5, fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(.72))),
    ]));
}