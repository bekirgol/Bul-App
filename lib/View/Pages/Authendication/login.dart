// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:bul_app/Constand/network.dart';
import 'package:bul_app/Constand/styles.dart';
import 'package:bul_app/View-Model/Provider/location_provider.dart';
import 'package:bul_app/View-Model/Provider/login_provider.dart';
import 'package:bul_app/View/Pages/home.dart';
import 'package:bul_app/View/Pages/Authendication/register.dart';
import 'package:bul_app/View/Widgets/loading.dart';
import 'package:bul_app/View/Widgets/login_textfield.dart';
import 'package:bul_app/View/Widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginViewModel>(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              colors: [
            Colors.red,
            Colors.white,
          ])),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: loginProvider.loginPageState == LoginPageState.LOADING
            ? Stack(
                children: [
                  buildBody(context, loginProvider),
                  Loading(),
                ],
              )
            : buildBody(context, loginProvider),
      ),
    );
  }

  SafeArea buildBody(BuildContext context, LoginViewModel loginProvider) {
    return SafeArea(
      child: buildBodyColumn(context, loginProvider),
    );
  }

  Widget buildBodyColumn(BuildContext context, LoginViewModel loginProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: buildFormColumn(loginProvider, context),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hesabın yok mu?",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Text(
                "Kayıt Ol",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget buildFormColumn(LoginViewModel loginProvider, BuildContext context) {
    return Column(
      children: [
        buildLoginText(),
        SizedBox(height: 50.0),
        buildText("   E-mail"),
        SizedBox(height: 10.0),
        buildEmailTextField(loginProvider),
        SizedBox(height: 10.0),
        buildText("   Parola"),
        SizedBox(height: 10.0),
        buildPasswordTextField(loginProvider),
        SizedBox(height: 10.0),
        buildForgotPassword(),
        SizedBox(height: 50.0),
        buildSubmitButton(loginProvider, context),
      ],
    );
  }

  Widget buildSubmitButton(LoginViewModel loginProvider, BuildContext context) {
    return SubmitButton(
        title: "Giriş Yap",
        click: () async {
          loginProvider.loginWithEmailAndPassword().then((loginResponse) {
            if (loginProvider.loginPageState == LoginPageState.SUCCES) {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => HomePage()));
            } else if (loginProvider.loginPageState == LoginPageState.ERROR) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(buildSnackBar(loginProvider));
            }
          });
        });
  }

  SnackBar buildSnackBar(LoginViewModel registerProvider) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.red,
      content: Text(
        registerProvider.text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  LoginTextField buildPasswordTextField(LoginViewModel loginProvider) {
    return LoginTextField(
      obscure: loginProvider.obsure,
      suffix: IconButton(
        onPressed: loginProvider.changeObsure,
        icon: loginProvider.obsure
            ? Icon(Icons.visibility_off)
            : Icon(Icons.visibility),
      ),
      textEditingController: loginProvider.passwordContoller,
    );
  }

  LoginTextField buildEmailTextField(LoginViewModel loginProvider) {
    return LoginTextField(
      textEditingController: loginProvider.emailController,
    );
  }

  Align buildForgotPassword() {
    return Align(
      alignment: Alignment.topRight,
      child: Text(
        "Parolanızı mı unuttunuz?",
        style: TextStyle(color: Colors.black38, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildText(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }

  Align buildLoginText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        " Giriş Yap",
        style: TextStyle(
          color: Colors.black,
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
