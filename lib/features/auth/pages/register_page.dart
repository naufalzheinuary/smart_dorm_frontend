import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Akun'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Center(
              child: Text(
                'Daftar Akun',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                'Buat akun Smart Dorm',
              ),
            ),

            const SizedBox(height: 32),

            const CustomTextField(
              hintText: 'Nama Lengkap',
            ),

            const SizedBox(height: 16),

            const CustomTextField(
              hintText: 'Email',
            ),

            const SizedBox(height: 16),

            const CustomTextField(
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 16),

            const CustomTextField(
              hintText: 'Konfirmasi Password',
              obscureText: true,
            ),

            const SizedBox(height: 24),

            CustomButton(
              text: 'Daftar',
              onPressed: () {},
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text(
                'Sudah punya akun? Login',
              ),
            ),

          ],
        ),
      ),

    );
  }
}