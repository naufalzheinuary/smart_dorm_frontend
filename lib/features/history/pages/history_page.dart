import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/widgets/app_bottom_navbar.dart';
import '../../../core/widgets/app_header.dart';

class HistoryPage extends StatefulWidget {

  const HistoryPage({
    super.key,
  });

  @override
  State<HistoryPage>
      createState() =>
          _HistoryPageState();
}

class _HistoryPageState
    extends State<HistoryPage> {

  String role = 'user';

  bool isLoading = true;

  @override
  void initState() {

    super.initState();

    loadRole();
  }

  Future<void> loadRole() async {

    final uid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();

    role = doc['role'];

    setState(() {

      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final currentUid =
        FirebaseAuth
            .instance
            .currentUser!
            .uid;

    if (isLoading) {

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      body: Column(
        children: [

          const AppHeader(
            title: 'Riwayat Akses',
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(

              stream: (

                role == 'admin'

                    ? FirebaseFirestore.instance
                        .collection('access_logs')
                        .orderBy(
                          'timestamp',
                          descending: true,
                        )

                    : FirebaseFirestore.instance
                        .collection('access_logs')
                        .where(
                          'uid',
                          isEqualTo: currentUid,
                        )
                        .orderBy(
                          'timestamp',
                          descending: true,
                        )

              ).snapshots(),

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
                      'Belum ada riwayat akses',
                    ),
                  );
                }

                final logs = snapshot.data!.docs;

                return ListView.builder(

                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 12,
                  ),

                  itemCount: logs.length,

                  itemBuilder: (context, index) {

                    final data = logs[index];

                    final user =
                        data['user_name'] ?? 'Unknown';

                    final method =
                        data['method'] ?? '-';

                    final status =
                        data['status'] ?? '-';

                    final timestamp =
                        data['timestamp'] as Timestamp?;

                    String formattedTime = '-';

                    if (timestamp != null) {

                      formattedTime = DateFormat(
                        'HH:mm WIB',
                      ).format(
                        timestamp.toDate(),
                      );
                    }

                    return _buildHistoryItem(

                      title: status == "GRANTED"
                          ? 'Akses Diterima'
                          : 'Akses Ditolak',

                      subtitle:
                          '$user • $method',

                      time: formattedTime,
                    );
                  },
                );
              },
            ),
          ),

        ],
      ),

      bottomNavigationBar: const AppBottomNavbar(
        currentIndex: 1,
      ),

    );
  }
}

Widget _buildHistoryItem({
  required String title,
  required String subtitle,
  required String time,
}) {

  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 5,
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

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Expanded(
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

          const SizedBox(width: 12),

          Text(
            time,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
          ),

        ],
      ),
    ),
  );
}