import 'package:flutter/material.dart';
import 'package:project_study/auth_provider.dart';
import 'package:project_study/login_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.isLoggedIn) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () => authProvider.logout(),
                    child: const Text("Logout")),
                const Text("Home Screen"),
              ],
            ),
          ),
        ),
      );
    } else {
      return LoginScreen();
    }
  }
}
