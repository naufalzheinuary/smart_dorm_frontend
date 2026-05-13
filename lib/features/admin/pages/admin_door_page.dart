import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class AdminDoorPage extends StatelessWidget {
  const AdminDoorPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ================= APPBAR =================

      appBar: AppBar(

        leading: IconButton(

          onPressed: () {

            context.go('/admin');

          },

          icon: const Icon(
            Icons.arrow_back,
          ),

        ),

        title: const Text(
          'Emergency Open Door',
        ),

      ),

      // ================= BODY =================

      body: StreamBuilder<DocumentSnapshot>(

        stream: FirebaseFirestore
            .instance
            .collection('system_control')
            .doc('main_door')
            .snapshots(),

        builder: (context, snapshot) {

          bool isUnlocked = false;

          if (snapshot.hasData &&
              snapshot.data!.exists) {

            final data =
                snapshot.data!.data()
                    as Map<String, dynamic>;

            isUnlocked =
                data['emergency_unlock']
                    ?? false;

          }

          return Padding(

            padding:
                const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.stretch,

              children: [

                // ================= ICON =================

                Icon(

                  isUnlocked
                      ? Icons.lock_open
                      : Icons.lock,

                  size: 120,

                  color: isUnlocked
                      ? Colors.green
                      : Colors.red,

                ),

                const SizedBox(height: 32),

                // ================= STATUS =================

                Text(

                  isUnlocked
                      ? 'DOOR UNLOCKED'
                      : 'DOOR LOCKED',

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight:
                        FontWeight.bold,

                    color: isUnlocked
                        ? Colors.green
                        : Colors.red,

                  ),
                ),

                const SizedBox(height: 16),

                // ================= WARNING =================

                const Text(

                  'Gunakan hanya untuk kondisi darurat.',

                  textAlign:
                      TextAlign.center,

                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 48),

                // ================= BUTTON =================

                SizedBox(

                  height: 70,

                  child: ElevatedButton.icon(

                    style:
                        ElevatedButton.styleFrom(

                      backgroundColor:
                          Colors.red,

                    ),

                    onPressed: () async {

                      await FirebaseFirestore
                          .instance
                          .collection(
                              'system_control')
                          .doc('main_door')
                          .set({

                        'emergency_unlock':
                            true,

                        'updated_at':
                            Timestamp.now(),

                      });

                      if (context.mounted) {

                        ScaffoldMessenger.of(
                                context)
                            .showSnackBar(

                          const SnackBar(

                            content: Text(
                              'Emergency unlock sent!',
                            ),

                          ),

                        );
                      }

                    },

                    icon: const Icon(
                      Icons.warning,
                      color: Colors.white,
                    ),

                    label: const Text(

                      'EMERGENCY OPEN DOOR',

                      style: TextStyle(

                        color: Colors.white,

                        fontSize: 18,

                        fontWeight:
                            FontWeight.bold,

                      ),
                    ),
                  ),
                ),

              ],
            ),
          );
        },
      ),
    );
  }
}