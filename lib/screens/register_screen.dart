import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../widgets/shared.dart';
import 'main_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppC.ow,
      body: Column(children: [
        const AuthHeader(
          title: 'Buat Akun\nBaru',
          subtitle: 'Daftar sekarang dan mulai perawatan sepatumu'),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 26, 24, 32),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: const [
              Expanded(child: AppInput(label: 'Nama Depan',   hint: 'Ahmad',  icon: Icons.person_outline_rounded)),
              SizedBox(width: 12),
              Expanded(child: AppInput(label: 'Nama Belakang', hint: 'Farhan', icon: Icons.person_outline_rounded)),
            ]),
            const SizedBox(height: 14),
            const AppInput(label: 'Email',                hint: 'ahmad@email.com',     icon: Icons.email_outlined),
            const SizedBox(height: 14),
            const AppInput(label: 'No. Telepon',          hint: '+62 812 3456 7890',   icon: Icons.phone_outlined),
            const SizedBox(height: 14),
            const AppInput(label: 'Kota',                 hint: 'Jakarta',             icon: Icons.location_on_outlined),
            const SizedBox(height: 14),
            const AppInput(label: 'Kata Sandi',           hint: 'Min. 8 karakter',     icon: Icons.lock_outline_rounded, obscure: true),
            const SizedBox(height: 14),
            const AppInput(label: 'Konfirmasi Kata Sandi', hint: 'Ulangi kata sandi',  icon: Icons.lock_outline_rounded, obscure: true),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Buat Akun',
              icon: Icons.check_rounded,
              onTap: () => Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const MainScreen()))),
            const SizedBox(height: 18),
            Row(children: const [
              Expanded(child: Divider(color: AppC.bdr)),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('atau daftar dengan', style: TextStyle(fontSize: 11.5, color: AppC.mut))),
              Expanded(child: Divider(color: AppC.bdr)),
            ]),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppC.bdr, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                padding: const EdgeInsets.symmetric(vertical: 12)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 20, height: 20,
                  decoration: BoxDecoration(color: const Color(0xFF4285F4), borderRadius: BorderRadius.circular(4)),
                  child: const Center(child: Text('G',
                    style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)))),
                const SizedBox(width: 8),
                const Text('Lanjutkan dengan Google',
                  style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppC.n7)),
              ])),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('Sudah punya akun?  ', style: TextStyle(fontSize: 13, color: AppC.mut)),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                child: const Text('Masuk di sini',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppC.n5))),
            ]),
          ]))),
      ]),
    );
  }
}