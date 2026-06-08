import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';

class BantuanScreen extends StatefulWidget {
  const BantuanScreen({super.key});
  @override
  State<BantuanScreen> createState() => _BantuanScreenState();
}

class _BantuanScreenState extends State<BantuanScreen> {
  int? _open;

  static const _faqs = [
    ['Berapa lama proses pencucian sepatu?',       'Tergantung layanan. Reguler 3 hari, Fast Clean 24 jam, Deep Clean 2 hari, dan Unyellowing 2 hari.'],
    ['Bagaimana cara penjemputan bekerja?',         'Setelah pemesanan, kurir kami akan menjemput sepatu ke alamat kamu dalam 30–60 menit.'],
    ['Apakah ada garansi untuk layanan?',           'Ya! Semua layanan kami bergaransi. Jika tidak puas, kami siap mengulang proses pencucian secara gratis.'],
    ['Metode pembayaran apa saja yang tersedia?',   'Kami menerima GoPay, OVO, DANA, ShopeePay, Transfer Bank BCA/Mandiri/BNI, dan COD (tunai).'],
    ['Apakah bisa dijadwalkan?',                    "Tentu! Kamu bisa memilih 'Jadwalkan' saat memesan untuk menentukan waktu penjemputan yang sesuai."],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Bantuan & FAQ', subtitle: 'Pertanyaan yang sering ditanyakan'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            // CS Card
            Container(
              padding: const EdgeInsets.all(18),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(gradient: AppC.darkGrad, borderRadius: BorderRadius.circular(17)),
              child: Row(children: [
                Container(width: 52, height: 52,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.1), borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 24)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Butuh Bantuan Lebih?',
                    style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                  const SizedBox(height: 3),
                  Text('Tim CS kami siap membantu 24/7',
                    style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(.48))),
                  const SizedBox(height: 9),
                  GestureDetector(onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(color: AppC.n4, borderRadius: BorderRadius.circular(11)),
                      child: const Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.chat_bubble_rounded, size: 13, color: Colors.white),
                        SizedBox(width: 5),
                        Text('Chat CS Sekarang',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: Colors.white)),
                      ]))),
                ])),
              ])),

            // FAQ list
            ..._faqs.asMap().entries.map((e) {
              final i = e.key;
              final f = e.value;
              final open = _open == i;
              return Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: GestureDetector(
                  onTap: () => setState(() => _open = open ? null : i),
                  child: AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Expanded(child: Text(f[0],
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppC.n8))),
                      const SizedBox(width: 8),
                      Icon(open ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        color: AppC.mut, size: 18),
                    ]),
                    if (open) ...[
                      const SizedBox(height: 10),
                      Text(f[1], style: const TextStyle(fontSize: 12.5, color: AppC.mut, height: 1.55)),
                    ],
                  ]))));
            }).toList(),
          ])),
      ]));
  }
}