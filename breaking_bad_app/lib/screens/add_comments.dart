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
  String commentText;
  List<dynamic> commentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.character.name,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            TextField(
              onChanged: (value) {
                commentText = value;
              },
              decoration: InputDecoration(hintText: "Add a commment."),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final documentsRef = await db.collection("characters").getDocuments();
          for (var doc in documentsRef.documents) {
            if (doc.documentID == widget.character.id.toString()) {
              commentList = doc.data["comments"];
            }
          }
          commentList.add(commentText);
          await db
              .collection("characters")
              .document(widget.character.id.toString())
              .setData({"comments": commentList});

          Navigator.pop(context);
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
