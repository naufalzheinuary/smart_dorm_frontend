import 'package:flutter/material.dart';
import '../../../core/widgets/app_bottom_navbar.dart';
import '../../../core/widgets/app_header.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            const AppHeader(
              title: 'Notifikasi',
            ),

            const SizedBox(height: 24),

            _buildNotificationItem(
              icon: Icons.lock_open,
              title: 'Pintu Berhasil Dibuka',
              subtitle: 'Face Recognition berhasil',
            ),

            _buildNotificationItem(
              icon: Icons.warning,
              title: 'Percobaan Akses Gagal',
              subtitle: 'Fingerprint tidak dikenali',
            ),

            _buildNotificationItem(
              icon: Icons.wifi_off,
              title: 'Device Offline',
              subtitle: 'Raspberry Pi terputus',
            ),

          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavbar(
        currentIndex: 2,
      ),

    );
  }
}

Widget _buildNotificationItem({
  required IconData icon,
  required String title,
  required String subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 24,
      vertical: 8,
    ),

    child: Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color: const Color(0xFF1565C0).withOpacity(0.1),

              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: const Color(0xFF1565C0),
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

              ],
            ),
          ),

        ],
      ),
    ),
  );
}