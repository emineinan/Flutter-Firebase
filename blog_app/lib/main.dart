import 'package:blog_app/authentication.dart';
import 'package:blog_app/home_page.dart';
import 'package:blog_app/login_register_page.dart';
import 'package:blog_app/mapping.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.black),
        home: MappingPage(
          auth: AuthService(),
        ));
  }
}
