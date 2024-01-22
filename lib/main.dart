import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'router.dart';
import 'package:provider/provider.dart';
import 'package:project_study/auth_provider.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late Future<AuthProvider> authProvider;

  @override
  void initState() {
    super.initState();
    setState(() {
      authProvider = AuthProvider().build();
    });
    GoogleFonts.pacifico();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authProvider,
      builder: (context, snapshot) => snapshot.hasData
          ? MultiProvider(
              providers: [
                  ChangeNotifierProvider<AuthProvider>.value(
                      value: snapshot.data as AuthProvider),
                ],
              child: MaterialApp.router(
                routerConfig: router,
              ))
          : const CircularProgressIndicator(),
    );
  }
}
