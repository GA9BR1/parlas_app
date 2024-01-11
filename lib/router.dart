import 'package:go_router/go_router.dart';
import 'package:project_study/auth_provider.dart';
import 'package:project_study/home_screen.dart';
import 'package:project_study/login_screen.dart';
import 'package:provider/provider.dart';

final router = GoRouter(initialLocation: '/home_validation', routes: [
  GoRoute(
      path: '/home_validation',
      builder: (context, state) => const HomeScreen(),
      redirect: (context, state) async {
        AuthProvider authProvider =
            Provider.of<AuthProvider>(context, listen: false);
        if (await authProvider.isLoggedIn()) {
          return null;
        } else {
          authProvider.logout();
          return '/login';
        }
      }),
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
]);
