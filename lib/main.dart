import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'router.dart';
import 'package:provider/provider.dart';
import 'package:project_study/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  AuthProvider authProvider = AuthProvider(prefs);
  runApp(
    ChangeNotifierProvider.value(
      value: authProvider,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: router);
  }
}
