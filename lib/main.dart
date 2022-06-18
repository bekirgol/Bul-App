// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:bul_app/View-Model/Provider/account_provider.dart';
import 'package:bul_app/View-Model/Provider/found_item_provider.dart';
import 'package:bul_app/View-Model/Provider/home_provider.dart';
import 'package:bul_app/View-Model/Provider/location_provider.dart';
import 'package:bul_app/View-Model/Provider/login_provider.dart';
import 'package:bul_app/View-Model/Provider/lost_items_provider.dart';
import 'package:bul_app/View-Model/Provider/publish_provider.dart';
import 'package:bul_app/View-Model/Provider/register_provider.dart';
import 'package:bul_app/View/Pages/Authendication/login.dart';
import 'package:bul_app/View/Pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool token = false;

  Future<void> _isToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token")!.isEmpty) {
      token = false;
    } else {
      token = true;
    }
  }

  @override
  void initState() {
    super.initState();
    _isToken();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider<RegisterViewModel>(
          create: (_) => RegisterViewModel(),
        ),
        ChangeNotifierProvider<HomeProvider>(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider<PublishProvider>(
          create: (_) => PublishProvider(),
        ),
        ChangeNotifierProvider<LostItemsProvider>(
          create: (_) => LostItemsProvider(),
        ),
        ChangeNotifierProvider<LocationProvider>(
          create: (_) => LocationProvider(),
        ),
        ChangeNotifierProvider<FoundItemViewModel>(
          create: (_) => FoundItemViewModel(),
        ),
        ChangeNotifierProvider<AccountProvider>(
          create: (_) => AccountProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Material App',
        home: token ? HomePage() : LoginPage(),
        theme: ThemeData(primaryColor: Color(0xFF12a5db)),
      ),
    );
  }
}
