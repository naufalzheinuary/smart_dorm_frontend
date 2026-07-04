import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:go_router/go_router.dart';

class AdminMaintenancePage extends StatelessWidget {
  const AdminMaintenancePage({super.key});

  Future<void> sendAction(
    BuildContext context,
    String action,
  ) async {

    try {

      await FirebaseFirestore.instance
          .collection('system_control')
          .doc('maintenance_trigger')
          .set({

        'action': action,
        'status': 'pending',

        'timestamp':
            FieldValue.serverTimestamp(),

      }, SetOptions(merge: true));

      if (context.mounted) {

        ScaffoldMessenger.of(context)
            .showSnackBar(

          SnackBar(
            content: Text(
              '$action dikirim'
            ),
          ),

        );
      }

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content: Text(
            'Error: $e'
          ),
        ),

      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
          ),

          onPressed: () {

            context.go('/admin');

          },

        ),

        title: const Text(
          'System Maintenance',
        ),

      ),

      body: Padding(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          children: [

            _actionButton(
              context,
              icon: Icons.camera_alt,
              title: "Restart Camera",
              action: "restart_camera",
            ),

            const SizedBox(height: 12),

            _actionButton(
              context,
              icon: Icons.fingerprint,
              title: "Restart Fingerprint",
              action: "restart_fingerprint",
            ),

            const SizedBox(height: 12),

            _actionButton(
              context,
              icon: Icons.contactless,
              title: "Restart RFID",
              action: "restart_rfid",
            ),

            const SizedBox(height: 12),

            _actionButton(
              context,
              icon: Icons.restart_alt,
              title: "Restart Semua Modul",
              action: "restart_all",
            ),

            const SizedBox(height: 24),

            StreamBuilder<DocumentSnapshot>(

              stream: FirebaseFirestore
                  .instance
                  .collection(
                    'system_control',
                  )
                  .doc(
                    'maintenance_trigger',
                  )
                  .snapshots(),

              builder:
                  (context, snapshot) {

                if (!snapshot.hasData) {

                  return const SizedBox();
                }

                final data =
                    snapshot.data!.data()
                        as Map<String, dynamic>?;

                final status =
                    data?['status'] ??
                        'idle';

                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [

                        CircleAvatar(
                          backgroundColor:
                              status == "success"
                                  ? Colors.green.shade100
                                  : status == "failed"
                                      ? Colors.red.shade100
                                      : Colors.orange.shade100,

                          child: Icon(
                            status == "success"
                                ? Icons.check_circle
                                : status == "failed"
                                    ? Icons.error
                                    : Icons.pending,
                            color:
                                status == "success"
                                    ? Colors.green
                                    : status == "failed"
                                        ? Colors.red
                                        : Colors.orange,
                          ),
                        ),

                        const SizedBox(width: 16),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              const Text(
                                "System Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                status.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15,
                                  color:
                                      status == "success"
                                          ? Colors.green
                                          : status == "failed"
                                              ? Colors.red
                                              : Colors.orange,
                                  fontWeight:
                                      FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(

    BuildContext context, {

    required IconData icon,
    required String title,
    required String action,

  }) {

    return SizedBox(

      width: double.infinity,
      height: 60,

      child: ElevatedButton.icon(

        icon: Icon(icon),

        label: Text(title),

        onPressed: () {

          sendAction(
            context,
            action,
          );
        },
      ),
    );
  }
}