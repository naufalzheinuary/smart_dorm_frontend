import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class AdminDoorPage extends StatefulWidget {
  const AdminDoorPage({super.key});

  @override
  State<AdminDoorPage> createState() =>
      _AdminDoorPageState();
}

class _AdminDoorPageState
    extends State<AdminDoorPage> {

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  bool isLoading = false;

  // ================= OPEN DOOR =================

  Future<void> openDoor() async {

    try {

      setState(() {
        isLoading = true;
      });

      await _firestore
          .collection('system_control')
          .doc('main_door')
          .set({

        'emergency_unlock': true,

        'timestamp':
            Timestamp.now(),

      }, SetOptions(merge: true));

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Emergency unlock sent',
          ),

        ),

      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content: Text(
            e.toString(),
          ),

        ),

      );

    } finally {

      setState(() {
        isLoading = false;
      });

    }

  }

  // ================= UI =================

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
          'Emergency Door Control',
        ),

      ),

      body: Padding(

        padding:
            const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            const SizedBox(height: 8),

            const Text(

              'Remote emergency unlock system for Smart Dorm',

            ),

            const SizedBox(height: 32),

            // ================= STATUS CARD =================

            StreamBuilder<DocumentSnapshot>(

              stream: _firestore
                  .collection(
                    'door_status',
                  )
                  .doc('current')
                  .snapshots(),

              builder: (
                  context,
                  snapshot,
                  ) {

                String status =
                    'UNKNOWN';

                if (
                    snapshot.hasData &&
                        snapshot.data!.exists
                ) {

                  final data =
                  snapshot.data!.data()
                  as Map<String,
                      dynamic>;

                  status =
                      data['status']
                      ?? 'UNKNOWN';

                }

                return Container(

                  padding:
                      const EdgeInsets.all(
                    24,
                  ),

                  decoration: BoxDecoration(

                    color: Colors.white,

                    borderRadius:
                        BorderRadius.circular(
                      24,
                    ),

                    boxShadow: [

                      BoxShadow(

                        color: Colors.black
                            .withOpacity(
                          0.05,
                        ),

                        blurRadius: 10,

                        offset:
                            const Offset(
                          0,
                          4,
                        ),

                      ),

                    ],

                  ),

                  child: Column(

                    children: [

                      Icon(

                        status ==
                                'UNLOCKED'
                            ? Icons.lock_open
                            : Icons.lock,

                        size: 70,

                        color:
                            status ==
                                    'UNLOCKED'
                                ? Colors.green
                                : Colors.red,

                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Text(

                        'Door Status',

                        style: TextStyle(

                          fontSize: 22,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Text(

                        status,

                        style: TextStyle(

                          fontSize: 24,

                          fontWeight:
                              FontWeight.bold,

                          color:
                              status ==
                                      'UNLOCKED'
                                  ? Colors.green
                                  : Colors.red,

                        ),

                      ),

                    ],

                  ),

                );

              },

            ),

            const SizedBox(height: 40),

            // ================= BUTTON =================

            SizedBox(

              height: 65,

              child: ElevatedButton.icon(

                onPressed:
                    isLoading
                        ? null
                        : openDoor,

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.red,

                ),

                icon: const Icon(
                  Icons.warning,
                  color: Colors.white,
                ),

                label: Text(

                  isLoading
                      ? 'PROCESSING...'
                      : 'EMERGENCY OPEN DOOR',

                  style: const TextStyle(

                    fontSize: 18,

                    fontWeight:
                        FontWeight.bold,

                    color: Colors.white,

                  ),

                ),

              ),

            ),

            const SizedBox(height: 24),

            // ================= WARNING =================

            Container(

              padding:
                  const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color:
                    Colors.orange.shade50,

                borderRadius:
                    BorderRadius.circular(
                  20,
                ),

              ),

              child: const Row(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Icon(
                    Icons.info,
                    color: Colors.orange,
                  ),

                  SizedBox(width: 12),

                  Expanded(

                    child: Text(

                      'Gunakan fitur ini hanya untuk kondisi darurat atau override akses manual.',

                      style: TextStyle(
                        fontSize: 15,
                      ),

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

}