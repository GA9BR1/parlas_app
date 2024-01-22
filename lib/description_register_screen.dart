import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionRegisterScreen extends StatelessWidget {
  const DescriptionRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Description",
            style: GoogleFonts.pacifico(),
          ),
          leading: IconButton(
            onPressed: () => context.go('/signup/image'),
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          centerTitle: true,
        ),
        body: const SafeArea(
            child: Center(
          child: Column(children: [Text("Description")]),
        )));
  }
}
