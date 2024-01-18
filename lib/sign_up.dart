import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:project_study/widgets/text_field.dart' as custom;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  

  @override
  Widget build(BuildContext context) {
   
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "lib/images/signUp_background.jpg",
          ),
          colorFilter:
              ColorFilter.mode(Color.fromARGB(80, 0, 0, 0), BlendMode.darken),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () => context.go('/login'),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title:
              Text("Sign Up", style: GoogleFonts.pacifico(color: Colors.white)),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    child: Column(children: [
                  custom.TextField(
                    controller: nameController,
                    hintText: "Name",
                  ),
                  const SizedBox(height: 30),
                  custom.TextField(
                    controller: emailController,
                    hintText: 'Email',
                  ),
                  const SizedBox(height: 30),
                  custom.TextField(
                    controller: passwordController,
                    hintText: 'Password',
                  ),
                  const SizedBox(height: 30),
                  custom.TextField(
                    controller: passwordConfirmationController,
                    hintText: 'Password Confirmation',
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Sign Up"),
                  ),
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
