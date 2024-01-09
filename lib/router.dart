import 'package:go_router/go_router.dart';
import 'package:project_study/login_screen.dart';
import 'package:project_study/home_screen.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(path: '/', builder: (context, state) => const HomeScreen())
]);
