// ignore_for_file: prefer_const_constructors

import 'package:bul_app/Constand/styles.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:bul_app/View/Pages/form.dart';
import 'package:bul_app/View/Widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PublishPage extends StatelessWidget {
  const PublishPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var publishProvider = Provider.of<PublishProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container(), flex: 6),
            Expanded(child: buildPublishText(), flex: 2),
            Expanded(
                child: buildFoundButton(context, publishProvider), flex: 1),
            SizedBox(height: 10.0),
            Expanded(child: buildLostButton(context, publishProvider), flex: 1),
            Expanded(child: Container(), flex: 6)
          ],
        ),
      ),
    );
  }

  Text buildPublishText() => Text("YAYINLA", style: Styles.headerStyle);

  SubmitButton buildFoundButton(
      BuildContext context, PublishProvider publishProvider) {
    return SubmitButton(
      title: "Buldum",
      click: () {
        publishProvider.clearForm();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FormPage(
              requests: "founditems",
              title: "Ne Buldun",
              // function: () {
              //   publishProvider.addItems("founditems");
              // },
            ),
          ),
        );
      },
    );
  }

  SubmitButton buildLostButton(
      BuildContext context, PublishProvider publishProvider) {
    return SubmitButton(
      title: "Kaybettim",
      click: () {
        publishProvider.clearForm();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FormPage(
              requests: "lostitems",
              title: "Ne Kaybettin",
              // function: () {
              //   publishProvider.addItems("lostitems");
              // },
            ),
          ),
        );
      },
    );
  }
}
