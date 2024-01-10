import 'package:flutter/material.dart';
import 'router.dart';
import 'package:provider/provider.dart';
import 'package:project_study/auth_provider.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ],
        child: MaterialApp.router(
          routerConfig: router,
        ));
  }
}
