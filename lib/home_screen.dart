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
                SizedBox(height: MediaQuery.of(context).size.height * .031),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage("lib/images/aleatory_person.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .5),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(0.4),
                          Colors.transparent
                        ],
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * .03),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("José Hernandez",
                                  style: GoogleFonts.lobster(
                                      fontSize: 20, color: Colors.white)),
                              const SizedBox(width: 10),
                              Text("20",
                                  style: GoogleFonts.lobster(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Mexico - Mexico City",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 15, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            height: MediaQuery.of(context).size.height * .15,
            surfaceTintColor: Colors.transparent,
            color: Colors.transparent,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .02,
                left: MediaQuery.of(context).size.width * .35,
                right: MediaQuery.of(context).size.width * .35,
                bottom: MediaQuery.of(context).size.height * .04),
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
