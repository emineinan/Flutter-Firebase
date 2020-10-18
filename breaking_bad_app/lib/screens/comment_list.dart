import 'package:breaking_bad_app/model/character.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentList extends StatefulWidget {
  final Character character;

  const CommentList({Key key, this.character}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  final db = Firestore.instance;
  List<dynamic> commentList = [];

  void getComments() async {
    final documentsRef = await db.collection("characters").getDocuments();

    for (var doc in documentsRef.documents) {
      if (doc.documentID == widget.character.id.toString()) {
        commentList = doc.data["comments"];
      }
    }
    setState(() {});
  }

  void deleteComment(String comment) async {
    commentList.remove(comment);
    await db
        .collection("characters")
        .document(widget.character.id.toString())
        .setData({"comments": commentList});

    setState(() {
      Navigator.pop(context);
    });

    if (commentList.length == 0) {
      await db
          .collection("characters")
          .document(widget.character.id.toString())
          .delete();

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text("${widget.character.name}"),
      ),
      body: ListView.builder(
          itemCount: commentList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(commentList[index]),
              trailing: GestureDetector(
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onTap: () {
                  deleteComment(commentList[index]);
                },
              ),
            );
          }),
    );
  }
}
