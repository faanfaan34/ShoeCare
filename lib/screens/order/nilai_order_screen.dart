import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors.dart';
import '../../../core/data.dart';
import '../../../core/helpers.dart';
import '../../../widgets/shared.dart';

class NilaiOrderScreen extends StatefulWidget {
  final RiwayatModel item;
  const NilaiOrderScreen({super.key, required this.item});
  @override
  State<NilaiOrderScreen> createState() => _NilaiOrderScreenState();
}

class _NilaiOrderScreenState extends State<NilaiOrderScreen> {
  int  _stars = 0;
  bool _done  = false;

  static const _labels = ['', 'Buruk', 'Kurang', 'Cukup', 'Bagus', 'Sempurna!'];

  @override
  Widget build(BuildContext context) {
    if (_done) {
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
                boxShadow: [BoxShadow(color: AppC.n5.withOpacity(.3), blurRadius: 24, offset: const Offset(0, 10))]),
              child: const Icon(Icons.star_rounded, color: Colors.white, size: 50)),
            const SizedBox(height: 24),
            Text('Terima Kasih!',
              style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w700, color: AppC.n8)),
            const SizedBox(height: 10),
            const Text(
              'Penilaianmu sangat berarti bagi kami untuk terus meningkatkan kualitas layanan.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: AppC.mut, height: 1.65)),
            const SizedBox(height: 28),
            PrimaryButton(label: 'Kembali ke Riwayat', onTap: () => Navigator.pop(context)),
          ]))));
    }

    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Nilai Layanan', subtitle: 'Bagaimana pengalamanmu?'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            AppCard(child: Column(children: [
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(20)),
                child: Icon(widget.item.icon, color: AppC.n5, size: 30)),
              const SizedBox(height: 12),
              Text(widget.item.layanan,
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: AppC.n8)),
              const SizedBox(height: 4),
              Text(widget.item.items, style: const TextStyle(fontSize: 13, color: AppC.mut)),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) => GestureDetector(
                  onTap: () => setState(() => _stars = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.star_rounded, size: 36,
                      color: i < _stars ? const Color(0xFFF59E0B) : AppC.bdr))))),
              const SizedBox(height: 8),
              Text(
                _stars > 0 && _stars <= 5 ? _labels[_stars] : 'Sentuh bintang untuk menilai',
                style: const TextStyle(fontSize: 13.5, color: AppC.mut)),
            ])),
            const SizedBox(height: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Komentar (Opsional)',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppC.n8)),
              const SizedBox(height: 9),
              TextFormField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ceritakan pengalamanmu menggunakan layanan kami...',
                  hintStyle: const TextStyle(color: Color(0xFFB0BFDF), fontSize: 13.5),
                  filled: true, fillColor: AppC.w,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppC.bdr, width: 2)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppC.bdr, width: 2)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppC.n5, width: 2)))),
              const SizedBox(height: 16),
              PrimaryButton(
                label: 'Kirim Penilaian', icon: Icons.check_rounded,
                onTap: _stars > 0 ? () => setState(() => _done = true) : null),
            ]),
          ]))),
      ]));
  }
}