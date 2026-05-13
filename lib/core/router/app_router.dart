import 'package:go_router/go_router.dart';

import '../../features/auth/pages/splash_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/register_page.dart';

import '../../features/home/pages/home_page.dart';

import '../../features/profile/pages/profile_page.dart';
import '../../features/history/pages/history_page.dart';
import '../../features/notification/pages/notification_page.dart';

import '../../features/biometric/pages/biometric_page.dart';

import '../../features/admin/pages/admin_page.dart';
import '../../features/admin/pages/admin_users_page.dart';
import '../../features/admin/pages/admin_logs_page.dart';

final GoRouter appRouter = GoRouter(

  routes: [

    // ================= SPLASH =================

    GoRoute(

      path: '/',

      builder: (context, state) {

        return const SplashPage();

      },

    ),

    // ================= LOGIN =================

    GoRoute(

      path: '/login',

      builder: (context, state) {

        return const LoginPage();

      },

    ),

    // ================= REGISTER =================

    GoRoute(

      path: '/register',

      builder: (context, state) {

        return const RegisterPage();

      },

    ),

    // ================= HOME =================

    GoRoute(

      path: '/home',

      builder: (context, state) {

        return const HomePage();

      },

    ),

    // ================= ADMIN =================

    GoRoute(

      path: '/admin',

      builder: (context, state) {

        return const AdminPage();

      },

    ),

    GoRoute(

      path: '/admin-users',

      builder: (context, state) {

        return const AdminUsersPage();

      },

    ),

    GoRoute(

      path: '/admin-logs',

      builder: (context, state) {

        return const AdminLogsPage();

      },

    ),

    // ================= PROFILE =================

    GoRoute(

      path: '/profile',

      builder: (context, state) {

        return const ProfilePage();

      },

    ),

    // ================= HISTORY =================

    GoRoute(

      path: '/history',

      builder: (context, state) {

        return const HistoryPage();

      },

    ),

    // ================= NOTIFICATION =================

    GoRoute(

      path: '/notification',

      builder: (context, state) {

        return const NotificationPage();

      },

    ),

    // ================= BIOMETRIC =================

    GoRoute(

      path: '/biometric',

      builder: (context, state) {

        return const BiometricPage();

      },

    ),

  ],

);