import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_study/auth_provider.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Settings'),
            LogoutButton(authProvider: authProvider),
          ],
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.authProvider,
  });

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return const Center(child: CircularProgressIndicator());
              });
          await authProvider.logout().whenComplete(() {
            Navigator.of(context).pop();
            context.go('/login');
          });
        },
        child: const Text("Logout"));
  }
}
