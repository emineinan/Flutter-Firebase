import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50.0,
                ),
                Container(
                  child: Image.asset("images/logo.png"),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 170.0,
                    height: 30.0,
                    child: Text("Login"),
                  ),
                )),
            SizedBox(
              height: 10.0,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.pink[100],
                  borderRadius: BorderRadius.circular(30),
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 170.0,
                    height: 40.0,
                    child: Text("Register"),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
