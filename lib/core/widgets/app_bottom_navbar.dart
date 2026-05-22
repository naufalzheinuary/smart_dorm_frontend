import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavbar extends StatelessWidget {

  final int currentIndex;

  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(

      clipBehavior: Clip.none,

      alignment: Alignment.bottomCenter,

      children: [

        // =========================
        // BOTTOM NAVBAR
        // =========================

        BottomNavigationBar(

          currentIndex: currentIndex,

          onTap: (index) {

            if (index == 0) {
              context.go('/home');
            }

            if (index == 1) {
              context.go('/history');
            }

            if (index == 3) {
              context.go('/notification');
            }

            if (index == 4) {
              context.go('/profile');
            }
          },

          type:
              BottomNavigationBarType.fixed,

          backgroundColor:
              const Color(0xFF1565C0),

          selectedItemColor:
              Colors.white,

          unselectedItemColor:
              Colors.white70,

          items: const [

            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Riwayat',
            ),

            // =========================
            // EMPTY SPACE FOR SCAN
            // =========================

            BottomNavigationBarItem(

              icon: SizedBox(
                height: 40,
              ),

              label: 'Biometric',
            ),

            BottomNavigationBarItem(
              icon:
                  Icon(Icons.notifications),
              label: 'Notifikasi',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Akun',
            ),

          ],
        ),

        // =========================
        // FLOATING SCAN BUTTON
        // =========================

        Positioned(

          top: -18,

          child: GestureDetector(

            onTap: () {

              context.go('/biometric');

            },

            child: Container(

              width: 65,
              height: 65,

              decoration: BoxDecoration(

                color:
                    const Color(0xFF1565C0),

                borderRadius:
                    BorderRadius.circular(
                        18),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black
                        .withOpacity(0.25),

                    blurRadius: 12,

                    offset:
                        const Offset(0, 6),
                  ),
                ],
              ),

              child: const Icon(

                Icons.fingerprint,

                color: Colors.white,

                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}