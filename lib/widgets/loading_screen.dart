import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Parlas", style: GoogleFonts.pacifico(fontSize: 45)),
          const SizedBox(height: 5),
          const SpinKitThreeBounce(color: Colors.black, size: 30)
        ],
      )),
    );
  }
}
