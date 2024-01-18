import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_study/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_study/widgets/text_field.dart' as custom;

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
    precacheImage(
      const AssetImage("lib/images/login_background.jpg"),
      context,
    );
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
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text("Parlas",
                        style: GoogleFonts.pacifico(
                            fontSize: 50, color: Colors.white)),
                    const SizedBox(height: 100),
                    Form(
                        child: Column(children: [
                      custom.TextField(
                          controller: emailController, hintText: 'Email'),
                      const SizedBox(height: 30),
                      custom.TextField(
                          controller: passwordController, hintText: 'Password'),
                      const SizedBox(height: 50),
                      LoginButton(signIn: signIn),
                    ])),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Don't have an account? ",
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                            onPressed: () => context.go('/signup'),
                            child: const Text("Sign Up",
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  ],
                ),
              )),
            ),
          )),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Function signIn;
  const LoginButton({super.key, required this.signIn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
                    style: TextStyle(fontSize: 20, color: Colors.black54)),
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
    );
  }
}
