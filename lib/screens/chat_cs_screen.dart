import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/colors.dart';

// ── Model ──────────────────────────────────────
class _Msg {
  final String text, time;
  final bool isCs;
  const _Msg({required this.text, required this.isCs, required this.time});
}

// ── Main Screen ────────────────────────────────
class ChatCsScreen extends StatefulWidget {
  const ChatCsScreen({super.key});
  @override
  State<ChatCsScreen> createState() => _ChatCsScreenState();
}

class _ChatCsScreenState extends State<ChatCsScreen> {
  final _ctrl   = TextEditingController();
  final _scroll = ScrollController();
  bool _isTyping = false;

  final List<_Msg> _messages = [
    const _Msg(
      text: 'Halo! Selamat datang di ShoeCare Customer Service 👟\nAda yang bisa kami bantu?',
      isCs: true,
      time: '08.00',
    ),
  ];

  static const _quickReplies = [
    'Status pesanan saya',
    'Cara penjemputan',
    'Metode pembayaran',
    'Lacak pesanan',
    'Keluhan layanan',
  ];

  static const Map<String, String> _autoReply = {
    'status pesanan'  : 'Kamu bisa cek status pesanan di menu Riwayat → pilih pesanan → Lacak Pesanan. Jika ada kendala, kabari kami ya!',
    'cara penjemputan': 'Setelah memesan, kurir kami akan menjemput sepatu ke alamatmu dalam 30–60 menit. Pastikan alamat sudah benar saat checkout.',
    'metode pembayaran': 'Kami menerima GoPay, OVO, DANA, ShopeePay, Transfer Bank BCA/Mandiri/BNI, dan COD (bayar saat jemput).',
    'lacak pesanan'   : 'Buka menu Riwayat, pilih pesanan aktif, lalu tap "Lacak Pesanan" untuk melihat posisi kurir secara real-time.',
    'keluhan layanan' : 'Maaf atas ketidaknyamanannya! Mohon ceritakan keluhanmu, kami akan segera menindaklanjuti dalam 1x24 jam.',
  };

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  String _nowTime() {
    final t = TimeOfDay.now();
    final h = t.hour.toString().padLeft(2, "0");
    final m = t.minute.toString().padLeft(2, "0");
    return "$h.$m";
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut);
      }
    });
  }

  void _send(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(_Msg(text: text.trim(), isCs: false, time: _nowTime()));
      _ctrl.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    String reply = 'Terima kasih pesannya! Tim CS kami sedang memproses. Mohon tunggu sebentar ya 🙏';
    final lower = text.toLowerCase();
    for (final entry in _autoReply.entries) {
      if (lower.contains(entry.key)) {
        reply = entry.value;
        break;
      }
    }

    Future.delayed(const Duration(milliseconds: 1300), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(_Msg(text: reply, isCs: true, time: _nowTime()));
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final top    = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        // ── Header ──
        Container(
          width: double.infinity,
          color: AppC.n8,
          padding: EdgeInsets.fromLTRB(16, top + 10, 16, 16),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.1),
                  border: Border.all(color: Colors.white.withOpacity(.16)),
                  borderRadius: BorderRadius.circular(11)),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 16))),
            const SizedBox(width: 12),
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                gradient: AppC.navyGrad,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: AppC.n5.withOpacity(.4), blurRadius: 8, offset: const Offset(0, 3))]),
              child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 22)),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('ShoeCare CS',
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
              Row(children: [
                Container(width: 7, height: 7,
                  decoration: const BoxDecoration(color: Color(0xFF4ADE80), shape: BoxShape.circle)),
                const SizedBox(width: 5),
                Text('Online',
                  style: TextStyle(fontSize: 11.5, color: Colors.white.withOpacity(.6))),
              ]),
            ])),
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.1),
                borderRadius: BorderRadius.circular(10)),
              child: Icon(Icons.phone_rounded, color: Colors.white.withOpacity(.8), size: 18)),
          ])),

        // ── Messages ──
        Expanded(child: ListView.builder(
          controller: _scroll,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          itemCount: _messages.length + (_isTyping ? 1 : 0),
          itemBuilder: (_, i) {
            if (_isTyping && i == _messages.length) return const _TypingBubble();
            return _BubbleWidget(msg: _messages[i]);
          })),

        // ── Quick replies ──
        if (_messages.isNotEmpty && _messages.last.isCs && !_isTyping)
          SizedBox(
            height: 44,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _quickReplies.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => _send(_quickReplies[i]),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppC.w,
                    border: Border.all(color: AppC.n1, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.06), blurRadius: 6)]),
                  child: Text(_quickReplies[i],
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppC.n6)))))),

        // ── Input bar ──
        Container(
          padding: EdgeInsets.fromLTRB(12, 10, 12, bottom + 10),
          decoration: BoxDecoration(
            color: AppC.w,
            border: const Border(top: BorderSide(color: AppC.bdr, width: 1.5)),
            boxShadow: [
              BoxShadow(color: AppC.n7.withOpacity(.06), blurRadius: 10, offset: const Offset(0, -3)),
            ]),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppC.ow,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppC.bdr, width: 1.5)),
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      Expanded(
                        child: TextField(
                          controller: _ctrl,
                          style: const TextStyle(fontSize: 14, color: AppC.n7),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: _send,
                          decoration: const InputDecoration(
                            hintText: 'Ketik pesan...',
                            hintStyle: TextStyle(color: AppC.mut, fontSize: 14),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 10)))),
                      const SizedBox(width: 4),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(Icons.attach_file_rounded, color: AppC.mut, size: 20)),
                    ]))),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => _send(_ctrl.text),
                child: Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    gradient: AppC.navyGrad,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(color: AppC.n5.withOpacity(.35), blurRadius: 10, offset: const Offset(0, 3)),
                    ]),
                  child: const Icon(Icons.send_rounded, color: Colors.white, size: 18))),
            ])),
      ]));
  }
}

