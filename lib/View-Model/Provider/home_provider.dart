// ignore_for_file: unused_field, prefer_final_fields, unused_element, prefer_const_constructors

import 'package:bul_app/View/Pages/Bottom%20Navigation%20Bar%20Items/account.dart';
import 'package:bul_app/View/Pages/Bottom%20Navigation%20Bar%20Items/found_items.dart';
import 'package:bul_app/View/Pages/Bottom%20Navigation%20Bar%20Items/lost_items.dart';
import 'package:bul_app/View/Pages/Bottom%20Navigation%20Bar%20Items/publish.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  List<Widget> screens = [
    PublishPage(),
    LostItemsPage(),
    FoundItemsPage(),
    AccountPage(),
  ];

  PageController pageController = PageController();

  void onPageChanged(int index) {
    currentIndex = index;
  }

  void onItemTapper(int selectedIndex) {
    pageController.jumpToPage(selectedIndex);
  }
}
