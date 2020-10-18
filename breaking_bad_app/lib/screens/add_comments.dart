import 'package:breaking_bad_app/model/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class AddComments extends StatefulWidget {
  final Character character;

  const AddComments({Key key, this.character}) : super(key: key);

  @override
  _AddCommentsState createState() => _AddCommentsState();
}

class _AddCommentsState extends State<AddComments> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await db
              .collection('characters')
              .document(widget.character.id.toString())
              .setData({"characterName": widget.character.name});
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
