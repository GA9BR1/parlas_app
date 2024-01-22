import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageRegisterScreen extends StatefulWidget {
  const UploadImageRegisterScreen({super.key});

  @override
  State<UploadImageRegisterScreen> createState() =>
      _UploadImageRegisterScreenState();
}

class _UploadImageRegisterScreenState extends State<UploadImageRegisterScreen> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    final img = await ImagePicker().pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose an option"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Picture",
            style: GoogleFonts.pacifico(fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Text("Upload your profile picture",
                  style: GoogleFonts.quicksand(fontSize: 15)),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: image != null
                        ? DecorationImage(
                            image: FileImage(File(image!.path)),
                            fit: BoxFit.cover)
                        : null,
                    border: Border.all(color: Colors.white)),
                child: ElevatedButton(
                  onPressed: () => myAlert(),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: const EdgeInsets.all(30),
                      backgroundColor: image != null
                          ? Colors.transparent
                          : Colors.grey[300]),
                  child: const Icon(Icons.add_a_photo),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text("This is how your profile picture will look like",
                      style: GoogleFonts.quicksand(fontSize: 15)),
                  Text(
                      "Click on next to continue or skip to add the picture later",
                      style: GoogleFonts.quicksand(fontSize: 10)),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () => context.go('/signup/description'),
                            child: Text("Skip",
                                style: GoogleFonts.quicksand(fontSize: 15))),
                        TextButton(
                            onPressed: () => context.go('/signup/description'),
                            child: Text("Next",
                                style: GoogleFonts.quicksand(fontSize: 15))),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}
