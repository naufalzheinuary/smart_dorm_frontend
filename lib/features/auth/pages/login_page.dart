import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/logo_sdl.png',
              height: 150,
            ),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                'Selamat Datang',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Center(
              child: Text(
                'Login to Smart Dorm',
              ),
            ),

            const SizedBox(height: 32),

            const CustomTextField(
              hintText: 'Email',
            ),

            const SizedBox(height: 16),

            const CustomTextField(
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 24),

            CustomButton(
              text: 'Login',
              onPressed: () {context.go('/home');
              },
            ),

            const SizedBox(height: 16),

            TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text(
                'Belum punya akun? Daftar',
              ),
            ),

          ],
        ),
      ),
    );
  }
}