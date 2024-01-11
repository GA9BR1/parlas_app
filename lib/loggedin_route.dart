import 'package:flutter/material.dart';
import 'package:project_study/auth_provider.dart';
import 'package:project_study/login_screen.dart';
import 'package:provider/provider.dart';

class LoggedInRoute extends StatelessWidget {
  final Widget child;

  const LoggedInRoute({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return authProvider.isLoggedIn ? child : const LoginScreen();
  }
}
