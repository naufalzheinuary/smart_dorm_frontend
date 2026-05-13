import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class AdminBiometricPage extends StatefulWidget {
  const AdminBiometricPage({super.key});

  @override
  State<AdminBiometricPage> createState() =>
      _AdminBiometricPageState();
}

class _AdminBiometricPageState
    extends State<AdminBiometricPage> {

  // ================= CONTROLLER =================

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final nimController =
      TextEditingController();

  final buildingController =
      TextEditingController();

  final roomController =
      TextEditingController();

  // ================= FIREBASE =================

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  // ================= STATE =================

  bool isLoading = false;

  String? createdUid;

  String enrollmentStatus =
      "Waiting Enrollment";

  // ================= CREATE USER =================

  Future<void> createUser() async {

    try {

      setState(() {
        isLoading = true;
      });

      final credential =
          await _auth
              .createUserWithEmailAndPassword(

        email:
            emailController.text.trim(),

        password:
            passwordController.text.trim(),

      );

      final uid =
          credential.user!.uid;

      createdUid = uid;

      await _firestore
          .collection('users')
          .doc(uid)
          .set({

        'uid': uid,

        'name':
            nameController.text.trim(),

        'email':
            emailController.text.trim(),

        'nim':
            nimController.text.trim(),

        'building':
            buildingController.text.trim(),

        'room':
            roomController.text.trim(),

        'role': 'user',

        'is_active': false,

        'createdAt':
            Timestamp.now(),

      });

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text('User berhasil dibuat'),
        ),

      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
              Text(e.toString()),
        ),

      );

    } finally {

      setState(() {
        isLoading = false;
      });

    }

  }

  // ================= REGISTER DATASET =================

  Future<void> registerDataset() async {

    if (createdUid == null) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content:
              Text('Buat user dulu'),
        ),

      );

      return;

    }

    try {

      setState(() {
        enrollmentStatus =
            "Processing Enrollment...";
      });

      await _firestore
          .collection('system_control')
          .doc('enrollment_trigger')
          .set({

        'start_enrollment': true,

        'uid': createdUid,

        'name':
            nameController.text.trim(),

        'timestamp':
            Timestamp.now(),

      });

      listenEnrollmentStatus();

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(
          content: Text(
            'Enrollment Trigger Sent',
          ),
        ),

      );

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(
          content:
              Text(e.toString()),
        ),

      );

    }

  }

  // ================= LISTEN STATUS =================

  void listenEnrollmentStatus() {

    _firestore
        .collection('system_control')
        .doc('enrollment_trigger')
        .snapshots()
        .listen((doc) {

      if (!doc.exists) return;

      final data = doc.data();

      final status =
          data?['status'];

      if (status == null) return;

      setState(() {

        if (status == "processing") {

          enrollmentStatus =
              "Enrollment Processing...";

        } else if (
            status == "success") {

          enrollmentStatus =
              "Enrollment Success";

        } else if (
            status == "failed") {

          enrollmentStatus =
              "Enrollment Failed";

        }

      });

    });

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
        'Biometric Enrollment',
      ),

    ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.stretch,

          children: [

            // ================= TITLE =================

            const Text(

              'Create User Account',

              style: TextStyle(
                fontSize: 26,
                fontWeight:
                    FontWeight.bold,
              ),

            ),

            const SizedBox(height: 8),

            const Text(
              'Centralized biometric enrollment system',
            ),

            const SizedBox(height: 32),

            // ================= NAME =================

            TextField(

              controller:
                  nameController,

              decoration:
                  const InputDecoration(

                labelText: 'Nama',

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 16),

            // ================= EMAIL =================

            TextField(

              controller:
                  emailController,

              decoration:
                  const InputDecoration(

                labelText: 'Email',

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 16),

            // ================= PASSWORD =================

            TextField(

              controller:
                  passwordController,

              obscureText: true,

              decoration:
                  const InputDecoration(

                labelText: 'Password',

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 16),

            // ================= NIM =================

            TextField(

              controller:
                  nimController,

              decoration:
                  const InputDecoration(

                labelText: 'NIM',

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 16),

            // ================= BUILDING =================

            TextField(

              controller:
                  buildingController,

              decoration:
                  const InputDecoration(

                labelText: 'Gedung',

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 16),

            // ================= ROOM =================

            TextField(

              controller:
                  roomController,

              decoration:
                  const InputDecoration(

                labelText: 'Kamar',

                border:
                    OutlineInputBorder(),

              ),

            ),

            const SizedBox(height: 32),

            // ================= CREATE USER =================

            SizedBox(

              height: 55,

              child: ElevatedButton(

                onPressed:
                    isLoading
                        ? null
                        : createUser,

                child: Text(

                  isLoading
                      ? 'Loading...'
                      : 'CREATE USER',

                ),

              ),

            ),

            const SizedBox(height: 16),

            // ================= REGISTER DATASET =================

            SizedBox(

              height: 55,

              child: ElevatedButton(

                onPressed:
                    registerDataset,

                style:
                    ElevatedButton.styleFrom(

                  backgroundColor:
                      Colors.orange,

                ),

                child: const Text(
                  'REGISTER DATASET',
                ),

              ),

            ),

            const SizedBox(height: 32),

            // ================= STATUS CARD =================

            Container(

              padding:
                  const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color:
                    Colors.white,

                borderRadius:
                    BorderRadius.circular(20),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(0.05),

                    blurRadius: 10,

                    offset:
                        const Offset(0, 4),

                  ),

                ],

              ),

              child: Column(

                children: [

                  const Icon(

                    Icons.fingerprint,

                    size: 60,

                    color: Colors.blue,

                  ),

                  const SizedBox(height: 16),

                  const Text(

                    'Enrollment Status',

                    style: TextStyle(

                      fontSize: 20,

                      fontWeight:
                          FontWeight.bold,

                    ),

                  ),

                  const SizedBox(height: 12),

                  Text(

                    enrollmentStatus,

                    style: const TextStyle(

                      fontSize: 18,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 40),

          ],

        ),

      ),

    );

  }

}