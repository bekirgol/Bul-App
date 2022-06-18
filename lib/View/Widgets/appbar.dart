import 'package:bul_app/Constand/styles.dart';
import 'package:flutter/material.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BuildAppBar(
      {Key? key, this.height = kToolbarHeight, required this.text})
      : super(key: key);
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: Styles.headerStyle,
      ),
      backgroundColor: Colors.red[200],
      elevation: 0,
      centerTitle: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
