import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavbar extends StatelessWidget {

  final int currentIndex;

  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      currentIndex: currentIndex,

      onTap: (index) {

        if (index == 0) {
          context.go('/home');
        }

        if (index == 1) {
          context.go('/history');
        }

        if (index == 2) {
          context.go('/notification');
        }

        if (index == 3) {
          context.go('/profile');
        }

      },

      type: BottomNavigationBarType.fixed,

      backgroundColor: const Color(0xFF1565C0),

      selectedItemColor: Colors.white,

      unselectedItemColor: Colors.white70,

      items: const [

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifikasi',
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Akun',
        ),

      ],
    );
  }
}