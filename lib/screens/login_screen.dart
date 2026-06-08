import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';
import 'main_screen.dart';
import 'register_screen.dart';
import 'onboarding_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const AuthHeader(title: 'Selamat\nDatang!', subtitle: 'Masuk untuk melanjutkan ke ShoeCare'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const AppInput(label: 'Email / No. Telepon', hint: 'ahmad@email.com',      icon: Icons.email_outlined),
            const SizedBox(height: 14),
            const AppInput(label: 'Kata Sandi',          hint: 'Masukkan kata sandi',  icon: Icons.lock_outline_rounded, obscure: true),
            const SizedBox(height: 6),
            Align(alignment: Alignment.centerRight,
              child: GestureDetector(onTap: () {},
                child: const Text('Lupa kata sandi?',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppC.n4)))),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Masuk',
              icon: Icons.login_rounded,
              onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MainScreen()))),
            const SizedBox(height: 18),
            _divider(),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _socialBtn('G', 'Google',   const Color(0xFF4285F4))),
              const SizedBox(width: 10),
              Expanded(child: _socialBtn('f', 'Facebook', const Color(0xFF1877F2))),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Belum punya akun?  ', style: TextStyle(fontSize: 13, color: AppC.mut)),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                child: const Text('Daftar gratis',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n5))),
            ]),
          ]))),
      ]),
    );
  }

  Widget _divider() => Row(children: [
    const Expanded(child: Divider(color: AppC.bdr)),
    Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text('atau masuk dengan', style: const TextStyle(fontSize: 11.5, color: AppC.mut))),
    const Expanded(child: Divider(color: AppC.bdr)),
  ]);

  Widget _socialBtn(String letter, String label, Color bg) => OutlinedButton(
    onPressed: () {},
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppC.bdr, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      padding: const EdgeInsets.symmetric(vertical: 12)),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(width: 20, height: 20,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text(letter,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)))),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppC.n7)),
    ]));
}