import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {

  final String title;

  const AppHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.only(
        top: 40,
        left: 20,
        right: 20,
        bottom: 25,
      ),

      decoration: const BoxDecoration(
        color: Color(0xFF1565C0),
      ),

      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}