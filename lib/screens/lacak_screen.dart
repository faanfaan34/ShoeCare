import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';

class LacakScreen extends StatelessWidget {
  const LacakScreen({super.key});

  static const _steps = [
    {'label': 'Pesanan Diterima',       'sub': 'Selasa, 18 Mar 2024 · 10.30',  'done': true,  'now': false, 'icon': Icons.check_circle_rounded},
    {'label': 'Kurir Menjemput Sepatu', 'sub': 'Selasa, 18 Mar 2024 · 12.15',  'done': true,  'now': false, 'icon': Icons.local_shipping_rounded},
    {'label': 'Sedang Dicuci',          'sub': 'Estimasi selesai Rabu, 14.00', 'done': false, 'now': true,  'icon': Icons.water_drop_rounded},
    {'label': 'Siap Dikirim',           'sub': 'Menunggu proses selesai',       'done': false, 'now': false, 'icon': Icons.inventory_2_rounded},
    {'label': 'Pesanan Terkirim',       'sub': 'Menunggu proses selesai',       'done': false, 'now': false, 'icon': Icons.location_on_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Lacak Pesanan', subtitle: 'SC-0324-02 · Fast Clean'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            AppCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('STATUS PESANAN',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppC.mut, letterSpacing: 1)),
              const SizedBox(height: 14),
              ..._steps.asMap().entries.map((e) {
                final i = e.key;
                final st = e.value;
                final done = st['done'] as bool;
                final now  = st['now']  as bool;
                return IntrinsicHeight(child: Row(children: [
                  Column(children: [
                    Container(width: 28, height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: done ? AppC.n5 : now ? AppC.n7 : AppC.bdr,
                        boxShadow: now ? [BoxShadow(color: AppC.n7.withOpacity(.25), blurRadius: 8, spreadRadius: 2)] : []),
                      child: Icon(
                        done ? Icons.check_rounded : st['icon'] as IconData,
                        size: 13, color: (done || now) ? Colors.white : AppC.mut)),
                    if (i < _steps.length - 1)
                      Expanded(child: Container(
                        width: 2,
                        color: done ? AppC.n5 : AppC.bdr,
                        margin: const EdgeInsets.symmetric(vertical: 2))),
                  ]),
                  const SizedBox(width: 14),
                  Expanded(child: Padding(
                    padding: EdgeInsets.only(bottom: i < _steps.length - 1 ? 20 : 0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(st['label'] as String,
                        style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700,
                          color: now ? AppC.n7 : done ? AppC.n8 : AppC.mut)),
                      const SizedBox(height: 2),
                      Text(st['sub'] as String, style: const TextStyle(fontSize: 11.5, color: AppC.mut)),
                    ]))),
                ]));
              }).toList(),
            ])),
            const SizedBox(height: 14),
            AppCard(child: Row(children: [
              Container(width: 50, height: 50,
                decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.local_shipping_rounded, color: AppC.n5, size: 22)),
              const SizedBox(width: 13),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Budi Santoso',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
                const SizedBox(height: 2),
                Row(children: [
                  const Text('+62 812-3456-7890', style: TextStyle(fontSize: 12, color: AppC.mut)),
                  const SizedBox(width: 6),
                  const Icon(Icons.star_rounded, size: 11, color: AppC.n5),
                  const Text(' 4.9', style: TextStyle(fontSize: 11, color: AppC.mut)),
                ]),
              ])),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.phone_rounded, size: 14),
                label: const Text('Hubungi'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppC.n7, foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700))),
            ])),
          ]))),
      ]));
  }
}