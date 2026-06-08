import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';

// ─── GRID PAINTER ─────────────────────────────

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.white.withOpacity(.025)..strokeWidth = 1;
    const step = 30.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }
  @override bool shouldRepaint(_) => false;
}

// ─── NAVY HEADER ──────────────────────────────

class NavyHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBack;
  final Widget? extra;

  const NavyHeader({
    super.key,
    required this.title,
    this.subtitle = '',
    this.showBack = true,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppC.n8),
      child: Stack(children: [
        Positioned.fill(child: CustomPaint(painter: GridPainter())),
        Positioned(
          right: -30, top: -30,
          child: Container(
            width: 200, height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppC.n3.withOpacity(.22), Colors.transparent])))),
        Builder(builder: (ctx) {
          final top = MediaQuery.of(ctx).padding.top;
          return Padding(
            padding: EdgeInsets.fromLTRB(20, top + 12, 20, 22),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (showBack)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.1),
                      border: Border.all(color: Colors.white.withOpacity(.16)),
                      borderRadius: BorderRadius.circular(11)),
                    child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16))),
              if (showBack) const SizedBox(height: 14),
              Text(title,
                style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w700,
                  color: Colors.white, height: 1.25)),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(subtitle,
                  style: TextStyle(fontSize: 12.5, color: Colors.white.withOpacity(.42))),
              ],
              if (extra != null) ...[const SizedBox(height: 18), extra!],
            ]),
          );
        }),
      ]),
    );
  }
}

// ─── APP CARD ─────────────────────────────────

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double radius;
  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 16,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding ?? const EdgeInsets.all(16),
      decoration: AppC.cardDeco(r: radius),
      child: child));
}

// ─── PRIMARY BUTTON ───────────────────────────

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
  final bool fullWidth;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.icon,
    this.fullWidth = true,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    width: fullWidth ? double.infinity : null,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppC.n5,
        foregroundColor: Colors.white,
        disabledBackgroundColor: AppC.n5.withOpacity(.4),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 17), const SizedBox(width: 6)],
        Text(label),
      ])));
}

// ─── SECONDARY BUTTON ─────────────────────────

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;

  const SecondaryButton({super.key, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppC.n5,
        side: const BorderSide(color: AppC.n5, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
      child: Text(label)));
}

// ─── APP INPUT ────────────────────────────────

class AppInput extends StatelessWidget {
  final String label, hint;
  final IconData icon;
  final bool obscure;
  final TextEditingController? controller;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label.toUpperCase(),
        style: const TextStyle(
          fontSize: 10.5, fontWeight: FontWeight.w700,
          color: AppC.n7, letterSpacing: 1.2)),
      const SizedBox(height: 7),
      TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(fontSize: 14, color: AppC.n7),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFB0BFDF), fontSize: 14),
          prefixIcon: Icon(icon, size: 18, color: AppC.mut),
          filled: true,
          fillColor: AppC.w,
          contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: AppC.bdr, width: 2)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: AppC.bdr, width: 2)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(color: AppC.n5, width: 2)))),
    ]);
}

// ─── STATUS CHIP ──────────────────────────────

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final map = {
      'selesai':  [const Color(0xFFEEF3FF), AppC.n5,  'Selesai'],
      'diproses': [const Color(0xFFEEF3FF), AppC.n6,  'Diproses'],
      'dijemput': [AppC.n0,                  AppC.n7,  'Dijemput'],
    };
    final d = map[status] ?? [AppC.n0, AppC.n5, status];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: d[0] as Color,
        borderRadius: BorderRadius.circular(8)),
      child: Text(
        (d[2] as String).toUpperCase(),
        style: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w700,
          color: d[1] as Color, letterSpacing: .5)));
  }
}

// ─── SECTION TITLE ────────────────────────────

class SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onAction;

  const SectionTitle({super.key, required this.title, this.action, this.onAction});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title,
        style: GoogleFonts.poppins(
          fontSize: 17, fontWeight: FontWeight.w700, color: AppC.n8)),
      if (action != null)
        GestureDetector(
          onTap: onAction,
          child: Text(action!,
            style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: AppC.n4))),
    ]);
}

// ─── AUTH HEADER ──────────────────────────────

class AuthHeader extends StatelessWidget {
  final String title, subtitle;
  const AuthHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    color: AppC.n8,
    child: Stack(children: [
      Positioned.fill(child: CustomPaint(painter: GridPainter())),
      Positioned(
        right: -30, top: -30,
        child: Container(
          width: 180, height: 180,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [AppC.n3.withOpacity(.22), Colors.transparent])))),
      Builder(builder: (ctx) {
          final top = MediaQuery.of(ctx).padding.top;
          return Padding(
            padding: EdgeInsets.fromLTRB(24, top + 12, 24, 32),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              GestureDetector(
                onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    border: Border.all(color: Colors.white.withOpacity(.16)),
                    borderRadius: BorderRadius.circular(11)),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 16))),
              const SizedBox(height: 22),
              Text(title,
                style: GoogleFonts.poppins(
                  fontSize: 31, fontWeight: FontWeight.w700,
                  color: Colors.white, height: 1.2)),
              const SizedBox(height: 6),
              Text(subtitle,
                style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(.42))),
            ])),
            Container(
              width: 52,
              height: 52,
              margin: const EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                gradient: AppC.navyGrad,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppC.n5.withOpacity(.4),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      );
    }),
  ]),
);
}

// ─── HARGA ROW (untuk form pesan & konfirmasi) ─

class HargaRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;

  const HargaRow({super.key, required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(label, style: TextStyle(fontSize: 12.5, color: Colors.white.withOpacity(.48))),
      Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: valueColor ?? Colors.white)),
    ]));
}