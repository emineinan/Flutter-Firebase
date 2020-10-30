import 'package:blog_app/authentication.dart';
import 'package:blog_app/photo_upload.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final AuthOperation auth;
  final VoidCallback onSignedOut;

  HomePage({Key key, this.auth, this.onSignedOut}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _logoutUser() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Container(),
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
}
