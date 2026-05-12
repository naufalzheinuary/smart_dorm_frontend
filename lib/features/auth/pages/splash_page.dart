import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () {
        context.go('/login');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset(
              'assets/images/logo_sdl.png',
              height: 180,
            ),

            const SizedBox(height: 24),

            const Text(
              'Smart Dorm Lock',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            const CircularProgressIndicator(),

          ],
        ),
      ),
    );
  }
}