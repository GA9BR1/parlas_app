import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:project_study/auth_provider.dart';
import 'package:project_study/widgets/loading_screen.dart';
import 'package:project_study/widgets/text_field.dart' as custom;
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();
  bool isLoading = true;

  signUp() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: SpinKitThreeBounce(
            color: Colors.white,
            size: 40,
          ));
        });
    await authProvider
        .register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text)
        .then((_) {
      context.go('/signup/image');
    }).onError((error, __) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }).whenComplete(() {
      Navigator.of(context).pop();
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preLoad());
  }

  Future preLoad() async {
    setState(() {
      isLoading = true;
    });

    GoogleFonts.pacifico();
    await cacheImage();

    setState(() {
      isLoading = false;
    });
  }

  Future cacheImage() async {
    await precacheImage(
        const CachedNetworkImageProvider(
            "https://images.pexels.com/photos/3194524/pexels-photo-3194524.jpeg?w=1280&h=1919&auto=compress&cs=tinysrgb"),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    "https://images.pexels.com/photos/3194524/pexels-photo-3194524.jpeg?w=1280&h=1919&auto=compress&cs=tinysrgb"),
                colorFilter: ColorFilter.mode(
                    Color.fromARGB(80, 0, 0, 0), BlendMode.darken),
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
                title: Text("Sign Up",
                    style: GoogleFonts.pacifico(color: Colors.white)),
              ),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 100),
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
                            const SizedBox(height: 30),
                            ElevatedButton(
                                onPressed: () => signUp(),
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 10),
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Finish",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ))),
                          ])),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text("Already have an account? ",
                                  style: TextStyle(color: Colors.white)),
                              TextButton(
                                  onPressed: () => context.go('/login'),
                                  child: const Text("Login",
                                      style: TextStyle(color: Colors.white))),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
