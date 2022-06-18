// ignore_for_file: unused_field, prefer_final_fields, constant_identifier_names

import 'package:bul_app/Interfaces/auth_service.dart';
import 'package:bul_app/Models/user.dart';
import 'package:bul_app/Service/auth.dart';
import 'package:bul_app/Service/fake_auth.dart';
import 'package:flutter/material.dart';

enum RegisterPageState { LOADING, SUCCES, ERROR }

class RegisterViewModel with ChangeNotifier {
  late TextEditingController nameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AuthService _authService;
  User? user;
  RegisterPageState? _pageState;
  String text = "";

  RegisterPageState? get pageState => _pageState;
  set pageState(RegisterPageState? value) {
    _pageState = value;
    notifyListeners();
  }

  RegisterViewModel() {
    nameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _authService = Auth();
  }

  Future<User?> fetchRegister() async {
    try {
      User _user = User(
        name: nameController.text.trim(),
        lastName: lastNameController.text.trim(),
        mail: emailController.text.trim(),
        password: passwordController.text,
      );

      pageState = RegisterPageState.LOADING;
      user = await _authService.register(_user);
      pageState = RegisterPageState.SUCCES;
      text = "Kullanıcı Oluşturuldu";
      nameController.clear();
      lastNameController.clear();
      emailController.clear();
      passwordController.clear();
      return user;
    } catch (e) {
      pageState = RegisterPageState.ERROR;
      text = "$e";
    }
  }
}
