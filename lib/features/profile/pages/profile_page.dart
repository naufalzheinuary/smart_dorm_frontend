import 'package:flutter/material.dart';
import '../../../core/widgets/app_bottom_navbar.dart';
import '../../../core/widgets/app_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            const AppHeader(
              title: 'Profil Saya',
            ),

            const SizedBox(height: 25),

            const CircleAvatar(
              radius: 60,
              backgroundColor: Color(0xFF1565C0),
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Naufal Azriel',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'naufal@email.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: Container(
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    _buildProfileItem(
                      icon: Icons.badge,
                      title: 'NIM',
                      value: '10101010',
                    ),

                    const SizedBox(height: 20),

                    _buildProfileItem(
                      icon: Icons.home,
                      title: 'Kamar',
                      value: '01 - Kamar 01',
                    ),

                    const SizedBox(height: 20),

                    _buildProfileItem(
                      icon: Icons.security,
                      title: 'Role',
                      value: 'Penghuni',
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {},

                  child: const Text('Logout'),
                ),
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavbar(
        currentIndex: 3,
      ),

    );
  }
}

Widget _buildProfileItem({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Row(
    children: [

      Icon(
        icon,
        color: const Color(0xFF1565C0),
      ),

      const SizedBox(width: 16),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),

    ],
  );
}