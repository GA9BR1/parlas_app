import 'package:flutter/material.dart';
import 'package:project_study/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.isLoggedIn) {
      return const Scaffold(
        body: Center(
          child: Text("Home Screen"),
        ),
      );
    } else {
      return const Scaffold(
        body: Center(
          child: Text("Login Screen"),
        ),
      );
    }
  }
}
