// ignore_for_file: unnecessary_new, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/product.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductManager implements ProductService {
  @override
  Future<List<Products>> getLostItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "${Constand.BASE_URL}/lostitems";
    final response = await http.get(Uri.parse(url), headers: {
      "x-acces-token": prefs.getString("token")!,
    });

    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    }
    return throw (response.body);
  }

  @override
  Future<List<Products>> getFoundItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = "${Constand.BASE_URL}/founditems";
    final response = await http.get(Uri.parse(url), headers: {
      "x-acces-token": prefs.getString("token")!,
    });

    if (response.statusCode == 200) {
      return productsFromJson(response.body);
    }

    return throw (response.body);
  }

  @override
  Future<bool> addItem(
      File imageFile, Products products, String requests) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final mimeTypeData =
        lookupMimeType(imageFile.path, headerBytes: [0xFF, 0xD8])!.split('/');
    String url = "${Constand.BASE_URL}/$requests";
    var headers = {
      "x-acces-token": prefs.getString("token")!,
      "Content-Type": "multipart/form-data",
    };

    var request = new http.MultipartRequest("POST", Uri.parse(url));

    request.headers.addAll(headers);
    request.files.add(await MultipartFile.fromPath('imageUrl', imageFile.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
    request.fields["title"] = products.title!;
    request.fields["description"] = products.description!;
    request.fields["category"] = products.category!;
    request.fields["latitude"] = products.latitude!;
    request.fields["longitude"] = products.longitude!;
    request.fields["city"] = products.city!;
    request.fields["district"] = products.district!;

    final response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }

    return false;
  }

  @override
  Future<List<Products>> getItemsByUserId(String request) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String url = "${Constand.BASE_URL}/$request/${prefs.getString("userId")!}";

    final response = await http.get(Uri.parse(url), headers: {
      "x-acces-token": prefs.getString("token")!,
    });

    if (response.statusCode == HttpStatus.ok) {
      return productsFromJson(response.body);
    }

    throw response.body;
  }
}
