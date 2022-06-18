import 'dart:io';

import 'package:bul_app/Models/product.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProductService {
  // Future<Products?> addLostItem(Products product);
  // Future<Products> addFoundItem(Products product);

  Future<List<Products>> getLostItems();
  Future<List<Products>> getFoundItems();
  Future<bool> addItem(File imagefile, Products products, String requests);
  Future<List<Products>> getItemsByUserId(String request);
}
