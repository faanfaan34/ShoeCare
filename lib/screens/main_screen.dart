import 'package:flutter/material.dart';
import '../core/colors.dart';
import 'tabs/beranda_tab.dart';
import 'tabs/layanan_tab.dart';
import 'tabs/riwayat_tab.dart';
import 'tabs/profil_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _idx = 0;

  static const _tabs = [BerandaTab(), LayananTab(), RiwayatTab(), ProfilTab()];

  static const _navItems = [
    {'icon': Icons.home_rounded,         'label': 'Beranda'},
    {'icon': Icons.layers_rounded,       'label': 'Layanan'},
    {'icon': Icons.access_time_rounded,  'label': 'Riwayat'},
    {'icon': Icons.person_rounded,       'label': 'Profil'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: _tabs[_idx],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppC.w,
          border: const Border(top: BorderSide(color: AppC.bdr, width: 1.5)),
          boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.06), blurRadius: 16, offset: const Offset(0, -4))]),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: List.generate(4, (i) {
                final active = _idx == i;
                final item = _navItems[i];
                return Expanded(child: GestureDetector(
                  onTap: () => setState(() => _idx = i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 42, height: 42,
                      decoration: BoxDecoration(
                        color: active ? AppC.n7 : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: active
                          ? [BoxShadow(color: AppC.n7.withOpacity(.28), blurRadius: 10, offset: const Offset(0, 3))]
                          : []),
                      child: Icon(item['icon'] as IconData, size: 20,
                        color: active ? Colors.white : AppC.mut)),
                    const SizedBox(height: 3),
                    Text(item['label'] as String,
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600,
                        color: active ? AppC.n7 : AppC.mut)),
                  ])));
              }),
            ))),
      ),
    );
  }
}