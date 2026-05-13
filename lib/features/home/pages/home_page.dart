import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/widgets/app_bottom_navbar.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final currentUser =
        FirebaseAuth.instance.currentUser;

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            const AppHeader(
              title: 'Smart Dorm Lock',
            ),

            Padding(
              padding: const EdgeInsets.all(24),

              child: FutureBuilder<DocumentSnapshot>(

                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser!.uid)
                    .get(),

                builder: (context, userSnapshot) {

                  // ================= LOADING USER =================

                  if (userSnapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const AppCard(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  }

                  // ================= USER NOT FOUND =================

                  if (!userSnapshot.hasData ||
                      !userSnapshot.data!.exists) {

                    return const AppCard(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          'Data user tidak ditemukan',
                        ),
                      ),
                    );
                  }

                  // ================= USER DATA =================

                  final userData =
                      userSnapshot.data!.data()
                          as Map<String, dynamic>;

                  final name =
                      userData['name'] ?? '-';

                  final nim =
                      userData['nim'] ?? '-';

                  final building =
                      userData['building'] ?? '-';

                  final room =
                      userData['room'] ?? '-';

                  return StreamBuilder<QuerySnapshot>(

                    stream: FirebaseFirestore.instance
                        .collection('access_logs')
                        .orderBy(
                          'timestamp',
                          descending: true,
                        )
                        .limit(1)
                        .snapshots(),

                    builder: (context, snapshot) {

                      // ================= LOADING =================

                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {

                        return const AppCard(
                          child: Padding(
                            padding: EdgeInsets.all(30),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      }

                      // ================= EMPTY =================

                      if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {

                        return const AppCard(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Text(
                              'Belum ada data akses',
                            ),
                          ),
                        );
                      }

                      final latest =
                          snapshot.data!.docs.first;

                      final data =
                          latest.data()
                              as Map<String, dynamic>;

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

                      return AppCard(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              'NIM: $nim',
                              style: const TextStyle(
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 10),

                            StreamBuilder<DocumentSnapshot>(

                              stream: FirebaseFirestore.instance
                                  .collection('door_status')
                                  .doc('current')
                                  .snapshots(),

                              builder: (context, doorSnapshot) {

                                bool isOpen = false;

                                if (doorSnapshot.hasData &&
                                    doorSnapshot.data!.exists) {

                                  final doorData =
                                      doorSnapshot.data!.data()
                                          as Map<String, dynamic>;

                                  final doorStatus =
                                      doorData['status'] ?? 'LOCKED';

                                  isOpen =
                                      doorStatus == "OPEN";
                                }

                                return Row(
                                  children: [

                                    const Text(
                                      'Status Pintu Kamar : ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                    Text(

                                      isOpen
                                          ? 'Terbuka'
                                          : 'Terkunci',

                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,

                                        color: isOpen
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),

                            const SizedBox(height: 15),

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,

                              children: [

                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Text(
                                      'Gedung',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      'Gedung $building - Kamar $room',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),

                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,

                                  children: [

                                    const Text(
                                      'Akses Terakhir',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      formattedTime,

                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),

                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),

              child: SizedBox(
                width: double.infinity,
                height: 200,

                child: AppCard(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Icon(
                        Icons.videocam,
                        size: 80,
                        color: Colors.grey.shade400,
                      ),

                      const SizedBox(height: 5),

                      Text(
                        'Preview Kamera Disini',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),

              child: Align(
                alignment: Alignment.centerLeft,

                child: Text(
                  'Fitur Aplikasi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Column(
                children: [

                  GestureDetector(
                    onTap: () async {

                      await FirebaseFirestore.instance
                          .collection('system_control')
                          .doc('auth_trigger')
                          .set({

                        'start_auth': true,
                        'timestamp':
                            FieldValue.serverTimestamp(),
                      });

                      context.go('/biometric');
                    },

                    child: Container(
                      width: 90,
                      height: 90,

                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0),

                        borderRadius: BorderRadius.circular(15),

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.power_settings_new,
                        size: 55,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Scan Biometric',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),

      bottomNavigationBar: const AppBottomNavbar(
        currentIndex: 0,
      ),

    );
  }
}