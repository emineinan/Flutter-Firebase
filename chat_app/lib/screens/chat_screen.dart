import 'package:chat_app/constans.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String id = "chatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {},
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
                    onChanged: (value) {},
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                  onPressed: () {},
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
