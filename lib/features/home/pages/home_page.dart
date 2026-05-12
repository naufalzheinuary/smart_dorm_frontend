import 'package:flutter/material.dart';
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

  bool isLocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [

            const AppHeader(
              title: 'Smart Dorm Lock',
            ),

            Padding(
              padding: const EdgeInsets.all(24),

              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      'Naufal Azriel',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'NIM: 10101010',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Row(
                      children: [

                        const Text(
                          'Status Pintu Kamar : ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          isLocked ? 'Terkunci' : 'Terbuka',

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isLocked ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            const Text(
                              'Gedung',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 5),

                            const Text(
                              '01 - Kamar 01',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,

                          children: [

                            const Text(
                              'Akses Terakhir',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              '-',
                              style: TextStyle(
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
                    onTap: () {
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