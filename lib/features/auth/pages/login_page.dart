import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Padding(

        padding:
            const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          mainAxisAlignment:
              MainAxisAlignment.center,

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
                  fontWeight:
                      FontWeight.bold,
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

            CustomTextField(
              controller:
                  _emailController,
              hintText: 'Email',
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller:
                  _passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 24),

            CustomButton(

              text: isLoading
                  ? 'Loading...'
                  : 'Login',

              onPressed: () async {

                if (isLoading) return;

                setState(() {
                  isLoading = true;
                });

                final error =
                    await AuthService()
                        .login(

                  email:
                      _emailController.text
                          .trim(),

                  password:
                      _passwordController
                          .text
                          .trim(),

                );

                if (error != null) {

                  setState(() {
                    isLoading = false;
                  });

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(

                    SnackBar(
                      content:
                          Text(error),
                    ),

                  );

                  return;
                }

                final role =
                    await AuthService()
                        .getRole();

                setState(() {
                  isLoading = false;
                });

                // ADMIN
                if (role == 'admin') {

                  context.go('/admin');

                }

                // USER
                else {

                  context.go('/home');

                }

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