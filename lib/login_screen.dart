import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          body: SafeArea(
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
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          decorationThickness: 0),
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      cursorColor: Colors.white,
                      style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          decorationThickness: 0),
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.white),
                          )),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      child: Expanded(
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
                      )),
                      onPressed: () => print("Pressed"),
                    )
                  ]),
                ))
              ],
            )),
          )),
    );
  }
}
