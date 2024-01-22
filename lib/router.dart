import 'package:go_router/go_router.dart';
import 'package:project_study/auth_provider.dart';
import 'package:project_study/description_register_screen.dart';
import 'package:project_study/home_screen.dart';
import 'package:project_study/login_screen.dart';
import 'package:project_study/sign_up.dart';
import 'package:project_study/upload_image_register_screen.dart';
import 'package:provider/provider.dart';
import 'package:project_study/settings_screen.dart';

Future<String?> redirectToLogin(context) async {
  AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
  if (await authProvider.isLoggedIn()) {
    return null;
  } else {
    authProvider.logout();
    return '/login';
  }
}

final router = GoRouter(initialLocation: '/home_validation', routes: [
  GoRoute(
      path: '/home_validation',
      builder: (context, state) => const HomeScreen(),
      redirect: (context, state) => redirectToLogin(context)),
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
      path: '/signup/image',
      builder: (context, state) => const UploadImageRegisterScreen()),
  GoRoute(
      path: '/signup/description',
      builder: (context, state) => const DescriptionRegisterScreen()),
  GoRoute(
      path: '/settings', builder: (context, state) => const SettingsScreen()),
]);
