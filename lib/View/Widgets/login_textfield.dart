// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final Icon? icon;
  final bool obscure;
  final TextAlign textAlign;
  final IconButton? suffix;

  const LoginTextField(
      {Key? key,
      this.title = "",
      required this.textEditingController,
      this.icon,
      this.obscure = false,
      this.textAlign = TextAlign.start,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.8,
        height: 40.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
        child: TextField(
          textAlign: textAlign,
          obscureText: obscure,
          controller: textEditingController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              hintText: title,
              hintStyle: const TextStyle(),
              prefixIcon: icon,
              suffixIcon: suffix),
        ),
      ),
    );
  }
}
