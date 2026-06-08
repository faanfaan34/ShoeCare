import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';
import '../lacak_screen.dart';
import '../main_screen.dart';

class SuksesScreen extends StatelessWidget {
  const SuksesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = 'SC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    return Scaffold(
      backgroundColor: AppC.ow,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 96, height: 96,
            decoration: BoxDecoration(
              gradient: AppC.navyGrad,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: AppC.n5.withOpacity(.3), blurRadius: 30, offset: const Offset(0, 12))]),
            child: const Icon(Icons.check_circle_outline_rounded, color: Colors.white, size: 52)),
          const SizedBox(height: 24),
          Text('Pesanan Berhasil!',
            style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: AppC.n8)),
          const SizedBox(height: 10),
          const Text(
            'Pesananmu telah dikonfirmasi. Kurir kami segera menuju lokasimu untuk menjemput sepatu.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.5, color: AppC.mut, height: 1.65)),
          const SizedBox(height: 30),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
            child: Column(children: [
              const Text('ID Pesanan', style: TextStyle(fontSize: 11, color: AppC.mut)),
              const SizedBox(height: 4),
              Text(orderId,
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: AppC.n7, letterSpacing: 1)),
            ])),
          const SizedBox(height: 28),
          PrimaryButton(
            label: 'Lacak Pesanan',
            icon: Icons.navigation_rounded,
            onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LacakScreen()))),
          const SizedBox(height: 10),
          SecondaryButton(
            label: 'Kembali ke Beranda',
            onTap: () => Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (_) => const MainScreen()), (_) => false)),
        ]))));
  }
}