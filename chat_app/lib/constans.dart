import 'package:flutter/material.dart';

const kSubmitButtonTextStyle = TextStyle(
    color: Color(0xFF574b90), fontWeight: FontWeight.bold, fontSize: 18.0);

const kMessageTextFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    hintText: "Type your message",
    border: InputBorder.none);

const kMessageContainerDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: Colors.pink, width: 2.0)));
