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
                List<MessageBubbles> messageWidgets = [];
                for (var message in messages) {
                  final messageText = message.data["text"];
                  final messageSender = message.data["sender"];
                  final messageWidget = MessageBubbles(
                    text: messageText,
                    sender: messageSender,
                  );
                  messageWidgets.add(messageWidget);
                }
                return Expanded(
                    child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                  children: messageWidgets,
                ));
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

class MessageBubbles extends StatelessWidget {
  final String text;
  final String sender;

  const MessageBubbles({Key key, this.text, this.sender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "sender",
            style: TextStyle(color: Colors.pink, fontSize: 12.0),
          ),
          SizedBox(height: 5.0),
          Material(
            borderRadius: BorderRadius.circular(30.0),
            elevation: 10.0,
            color: Color(0xFF574b90),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "$text",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }
}