// ── Chat bubble ────────────────────────────────
class _BubbleWidget extends StatelessWidget {
  final _Msg msg;
  const _BubbleWidget({required this.msg});

  @override
  Widget build(BuildContext context) {
    final isCs = msg.isCs;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isCs ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isCs) ...[
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(gradient: AppC.navyGrad, borderRadius: BorderRadius.circular(9)),
              child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 16)),
            const SizedBox(width: 8),
          ],
          Flexible(child: Column(
            crossAxisAlignment: isCs ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isCs ? AppC.w : AppC.n7,
                  borderRadius: BorderRadius.only(
                    topLeft:     const Radius.circular(16),
                    topRight:    const Radius.circular(16),
                    bottomLeft:  Radius.circular(isCs ? 4 : 16),
                    bottomRight: Radius.circular(isCs ? 16 : 4)),
                  boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.08), blurRadius: 8, offset: const Offset(0, 2))]),
                child: Text(msg.text,
                  style: TextStyle(fontSize: 13.5, height: 1.45, color: isCs ? AppC.n8 : Colors.white))),
              const SizedBox(height: 4),
              Row(mainAxisSize: MainAxisSize.min, children: [
                Text(msg.time, style: const TextStyle(fontSize: 10.5, color: AppC.mut)),
                if (!isCs) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all_rounded, size: 13, color: AppC.n3),
                ],
              ]),
            ])),
          if (!isCs) const SizedBox(width: 4),
        ]));
  }
}

// ── Typing indicator ───────────────────────────
class _TypingBubble extends StatefulWidget {
  const _TypingBubble();
  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(gradient: AppC.navyGrad, borderRadius: BorderRadius.circular(9)),
          child: const Icon(Icons.support_agent_rounded, color: Colors.white, size: 16)),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: AppC.w,
            borderRadius: const BorderRadius.only(
              topLeft:    Radius.circular(16),
              topRight:   Radius.circular(16),
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(16)),
            boxShadow: [BoxShadow(color: AppC.n7.withOpacity(.08), blurRadius: 8)]),
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                final val = ((_ctrl.value + i * 0.3) % 1.0);
                final dy  = val < 0.5 ? val * 2 : (1 - val) * 2;
                return Transform.translate(
                  offset: Offset(0, -5 * dy),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: 7, height: 7,
                    decoration: const BoxDecoration(color: AppC.mut, shape: BoxShape.circle)));
              })))),
      ]));
  }
}