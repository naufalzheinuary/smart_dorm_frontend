import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const SmartDormApp());
}

class SmartDormApp extends StatelessWidget {
  const SmartDormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'Smart Dorm Lock',

      theme: AppTheme.lightTheme,

      routerConfig: appRouter,
    );
  }
}