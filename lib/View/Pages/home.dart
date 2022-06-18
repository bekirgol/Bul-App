// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bul_app/Models/user.dart';
import 'package:bul_app/View-Model/Provider/home_provider.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final User? user;
  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    var publishProvider = Provider.of<PublishProvider>(context);

    return Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(homeProvider),
        body: buildBody(homeProvider, publishProvider));
  }

  Widget buildBody(HomeProvider homeProvider, PublishProvider publishProvider) {
    return PageView(
      controller: homeProvider.pageController,
      children: homeProvider.screens,
      onPageChanged: homeProvider.onPageChanged,
    );
  }

  BottomNavigationBar buildBottomNavigationBar(HomeProvider homeProvider) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: homeProvider.onItemTapper,
      currentIndex: homeProvider.currentIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Yayınla",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: "Kayıplar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: "Bulunanlar",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: "Hesabım",
        ),
      ],
    );
  }
}
