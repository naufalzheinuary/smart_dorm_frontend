import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  final _nameController =
      TextEditingController();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final _confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        title: const Text('Daftar Akun'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24),

          child: ConstrainedBox(

            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context)
                      .size
                      .height -
                  100,
            ),

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [

                const Center(
                  child: Text(
                    'Daftar Akun',
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
                    'Buat akun Smart Dorm',
                  ),
                ),

                const SizedBox(height: 32),

                CustomTextField(
                  controller:
                      _nameController,
                  hintText:
                      'Nama Lengkap',
                ),

                const SizedBox(height: 16),

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

                const SizedBox(height: 16),

                CustomTextField(
                  controller:
                      _confirmPasswordController,
                  hintText:
                      'Konfirmasi Password',
                  obscureText: true,
                ),

                const SizedBox(height: 24),

                CustomButton(

                  text: isLoading
                      ? 'Loading...'
                      : 'Daftar',

                  onPressed: () async {

                    if (isLoading) return;

                    if (_nameController.text
                        .trim()
                        .isEmpty) {

                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            'Nama wajib diisi',
                          ),
                        ),

                      );

                      return;
                    }

                    if (_emailController.text
                        .trim()
                        .isEmpty) {

                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            'Email wajib diisi',
                          ),
                        ),

                      );

                      return;
                    }

                    if (_passwordController
                        .text
                        .trim()
                        .isEmpty) {

                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            'Password wajib diisi',
                          ),
                        ),

                      );

                      return;
                    }

                    if (_passwordController
                            .text !=
                        _confirmPasswordController
                            .text) {

                      ScaffoldMessenger.of(
                              context)
                          .showSnackBar(

                        const SnackBar(
                          content: Text(
                            'Password tidak sama',
                          ),
                        ),

                      );

                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });

                    final error =
                        await AuthService()
                            .register(

                      name:
                          _nameController.text
                              .trim(),

                      email:
                          _emailController.text
                              .trim(),

                      password:
                          _passwordController
                              .text
                              .trim(),

                    );

                    setState(() {
                      isLoading = false;
                    });

                    if (error != null) {

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

                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          'Register berhasil',
                        ),
                      ),

                    );

                    context.go('/login');

                  },

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
        ),
      ),
    );
  }
}