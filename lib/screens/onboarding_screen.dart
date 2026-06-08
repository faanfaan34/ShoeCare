import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _page = 0;

  static const _pages = [
    {
      'icon': Icons.water_drop_rounded,
      'badge': 'Bersih Profesional',
      'title': 'Cuci Sepatu\nBersih Sempurna',
      'desc': 'Layanan cuci sepatu profesional dengan teknologi terkini. Setiap detail diperhatikan untuk hasil terbaik.',
      'floats': [
        [Icons.auto_awesome_rounded, 'Deep Clean'],
        [Icons.bolt_rounded,         'Express 24 Jam'],
        [Icons.inventory_2_rounded,  'Jemput Gratis'],
      ],
    },
    {
      'icon': Icons.local_shipping_rounded,
      'badge': 'Door-to-Door',
      'title': 'Jemput & Antar\nKe Rumahmu',
      'desc': 'Kami menjemput sepatu kotor dan mengantarkan kembali dalam kondisi bersih sempurna ke pintu rumahmu.',
      'floats': [
        [Icons.local_shipping_rounded, 'Jemput Antar'],
        [Icons.location_on_rounded,    'Live Tracking'],
        [Icons.notifications_rounded,  'Notif Real-time'],
      ],
    },
    {
      'icon': Icons.emoji_events_rounded,
      'badge': 'Terpercaya',
      'title': 'Dipercaya\n50.000+ Pelanggan',
      'desc': 'Bergabunglah dengan ribuan pelanggan yang sudah merasakan manfaat ShoeCare. Kualitas premium, harga terjangkau.',
      'floats': [
        [Icons.star_rounded,       'Rating 4.9/5'],
        [Icons.security_rounded,   'Bergaransi'],
        [Icons.emoji_events_rounded, 'Tim Ahli'],
      ],
    },
  ];

  void _go(Widget screen) =>
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));

  @override
  Widget build(BuildContext context) {
    final p = _pages[_page];
    final floats = p['floats'] as List;
    final icon   = p['icon'] as IconData;
    final badge  = p['badge'] as String;
    final title  = p['title'] as String;
    final desc   = p['desc'] as String;

    return Scaffold(
      backgroundColor: AppC.w,
      body: Column(children: [
        // ── Visual area ──
        Expanded(child: Stack(children: [
          Positioned(
            top: -60,
            left: MediaQuery.of(context).size.width / 2 - 190,
            child: Container(width: 380, height: 380,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppC.n8))),
          Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(height: 40),
            Container(
              width: 200, height: 180,
              decoration: BoxDecoration(
                color: AppC.w, borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 40, offset: const Offset(0, 16))]),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 72, height: 72,
                  decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(22)),
                  child: Icon(icon, color: AppC.n5, size: 36)),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: AppC.n7, borderRadius: BorderRadius.circular(20)),
                  child: Text(badge,
                    style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: .5))),
              ])),
          ])),
          // Float badges
          _floatBadge(floats[0] as List, top: 38, right: 18, delay: 0),
          _floatBadge(floats[1] as List, bottom: 62, left: 10, delay: 1000),
          _floatBadge(floats[2] as List, bottom: 30, right: 16, delay: 600),
        ])),

        // ── Content area ──
        Container(
          decoration: BoxDecoration(
            color: AppC.w,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.06), blurRadius: 20, offset: const Offset(0, -6))]),
          padding: const EdgeInsets.fromLTRB(26, 28, 26, 36),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Dots
            Row(children: List.generate(3, (i) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 6),
              width: i == _page ? 28 : 6, height: 5,
              decoration: BoxDecoration(
                color: i == _page ? AppC.n5 : AppC.n0,
                borderRadius: BorderRadius.circular(3))))),
            const SizedBox(height: 20),
            Text(title,
              style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: AppC.n8, height: 1.25)),
            const SizedBox(height: 10),
            Text(desc, style: const TextStyle(fontSize: 13, color: AppC.mut, height: 1.65)),
            const SizedBox(height: 24),
            Row(children: _page < 2
              ? [
                  GestureDetector(
                    onTap: () => _go(const LoginScreen()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(16)),
                      child: const Text('Lewati', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n6)))),
                  const SizedBox(width: 10),
                  Expanded(child: PrimaryButton(label: 'Selanjutnya', onTap: () => setState(() => _page++))),
                ]
              : [
                  Expanded(child: SecondaryButton(label: 'Masuk',       onTap: () => _go(const LoginScreen()))),
                  const SizedBox(width: 10),
                  Expanded(child: PrimaryButton(label: 'Daftar Gratis', onTap: () => _go(const RegisterScreen()))),
                ]),
          ])),
      ]),
    );
  }

  Widget _floatBadge(List item, {double? top, double? bottom, double? left, double? right, int delay = 0}) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
        decoration: BoxDecoration(
          color: AppC.w, borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.12), blurRadius: 14, offset: const Offset(0, 3))]),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 24, height: 24,
            decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(7)),
            child: Icon(item[0] as IconData, size: 13, color: AppC.n5)),
          const SizedBox(width: 6),
          Text(item[1] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppC.n7)),
        ])));
  }
}