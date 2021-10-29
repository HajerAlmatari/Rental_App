import 'package:flutter/material.dart';
import 'pages/homePage.dart';
import 'pages/addRealEstate.dart';
import 'pages/signupPage.dart';
import 'pages/login.dart';
import 'pages/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Rental app',
      home: Login(),
    );
  }
}
