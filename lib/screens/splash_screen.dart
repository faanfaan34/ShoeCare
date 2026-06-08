import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale, _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _fade  = CurvedAnimation(parent: _ctrl, curve: const Interval(.4, 1.0));
    _ctrl.forward();
    Timer(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
      }
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.n8,
      body: Stack(children: [
        Positioned.fill(child: CustomPaint(painter: GridPainter())),
        Positioned(left: -80, top: -80,
          child: Container(width: 400, height: 400,
            decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: RadialGradient(colors: [AppC.n3.withOpacity(.18), Colors.transparent])))),
        Positioned(right: -60, bottom: -60,
          child: Container(width: 300, height: 300,
            decoration: BoxDecoration(shape: BoxShape.circle,
              gradient: RadialGradient(colors: [AppC.n5.withOpacity(.22), Colors.transparent])))),
        Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
          ScaleTransition(
            scale: _scale,
            child: Container(
              width: 160, height: 160,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.08),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(color: AppC.n4.withOpacity(.35), blurRadius: 40, offset: const Offset(0, 16))]),
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                'assets/images/logo_shoecare.png',
                fit: BoxFit.contain))),
          const SizedBox(height: 22),
          FadeTransition(
            opacity: _fade,
            child: Column(children: [
              RichText(text: TextSpan(
                style: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.w800, letterSpacing: -1),
                children: const [
                  TextSpan(text: 'Shoe', style: TextStyle(color: Colors.white)),
                  TextSpan(text: 'Care', style: TextStyle(color: AppC.n2)),
                ])),
              const SizedBox(height: 6),
              Text('LAUNDRY SEPATU PREMIUM',
                style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600,
                  color: Colors.white.withOpacity(.35), letterSpacing: 3.5)),
            ])),
        ])),
        Positioned(
          bottom: 80, left: 0, right: 0,
          child: FadeTransition(
            opacity: _fade,
            child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8, height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppC.n3.withOpacity(1 - i * 0.35))))))),
      ]),
    );
  }
}