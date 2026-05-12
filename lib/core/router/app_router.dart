import 'package:go_router/go_router.dart';
import '../../features/auth/pages/splash_page.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/register_page.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/history/pages/history_page.dart';
import '../../features/notification/pages/notification_page.dart';
import '../../features/biometric/pages/biometric_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const SplashPage();
      },
    ),

    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),

    GoRoute(
      path: '/register',
      builder: (context, state) {
        return const RegisterPage();
      },
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) {
        return const ProfilePage();
      },
    ),

    GoRoute(
      path: '/history',
      builder: (context, state) {
        return const HistoryPage();
      },
    ),

    GoRoute(
      path: '/notification',
      builder: (context, state) {
        return const NotificationPage();
      },
    ),

    GoRoute(
      path: '/biometric',
      builder: (context, state) {
        return const BiometricPage();
      },
    ),

  ],
);