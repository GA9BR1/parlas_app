import 'package:go_router/go_router.dart';
import 'package:project_study/auth_provider.dart';
import 'package:project_study/home_screen.dart';
import 'package:project_study/login_screen.dart';
import 'package:provider/provider.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
    redirect: (context, state) {
      AuthProvider authProvider =
          Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isLoggedIn) {
        return null;
      } else {
        authProvider.logout();
        return '/login';
      }
    },
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
]);
