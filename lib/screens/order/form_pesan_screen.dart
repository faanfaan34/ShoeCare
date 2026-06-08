import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/colors.dart';
import '../../../core/data.dart';
import '../../../core/helpers.dart';
import '../../../widgets/shared.dart';
import 'konfirmasi_screen.dart';

class FormPesanScreen extends StatefulWidget {
  final LayananModel? layanan;
  const FormPesanScreen({super.key, this.layanan});
  @override
  State<FormPesanScreen> createState() => _FormPesanScreenState();
}

class _FormPesanScreenState extends State<FormPesanScreen> {
  int _step = 1;
  JenisModel? _jenis;
  LayananModel? _layanan;
  int _qty = 1;
  String _jemput = 'sekarang';
  int _metodeIdx = 0;

  @override
  void initState() {
    super.initState();
    _layanan = widget.layanan;
  }

  int get _hJ => _jenis?.harga ?? 0;
  int get _hL => _layanan?.tambah ?? 0;
  int get _hS => _hJ + _hL;
  int get _tot => _hS * _qty;

  @override
  Widget build(BuildContext context) {
    final titles = ['', 'Pilih Jenis Bahan', 'Pilih Layanan', 'Detail Pesanan'];
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        NavyHeader(title: titles[_step], subtitle: 'Langkah $_step dari 3'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 100),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _stepBar(),
            if (_step == 1) _buildStep1(),
            if (_step == 2) _buildStep2(),
            if (_step == 3) _buildStep3(),
          ]))),
      ]),
      bottomNavigationBar: SafeArea(child: Container(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 16),
        decoration: const BoxDecoration(color: AppC.w, border: Border(top: BorderSide(color: AppC.bdr, width: 1.5))),
        child: Opacity(
          opacity: (_step == 1 && _jenis == null) || (_step == 2 && _layanan == null) ? .4 : 1,
          child: PrimaryButton(
            label: _step == 1
              ? (_jenis != null ? 'Lanjut — ${_jenis!.nama} (${fmtRp(_hJ)})' : 'Pilih salah satu jenis bahan')
              : _step == 2
              ? (_layanan != null ? 'Lanjut — ${_layanan!.nama} (${fmtRp(_hS)}/pasang)' : 'Pilih salah satu layanan')
              : 'Lanjut ke Konfirmasi (${fmtRp(_tot)})',
            onTap: () {
              if (_step == 1 && _jenis != null) { setState(() => _step = 2); }
              else if (_step == 2 && _layanan != null) { setState(() => _step = 3); }
              else if (_step == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => KonfirmasiScreen(
                  jenis: _jenis!, layanan: _layanan!, qty: _qty,
                  hJ: _hJ, hL: _hL, hS: _hS, tot: _tot,
                  metode: paymentData[_metodeIdx].nama, jemput: _jemput)));
              }
            })))),
    );
  }

  Widget _stepBar() => Padding(
    padding: const EdgeInsets.only(bottom: 22),
    child: Row(children: [
      _stepDot(1, 'Jenis\nBahan'),
      Expanded(child: AnimatedContainer(duration: const Duration(milliseconds: 250),
        height: 2, margin: const EdgeInsets.only(bottom: 14), color: _step > 1 ? AppC.n5 : AppC.bdr)),
      _stepDot(2, 'Pilih\nLayanan'),
      Expanded(child: AnimatedContainer(duration: const Duration(milliseconds: 250),
        height: 2, margin: const EdgeInsets.only(bottom: 14), color: _step > 2 ? AppC.n5 : AppC.bdr)),
      _stepDot(3, 'Detail'),
    ]));

  Widget _stepDot(int n, String label) {
    final done = _step > n;
    final now  = _step == n;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 28, height: 28,
        decoration: BoxDecoration(shape: BoxShape.circle,
          color: done ? AppC.n7 : now ? AppC.n5 : AppC.n0,
          boxShadow: now ? [BoxShadow(color: AppC.n5.withOpacity(.32), blurRadius: 8, offset: const Offset(0, 3))] : []),
        child: Center(child: done
          ? const Icon(Icons.check_rounded, size: 13, color: Colors.white)
          : Text('$n', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700,
              color: now ? Colors.white : AppC.mut)))),
      const SizedBox(height: 5),
      Text(label, style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700,
        color: (done || now) ? AppC.n7 : AppC.mut), textAlign: TextAlign.center),
    ]);
  }

  // ── Step 1: Pilih Jenis Bahan ──
  Widget _buildStep1() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Sepatumu Terbuat dari Bahan Apa?',
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n8)),
    const SizedBox(height: 5),
    const Text('Jenis bahan menentukan teknik dan biaya pencucian yang tepat',
      style: TextStyle(fontSize: 12.5, color: AppC.mut, height: 1.5)),
    const SizedBox(height: 16),
    GridView.count(
      crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10,
      shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.05,
      children: jenisData.map((j) {
        final sel = _jenis?.id == j.id;
        return GestureDetector(
          onTap: () => setState(() => _jenis = j),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: j.bg,
              border: Border.all(color: sel ? AppC.n5 : Colors.transparent, width: 2.5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.07), blurRadius: 10, offset: const Offset(0, 3))]),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(width: 40, height: 40,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(.7), borderRadius: BorderRadius.circular(12)),
                  child: Icon(j.icon, size: 20, color: j.icColor)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 20, height: 20,
                  decoration: BoxDecoration(
                    color: sel ? AppC.n7 : Colors.transparent,
                    border: Border.all(color: sel ? AppC.n7 : AppC.bdr, width: 2),
                    borderRadius: BorderRadius.circular(6)),
                  child: sel ? const Icon(Icons.check_rounded, size: 11, color: Colors.white) : null),
              ]),
              const SizedBox(height: 9),
              Text(j.nama, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: AppC.n8)),
              Text(j.desk, style: const TextStyle(fontSize: 10.5, color: AppC.mut, height: 1.3)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(8)),
                child: Text('+ ${fmtRp(j.harga)}',
                  style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: AppC.n6))),
            ])));
      }).toList()),
    if (_jenis != null) ...[
      const SizedBox(height: 14),
      Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(14)),
        child: Row(children: [
          const Icon(Icons.info_outline_rounded, size: 15, color: AppC.n5),
          const SizedBox(width: 8),
          Expanded(child: RichText(text: TextSpan(
            style: const TextStyle(fontSize: 12, color: AppC.n7, height: 1.5),
            children: [
              TextSpan(text: '${_jenis!.nama}: ', style: const TextStyle(fontWeight: FontWeight.w700)),
              TextSpan(text: _jenis!.tips),
            ]))),
        ])),
    ],
  ]);

  // ── Step 2: Pilih Layanan ──
  Widget _buildStep2() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Pilih Layanan Pencucian',
      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: AppC.n8)),
    const SizedBox(height: 4),
    RichText(text: TextSpan(
      style: const TextStyle(fontSize: 12.5, color: AppC.mut),
      children: [
        const TextSpan(text: 'Harga sudah termasuk biaya bahan '),
        TextSpan(text: _jenis?.nama ?? '',
          style: const TextStyle(fontWeight: FontWeight.w700, color: AppC.n7)),
        TextSpan(text: ' (${fmtRp(_jenis?.harga ?? 0)})'),
      ])),
    const SizedBox(height: 16),
    ...layananData.map((s) {
      final tot1 = (_jenis?.harga ?? 0) + s.tambah;
      final sel  = _layanan?.id == s.id;
      return GestureDetector(
        onTap: () => setState(() => _layanan = s),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: sel ? AppC.n0 : AppC.w,
            border: Border.all(color: sel ? AppC.n5 : Colors.transparent, width: 2.5),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.07), blurRadius: 10, offset: const Offset(0, 3))]),
          child: Row(children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: sel ? AppC.n7 : AppC.n0, borderRadius: BorderRadius.circular(13)),
              child: Icon(s.icon, size: 22, color: sel ? Colors.white : AppC.n5)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s.nama, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: AppC.n8)),
              const SizedBox(height: 2),
              Row(children: [
                const Icon(Icons.access_time_rounded, size: 11, color: AppC.mut),
                const SizedBox(width: 3),
                Text('${s.durasi} · ${s.badge}', style: const TextStyle(fontSize: 11, color: AppC.mut)),
              ]),
              const SizedBox(height: 4),
              RichText(text: TextSpan(
                style: const TextStyle(fontSize: 11, color: AppC.mut),
                children: [
                  TextSpan(text: '${fmtRp(_jenis?.harga ?? 0)} + ${fmtRp(s.tambah)} = '),
                  TextSpan(text: '${fmtRp(tot1)}/pasang',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppC.n5)),
                ])),
            ])),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20, height: 20,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: sel ? AppC.n7 : Colors.transparent,
                border: Border.all(color: sel ? AppC.n7 : AppC.bdr, width: 2)),
              child: sel ? Center(child: Container(width: 8, height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white))) : null),
          ])));
    }).toList(),
  ]);

  // ── Step 3: Detail Pesanan ──
  Widget _buildStep3() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    // Ringkasan
    Container(
      padding: const EdgeInsets.all(14), margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(16)),
      child: Row(children: [
        Container(width: 46, height: 46,
          decoration: BoxDecoration(color: AppC.w, borderRadius: BorderRadius.circular(13)),
          child: Icon(_jenis?.icon ?? Icons.layers_rounded, size: 22, color: AppC.n5)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Jenis Bahan · Layanan', style: TextStyle(fontSize: 11.5, color: AppC.mut)),
          Text('${_jenis?.nama} · ${_layanan?.nama}',
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w700, color: AppC.n8)),
          Text(fmtRp(_hS), style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n5)),
        ])),
        GestureDetector(onTap: () => setState(() => _step = 1),
          child: const Text('Ubah', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n4))),
      ])),

    // Jumlah
    Text('Jumlah Pasang', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppC.n8)),
    const SizedBox(height: 10),
    AppCard(child: Row(children: [
      GestureDetector(onTap: () => setState(() { if (_qty > 1) _qty--; }),
        child: Container(width: 34, height: 34,
          decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.remove_rounded, color: AppC.n7, size: 16))),
      Expanded(child: Center(child: Text('$_qty',
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: AppC.n8)))),
      GestureDetector(onTap: () => setState(() => _qty++),
        child: Container(width: 34, height: 34,
          decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.add_rounded, color: AppC.n7, size: 16))),
      const SizedBox(width: 12),
      const Text('Pasang', style: TextStyle(fontSize: 13, color: AppC.mut)),
    ])),
    const SizedBox(height: 18),

    // Penjemputan
    Text('Penjemputan', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppC.n8)),
    const SizedBox(height: 10),
    ...[
      ['sekarang', Icons.local_shipping_rounded, 'Jemput Sekarang', 'Estimasi 30–60 menit'],
      ['jadwal',   Icons.calendar_today_rounded,  'Jadwalkan',       'Pilih tanggal & waktu'],
    ].map((v) {
      final sel = _jemput == v[0];
      return GestureDetector(
        onTap: () => setState(() => _jemput = v[0] as String),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 9),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: sel ? AppC.n0 : AppC.w,
            border: Border.all(color: sel ? AppC.n5 : Colors.transparent, width: 2.5),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.07), blurRadius: 8)]),
          child: Row(children: [
            Container(width: 44, height: 44,
              decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(13)),
              child: Icon(v[1] as IconData, size: 20, color: AppC.n5)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(v[2] as String, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppC.n8)),
              Text(v[3] as String, style: const TextStyle(fontSize: 11.5, color: AppC.mut)),
            ])),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20, height: 20,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: sel ? AppC.n7 : Colors.transparent,
                border: Border.all(color: sel ? AppC.n7 : AppC.bdr, width: 2)),
              child: sel ? Center(child: Container(width: 8, height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white))) : null),
          ])));
    }).toList(),
    const SizedBox(height: 8),

    // Pembayaran
    Text('Metode Pembayaran', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppC.n8)),
    const SizedBox(height: 10),
    ...paymentData.asMap().entries.map((e) {
      final i = e.key; final p = e.value; final sel = _metodeIdx == i;
      return GestureDetector(
        onTap: () => setState(() => _metodeIdx = i),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(bottom: 9),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: sel ? AppC.n0 : AppC.w,
            border: Border.all(color: sel ? AppC.n5 : Colors.transparent, width: 2.5),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.07), blurRadius: 8)]),
          child: Row(children: [
            Container(width: 44, height: 44,
              decoration: BoxDecoration(color: AppC.n0, borderRadius: BorderRadius.circular(13)),
              child: Icon(p.icon, size: 20, color: AppC.n5)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p.nama, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: AppC.n8)),
              Text(p.detail, style: const TextStyle(fontSize: 11.5, color: AppC.mut)),
            ])),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20, height: 20,
              decoration: BoxDecoration(shape: BoxShape.circle,
                color: sel ? AppC.n7 : Colors.transparent,
                border: Border.all(color: sel ? AppC.n7 : AppC.bdr, width: 2)),
              child: sel ? Center(child: Container(width: 8, height: 8,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white))) : null),
          ])));
    }).toList(),
    const SizedBox(height: 8),

    // Rincian harga
    Text('Rincian Harga', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: AppC.n8)),
    const SizedBox(height: 10),
    Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(gradient: AppC.darkGrad, borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        HargaRow(label: 'Biaya Jenis Bahan (${_jenis?.nama})', value: fmtRp(_hJ)),
        HargaRow(label: 'Biaya Layanan (${_layanan?.nama})',   value: '+ ${fmtRp(_hL)}'),
        HargaRow(label: 'Harga per Pasang',                    value: fmtRp(_hS)),
        HargaRow(label: 'Jumlah',                              value: '× $_qty pasang'),
        HargaRow(label: 'Ongkos Jemput', value: 'Gratis',     valueColor: AppC.n2),
        const Divider(color: Colors.white12, height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Total Bayar', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white.withOpacity(.55))),
          Text(fmtRp(_tot),
            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
        ]),
      ])),
  ]);
}