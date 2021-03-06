import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "loginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final auth = FirebaseAuth.instance;
  String email;
  String password;
  bool isLoad = false;

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: 1), value: 0.2);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white.withOpacity(controller.value),
      body: ModalProgressHUD(
        inAsyncCall: isLoad,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      child: Image.asset("images/logo2.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Color(0xFF574b90)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xFF574b90),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Color(0xFF574b90)),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xFF574b90),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      )),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Material(
                      elevation: 5.0,
                      color: Color(0xFF574b90),
                      borderRadius: BorderRadius.circular(30),
                      child: MaterialButton(
                        onPressed: () async {
                          try {
                            setState(() {
                              isLoad = true;
                            });
                            final user = await auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            if (user != null) {
                              setState(() {
                                isLoad = true;
                              });
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                          } catch (e) {
                            print(e.message);
                          }
                        },
                        minWidth: 170.0,
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
