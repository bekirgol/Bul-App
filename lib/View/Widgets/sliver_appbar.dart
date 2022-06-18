import 'package:bul_app/Constand/styles.dart';
import 'package:flutter/material.dart';

class BuildSliverAppBar extends StatelessWidget {
  const BuildSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.red[200],
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildAppbarContainer(context, "Filtrele"),
          buildAppbarContainer(context, "Sırala"),
        ],
      ),
    );
  }

  Widget buildAppbarContainer(BuildContext context, String text) {
    return Card(
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.45,
        height: 50.0,
        child: Text(text, style: Styles.cardTextStyle),
      ),
    );
  }
}
