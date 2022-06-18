// ignore_for_file: constant_identifier_names

import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:flutter/cupertino.dart';

enum FoundItemPageState { LOADING, SUCCES, ERROR, IDLE }

class FoundItemViewModel with ChangeNotifier {
  late List<Products> items;
  late List<Products> itemsByUserId;
  late ProductService productService;

  FoundItemPageState? _pageState;
  FoundItemPageState? get pageState => _pageState;
  set pageState(FoundItemPageState? value) {
    _pageState = value;
    notifyListeners();
  }

  FoundItemViewModel() {
    items = [];
    itemsByUserId = [];
    pageState = FoundItemPageState.IDLE;
    productService = ProductManager();
    fetchItems();
    fetchItemsByUserId();
    items.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
  }

  Future<void> fetchItems() async {
    try {
      pageState = FoundItemPageState.LOADING;
      items = await productService.getFoundItems();
      pageState = FoundItemPageState.SUCCES;
    } catch (e) {
      pageState = FoundItemPageState.ERROR;
    }
  }

  Future<void> fetchItemsByUserId() async {
    try {
      pageState = FoundItemPageState.LOADING;
      itemsByUserId = await productService.getItemsByUserId("founditems");
      pageState = FoundItemPageState.SUCCES;
    } catch (e) {
      pageState = FoundItemPageState.ERROR;
      print(e);
    }
  }

  Future<void> pullRefresh() async {
    fetchItems();
  }
}
