import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:project_study/users_request.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TopBar(),
        ),
        body: CardPages(),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

class CardPages extends StatefulWidget {
  const CardPages({super.key});

  @override
  State<CardPages> createState() => _CardPagesState();
}

class _CardPagesState extends State<CardPages> {
  late Future<List<Person>> people;
  int previousCard = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      people = getPeople();
    });
  }

  Future<void> fetchMorePeople() async {
    List<Person> newPeople = await getPeople();
    List<Person> currentPeople = await people;
    currentPeople.addAll(newPeople);
    setState(() {
      people = Future.value(currentPeople);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: FutureBuilder(
        future: people,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
                child: SpinKitThreeBounce(
              color: Colors.white,
              size: 30,
            ));
          } else {
            if (snapshot.hasData) {
              return PageView(
                onPageChanged: (value) async {
                  if (value % 3 == 0 && value > previousCard) {
                    setState(() {
                      previousCard = value;
                    });
                    await fetchMorePeople();
                  }
                },
                scrollDirection: Axis.horizontal,
                children: [
                  for (var person in snapshot.data as List<Person>) ...[
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .05,
                            vertical: MediaQuery.of(context).size.height * .02),
                        child: PersonCard(person: person)),
                  ]
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Server is not responding as expected...",
                    style:
                        GoogleFonts.nunito(fontSize: 20, color: Colors.white)),
                Text("Try again later.",
                    style:
                        GoogleFonts.nunito(fontSize: 20, color: Colors.white)),
              ],
            );
          }
        },
      )),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
        ));
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
}

class PersonCard extends StatefulWidget {
  final Person person;

  const PersonCard({
    super.key,
    required this.person,
  });

  @override
  State<PersonCard> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool openDescription = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: MediaQuery.of(context).size.height * .7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: Image.network(widget.person.picture.large).image,
          fit: BoxFit.cover,
        ),
      ),
      child: GestureDetector(
        onVerticalDragEnd: (details) => {
          setState(() {
            if (openDescription && details.primaryVelocity! > 0) {
              openDescription = false;
            } else if (!openDescription && details.primaryVelocity! < 0) {
              openDescription = true;
            }
          })
        },
        onTap: () => {
          setState(() {
            openDescription = !openDescription;
          })
        },
        child: AnimatedContainer(
          curve: Curves.easeInOutCubicEmphasized,
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height *
                  (openDescription ? .0 : 0.43)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: const Radius.circular(20),
              bottomRight: const Radius.circular(20),
              topLeft:
                  openDescription ? const Radius.circular(20) : Radius.zero,
              topRight:
                  openDescription ? const Radius.circular(20) : Radius.zero,
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
            ),
          ),
          child: Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * .03,
                left: MediaQuery.of(context).size.width * .03,
                right: MediaQuery.of(context).size.width * .03),
            child: Column(children: [
              Row(
                children: [
                  Text("${widget.person.name.first} ${widget.person.name.last}",
                      style: GoogleFonts.lobster(
                          fontSize: 20, color: Colors.white)),
                  const SizedBox(width: 10),
                  Text("${widget.person.dob.age}",
                      style: GoogleFonts.lobster(
                          fontSize: 20, color: Colors.white)),
                ],
              ),
              Row(
                children: [
                  Text(
                      "${widget.person.location.country} - ${widget.person.location.city}",
                      style: GoogleFonts.quicksand(
                          fontSize: 15, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: AnimatedSize(
                      curve: Curves.easeInOutCubicEmphasized,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        "lorem ipsum dolor sit amet, consectetur adipiscing elit"
                        "Ut auctor, nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl nisl eget ultricies ultrices, nisl nisl"
                        "molestie nisl, nec ultricies nisl",
                        style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white),
                        maxLines: openDescription ? 25 : 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * .01),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .02,
                                vertical:
                                    MediaQuery.of(context).size.height * .005),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black.withOpacity(0.4)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () => {},
                                    icon: const Icon(
                                      Icons.send,
                                      color: Colors.white,
                                      size: 32,
                                    )),
                                LikeButton(
                                  isLiked: widget.person.isLiked,
                                  size: 35,
                                  onTap: (_) {
                                    setState(() {
                                      widget.person.isLiked = true;
                                    });
                                    return Future.value(true);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
