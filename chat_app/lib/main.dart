import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: "welcomeScreen",
      routes: {
        "welcomeScreen": (context) => WelcomeScreen(),
        "registerScreen": (context) => RegisterScreen(),
        "loginScreen": (context) => LoginScreen(),
        "chatScreen": (context) => ChatScreen()
      },
    );
  }
}
