import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/app_bottom_navbar.dart';
import '../../../core/widgets/app_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    final currentUser =
        FirebaseAuth.instance.currentUser;

    if (currentUser == null) {

      return const Scaffold(
        body: Center(
          child: Text(
            'User belum login',
          ),
        ),
      );

    }

    return Scaffold(

      body: FutureBuilder<DocumentSnapshot>(

        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get(),

        builder: (context, snapshot) {

          // ================= LOADING =================

          if (
              snapshot.connectionState
              == ConnectionState.waiting) {

            return const Center(
              child:
                  CircularProgressIndicator(),
            );

          }

          // ================= ERROR =================

          if (snapshot.hasError) {

            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );

          }

          // ================= NO DATA =================

          if (
              !snapshot.hasData
              || !snapshot.data!.exists) {

            return const Center(
              child: Text(
                'Data user tidak ditemukan',
              ),
            );

          }

          // ================= USER DATA =================

          final data =
              snapshot.data!.data()
                  as Map<String, dynamic>;

          final name =
              data['name'] ?? '-';

          final email =
              data['email'] ?? '-';

          final nim =
              data['nim'] ?? '-';

          final building =
              data['building'] ?? '-';

          final room =
              data['room'] ?? '-';

          final role =
              data['role'] ?? 'user';

          final isActive =
              data['is_active'] ?? false;

          return SingleChildScrollView(

            child: Column(

              children: [

                const AppHeader(
                  title: 'Profil Saya',
                ),

                const SizedBox(height: 25),

                const CircleAvatar(

                  radius: 60,

                  backgroundColor:
                      Color(0xFF1565C0),

                  child: Icon(

                    Icons.person,

                    size: 60,

                    color: Colors.white,

                  ),

                ),

                const SizedBox(height: 24),

                // ================= NAME =================

                Text(

                  name,

                  style: const TextStyle(

                    fontSize: 24,

                    fontWeight:
                        FontWeight.bold,

                  ),

                ),

                const SizedBox(height: 8),

                // ================= EMAIL =================

                Text(

                  email,

                  style: const TextStyle(

                    fontSize: 16,

                    color: Colors.grey,

                  ),

                ),

                const SizedBox(height: 30),

                // ================= CARD =================

                Padding(

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),

                  child: Container(

                    padding:
                        const EdgeInsets.all(24),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                        28,
                      ),

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

                        // ================= NIM =================

                        _buildProfileItem(

                          icon: Icons.badge,

                          title: 'NIM',

                          value: nim,

                        ),

                        const SizedBox(height: 20),

                        // ================= ROOM =================

                        _buildProfileItem(

                          icon: Icons.home,

                          title: 'Kamar',

                          value:
                              'Gedung $building - Kamar $room',

                        ),

                        const SizedBox(height: 20),

                        // ================= ROLE =================

                        _buildProfileItem(

                          icon: Icons.security,

                          title: 'Role',

                          value:
                              role.toUpperCase(),

                        ),

                        const SizedBox(height: 20),

                        // ================= STATUS =================

                        _buildProfileItem(

                          icon:
                              Icons.verified_user,

                          title:
                              'Status Akun',

                          value:
                              isActive
                                  ? 'ACTIVE'
                                  : 'INACTIVE',

                        ),

                      ],

                    ),

                  ),

                ),

                const SizedBox(height: 30),

                // ================= LOGOUT =================

                Padding(

                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),

                  child: SizedBox(

                    width: double.infinity,

                    child: ElevatedButton(

                      onPressed: () async {

                        await FirebaseAuth
                            .instance
                            .signOut();

                        if (
                            context.mounted) {

                          context.go(
                            '/login',
                          );

                        }

                      },

                      child: const Text(
                        'Logout',
                      ),

                    ),

                  ),

                ),

                const SizedBox(height: 40),

              ],

            ),

          );

        },

      ),

      bottomNavigationBar:
          const AppBottomNavbar(
        currentIndex: 3,
      ),

    );

  }

}

// ================= PROFILE ITEM =================

Widget _buildProfileItem({

  required IconData icon,

  required String title,

  required String value,

}) {

  return Row(

    children: [

      Icon(

        icon,

        color:
            const Color(0xFF1565C0),

      ),

      const SizedBox(width: 16),

      Expanded(

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

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

                fontWeight:
                    FontWeight.bold,

              ),

            ),

          ],

        ),

      ),

    ],

  );

}