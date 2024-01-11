import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_study/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  fill() {
    emailController.text = "gustavo@email.com";
    passwordController.text = "password";
  }

  signIn() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    await authProvider
        .authenticate(
            email: emailController.text, password: passwordController.text)
        .then((_) => context.go('/'))
        .onError((error, __) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }).whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/images/login_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                  child: Column(
                children: [
                  const SizedBox(height: 100),
                  Text("Parlas",
                      style: GoogleFonts.pacifico(
                          fontSize: 50, color: Colors.white)),
                  const SizedBox(height: 100),
                  Form(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(children: [
                      ElevatedButton(
                          onPressed: fill, child: const Text("Fill")),
                      LoginField(
                          controller: emailController, hintText: 'Email'),
                      const SizedBox(height: 30),
                      LoginField(
                          controller: passwordController, hintText: 'Password'),
                      const SizedBox(height: 50),
                      ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Login",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black54)),
                                  SizedBox(width: 5),
                                  Column(children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Icon(Icons.login, color: Colors.black54)
                                  ])
                                ],
                              ),
                            ),
                          ],
                        ),
                        onPressed: () => signIn(),
                      )
                    ]),
                  ))
                ],
              )),
            ),
          )),
    );
  }
}

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.controller,
    required this.hintText,
  });

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      obscureText: hintText == 'Password' ? true : false,
      style: const TextStyle(
          color: Colors.white,
          decoration: TextDecoration.none,
          decorationThickness: 0),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white),
          )),
    );
  }
}
