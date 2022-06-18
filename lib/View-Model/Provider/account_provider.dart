import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  late ProductService service;
  List<Products> items = [];
  AccountProvider() {
    service = ProductManager();
  }

  // Future<void> fetchIItem() async {
  //   items = await service.getItemsByUserId(userId, request)
  // }
}
