import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/data.dart';
import '../../widgets/shared.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({super.key});
  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  int _sel = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Metode Pembayaran', subtitle: 'Kelola metode bayarmu'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            ...paymentData.asMap().entries.map((e) {
              final i = e.key; final p = e.value; final sel = _sel == i;
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () => setState(() => _sel = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: sel ? AppC.n0 : AppC.w,
                      border: Border.all(color: sel ? AppC.n5 : Colors.transparent, width: 2.5),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.07), blurRadius: 8)]),
                    child: Row(children: [
                      Container(width: 44, height: 44,
                        decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(13)),
                        child: Icon(p.icon, color: AppC.n5, size: 20)),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(p.nama, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
                        Text(p.detail, style: const TextStyle(fontSize: 12, color: AppC.mut)),
                      ])),
                      if (sel)
                        Container(width: 22, height: 22,
                          decoration: const BoxDecoration(color: AppC.n7, shape: BoxShape.circle),
                          child: const Icon(Icons.check_rounded, size: 12, color: Colors.white)),
                    ]))));
            }).toList(),
            const SizedBox(height: 4),
            PrimaryButton(label: 'Tambah Metode Bayar', icon: Icons.add_rounded, onTap: () {}),
          ])),
      ]));
  }
}