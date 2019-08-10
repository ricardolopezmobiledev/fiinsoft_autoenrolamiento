import 'package:flutter/material.dart';
import 'LoginScreen.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/AuthService.dart';
import 'package:fiinsoft_autoenrolamiento/MainView.dart';
import 'package:fiinsoft_autoenrolamiento/Utils/TakePhoto.dart';

AuthService appAuth = new AuthService();

void main() async {
  // Set default home.
  Widget _defaultHome = new MyHomePage();

  // Get result of the login function.
  bool _result = await appAuth.login();
  if (_result) {
    _defaultHome = new MainView();
  }

  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new MainView(),
      '/login': (BuildContext context) => new MyHomePage()
    },
  ));
}