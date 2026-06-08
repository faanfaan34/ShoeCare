import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared.dart';

class NotifSettingScreen extends StatefulWidget {
  const NotifSettingScreen({super.key});
  @override
  State<NotifSettingScreen> createState() => _NotifSettingScreenState();
}

class _NotifSettingScreenState extends State<NotifSettingScreen> {
  final List<bool> _states = [true, true, true, false, false, true, true, false];

  static const _groups = [
    {
      'grp': 'Pesanan',
      'items': [
        [Icons.inventory_2_rounded,       'Status Pesanan'],
        [Icons.local_shipping_rounded,    'Update Kurir'],
        [Icons.check_circle_rounded,      'Pesanan Selesai'],
      ],
    },
    {
      'grp': 'Promosi',
      'items': [
        [Icons.star_outline_rounded,      'Penawaran Spesial'],
        [Icons.notifications_outlined,    'Berita & Update'],
      ],
    },
    {
      'grp': 'Saluran',
      'items': [
        [Icons.notifications_rounded,     'Push Notification'],
        [Icons.email_outlined,            'Email'],
        [Icons.phone_outlined,            'SMS'],
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    int idx = 0;
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const NavyHeader(title: 'Notifikasi', subtitle: 'Atur preferensi notifikasimu'),
        Expanded(child: ListView(
          padding: const EdgeInsets.all(18),
          children: _groups.map((g) {
            final items = g['items'] as List;
            final startIdx = idx;
            idx += items.length;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(padding: const EdgeInsets.only(left: 2, bottom: 8),
                  child: Text((g['grp'] as String).toUpperCase(),
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppC.mut, letterSpacing: 1.3))),
                AppCard(child: Column(children: items.asMap().entries.map((e) {
                  final ii = startIdx + e.key;
                  final item = e.value as List;
                  return Column(children: [
                    if (e.key > 0) const Divider(height: 1, color: AppC.n0),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                      leading: Container(width: 34, height: 34,
                        decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(10)),
                        child: Icon(item[0] as IconData, size: 16, color: AppC.n5)),
                      title: Text(item[1] as String,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppC.n8)),
                      trailing: Switch.adaptive(
                        value: _states[ii],
                        onChanged: (v) => setState(() => _states[ii] = v),
                        activeColor: AppC.n5)),
                  ]);
                }).toList())),
              ]));
          }).toList())),
      ]));
  }
}