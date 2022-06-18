// ignore_for_file: avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new, invalid_return_type_for_catch_error

import 'package:bul_app/Constand/styles.dart';
import 'package:bul_app/View-Model/Provider/register_provider.dart';
import 'package:bul_app/View/Pages/Authendication/login.dart';
import 'package:bul_app/View/Widgets/loading.dart';
import 'package:bul_app/View/Widgets/login_textfield.dart';
import 'package:bul_app/View/Widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var registerProvider = Provider.of<RegisterViewModel>(context);

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
        body: registerProvider.pageState == RegisterPageState.LOADING
            ? Center(
                child: Stack(
                  children: [
                    buildBody(context, registerProvider),
                    Loading(),
                  ],
                ),
              )
            : Center(child: buildBody(context, registerProvider)),
      ),
    );
  }

  Widget buildBody(BuildContext context, RegisterViewModel registerProvider) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLoginText(),
                SizedBox(height: 20.0),
                buildForm(registerProvider),
                SizedBox(height: 10.0),
                buildSubmitButton(context, registerProvider),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hesabın var mı?",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(
              width: 10.0,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: Text(
                "Giriş Yap",
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

  Widget buildSubmitButton(
      BuildContext context, RegisterViewModel registerProvider) {
    return SubmitButton(
      title: "Kayıt Ol",
      click: () async {
        registerProvider.fetchRegister().then((value) {
          if (registerProvider.pageState == RegisterPageState.SUCCES) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => LoginPage()));

            ScaffoldMessenger.of(context)
                .showSnackBar(buildSnackBar(registerProvider));
          } else if (registerProvider.pageState == RegisterPageState.ERROR) {
            ScaffoldMessenger.of(context)
                .showSnackBar(buildSnackBar(registerProvider));
          }
        });
      },
    );
  }

  Widget buildForm(RegisterViewModel registerProvider) {
    return Column(
      children: [
        buildText("  İsim"),
        LoginTextField(
          textEditingController: registerProvider.nameController,
        ),
        SizedBox(height: 10.0),
        buildText("  Soyisim"),
        LoginTextField(
          textEditingController: registerProvider.lastNameController,
        ),
        SizedBox(height: 10.0),
        buildText("  E-mail"),
        LoginTextField(
          textEditingController: registerProvider.emailController,
        ),
        SizedBox(height: 10.0),
        buildText("  Password"),
        LoginTextField(
          textEditingController: registerProvider.passwordController,
          obscure: true,
        ),
      ],
    );
  }

  Widget buildLoginText() {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        " Kayıt Ol",
        style: Styles.headerStyle,
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

  SnackBar buildSnackBar(RegisterViewModel registerProvider) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      backgroundColor: Colors.white,
      content: Text(
        registerProvider.text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
