import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:project_study/widgets/text_field.dart' as custom;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_image_compress/flutter_image_compress.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Future<Uint8List> _loadImage() async {
    final ByteData data =
        await rootBundle.load("lib/images/signUp_background.jpg");
    final List<int> bytes = data.buffer.asUint8List();
    final Uint8List compressedBytes =
        await FlutterImageCompress.compressWithList(
      Uint8List.fromList(bytes),
      minHeight: 1920, // Ajuste a altura desejada
      minWidth: 1080, // Ajuste a largura desejada
      quality: 100, // Ajuste a qualidade desejada
    );

    final ui.Codec codec = await ui.instantiateImageCodec(compressedBytes);
    final ui.Image image = (await codec.getNextFrame()).image;

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      final Uint8List imageData =
          Uint8List.fromList(byteData.buffer.asUint8List());
      return imageData;
    } else {
      // Tratar caso byteData seja nulo, se necessário
      throw Exception("Failed to convert image to ByteData");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return BuildUi(imageData: snapshot.data!);
        } else {
          return Scaffold(
              backgroundColor: Colors.grey[900],
              body: Scaffold(
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
                body: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                            child: Column(children: [
                          custom.TextField(),
                          SizedBox(height: 30),
                          custom.TextField(),
                          SizedBox(height: 30),
                          custom.TextField(),
                          SizedBox(height: 30),
                          custom.TextField(),
                        ])),
                      ],
                    ),
                  ),
                ),
              ));
        }
      },
    );
  }
}

class BuildUi extends StatelessWidget {
  BuildUi({
    super.key,
    required this.imageData,
  });

  final Uint8List imageData;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(imageData),
          colorFilter: const ColorFilter.mode(
            Color.fromARGB(80, 0, 0, 0),
            BlendMode.darken,
          ),
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
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
