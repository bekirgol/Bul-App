// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6)),
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
