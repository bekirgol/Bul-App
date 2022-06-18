// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum LostItemsPageState { LOADING, SUCCES, ERROR, IDLE }

class LostItemsProvider with ChangeNotifier {
  late List<Products> _items;
  List<Products> get items => _items;
  set items(List<Products> value) {
    _items = value;
    notifyListeners();
  }

  late List<Products> itemsByUserId;
  late LostItemsPageState _pageState;
  late ProductService _productService;

  LostItemsProvider() {
    items = [];
    itemsByUserId = [];
    _pageState = LostItemsPageState.IDLE;
    _productService = ProductManager();
    fetchLostItems();
    fetchItemsByUserId();
  }

  LostItemsPageState get pageState => _pageState;
  set pageState(LostItemsPageState value) {
    _pageState = value;
    notifyListeners();
  }

  Future<List<Products>> fetchLostItems() async {
    try {
      pageState = LostItemsPageState.LOADING;
      items = await _productService.getLostItems();
      pageState = LostItemsPageState.SUCCES;
      return items;
    } catch (e) {
      pageState = LostItemsPageState.ERROR;
      throw e.toString();
      // print(e);
    }
  }

  Future<void> fetchItemsByUserId() async {
    try {
      itemsByUserId = await _productService.getItemsByUserId("lostitems");
    } catch (e) {
      print(e);
    }
  }

  List<Products> filterByCity(String city) {
    return items.where((element) => element.city == city).toList();
  }

  List<Products> filterByCategory(String category) {
    return items.where((element) => element.category == category).toList();
  }

  List<Products> filterByCityAndRegion(String city, String region) {
    return items
        .where((element) => element.city == city && element.district == region)
        .toList();
  }

  List<Products> filterByCityAndCategory(String city, String category) {
    return items
        .where(
            (element) => element.city == city && element.category == category)
        .toList();
  }

  List<Products> filterByCityAndRegionAndCategory(
      String city, String region, String category) {
    return items
        .where((element) =>
            element.city == city &&
            element.district == region &&
            element.category == category)
        .toList();
  }

  Future<void> pullRefresh() async {
    fetchLostItems();
  }
}
