import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/widgets/app_bottom_navbar.dart';
import '../../../core/widgets/app_header.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(
        children: [

          const AppHeader(
            title: 'Notifikasi',
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance
                  .collection('access_logs')
                  .orderBy(
                    'timestamp',
                    descending: true,
                  )
                  .limit(20)
                  .snapshots(),

              builder: (context, snapshot) {

                // ================= LOADING =================
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // ================= ERROR =================
                if (snapshot.hasError) {

                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                    ),
                  );
                }

                // ================= EMPTY =================
                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {

                  return const Center(
                    child: Text(
                      'Belum ada notifikasi',
                    ),
                  );
                }

                final notifications =
                    snapshot.data!.docs;

                return ListView.builder(

                  itemCount: notifications.length,

                  itemBuilder: (context, index) {

                    final data =
                        notifications[index];

                    final user =
                        data['user_name'] ?? 'Unknown';

                    final method =
                        data['method'] ?? '-';

                    final status =
                        data['status'] ?? '-';

                    String title;
                    String subtitle;

                    // ================= GRANTED =================
                    if (status == "GRANTED") {

                      title =
                          'Pintu Berhasil Dibuka';

                      subtitle =
                          '$user menggunakan $method';
                    }

                    // ================= DENIED =================
                    else if (
                        status == "DENIED") {

                      title =
                          'Percobaan Akses Gagal';

                      subtitle =
                          '$user gagal autentikasi';
                    }

                    // ================= MISMATCH =================
                    else if (
                        status == "MISMATCH") {

                      title =
                          'Autentikasi Tidak Cocok';

                      subtitle =
                          '$user mismatch credential';
                    }

                    // ================= RFID FAILED =================
                    else if (
                        status == "RFID_FAILED") {

                      title =
                          'RFID Gagal';

                      subtitle =
                          '$user gagal verifikasi RFID';
                    }

                    // ================= DEFAULT =================
                    else {

                      title = status;

                      subtitle =
                          '$user • $method';
                    }

                    return _buildNotificationItem(
                      title: title,
                      subtitle: subtitle,
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),

      bottomNavigationBar: const AppBottomNavbar(
        currentIndex: 2,
      ),

    );
  }
}

Widget _buildNotificationItem({
  required String title,
  required String subtitle,
}) {

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 6,
    ),

    child: Container(
      width: double.infinity,

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),

        ],
      ),
    ),
  );
}