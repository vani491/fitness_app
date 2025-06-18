
import 'package:flutter_dashboard/dashboard.dart';
import 'package:go_router/go_router.dart';
import '../pages/login/login_screen.dart';
import '../pages/register/register_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) =>  DashBoard(),
    ),
  ],
);
