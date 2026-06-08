import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class UlasanScreen extends StatefulWidget {
  const UlasanScreen({super.key});
  @override
  State<UlasanScreen> createState() => _UlasanScreenState();
}

class _UlasanScreenState extends State<UlasanScreen> {
  int _stars = 0;
  static const _labels = ['', '1 - Buruk', '2 - Kurang', '3 - Cukup', '4 - Bagus', '5 - Luar Biasa!'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Ulasan Aplikasi', subtitle: 'Pendapatmu sangat berarti'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            AppCard(child: Column(children: [
              Container(
                width: 72, height: 72,
                decoration: BoxDecoration(gradient: AppC.navyGrad, borderRadius: BorderRadius.circular(22)),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 36)),
              const SizedBox(height: 12),
              Text('ShoeCare', style: GoogleFonts.fraunces(fontSize: 22, fontWeight: FontWeight.w700, color: AppC.n8)),
              const SizedBox(height: 4),
              const Text('Beri nilai untuk aplikasi kami', style: TextStyle(fontSize: 13, color: AppC.mut)),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) => GestureDetector(
                  onTap: () => setState(() => _stars = i + 1),
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.star_rounded, size: 36,
                      color: i < _stars ? const Color(0xFFF59E0B) : AppC.bdr))))),
              const SizedBox(height: 6),
              Text(
                _stars > 0 && _stars <= 5 ? _labels[_stars] : 'Sentuh bintang untuk menilai',
                style: const TextStyle(fontSize: 14, color: AppC.mut)),
            ])),
            const SizedBox(height: 16),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Ceritakan pengalamanmu menggunakan aplikasi ShoeCare...',
                hintStyle: const TextStyle(color: Color(0xFFB0BFDF), fontSize: 13.5),
                filled: true, fillColor: AppC.w,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppC.bdr, width: 2)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppC.bdr, width: 2)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppC.n5, width: 2)))),
            const SizedBox(height: 16),
            PrimaryButton(label: 'Kirim Ulasan', icon: Icons.check_rounded, onTap: () => Navigator.pop(context)),
          ]))),
      ]));
  }
}