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
          StreamBuilder<QuerySnapshot>(
              stream: firestore.collection("messages").snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                    ),
                  );
                }
                final messages = snapshot.data.documents;
                List<Text> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message.data["text"];
                  final messageSender = message.data["sender"];
                  final messageWidget = Text(
                    "$messageText sender: $messageSender",
                    style: TextStyle(color: Colors.black),
                  );
                  messageWidgets.add(messageWidget);
                }
                return Column(
                  children: messageWidgets,
                );
              }),
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
