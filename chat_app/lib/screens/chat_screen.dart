import 'package:chat_app/constans.dart';
import 'package:chat_app/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final auth = FirebaseAuth.instance;
  FirebaseUser user;

  final firestore = Firestore.instance;
  String message;

  void getUsers() async {
    try {
      final u = await auth.currentUser();
      if (u != null) {
        user = u;
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                try {
                  await auth.signOut();
                  Navigator.pushNamed(context, LoginScreen.id);
                } catch (e) {
                  print(e.message);
                }
              },
              icon: Icon(Icons.close),
              label: Text(
                "Sign out",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      message = value;
                    },
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () async {
                    await firestore
                        .collection("messages")
                        .add({"text": message, "sender": user.email});
                  },
                  child: Text(
                    "SUBMIT",
                    style: kSubmitButtonTextStyle,
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
