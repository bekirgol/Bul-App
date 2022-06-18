import 'dart:convert';
import 'dart:io';

import 'package:bul_app/Interfaces/product_service.dart';
import 'package:bul_app/Models/category_model.dart';
import 'package:bul_app/Models/product.dart';
import 'package:bul_app/Models/province.dart';
import 'package:bul_app/Service/product_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

enum PageState { LOADING, SUCCES, ERROR, IDLE }

class PublishProvider with ChangeNotifier {
  List<Category> categories = [];
  List<CityAndRegion> cities = [];
  List<String> regions = [];
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late ImagePicker _imagePicker;
  String errorMessage = "";
  Position? position;

  ProductService service = ProductManager();
  XFile? _image;
  XFile? get image => _image;
  set image(XFile? value) {
    _image = value;
    notifyListeners();
  }

  PageState? _pageState;
  PageState? get pageState => _pageState;
  set pageState(PageState? value) {
    _pageState = value;
    notifyListeners();
  }

  LatLng? _latLng;
  LatLng? get latLng => _latLng;
  set latLng(LatLng? value) {
    _latLng = value;
    notifyListeners();
  }

  String? _selectedCategory = "Kategori Seçiniz";
  String? get selectedCategory => _selectedCategory;
  set selectedCategory(String? value) {
    _selectedCategory = value;
    notifyListeners();
  }

  String? _selectedCity = "Şehir Seçiniz";
  String? get selectedCity => _selectedCity;
  set selectedCity(String? value) {
    _selectedCity = value;
    notifyListeners();
  }

  String? _selectedRegion = "İlçe Seçiniz";
  String? get selectedRegion => _selectedRegion;
  set selectedRegion(String? value) {
    _selectedRegion = value;
    notifyListeners();
  }

  List<Placemark>? _placemark;
  List<Placemark>? get placemark => _placemark;
  set placemark(List<Placemark>? value) {
    _placemark = value;
    notifyListeners();
  }

  PublishProvider() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    _imagePicker = ImagePicker();
    fetchCategory();
    fetchCity();
  }

  void clearFilterForm() {
    selectedCategory = "Kategori Seçiniz";
    selectedCity = "Şehir Seçiniz";
    selectedRegion = null;
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    selectedCategory = "Kategori Seçiniz";
    placemark = null;
    latLng = null;
    image = null;
    pageState = PageState.IDLE;
  }

  Future<void> addImage() async {
    image = await _imagePicker.pickImage(source: ImageSource.camera);
  }

  Future<void> getLocation() async {
    placemark =
        await placemarkFromCoordinates(latLng!.latitude, latLng!.longitude);
  }

  Future<void> addItems(String requests) async {
    try {
      Products products = Products(
        title: titleController.text,
        description: descriptionController.text,
        category: selectedCategory,
        latitude: latLng?.latitude.toString(),
        longitude: latLng?.longitude.toString(),
        city: placemark?.first.administrativeArea,
        district: placemark?.first.subAdministrativeArea,
      );
      pageState = PageState.LOADING;
      await service.addItem(File(image!.path), products, requests);
      pageState = PageState.SUCCES;
    } catch (e) {
      pageState = PageState.ERROR;
      errorMessage = e.toString();
    }
  }

  Future<void> fetchCategory() async {
    final String response =
        await rootBundle.loadString("assets/json/category.json");
    final data = categoryFromJson(response);
    categories = data;
  }

  Future<void> fetchCity() async {
    final String response =
        await rootBundle.loadString("assets/json/il-ilce.json");
    final data = cityAndRegionFromJson(response);
    cities = data;
  }

  fetchRegion(String il) {
    cities.where((element) => element.il == il).map((e) {
      regions = e.ilceleri!;
    }).toList();
  }
}
