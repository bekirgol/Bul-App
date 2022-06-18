// ignore_for_file: unused_field, prefer_final_fields, constant_identifier_names

import 'package:bul_app/Interfaces/auth_service.dart';
import 'package:bul_app/Models/login_response.dart';
import 'package:bul_app/Service/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LoginPageState { SUCCES, LOADING, IDLE, ERROR }

class LoginViewModel with ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController passwordContoller;
  LoginPageState? _loginPageState;
  late AuthService _authService;
  LoginResponse? response;
  String text = "";

  LoginPageState? get loginPageState => _loginPageState;
  set loginPageState(LoginPageState? value) {
    _loginPageState = value;
    notifyListeners();
  }

  bool _obsure = true;
  bool get obsure => _obsure;
  set obsure(bool value) {
    _obsure = value;
    notifyListeners();
  }

  void changeObsure() {
    obsure = !obsure;
  }

  LoginViewModel() {
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
    _loginPageState = LoginPageState.IDLE;
    _authService = Auth();
  }

  Future<LoginResponse?> loginWithEmailAndPassword() async {
    try {
      loginPageState = LoginPageState.LOADING;
      response = await _authService.loginWithEmailAndPassword(
          emailController.text.trim(), passwordContoller.text);
      loginPageState = LoginPageState.SUCCES;
      emailController.clear();
      passwordContoller.clear();
      saveToken();
      return response;
    } catch (e) {
      loginPageState = LoginPageState.ERROR;
      text = "$e";
    }
  }

  Future<void> saveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", response!.tokens!.accesToken!);
    prefs.setString("userId", response!.id!);
  }
}
