import 'package:blog_app/authentication.dart';
import 'package:blog_app/photo_upload.dart';
import 'package:blog_app/posts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AuthOperation auth;
  final VoidCallback onSignedOut;

  HomePage({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Posts> postList = [];
  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    DatabaseReference ref =
        FirebaseDatabase.instance.reference().child("Posts");

    ref.once().then((DataSnapshot snapshot) {
      var ids = snapshot.value.keys;
      var data = snapshot.value;
      postList.clear();

      for (var inKey in ids) {
        Posts post = new Posts(
            image: data[inKey]["image"],
            explanation: data[inKey]["explanation"],
            date: data[inKey]["date"],
            time: data[inKey]["time"]);
        postList.add(post);
      }
      setState(() {
        print(postList.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Container(
        child: postList.length == 0
            ? Text("No post uploaded yet.")
            : ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                  return postCard(
                      postList[index].image,
                      postList[index].explanation,
                      postList[index].date,
                      postList[index].time);
                }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurpleAccent,
        child: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton.icon(
                  color: Colors.transparent,
                  onPressed: _logoutUser,
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton.icon(
                  color: Colors.transparent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => PhotoUpload()));
                  },
                  icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  label: Text(
                    "New Post",
                    style: TextStyle(color: Colors.white),
                  )),
              FlatButton.icon(
                  color: Colors.transparent,
                  onPressed: () {},
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Settings",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget postCard(String image, String explanation, String date, String time) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
                Text(
                  time,
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
            Text(
              explanation,
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
