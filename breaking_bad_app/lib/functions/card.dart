import 'package:flutter/material.dart';

Widget buildCard(String leading, String title) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 25.0),
    child: ListTile(
      leading: Text(
        leading,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
    ),
  );
}
