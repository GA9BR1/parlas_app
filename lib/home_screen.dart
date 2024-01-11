import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_study/auth_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () => {
                        authProvider.logout(),
                        context.go('/login'),
                      },
                  child: const Text("Logout")),
              const Text("Home Screen"),
            ],
          ),
        ),
      ),
    );
  }
}
