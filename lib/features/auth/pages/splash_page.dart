import 'dart:async';

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() =>
      _SplashPageState();
}

class _SplashPageState
    extends State<SplashPage> {

  @override
  void initState() {

    super.initState();

    checkLogin();

  }

  // ================= CHECK LOGIN =================

  Future<void> checkLogin() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    final user =
        FirebaseAuth.instance.currentUser;

    // ================= BELUM LOGIN =================

    if (user == null) {

      if (mounted) {

        context.go('/login');

      }

      return;
    }

    // ================= CEK ROLE =================

    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

    final data =
        doc.data();

    final role =
        data?['role'];

    // ================= ADMIN =================

    if (role == 'admin') {

      if (mounted) {

        context.go('/admin');

      }

    }

    // ================= USER =================

    else {

      if (mounted) {

        context.go('/home');

      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment:
              MainAxisAlignment.center,

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

                fontWeight:
                    FontWeight.bold,

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