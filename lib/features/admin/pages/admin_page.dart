import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            GridView.count(

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              crossAxisCount: 2,

              crossAxisSpacing: 16,
              mainAxisSpacing: 16,

              children: [

                _buildMenuCard(
                  context,
                  icon: Icons.people,
                  title: 'List User',
                  route: '/admin-users',
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.history,
                  title: 'Access Logs',
                  route: '/admin-logs',
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.lock_open,
                  title: 'Open Door',
                  route: '/admin-door',
                ),

                _buildMenuCard(
                  context,
                  icon: Icons.fingerprint,
                  title: 'Biometric',
                  route: '/admin-biometric',
                ),

              ],
            ),

            const SizedBox(height: 24),

            // ================= LOGOUT =================

            SizedBox(

              width: 200,
              height: 70,

              child: GestureDetector(

                onTap: () async {

                  await FirebaseAuth.instance
                      .signOut();

                  if (context.mounted) {

                    context.go('/login');

                  }

                },

                child: Container(

                  decoration: BoxDecoration(

                    color: Colors.red,

                    borderRadius:
                        BorderRadius.circular(20),

                  ),

                  child: const Row(

                    mainAxisAlignment:
                        MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),

                      SizedBox(width: 12),

                      Text(

                        'Logout',

                        style: TextStyle(

                          color: Colors.white,

                          fontSize: 18,

                          fontWeight:
                              FontWeight.bold,

                        ),

                      ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// ================= MENU CARD =================

Widget _buildMenuCard(

  BuildContext context, {

  required IconData icon,

  required String title,

  required String route,

}) {

  return GestureDetector(

    onTap: () {

      context.go(route);

    },

    child: Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(

            color:
                Colors.black.withOpacity(0.05),

            blurRadius: 10,

            offset: const Offset(0, 4),

          ),

        ],
      ),

      child: Column(

        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Icon(

            icon,

            size: 48,

            color: const Color(0xFF1565C0),

          ),

          const SizedBox(height: 16),

          Text(

            title,

            style: const TextStyle(

              fontSize: 18,

              fontWeight: FontWeight.bold,

            ),

          ),

        ],
      ),
    ),
  );
}