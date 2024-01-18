import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  const TextField({
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
