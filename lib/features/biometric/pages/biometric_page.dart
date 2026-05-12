import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({super.key});

  @override
  State<BiometricPage> createState() =>
      _BiometricPageState();
}

class _BiometricPageState
    extends State<BiometricPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor:
          const Color(0xFFF5F7FB),

      body: StreamBuilder<DocumentSnapshot>(

        stream: FirebaseFirestore.instance
            .collection('auth_state')
            .doc('current')
            .snapshots(),

        builder: (context, snapshot) {

          // ================= LOADING =================
          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
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
              !snapshot.data!.exists) {

            return const Center(
              child: Text(
                'Belum ada data biometric',
              ),
            );
          }

          final data =
              snapshot.data!.data()
                  as Map<String, dynamic>;

          final currentStep =
              data['current_step'] ??
                  'Face Recognition';

          final statusText =
              data['status_text'] ?? '-';

          final faceAttempt =
              data['face_attempt'] ?? 0;

          final fingerprintAttempt =
              data['fingerprint_attempt'] ?? 0;

          final rfidAttempt =
              data['rfid_attempt'] ?? 0;

          final accessGranted =
              data['access_granted'] ??
                  false;

          final accessDenied =
              data['access_denied'] ??
                  false;

          return SingleChildScrollView(
            child: Column(
              children: [

                // =========================
                // HEADER
                // =========================

                Container(
                  width: double.infinity,

                  padding:
                      const EdgeInsets.only(
                    top: 55,
                    left: 24,
                    right: 24,
                    bottom: 24,
                  ),

                  decoration:
                      const BoxDecoration(
                    color:
                        Color(0xFF1565C0),
                  ),

                  child: Row(
                    children: [

                      GestureDetector(
                        onTap: () {
                          context.go('/home');
                        },

                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(
                          width: 16),

                      const Text(
                        'Biometric Authentication',

                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 24,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // STATUS CARD
                // =========================

                Container(
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 24,
                  ),

                  padding:
                      const EdgeInsets.all(
                          24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 10,

                        offset:
                            const Offset(
                                0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      const Text(
                        'Current Authentication Step',

                        style: TextStyle(
                          fontSize: 16,
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      Text(
                        currentStep,

                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 20),

                      Text(
                        statusText,

                        textAlign:
                            TextAlign.center,

                        style:
                            const TextStyle(
                          fontSize: 18,
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // =========================
                // DEVICE STATUS
                // =========================

                Container(
                  margin:
                      const EdgeInsets
                          .symmetric(
                    horizontal: 24,
                  ),

                  padding:
                      const EdgeInsets.all(
                          24),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                            24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withOpacity(0.05),

                        blurRadius: 10,

                        offset:
                            const Offset(
                                0, 4),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [

                      _buildAttemptRow(
                        title:
                            'Face Recognition',

                        value: faceAttempt == -1
                            ? 'MATCH'
                            : '$faceAttempt/3',
                      ),

                      const SizedBox(
                          height: 20),

                      _buildAttemptRow(
                        title:
                            'Fingerprint',

                        value: fingerprintAttempt == -1
                            ? 'MATCH'
                            : '$fingerprintAttempt/3',
                      ),

                      const SizedBox(
                          height: 20),

                      _buildAttemptRow(
                        title:
                            'RFID Verification',

                        value: rfidAttempt == -1
                            ? 'MATCH'
                            : '$rfidAttempt/3',
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // =========================
                // ACCESS GRANTED
                // =========================

                if (accessGranted)

                  Container(
                    margin:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 24,
                    ),

                    padding:
                        const EdgeInsets
                            .all(24),

                    decoration:
                        BoxDecoration(
                      color: Colors
                          .green.shade100,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  24),
                    ),

                    child: const Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        Icon(
                          Icons
                              .check_circle,

                          color:
                              Colors.green,
                        ),

                        SizedBox(width: 12),

                        Text(
                          'ACCESS GRANTED',

                          style:
                              TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .bold,

                            color:
                                Colors
                                    .green,
                          ),
                        ),

                      ],
                    ),
                  ),

                // =========================
                // ACCESS DENIED
                // =========================

                if (accessDenied)

                  Container(
                    margin:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 24,
                    ),

                    padding:
                        const EdgeInsets
                            .all(24),

                    decoration:
                        BoxDecoration(
                      color:
                          Colors.red.shade100,

                      borderRadius:
                          BorderRadius
                              .circular(
                                  24),
                    ),

                    child: const Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [

                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),

                        SizedBox(width: 12),

                        Text(
                          'ACCESS DENIED',

                          style:
                              TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .bold,

                            color:
                                Colors.red,
                          ),
                        ),

                      ],
                    ),
                  ),

                const SizedBox(height: 40),

              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _buildAttemptRow({
  required String title,
  required String value,
}) {

  return Row(
    mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

    children: [

      Text(
        title,

        style: const TextStyle(
          fontSize: 16,
        ),
      ),

      Text(
        value,

        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),

    ],
  );
}