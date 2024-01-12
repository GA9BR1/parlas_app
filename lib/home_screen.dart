import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        // Add one stop for each color. Stops should increase from 0 to 1
        stops: [0.1, 0.5, 0.7, 0.9],
        colors: [
          // Colors are easy thanks to Flutter's Colors class.
          Color.fromRGBO(150, 50, 25, 0.682),
          Color.fromARGB(209, 156, 52, 26),
          Color.fromARGB(173, 187, 57, 24),
          Color.fromARGB(174, 230, 53, 9),
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: const [
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.messenger_outline_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
          ],
          title: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Parlas",
                style: GoogleFonts.pacifico(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              )),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * .05),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: const Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Image(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('lib/images/aleatory_person.jpeg')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            surfaceTintColor: Colors.transparent,
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .35,
                vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () => context.go('/settings'),
                      icon: const Icon(
                        Icons.settings,
                        size: 30,
                      )),
                  IconButton(
                    onPressed: () => {},
                    icon: const Icon(Icons.person, size: 30),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
